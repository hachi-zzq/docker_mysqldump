FROM alpine:3.6

MAINTAINER hachi.zzq@gmail.com

RUN apk add --no-cache mysql-client

RUN mkdir -p /opt/backup

VOLUME ["/opt/backup"]

COPY mysqlback.sh /etc/periodic/daily

ENTRYPOINT ["crond", "-f"]


