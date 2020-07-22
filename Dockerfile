FROM jenkins:1.642.4

USER root

RUN sed -i 's;http://archive.debian.org/debian/;http://deb.debian.org/debian/;' /etc/apt/sources.list \
    && echo "deb http://archive.debian.org/debian jessie main" > /etc/apt/sources.list \
    && rm /etc/apt/sources.list.d/jessie-backports.list

RUN apt-get update \
    && apt-get install --force-yes -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common sudo \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    && apt-get update \
    && apt-get install --force-yes -y docker-ce \
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
COPY github-api.hpi /usr/share/jenkins/ref/plugins/github-api.jpi

COPY create-dsl-job.groovy /usr/share/jenkins/ref/init.groovy.d/create-dsl-job.groovy
COPY basic-authentication.groovy /usr/share/jenkins/ref/init.groovy.d/basic-authentication.groovy

COPY .dockercfg /usr/share/jenkins/ref/.dockercfg

COPY envinject-plugin-configuration.xml /usr/share/jenkins/ref/envinject-plugin-configuration.xml
