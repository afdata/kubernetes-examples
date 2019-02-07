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

# Forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
        && ln -sf /dev/stderr /var/log/nginx/error.log

COPY default.conf /etc/nginx/conf.d/default.conf
ADD  ./parse /usr/local/src/parse
ADD  ./start /usr/local/src/start
ADD  ./magento-install.sh /tmp/magento-install.sh
RUN chmod 775 /usr/local/src/parse /usr/local/src/start /etc/nginx/conf.d/default.conf /tmp/magento-install.sh

WORKDIR /var/www/html

#RUN cd /tmp && \ 
#  curl https://codeload.github.com/magento/magento2/tar.gz/$MAGENTO_VERSION -o $MAGENTO_VERSION.tar.gz && \
#  tar xvf $MAGENTO_VERSION.tar.gz && \
#  mv magento2-$MAGENTO_VERSION/* magento2-$MAGENTO_VERSION/.htaccess ./


EXPOSE 80 443

CMD ["/usr/local/src/start"]
