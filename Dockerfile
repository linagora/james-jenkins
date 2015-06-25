FROM jenkins:1.609.1

USER root

RUN echo "" >> /etc/apt/sources.list \
      && apt-get update \
      && apt-get install -y docker.io \
      && rm -rf /var/lib/apt/lists/*

USER jenkins

COPY plugins.txt /plugins.txt

RUN /usr/local/bin/plugins.sh /plugins.txt

COPY create-dsl-job.groovy /usr/share/jenkins/ref/init.groovy.d/create-dsl-job.groovy
