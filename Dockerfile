FROM hypriot/rpi-alpine-scratch

## Update base image and install prerequisites
RUN apk add --update git python && \
  rm -rf /var/cache/apk/*

## Install Couchpotato
RUN mkdir /opt && \
  cd /opt && \
  git clone https://github.com/RuudBurger/CouchPotatoServer.git

## Expose port
EXPOSE 5050

RUN mkdir -p /config
RUN mkdir -p /data

RUN touch /config/CouchPotato.cfg

## Map volume for configuration and data
Volume /config /movies /data

## Set working directory
WORKDIR /opt

## Run Couchpotato
ENTRYPOINT ["python", "CouchPotatoServer/CouchPotato.py", "--data_dir",  "/data/", "--config_file=/config/CouchPotato.cfg"]
