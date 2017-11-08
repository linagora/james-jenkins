FROM jenkinsci/jnlp-slave:3.10-1

#docker run -d -v /var/run/docker.sock:/var/run/docker.sock --volumes-from=keys --rm --name jenkins-slave jenkins-slave -url <master-url> <secret> <host>

USER root

RUN apt-get update \
    && apt-get install -y apt-transport-https ca-certificates \
    && apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D \
    && echo deb https://apt.dockerproject.org/repo debian-jessie main >> /etc/apt/sources.list.d/docker.list \
    && apt-get update \
    && apt-get install -y docker-engine \
    && rm -rf /var/lib/apt/lists/*

ADD launch-slave /root/

ENTRYPOINT ["/root/launch-slave"]
