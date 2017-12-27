FROM alpine:3.5
LABEL maintainer="zhb"

RUN apk update && apk add curl bash tree tzdata \
    && cp -r -f /usr/share/zoneinfo/Hongkong /etc/localtime 

CMD ["/bin/sh"]
