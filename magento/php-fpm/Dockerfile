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
                        php-devel \
                        php-common \
                        php-intl \
                        php-mbstring \
                        php-bcmath \
                        php-json \
                        php-iconv \
                        php-fpm \
                        php-cli \
                        php-soap \
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
                        composer \
                        postgresql-devel 



RUN mkdir -p /var/www/html/

WORKDIR /var/www/html




ADD www.conf /etc/php-fpm.d/www.conf
ADD php-fpm.conf /etc/php-fpm.conf

EXPOSE 9000

CMD ["php-fpm", "-F"]
