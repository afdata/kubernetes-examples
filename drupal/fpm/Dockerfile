FROM centos:7

#ENV PHP_INI_DIR /usr/local/etc/php

# Install repositories and enable Remi's PHP 7.0 repository
RUN yum install -y      http://rpms.remirepo.net/enterprise/remi-release-7.rpm \
                        https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
                        && yum-config-manager --enable remi-php70 \
                        && yum update -y \
			&& useradd www-data


# Install PHP and Modules
RUN yum install -y      zip \
                        php-fpm \
                        php \
                        php-pgsql \
			php-mysql \
			php-mysqlnd \
			php-xml \
                        php-pdo \
                        php-mbstring \
                        php-gd \
                        php-opcache \
                        php-pdo \
                        libpng12-devel \
                        libjpeg-turbo-devel \
                        postgresql-devel \
			php-pecl-memache \
			php-pecl-redis


#RUN mkdir -p $PHP_INI_DIR/conf.d

RUN mkdir -p /var/www/html/

WORKDIR /var/www/html

# https://www.drupal.org/node/3060/release
ENV DRUPAL_VERSION 8.2.1
ENV DRUPAL_MD5 ad5ab19697ee0f7d786184ceaa7ddf6a

RUN curl -fSL "https://ftp.drupal.org/files/projects/drupal-${DRUPAL_VERSION}.tar.gz" -o drupal.tar.gz \
        && echo "${DRUPAL_MD5} *drupal.tar.gz" | md5sum -c - \
        && tar -xz --strip-components=1 -f drupal.tar.gz \
        && rm drupal.tar.gz \
	&& chown -R www-data:www-data sites modules themes

# see https://secure.php.net/manual/en/opcache.installation.php
RUN { \
                echo 'opcache.memory_consumption=128'; \
                echo 'opcache.interned_strings_buffer=8'; \
                echo 'opcache.max_accelerated_files=4000'; \
                echo 'opcache.revalidate_freq=60'; \
                echo 'opcache.fast_shutdown=1'; \
                echo 'opcache.enable_cli=1'; \
        } > /etc/php/conf.d/opcache-recommended.ini


ADD www.conf /etc/php-fpm.d/www.conf
ADD php-fpm.conf /etc/php-fpm.conf

EXPOSE 9000

CMD ["php-fpm", "-F"]
