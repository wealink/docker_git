#!/bin/bash
docker run -d -p 80:80 \
              -p 443:443 \
	      -v `pwd`/conf:/opt/nginx/conf:rw \
	      -v `pwd`/html:/opt/nginx/html:rw \
	      -v `pwd`/logs:/opt/nginx/logs:rw \
	      --name nginx \
	      zhaohongbo/nginx1.10
