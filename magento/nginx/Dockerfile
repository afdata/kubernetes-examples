FROM centos:7


ENV MAGENTO_VERSION=2.3

# Install EPEL repository and REMI
RUN yum install -y      http://rpms.remirepo.net/enterprise/remi-release-7.rpm \
                        https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
                        yum-utils \
                        && yum-config-manager --enable remi-php72 \
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
                        zip

# Install necessary packages for Magento
RUN yum install -y curl \
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
                   php-zip \
                   php-bcmath \
                   php-mysqlnd \
                   php-soap

# Forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
        && ln -sf /dev/stderr /var/log/nginx/error.log

RUN rm -rf /etc/nginx/*
COPY default.conf /etc/nginx/conf.d/default.conf
COPY nginx.conf.sample /etc/nginx/conf.d/nginx.conf.sample
COPY fastcgi_params /etc/nginx/fastcgi_params
COPY mime.types /etc/nginx/mime.types
COPY nginx.conf /etc/nginx/nginx.conf
ADD  ./parse /usr/local/src/parse
ADD  ./start /usr/local/src/start
ADD  ./magento-install.sh /tmp/magento-install.sh
RUN chmod 775 /usr/local/src/parse /usr/local/src/start /etc/nginx/conf.d/default.conf /tmp/magento-install.sh
WORKDIR /var/www/html

EXPOSE 80 443

ENTRYPOINT ["/tmp/magento-install.sh"]
CMD ["/usr/local/src/start"]
