FROM jenkins:1.609.1

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

COPY create-dsl-job.groovy /usr/share/jenkins/ref/init.groovy.d/create-dsl-job.groovy
COPY use-ldap-authentication.groovy  /usr/share/jenkins/ref/init.groovy.d/use-ldap-authentication.groovy
