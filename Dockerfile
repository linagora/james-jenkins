FROM jenkins:1.642.4

USER root

RUN echo "deb http://archive.debian.org/debian jessie main" > /etc/apt/sources.list \
    && rm /etc/apt/sources.list.d/jessie-backports.list

RUN apt-get update \
    && apt-get install -y apt-transport-https ca-certificates \
    && apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
    && echo deb https://apt.dockerproject.org/repo debian-jessie main >> /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y docker-engine \
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
