FROM php:5.6
MAINTAINER Jens Kohl <jens.kohl@milchundzucker.de>

COPY assets/ssh_config /root/.ssh/config
COPY assets/xdebug /usr/local/bin/xdebug
COPY assets/uopz /usr/local/bin/uopz

RUN apt-get update && apt-get install -y \
  git-core \
  subversion \
  unzip \
  rsync \
  ssh-client \
  libxml2-dev \
  libssh2-1-dev \
  libicu-dev \
  --no-install-recommends && apt-get clean

RUN set -xe \
  && php -v \
  && cd /tmp \
  && php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php \
  && php composer-setup.php \
  && php -r "unlink('composer-setup.php');" \
  && mv composer.phar /usr/local/bin/composer \
  && which composer \
  && composer --version \
  && curl -L http://www.phing.info/get/phing-latest.phar -o /usr/local/bin/phing \
  && chmod +x /usr/local/bin/phing \
  && which phing \
  && phing -version \
  && pecl install uopz-2.0.7 \
  && chmod +x /usr/local/bin/uopz \
  # && echo "extension=uopz.so" > /usr/local/etc/php/conf.d/uopz.ini \
  && pecl install ssh2-0.13 \
  && echo "extension=ssh2.so" > /usr/local/etc/php/conf.d/ssh2.ini \
  && docker-php-ext-install opcache soap pdo_mysql intl

RUN pecl install xdebug \
  && chmod +x /usr/local/bin/xdebug \
  && php -m
  # && echo "zend_extension=xdebug.so" > /usr/local/etc/php/conf.d/xdebug.ini

RUN cat $HOME/.ssh/config && chmod -R 600 $HOME/.ssh &&  ls -l $HOME/.ssh/config

CMD php -a
