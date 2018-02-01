ARG target=amd64
FROM $target/alpine

# set version label
LABEL maintainer="carlosedp"

ARG arch=amd64
ENV ARCH=$arch

# set python to use utf-8 rather than ascii
ENV PYTHONIOENCODING="UTF-8"
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

COPY tmp/qemu-$ARCH-static /usr/bin/qemu-$ARCH-static

RUN apk update && \
    apk upgrade && \
    apk add --update git python2 && \
    rm -rf /var/cache/apk/*

## Update base image and install prerequisites
RUN mkdir -p /opt/couchpotato \
    && cd /opt/couchpotato \
    && git clone https://github.com/CouchPotato/CouchPotatoServer.git \
    && mkdir -p /volumes/config /volumes/data /volumes/media

ADD CouchPotato.cfg /volumes/config/CouchPotato.cfg

## Expose port
EXPOSE 5050

## Map volume for configuration, data and media
VOLUME /volumes/config /volumes/data /volumes/media

## Set working directory
WORKDIR /opt/couchpotato

## Run Couchpotato with parameter to indicate where are data and config folder
ENTRYPOINT ["python", "CouchPotatoServer/CouchPotato.py", "--data_dir",  "/volumes/data/", "--config_file=/volumes/config/CouchPotato.cfg"]
