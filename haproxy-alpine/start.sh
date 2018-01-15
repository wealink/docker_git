#!/bin/bash
docker run -d -p 80:80 \
	-v `pwd`/haproxy.cfg:/usr/local/etc/haproxy/haproxy.cfg:rw \
	--name haproxy \
	zhaohongbo/haproxy:1.6
