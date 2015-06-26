import hudson.plugins.git.GitSCM;
import hudson.triggers.SCMTrigger;
import javaposse.jobdsl.plugin.*;
import jenkins.model.Jenkins;

jenkins = Jenkins.instance;
jobName = "create-dsl-job";
gitTrigger = new SCMTrigger("* * * * *");
dslBuilder = new ExecuteDslScripts(scriptLocation=new ExecuteDslScripts.ScriptLocation(value = "false", targets="build-script", scriptText=""), ignoreExisting=false, removedJobAction=RemovedJobAction.DISABLE);
dslProject = new hudson.model.FreeStyleProject(jenkins, jobName);
dslProject.scm = new GitSCM("https://ci.open-paas.org/stash/scm/jwc/jenkins.git");
dslProject.addTrigger(gitTrigger);
dslProject.createTransientActions();
dslProject.getPublishersList().add(dslBuilder);
jenkins.add(dslProject, jobName);
gitTrigger.start(dslProject, true);