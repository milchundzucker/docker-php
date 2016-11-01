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
  && pecl install uopz-2.0.7 \
  && docker-php-ext-install opcache soap pdo_mysql \
  && php -m
  # && mkdir -p $HOME/.ssh \
  # && ls -l $HOME/.ssh
  && chmod +x /usr/local/bin/uopz \
  # && echo "extension=uopz.so" > /usr/local/etc/php/conf.d/uopz.ini \

RUN pecl install xdebug \
  && chmod +x /usr/local/bin/xdebug
  # && echo "zend_extension=xdebug.so" > /usr/local/etc/php/conf.d/xdebug.ini

RUN cat $HOME/.ssh/config && chmod -R 600 $HOME/.ssh &&  ls -l $HOME/.ssh/config

CMD php -a
