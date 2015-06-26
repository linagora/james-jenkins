import jenkins.model.Jenkins;
import hudson.security.FullControlOnceLoggedInAuthorizationStrategy;
import hudson.security.LDAPSecurityRealm;

jenkins.authorizationStrategy = new FullControlOnceLoggedInAuthorizationStrategy() ;
jenkins.securityRealm= new LDAPSecurityRealm(server="ldap.linagora.com:389", rootDN = "", userSearchBase="", userSearch="uid={0}", groupSearchBase="", groupSearchFilter="", groupMembershipStrategy = null, managerDN = "", managerPasswordSecret = null, inhibitInferRootDN = false, disableMailAddressResolver = false, cache = null);
