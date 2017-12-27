#!/bin/bash
docker run -d -p 6379:6379 \
	-v `pwd`/redis-server.conf:/etc/redis-server.conf:rw \
	--name redis-server \
	zhaohongbo/redis-server:3.2
