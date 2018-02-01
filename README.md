[hub]: https://hub.docker.com/r/carlosedp/couchpotato/

# carlosedp/couchpotato

[![Build Status](https://travis-ci.org/carlosedp/docker-couchpotato.svg?branch=master)](https://travis-ci.org/carlosedp/docker-sickrage) [![](https://images.microbadger.com/badges/image/carlosedp/couchpotato.svg)](https://microbadger.com/images/carlosedp/couchpotato "Get your own image badge on microbadger.com")

Automatic Movie downloader docker image. It watches for new episodes of your favorite shows, and when they are posted it does its magic. [Sickrage](https://sickrage.github.io/)

## Usage

### Media Folder Structure

The containers expect a similar structure with Downloads, Incomplete, Movies, TVShows and Concerts directories on your drive.

    /mnt/external/Downloads/
                            /Incomplete
                            /Movies
                            /TVShows
                  /Movies/
                  /TVShows/
                  /Concerts/

To make all applications behave similarly, the external volume will be mounted on `/volumes/media` in the container.

    export MEDIA=/mnt/1TB-WDred

```
    docker volume create couchpotato_config
    docker volume create couchpotato_data
    docker run -d \
    --name couchpotato \
    --restart=unless-stopped \
    --net=mediaserver \
    -p 5050:5050 \
    -v $MEDIA:/volumes/media \
    -v couchpotato_data:/volumes/data \
    -v couchpotato_config:/volumes/config \
    -v /etc/localtime:/etc/localtime:ro \
    carlosedp/couchpotato
```

## Parameters

* `-p 5050` - the port(s)
* `-v $MEDIA:/volumes/media` - your media folder.
* `-e PGID` for GroupID - see below for explanation
* `-e PUID` for UserID - see below for explanation

It is based on alpine linux with s6 overlay, for shell access whilst the container is running do `docker exec -it sickrage /bin/sh`.

### User / Group Identifiers

Sometimes when using data volumes (`-v` flags) permissions issues can arise between the host OS and the container. We avoid this issue by allowing you to specify the user `PUID` and group `PGID`. Ensure the data volume directory on the host is owned by the same user you specify and it will "just work" ™.

In this instance `PUID=1001` and `PGID=1001`. To find yours use `id user` as below:

```
  $ id <dockeruser>
    uid=1001(dockeruser) gid=1001(dockergroup) groups=1001(dockergroup)
```

## Setting up the application

Web interface is at `<your ip>:5050` , set paths for downloads, tv-shows to match docker mappings via the webui.

## Info

* To monitor the logs of the container in realtime `docker logs -f sickrage`.

* container version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' sickrage`

* image version number

`docker inspect -f '{{ index .Config.Labels "build_version" }}' linuxserver/sickrage`
