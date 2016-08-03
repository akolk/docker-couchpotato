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

## Create config and data folder
RUN mkdir -p /config
RUN mkdir -p /data

## Create config file
RUN touch /config/CouchPotato.cfg

## Map volume for configuration, data and movies
Volume /config /data /movies

## Set working directory
WORKDIR /opt

## Run Couchpotato with parameter to indicate where are data and config folder
ENTRYPOINT ["python", "CouchPotatoServer/CouchPotato.py", "--data_dir",  "/data/", "--config_file=/config/CouchPotato.cfg"]
