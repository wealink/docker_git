#!/bin/bash
docker build -t zhaohongbo/tomcat:8 .
docker run -d -p 8080:8080 \
	-v `pwd`/conf:/opt/tomcat/conf:rw \
	-v `pwd`/webapps:/opt/tomcat/webapps:rw \
	-v `pwd`/logs:/opt/tomcat/logs:rw \
	-v `pwd`/bin:/opt/tomcat/bin:rw \
	--name tomcat \
	zhaohongbo/tomcat:8
