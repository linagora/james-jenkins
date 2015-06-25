FROM jenkins:1.609.1

COPY plugins.txt /plugins.txt

RUN /usr/local/bin/plugins.sh /plugins.txt

COPY create-dsl-job.groovy /usr/share/jenkins/ref/init.groovy.d/create-dsl-job.groovy
COPY use-ldap-authentication.groovy  /usr/share/jenkins/ref/init.groovy.d/use-ldap-authentication.groovy
