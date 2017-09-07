FROM centos:7

# Add Nginx repository
ADD ./nginx.repo  /etc/yum.repos.d/nginx.repo
# Install repositories and enable Remi's PHP 7.0 repository
RUN yum install -y      http://rpms.remirepo.net/enterprise/remi-release-7.rpm \
                        https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
                        && yum-config-manager --enable remi-php70 \
                        && yum update -y \
			&& useradd www-data

# Install Nginx and Modules
RUN yum install -y      nginx \
                        nginx-module-xslt \
                        nginx-module-geoip \
                        nginx-module-image-filter \
                        nginx-module-perl \
                        nginx-module-njs \
                        gettext \
			zip \
                        php-fpm \
                        php \
                        php-pgsql \
			php-mysql \
			php-mysqlnd \
			php-xml \
                        php-pdo \
                        php-mbstring \
                        php-gd \
			php-imap \
			php-pgsql \
                        php-opcache \
                        php-pdo \
			php-pecl-memache \
			php-pecl-redis \
			supervisor


# Install Supervisord and add Configuration

COPY ./supervisord.conf /etc/supervisord.conf
COPY ./default.conf /etc/nginx/conf.d/default.conf

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


ADD www.conf /etc/php-fpm.d/www.conf
ADD php-fpm.conf /etc/php-fpm.conf

EXPOSE 80 443

CMD ["supervisord"]
