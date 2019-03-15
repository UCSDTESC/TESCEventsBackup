FROM ubuntu:latest

RUN uname -r

RUN apt-get update
RUN apt-get install -y \
  awscli \
  mongo \
  && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /usr

CMD [ "bash", "backup.sh" ]