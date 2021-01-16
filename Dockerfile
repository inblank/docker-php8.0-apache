FROM php:8.0.1-apache
RUN apt-get update && apt-get install -y \
        libfreetype6-dev libjpeg62-turbo-dev libpng-dev libicu-dev libmemcached-dev libbz2-dev \
        libssl-dev librabbitmq-dev libxml2-dev libxslt1.1 libxslt1-dev libzip-dev libpq-dev \
        unzip libc-client-dev libkrb5-dev libtidy-dev git subversion \
    && a2enmod rewrite \
    && docker-php-ext-configure zip \
    && docker-php-ext-configure gd \
    && docker-php-ext-configure imap --with-kerberos --with-imap-ssl
RUN printf "\n" | pecl install redis \
    && printf "\n" | pecl install memcached \
    && printf "\n" | pecl install memcache \
    && printf "\n" | pecl install mongodb \
    && printf "\n" | pecl install rar \
    && printf "\n" | pecl install xdebug \
    && printf "\n" | pecl install dbase \
    && printf "\n" | pecl install swoole \
    && docker-php-ext-enable redis memcached memcache mongodb xdebug rar dbase swoole \
    && docker-php-ext-install bcmath bz2 calendar exif opcache mysqli pdo_mysql pdo_pgsql intl zip soap gd xsl pcntl sockets imap tidy \
    && a2enmod ssl \
    && chmod 777 /var/log
RUN mkdir -p /usr/src/php/ext/amqp \
    && git clone https://github.com/php-amqp/php-amqp.git /usr/src/php/ext/amqp \
    && docker-php-ext-install amqp
