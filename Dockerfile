FROM ubuntu:latest

RUN uname -r

RUN apt-get update
RUN apt-get install -y \
  awscli \
  mongodb-org-tools \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /usr

CMD [ "bash", "backup.sh" ]