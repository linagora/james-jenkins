import hudson.util.DescribableList;
import hudson.security.FullControlOnceLoggedInAuthorizationStrategy;
import hudson.security.HudsonPrivateSecurityRealm;
import hudson.slaves.NodeProperty;
import hudson.slaves.NodePropertyDescriptor;
import jenkins.model.Jenkins;
import org.jenkinsci.plugins.envinject.*;

jenkins = Jenkins.instance;

DescribableList<NodeProperty<?>, NodePropertyDescriptor> globalNodeProperties = jenkins.getGlobalNodeProperties();

envInjectNodeProperty= new EnvInjectNodeProperty(false, "/var/lib/jenkins/secret.properties")
propDescriptor = envInjectNodeProperty.getDescriptor()

def passEntry = new EnvInjectGlobalPasswordEntry(System.getenv("JENKINS_ADMIN"), System.getenv("JENKINS_PASSWORD"))
List<EnvInjectGlobalPasswordEntry> envInjectGlobalPasswordEntriesList= [passEntry];
propDescriptor.envInjectGlobalPasswordEntries = envInjectGlobalPasswordEntriesList.toArray(new EnvInjectGlobalPasswordEntry[envInjectGlobalPasswordEntriesList.size()]);
propDescriptor.save();
jenkins.authorizationStrategy = new FullControlOnceLoggedInAuthorizationStrategy();
def hudsonRealm = new HudsonPrivateSecurityRealm(false);
hudsonRealm.createAccount(System.getenv("JENKINS_ADMIN"), System.getenv("JENKINS_PASSWORD"));
jenkins.setSecurityRealm(hudsonRealm);
jenkins.save();
