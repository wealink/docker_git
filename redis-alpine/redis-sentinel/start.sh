#!/bin/bash
docker run -d -p 26379:26379 \
	-v `pwd`/redis-sentinel.conf:/etc/redis-sentinel.conf:rw \
	--name redis-sentinel \
	zhaohongbo/redis-sentinel:3.2
