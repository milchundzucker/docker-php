FROM php:7.1
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
  libbz2-dev \
  libgmp3-dev \
  --no-install-recommends && apt-get clean

ENV COMPOSER_ALLOW_SUPERUSER 1
ENV COMPOSER_HOME /composer

RUN set -xe \
  && echo "date.timezone=${PHP_TIMEZONE:-UTC}" > ${PHP_INI_DIR}/conf.d/date_timezone.ini \
  && php -v \
  && cd /tmp \
  && php -r "readfile('https://getcomposer.org/installer');" > composer-setup.php \
  && php composer-setup.php \
  && php -r "unlink('composer-setup.php');" \
  && mv composer.phar /usr/local/bin/composer \
  && which composer \
  && composer --version \
  && curl -L http://www.phing.info/get/phing-latest.phar -o /usr/local/bin/phing --silent \
  && chmod +x /usr/local/bin/phing \
  && which phing \
  && phing -version \
  && pecl install uopz-5.0.2 \
  && chmod +x /usr/local/bin/uopz \
  # && echo "extension=uopz.so" > ${PHP_INI_DIR}/conf.d/uopz.ini \
  && pecl install ssh2-1.1.2 \
  && echo "extension=ssh2.so" > ${PHP_INI_DIR}/conf.d/ssh2.ini \
  && docker-php-ext-install opcache soap pdo_mysql intl bz2 gmp sockets \
  && curl -o libsodium.tar.gz https://download.libsodium.org/libsodium/releases/LATEST.tar.gz \
  && tar -xf libsodium.tar.gz \
  && rm -f libsodium.tar.gz \
  && mv libsodium* libsodium \
  && cd libsodium \
  && ./configure \
  && make -s \
  && make -s install \
  && cd .. \
  && rm -Rf libsodium \
  && pecl install libsodium \
  && echo "extension=sodium.so" > ${PHP_INI_DIR}/conf.d/sodium.ini

RUN pecl install xdebug \
  && chmod +x /usr/local/bin/xdebug \
  && php -m
  # && echo "zend_extension=xdebug.so" > ${PHP_INI_DIR}/conf.d/xdebug.ini

RUN cat $HOME/.ssh/config && chmod -R 600 $HOME/.ssh &&  ls -l $HOME/.ssh/config

CMD php -a
