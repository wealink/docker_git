#!/bin/bash
maindir=/opt
datadir=/data/mysql
pass=152258
#创建和管理用户"=
if [ `id mysql|echo $?` -ne 0 ];then
	groupadd -r mysql
	useradd -g mysql -r -s /sbin/nologin mysql
	if [ $? -eq 0 ];then
		echo "创建Mysql用户成功!!!"
	fi
else 
	echo "Mysql用户已存在!!!"
fi

#清理老数据
rm -rf /etc/init/mysqld /etc/my.cnf ${maindir}/mysql55 ${datadir}
if [ $? -eq 0 ];then
	echo "清理成功!!!"
else
	echo "清理失败!!!"
	exit 1
fi

#目录权限设置
mkdir -p ${datadir}/{data,log}
chown -R mysql:mysql $datadir
count=`ls -l ${datadir}/ |grep mysql|wc -l`
if [ $count -eq 2 ];then
	echo "创建数据、日志目录成功!!!"
else
	echo "创建失败!!!"
	exit 2
fi

#调整数据库安装路径/opt
tar -xf mysql-5.5.28-linux2.6-x86_64.tar.gz -C /opt
mv /opt/mysql-5.5.28-linux2.6-x86_64 ${maindir}/mysql55
cd ${maindir}/mysql55
if [ $? -eq 0 ];then
	echo "切换到应用目录成功!!!"
else
	echo "切换到应用目录失败!!!"
	exit 3
fi
chown -R mysql:mysql  .

echo "初始化数据库"
scripts/mysql_install_db --user=mysql --datadir=${datadir}/data &> /dev/null
if [ $? -eq 0 ];then
	echo "初始化成功!!!"
else
	echo "初始化失败!!!"
	exit 4
fi

echo "修改配置文件"
cd - &> /dev/null
cp my.cnf /etc/my.cnf
sed -i "s#^datadir		= /data/mysql/data#datadir=${datadir}/data#" /etc/my.cnf
sed -i "s#^slow_query_log_file=/data/mysql/log/slow_query.log#slow_query_log_file=${datadir}/log/slow_query.log#" /etc/my.cnf
egrep "^datadir" /etc/my.cnf
grep "slow_query_log_file" /etc/my.cnf


echo "修改启动文件"
cp ${maindir}/mysql55/support-files/mysql.server  /etc/init.d/mysqld
sed -i "s#^basedir=#basedir=${maindir}/mysql55#" /etc/init.d/mysqld
sed -i "s#^datadir=#datadir=${datadir}/data#" /etc/init.d/mysqld
egrep "^basedir" /etc/init.d/mysqld
egrep "^datadir" /etc/init.d/mysqld

echo "修改环境变量、修改密码"
cp ${maindir}/mysql55/bin/mysql* /usr/bin/
service mysqld start
mysqladmin -uroot password "$pass"
