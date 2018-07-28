#!/bin/bash

#1.数据库信息定义
mysql_host=$MYSQL_HOST
mysql_user=$MYSQL_USER
mysql_passwd=$MYSQL_PASSWORD
mysql_port=$MYSQL_PORT


#当前日期
date=$(date -d '+0 days' +%Y%m%d)

#sql备份目录
back_dir="/opt/backup"
back_date_dir=$back_dir/$date


if [ ! -d $back_date_dir ]; then
	mkdir -p $back_date_dir
fi

#备份的数据库数组
db_arr=$(echo "show databases;" | mysql -u$mysql_user -p$mysql_passwd -h$mysql_host -p$mysql_port)
#不需要备份的单例数据库


zipname="enstar_bak_"$date".tar.bz"


#2.进入到备份目录
cd $back_date_dir


#3.循环备份
for dbname in ${db_arr}
do
	if [ $dbname != 'Database' -a $dbname != 'information_schema' -a $dbname != 'mysql' -a $dbname != 'phpmyadmin' -a $dbname != 'performance_schema' ];then
		sqlfile=$dbname-$date".sql"
		mysqldump -u$mysql_user -p$mysql_passwd -h$mysql_host -P$mysql_port $dbname >$sqlfile
    fi
done

cd ..

#4.tar打包所有的sql文件
tar -jcf $back_dir/$zipname  $date/*
#打包成功后删除sql文件
if [ $? = 0 ]; then
rm -rf $back_date_dir
fi