# docker-php7-dev
## Requirements 
  * docker
  * docker-compose

## How to use
1. Insert files from this repository near your project directory. Eg.: 
  * ./app - your project directory
  * ./docker
2. Edit docker.sh 
  * set up your application directory: `APP_DIR="../app"`
  * set up your project name: `PROJECT="phpapp"`
3. Edit docker-compose.yaml
  * set up your mysql user and database: 
   ```yml
        MYSQL_ROOT_PASSWORD: secret
        MYSQL_DATABASE: app
        MYSQL_USER: app
        MYSQL_PASSWORD: app
     ```
  * set up phpMyAdmin configuration
   ```yml
        - PMA_USER=app
        - PMA_PASSWORD=app
   ```
  * set up application directory mapping (replace `../app/` by your own path
   ```yml
   app:
     image: php:7.0-fpm
     command: "true"
     volumes:
      - "../app/:/var/www/app/"
   ```
4. Now you can run your containers. Go to the docker directory and run `./docker.sh up`. Docker will download images and run all containers.  
   


