#! /bin/bash
# sudo chmod 777 /etc/profile
#filePath jdk下载包的路径
filePath=~/Downloads
#登陆用户
user=$(whoami)
if [ ${user} != root ]
then
#普通用户需要赋予权限执行配置文件
echo "请输入登录用户密码给予配置文件权限，配合后续步骤需要！"
sudo chmod 777 /etc/profile
fi

#检测用户是否安装java
java -verson > /dev/null 2>&1
if [ $? != 0 ]
then
echo "没有安装jdk"
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
echo "export JAVA_HOME=//opt/jdk${jdkName}" >> /etc/profile
echo "export PATH=$JAVA_HOME/bin:$PATH" >> /etc/profile
echo "export CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar" >> /etc/profile
#刷新使配置文件立即生效
source /etc/profile
echo "jdk8安装完成"
java -version
else
echo "已经安装jdk"
echo $JAVA_HOME | grep jdk1.8
if [[ $? != 0 ]]; then
	echo "已经安装jdk的版本高于1.8或者低于1.8"
	echo "准备删除中...."
fi
fi