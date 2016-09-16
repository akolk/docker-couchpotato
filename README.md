# docker-rpi-couchpotato
This is a raspberry pi compatible Couchpotato DockerFile.

To build it :

    docker build -t rpi-couchpotato .

To run it (with image on docker hub) :

    docker run -d -p 5050:5050 \
    -v /path_to_your_media_folder:/volumes/media \
    -v /path_to_your_data_folder:/volumes/data \
    -v /path_to_your_config_folder:/volumes/config \
    -v /etc/localtime:/etc/localtime:ro \
    --restart unless-stopped \
    --name couchpotato \
    dtroncy/rpi-couchpotato

Description of parameters :
  - **-d** : to launch container as demon
  - **-v /path_to_your_media_folder:/volumes/media** : mount media folder in your container to a folder in your host. The media folder is the folder where couchpotato scan your actuals media
  - **-v /path_to_your_data_folder:/volumes/data** : mount data folder in your container to a folder in your host
  - **-v /path_to_your_config_folder:/volumes/config** : mount config folder in your container to a folder in your host
  - **-v /etc/localtime:/etc/localtime:ro** : synchronise time between host and container
  - **--restart unless-stopped** : restart the container unless it has been stopped by user
  - **--name couchpotato** : container's name
  - **dtroncy/rpi-couchpotato** : image's name
