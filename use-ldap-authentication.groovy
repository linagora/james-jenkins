import jenkins.model.Jenkins;
import hudson.security.FullControlOnceLoggedInAuthorizationStrategy;
import hudson.security.LDAPSecurityRealm;

jenkins.authorizationStrategy = new FullControlOnceLoggedInAuthorizationStrategy() ;
jenkins.securityRealm= new LDAPSecurityRealm(server="ldaps://ldap.linagora.com", rootDN = "", userSearchBase="", userSearch="uid={0}", groupSearchBase="", groupSearchFilter="", groupMembershipStrategy = null, managerDN = "", managerPasswordSecret = null, inhibitInferRootDN = false, disableMailAddressResolver = false, cache = null);
