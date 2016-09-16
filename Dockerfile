FROM hypriot/rpi-alpine-scratch

## Update base image and install prerequisites
RUN apk add --update git python \
    && rm -rf /var/cache/apk/* \
    && mkdir -p /opt/couchpotato \
    && cd /opt/couchpotato \
    && git clone https://github.com/RuudBurger/CouchPotatoServer.git \
    && mkdir -p /volumes/config /volumes/data /volumes/media \
    && touch /volumes/config/CouchPotato.cfg

## Expose port
EXPOSE 5050

## Map volume for configuration, data and media
VOLUME /volumes/config /volumes/data /volumes/media

## Set working directory
WORKDIR /opt/couchpotato

## Run Couchpotato with parameter to indicate where are data and config folder
ENTRYPOINT ["python", "CouchPotatoServer/CouchPotato.py", "--data_dir",  "/volumes/data/", "--config_file=/volumes/config/CouchPotato.cfg"]
