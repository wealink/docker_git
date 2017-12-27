#!/bin/bash
docker run -d -p 9000:9000 \
	-v `pwd`/etc/php-fpm.conf:/usr/local/etc/php-fpm.conf:rw \
	-v `pwd`/etc/www.conf:/usr/local/etc/php-fpm.d/www.conf:rw \
	-v `pwd`/web:/opt/web:rw \
	--name php \
	zhaohongbo/php:7.2 
