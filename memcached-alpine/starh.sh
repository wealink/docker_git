#!/bin/bash
docker run -d -p 11211:11211 \
	--name memcached \
	zhaohongbo/memcached:1.5 
