FROM alpine:3.6

MAINTAINER hachi.zzq@gmail.com

RUN apk update && apk add curl bash tree tzdata \
&& cp -r -f /usr/share/zoneinfo/Hongkong /etc/localtime \
&& apk add --no-cache mysql-client

RUN mkdir -p /opt/backup

VOLUME ["/opt/backup"]

COPY mysqlback.sh /etc/periodic/daily/mysqlback

RUN chmod a+x /etc/periodic/daily/mysqlback

ENTRYPOINT ["crond", "-f"]


