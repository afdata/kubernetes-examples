FROM centos:7


ENV MAGENTO_VERSION=2.2.2

# Install EPEL repository and REMI
RUN yum install -y      http://rpms.remirepo.net/enterprise/remi-release-7.rpm \
                        https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm \
                        yum-utils \
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
                        zip

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
        && ln -sf /dev/stderr /var/log/nginx/error.log

COPY default.conf /etc/nginx/conf.d/default.conf
ADD  ./parse /usr/local/src/parse
ADD  ./start /usr/local/src/start
RUN chmod 775 /usr/local/src/parse /usr/local/src/start /etc/nginx/conf.d/default.conf

ENV MAGENTO_VERSION 1.9.3.8

RUN mkdir -p /var/www/html

RUN cd /tmp && \
    curl https://codeload.github.com/OpenMage/magento-mirror/tar.gz/$MAGENTO_VERSION -o $MAGENTO_VERSION.tar.gz && \
    tar xvf $MAGENTO_VERSION.tar.gz && \
    mv magento-mirror-$MAGENTO_VERSION/* magento-mirror-$MAGENTO_VERSION/.htaccess /var/www/html

RUN chown -R www-data:www-data /var/www/html

COPY ./bin/install-magento /usr/local/bin/install-magento
RUN chmod +x /usr/local/bin/install-magento

RUN yum install -y mysql
RUN mkdir -p /var/www/html/media
COPY ./sampledata/magento-sample-data-1.9.1.0.tgz /opt/
COPY ./bin/install-sampledata-1.9 /usr/local/bin/install-sampledata
RUN chmod +x /usr/local/bin/install-sampledata
RUN sh -c /usr/local/bin/install-sampledata

RUN bash -c 'bash < <(curl -s -L https://raw.github.com/colinmollenhour/modman/master/modman-installer)'
RUN mv ~/bin/modman /usr/local/bin

WORKDIR /var/www/html

EXPOSE 80 443

CMD ["/usr/local/src/start"]
