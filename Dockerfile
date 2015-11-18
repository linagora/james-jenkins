FROM jenkins:1.609.3

USER root

RUN echo "deb http://http.debian.net/debian jessie-backports main" >> /etc/apt/sources.list \
      && apt-get update \
      && apt-get install -y docker.io \
      && rm -rf /var/lib/apt/lists/*

USER jenkins

RUN git config --global user.name "Jenkins James" \
      && git config --global user.email "root@open-paas.org"

COPY plugins.txt /plugins.txt

RUN /usr/local/bin/plugins.sh /plugins.txt
COPY ghprb.hpi /usr/share/jenkins/ref/plugins/ghprb.jpi
COPY job-dsl.hpi /usr/share/jenkins/ref/plugins/job-dsl.jpi
COPY workflow-aggregator.hpi /usr/share/jenkins/ref/plugins/workflow-aggregator.jpi
COPY workflow-api.hpi /usr/share/jenkins/ref/plugins/workflow-api.jpi
COPY workflow-basic-steps.hpi /usr/share/jenkins/ref/plugins/workflow-basic-steps.jpi
COPY workflow-cps-global-lib.hpi /usr/share/jenkins/ref/plugins/workflow-cps-global-lib.jpi
COPY workflow-cps.hpi /usr/share/jenkins/ref/plugins/workflow-cps.jpi
COPY workflow-durable-task-step.hpi /usr/share/jenkins/ref/plugins/workflow-durable-task-step.jpi
COPY workflow-job.hpi /usr/share/jenkins/ref/plugins/workflow-job.jpi
COPY workflow-scm-step.hpi /usr/share/jenkins/ref/plugins/workflow-scm-step.jpi
COPY workflow-step-api.hpi /usr/share/jenkins/ref/plugins/workflow-step-api.jpi
COPY workflow-support.hpi /usr/share/jenkins/ref/plugins/workflow-support.jpi

COPY create-dsl-job.groovy /usr/share/jenkins/ref/init.groovy.d/create-dsl-job.groovy
COPY use-ldap-authentication.groovy  /usr/share/jenkins/ref/init.groovy.d/use-ldap-authentication.groovy

ENV JENKINS_OPTS --httpsPort=8083 --httpsCertificate=/keys/httpsCert.pem --httpsPrivateKey=/keys/httpsKey.pem
EXPOSE 8083

