#! /bin/bash
#  Created by SunYun on 2021/6/7.
#  Copyright © 2021 SunYun. All rights reserved
#登陆用户
user=$(whoami)
if [ ${user} != root ]
then
#普通用户需要赋予权限执行配置文件
echo "后期运行spark会要求请输入登录用户密码！"
#sudo chmod 777 /etc/profile
sudo mkdir ~/Downloads
#echo -n "是否需要通过scp下载jdk和spark2文件 Y or N"
#read INPUT
#if [ $INPUT=Y -o $INPUT=y ]
#then
#	echo "密码内部使用..."
#	scp sunyun@101.32.75.46:~Downloads ~/Downloads
#else
#	"请通过百度网盘下载到～Downloads目录下哦"
#fi
sudo chmod +x *.sh
fi
filePath=~/Downloads
function installJdk8(){
	sudo mkdir /opt/jdk
	sudo chmod 777 /opt/jdk
	echo "解压中"
	#tar -xzvf $filePath/jdk*.tar.gz -C ~/jdk
	tar -xzf $filePath/jdk*.tar.gz -C /opt/jdk
	echo "解压完成"
	#cd ~/jdk/jdk1.8.0_162
	# NF字段数量变量
	#pwd | awk -F "/" '{print $NF}'
	jdkName=$(cd /opt/jdk/jdk1.8.0_162 && pwd | awk -F "/" '{print $NF}')
	echo "jdk安装版本为${jdkName}"
	#echo "export JAVA_HOME=/home/${user}/jdk/jdk1.8.0_162" >> /etc/profile
	echo "export JAVA_HOME=/opt/jdk/${jdkName}" >> .bashrc
	echo "export PATH=$PATH:$JAVA_HOME/bin:" >> .bashrc
	echo "export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar" >> .bashrc
	#刷新使配置文件立即生效
	#source /etc/profile
	source .bashrc
	echo "jdk8安装完成"
}
function installSpark2(){
	sudo mkdir /opt/apache-spark
	sudo chmod 777 /opt/apache-spark
	echo "解压中"
	tar -xvf $filePath/spark*.tar -C /opt/apache-spark
	echo "解压完成"
	sparkName=$(cd /opt/apache-spark/spark-2.4.8-bin-hadoop2.7 && pwd | awk -F "/" '{print $NF}')
	echo "export SPARK_HOME=/opt/apache-spark/${sparkName}" >> .bashrc
	echo "export PATH=$PATH:$JAVA_HOME/bin:$SPARK_HOME/bin" >> .bashrc
	#刷新使配置文件立即生效
	#source /etc/profile
	source .bashrc
	cd /opt/apache-spark/spark-2.4.8-bin-hadoop2.7/conf
	cp spark-env.sh.template spark-env.sh
	echo "配置JAVA_HOME环境"
	echo "JAVA_HOME=/opt/jdk/jdk1.8.0_162" >> spark-env.sh
	cd /opt/apache-spark/spark-2.4.8-bin-hadoop2.7/sbin
	./stop-all.sh
	echo "启动Spark中....."
	./start-all.sh
}
function installProcess(){
	installJdk8
	echo "开始安装spark2"
	installSpark2
	echo "spark2安装完成"
	cd /opt/apache-spark/spark-2.4.8-bin-hadoop2.7/bin;spark-submit /home/user/stu-count.py
	#echo "重启后java环境生效"
}
java -verson > /dev/null 2>&1
if [ $? != 0 ]
then
	echo "没有安装jdk，即将安装jdk1.8版本到/opt/jdk目录下"
	installProcess
elif [ $? == 0 ]
 then
	echo $JAVA_HOME | grep openjdk
	if [ $? != 0 ]
	then
		sudo apt-get remove openjdk*
		installProcess
	fi
fi







