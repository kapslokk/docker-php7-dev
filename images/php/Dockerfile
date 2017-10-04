FROM php:7.1-fpm
ARG arg_host_uid
RUN usermod -u $arg_host_uid www-data

RUN apt-get update && apt-get install -y \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmcrypt-dev \
        libpng12-dev \
        libxml2-dev \
        libicu-dev \
        libcurl4-openssl-dev \
    && docker-php-ext-install -j$(nproc) iconv mcrypt intl curl \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install -j$(nproc) gd \
    && docker-php-ext-install -j$(nproc) mysqli pdo pdo_mysql \
    && docker-php-ext-install -j$(nproc) soap

RUN pecl install redis-3.1.4  && docker-php-ext-enable redis
RUN pecl install xdebug-2.5.0 && docker-php-ext-enable xdebug

