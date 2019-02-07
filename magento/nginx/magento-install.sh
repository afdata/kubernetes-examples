#!/bin/sh

yum install -y curl \
               php \
               php-json \
               php-phar \
               php-mbstring \
               git \
               unzip \
               php-openssl \
               php-zlib \
               php-ctype \
               php-gd \
               php-dom \
               php-mcrypt \
               php-curl \
               php-iconv \
               php-intl \
               php-zip &&
cd /var/www/html &&
curl -sS https://getcomposer.org/installer -o composer-setup.php &&
php composer-setup.php --install-dir=/usr/local/bin --filename=composer --with-openssl &&
composer install

chown -vR 1000:1000 /var/www/html
exit 0
