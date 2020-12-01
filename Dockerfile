# Need at least version 3.9 to get correct version of mongodb-tools that accepts --uri option for mongodump
FROM alpine:3.9

RUN apk update

# Install base and dev packages
RUN apk add --no-cache --virtual .build-deps
RUN apk add bash

# Install Mongodb-Tools
RUN apk add --no-cache mongodb-tools

# Install AWSCLI
RUN apk -Uuv add groff less python py-pip
RUN pip install awscli
RUN apk --purge -v del py-pip
RUN rm /var/cache/apk/*

WORKDIR /usr

COPY backup.sh /backup.sh

CMD [ "bash", "/backup.sh" ]
