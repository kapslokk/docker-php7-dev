#!/bin/bash
DOCKER_COMPOSE_DIR="./"
OPTIONS="-f $DOCKER_COMPOSE_DIR/docker-compose.yaml"

install () {
    if [ $UID = 0 ]; then
        echo "You should not run this script as root!";
        exit
    fi

    echo "HOST_UID=$UID" > .env

    echo "Enter project name (default: app)"
    read project_name
    if [ -z "$project_name" ]; then
        echo "COMPOSE_PROJECT_NAME=app" >> .env
    else
        echo "COMPOSE_PROJECT_NAME=$project_name" >> .env
    fi

    echo "Enter path to your php application (default: ../app/)"
    read path_to_application
    if [ -z "$path_to_application" ]; then
        echo "APP_PATH=../app" >> .env
    else
        echo "APP_PATH=$path_to_application" >> .env
    fi

    echo "Enter MySQL connection data."
    echo "Root password: (default: secret)"
    read root_password
    if [ -z "$root_password" ]; then
        echo "MYSQL_ROOT_PASSWORD=secret" >> .env
    else
        echo "MYSQL_ROOT_PASSWORD=$root_password" >> .env
    fi

    echo "Database name: (default: app)"
    read db_name
    if [ -z "$db_name" ]; then
        echo "MYSQL_DATABASE=app" >> .env
    else
        echo "MYSQL_DATABASE=$db_name" >> .env
    fi


    echo "Database user: (default: app)"
    read db_user
    if [ -z "$db_user" ]; then
        echo "MYSQL_USER=app" >> .env
    else
        echo "MYSQL_USER=$db_user" >> .env
    fi

    echo "Database password: (default: app)"
    read db_passwd
    if [ -z "$db_passwd" ]; then
        echo "MYSQL_PASSWORD=app" >> .env
    else
        echo "MYSQL_PASSWORD=$db_passwd" >> .env
    fi

}

up() {

    docker-compose $OPTIONS up -d "${@:2}"
}

stop() {
    docker-compose $OPTIONS stop
}

restart() {
    docker-compose $OPTIONS restart
}

composer() {
    docker-compose run -u $UID composer  "${@:2}"
}

ps(){
    docker-compose $OPTIONS ps
}

logs(){
    docker-compose $OPTIONS logs -f
}


rebuild(){
    docker-compose -f "$DOCKER_COMPOSE_DIR/docker-compose.yaml" build --no-cache
}

bash() {
    docker-compose exec --user $UID ${@:2} /bin/bash "${@:3}"
}

bash_root() {
    docker-compose exec --user 0 ${@:2} /bin/bash "${@:3}"
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
        "install") install
       ;;
       "up") up "$@"
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
       "bash_root") bash_root "$@"
       ;;
    esac
fi
