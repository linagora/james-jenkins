import hudson.model.FreeStyleProject;
import hudson.plugins.git.GitSCM;
import hudson.plugins.git.BranchSpec;
import hudson.triggers.SCMTrigger;
import javaposse.jobdsl.plugin.*;
import jenkins.model.Jenkins;
import jenkins.model.JenkinsLocationConfiguration;
import org.jenkinsci.plugins.scriptsecurity.sandbox.Whitelist;
import org.jenkinsci.plugins.scriptsecurity.sandbox.whitelists.BlanketWhitelist;
import org.jenkinsci.plugins.workflow.job.WorkflowJob;
import org.jenkinsci.plugins.workflow.cps.CpsScmFlowDefinition;

jenkins = Jenkins.instance;
jenkins.getExtensionList(Whitelist.class).push(new BlanketWhitelist());

configuration = JenkinsLocationConfiguration.get();
configuration.setUrl(System.getenv("JENKINS_URL"));
configuration.save();

scm = new GitSCM("https://github.com/linagora/james-jenkins");
scm.branches = [new BranchSpec("*/master")];
workflowJob = new WorkflowJob(jenkins, "workflow");
workflowJob.definition = new CpsScmFlowDefinition(scm, "workflow-job");
jenkins.add(workflowJob, workflowJob.name);

jobName = "create-dsl-job";
gitTrigger = new SCMTrigger("* * * * *");
dslBuilder = new ExecuteDslScripts(scriptLocation=new ExecuteDslScripts.ScriptLocation(value = "false", targets="build-stash-script", scriptText=""), ignoreExisting=false, removedJobAction=RemovedJobAction.DISABLE);
dslProject = new hudson.model.FreeStyleProject(jenkins, jobName);
dslProject.scm = new GitSCM("https://github.com/linagora/james-jenkins.git");
dslProject.scm.branches = [new BranchSpec("*/master")];
dslProject.addTrigger(gitTrigger);
dslProject.createTransientActions();
dslProject.getPublishersList().add(dslBuilder);
jenkins.add(dslProject, jobName);
gitTrigger.start(dslProject, true);
