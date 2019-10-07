FROM php:7.1-apache

LABEL maintainer="matthew@mhcommerce.com"
LABEL php_version="7.1"

ENV INSTALL_DIR /var/www/html
ENV COMPOSER_HOME /var/www/.composer/

RUN curl -sS https://getcomposer.org/installer | php \
    && mv composer.phar /usr/local/bin/composer

RUN requirements="git libmcrypt-dev libmcrypt4 libcurl3-dev libjpeg* libfreetype6 libfreetype6-dev libicu-dev libxslt1-dev unzip" \
    && apt-get update \
    && apt-get install -y $requirements \
    && rm -rf /var/lib/apt/lists/*

RUN  docker-php-ext-install pdo_mysql \
    && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ \
    && docker-php-ext-install gd \
    && docker-php-ext-install mcrypt \
    && docker-php-ext-install mbstring \
    && docker-php-ext-install bcmath \
    && docker-php-ext-install zip \
    && docker-php-ext-install intl \
    && docker-php-ext-install xsl \
    && docker-php-ext-install soap \
    && docker-php-ext-install sockets \
    && requirementsToRemove="libmcrypt-dev libcurl3-dev libfreetype6-dev" \
    && apt-get purge --auto-remove -y $requirementsToRemove
