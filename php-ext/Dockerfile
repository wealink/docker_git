FROM zhaohongbo/php:7.2
ENV PHPREDIS_VERSION 3.1.3
RUN curl -L -o /tmp/redis.tar.gz https://github.com/phpredis/phpredis/archive/$PHPREDIS_VERSION.tar.gz \
    && tar xfz /tmp/redis.tar.gz \
    && rm -r /tmp/redis.tar.gz \
    && mkdir -p /usr/src/php/ext \
    && mv phpredis-$PHPREDIS_VERSION /usr/src/php/ext/redis \
    && docker-php-ext-install redis \
    && rm -rf /usr/src/php

RUN apk add gcc make autoconf libc-dev git \
	&& cd /tmp \
	&& git clone --depth=1 "git://github.com/phalcon/cphalcon.git" \
	&& cd cphalcon/build \
	&& ./install \
	&& docker-php-ext-enable phalcon \
	&& apk del gcc make autoconf libc-dev git \
	&& rm -rf /tmp/cphalcon 
