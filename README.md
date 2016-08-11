# docker-rpi-couchpotato
This is a raspberry pi compatible Couchpotato DockerFile.

To build it :

    docker build -t rpi-couchpotato .

To run it (with image on docker hub) :

    docker run -d -p 5050:5050 \
    -v /path_to_your_movies_folder:/applications/couchpotato/movies \
    -v /path_to_your_data_folder:/applications/couchpotato/data \
    -v /path_to_your_config_folder:/applications/couchpotato/config \
    -v /etc/localtime:/etc/localtime:ro \
    --restart unless-stopped \
    --name couchpotato \
    dtroncy/rpi-couchpotato

Description of parameters :
  - **-d** : to launch container as demon
  - **-v /path_to_your_movies_folder:/applications/couchpotato/movies** : mount movies folder in your container to a folder in your host. The movies folder is the folder where couchpotato scan your actuals movies
  - **-v /path_to_your_data_folder:/applications/couchpotato/data** : mount data folder in your container to a folder in your host
  - **-v /path_to_your_config_folder:/applications/couchpotato/config** : mount config folder in your container to a folder in your host
  - **-v /etc/localtime:/etc/localtime:ro** : synchronise time between host and container
  - **--restart unless-stopped** : restart the container unless it has been stopped by user
  - **--name couchpotato** : container's name
  - **dtroncy/rpi-couchpotato** : image's name
