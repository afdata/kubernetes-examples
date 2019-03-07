#!/bin/sh

#MAGENTO_VERSION="2.3"
#MAGENTO_BASE_URL="http://magento.example.local/"
#ADMIN_PASSWORD="GkxK8P52M7b32Rz"
#ADMIN_EMAIL="user@example.com"

if [ ! -f "/var/www/html/bin/magento" ]; then
  ## Clone Magento from repository.
  rm -rf /var/www/html/magento2 && cd /var/www/html &&\
  /usr/bin/git clone https://github.com/magento/magento2.git &&\
  cd magento2 && /usr/bin/git checkout $MAGENTO_VERSION &&\
  cd ../ && mv magento2/* ./ && rm -rf ./magento2
else echo "Magento distributive had been clonned."
fi

if [ ! -f "/usr/local/bin/composer" ]; then
  ## Install composer for Magento
  curl -sS https://getcomposer.org/installer -o composer-setup.php &&
  php composer-setup.php --install-dir=/usr/local/bin --filename=composer --with-openssl
else echo "Composer had been installed."
fi

if [ ! -d "/var/www/html/vendor/zendframework" ]; then
  cd /var/www/html && composer install
else echo "Magento dependencieshad been installed."
fi

if [ ! -f "/var/www/html/magento-install" ]; then
  ## Install Magento
  cd /var/www/html &&\
  bin/magento setup:install --db-host=mysql \
                            --db-name=magento \
                            --db-user=magento \
                            --db-password=abc1234 \
                            --admin-firstname=Magento \
                            --admin-lastname=Admin \
                            --admin-email=$ADMIN_EMAIL \
                            --admin-user=admin \
                            --admin-password=$ADMIN_PASSWORD \
                            --language=en_US \
                            --currency=EUR \
                            --timezone=Europe/Berlin \
                            --base-url=$MAGENTO_BASE_URL
  ## Set owner for html folder as www-data
  chown -vR 1000:1000 /var/www/html
  echo "Magento installation has been finished."
  touch /var/www/html/magento-install
else echo "Magento had been installed."
fi

exec "$@"