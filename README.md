# docker-php7-dev
## What's inside? 
  * PHP 7.0 
  * Nginx
  * MySQL (MariaDB)
  * phpMyAdmin
  * Composer

## Requirements 
  * docker
  * docker-compose

## Installation
```
 git clone https://github.com/kapslokk/docker-php7-dev.git
 cd docker-php7-dev
 ./docker.sh install
 ```
 
## How to run containers
Go to `docker-php7-dev` directory and run ./docker.sh up
```
cd docker-php7-dev
./docker.sh up
```
Containers should be created now. 

## Composer
To use composer you should run `./docker.sh composer command` eg.:
```
./docker.sh composer install
```

## Access to bash in containers
You can easily get access to bash inside containers. 
Just run `./docker.sh bash service` eg.:
```
 ./docker.sh bash php
```
There is also a way to get access as root - you should type bash_root instead of bash eg.: 
```
 ./docker.sh bash_root php
```

## docker.sh commands 
After type ./docker.sh you will get list of available commands:
```
Run ./docker.sh with parameters:
    up          - Start all docker containers
    stop        - Stop all docker containers
    restart     - Restart all docker containers
    composer    - Run composer in application directory. Eg. ./docker.sh composer dump-autoload -o
    ps          - List running containers
    logs        - Tail containers logs
    rebuild     - Rebuild images build from Dockerfiles
    bash        - Get a shell from container. Eg. ./docker.sh bash php
    bash_root   - Get a shell from container as root. Eg. ./docker.sh bash_root php
```