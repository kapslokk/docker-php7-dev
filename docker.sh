#!/bin/bash
DOCKER_COMPOSE_DIR="./"
APP_DIR="../test_app"
PROJECT="forum"
OPTIONS="-p $PROJECT -f $DOCKER_COMPOSE_DIR/docker-compose.yaml"

up() {

    docker-compose $OPTIONS up -d
}

stop() {
    docker-compose $OPTIONS stop
}

restart() {
    docker-compose $OPTIONS restart
}

composer() {
    docker run -u 1000 --rm -v -u $UID $(pwd)/$APP_DIR:/app composer/composer  "${@:2}"
}

ps(){
    docker-compose $OPTIONS ps
}

logs(){
    docker-compose $OPTIONS logs -f
}


rebuild(){
    docker-compose -p "$PROJECT" -f "$DOCKER_COMPOSE_DIR/docker-compose.yaml" build --no-cache
}

bash() {
    docker exec -i -t "$PROJECT"_"${@:2}"_1 /bin/bash "${@:3}"
}

bash_root() {
    docker exec -u 1 -i -t "$PROJECT"_"${@:2}"_1 /bin/bash "${@:3}"
}
command_list() {
    echo "Run ./docker.sh with parameters:
    up          - Start all docker containers
    stop        - Stop all docker containers
    restart     - Restart all docker containers
    composer    - Run composer in application directory. Eg. ./docker.sh composer dump-autoload -o
    ps          - List running containers
    logs        - Tail containers logs
    rebuild     - Rebuild images build from Dockerfiles
    bash        - Get a shell from container. Eg. ./docker.sh bash php
    bash_root   - Get a shell from container as root. Eg. ./docker.sh bash_root php"
}

if [[ $1 == ""  ]]; then
    command_list
else
    case "$1" in
       "up") up
       ;;
       "stop") stop
       ;;
       "restart") restart
       ;;
       "rebuild") rebuild
       ;;
       "ps") ps
       ;;
       "logs") logs
       ;;
       "composer") composer "$@"
       ;;
       "bash") bash "$@"
       ;;
       "bash_root") bash "$@"
       ;;
    esac
fi
