#!/bin/bash
docker run -d -p 80:80 \
              -p 443:443 \
	      -v `pwd`/conf/nginx.conf:/opt/nginx/conf/nginx.conf:rw \
	      -v `pwd`/conf/conf.d:/opt/nginx/conf/conf.d:rw \
	      -v `pwd`/logs:/opt/nginx/logs:rw \
	      -v `pwd`/web:/opt/web:rw \
	      --name nginx \
	      zhaohongbo/nginx:1.12
