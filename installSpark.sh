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

sudo mkdir /opt/apache-spark
sudo chmod 777 /opt/apache-spark
echo "解压中"
tar -xvf $filePath/spark*.tar -C /opt/apache-spark
echo "解压完成"
sparkName=$(cd /opt/apache-spark/spark-2.4.8-bin-hadoop2.7 && pwd | awk -F "/" '{print $NF}')
echo "export SPARK_HOME=/opt/apache-spark/${sparkName}" >> /etc/profile
echo "export PATH=$PATH:$JAVA_HOME/bin:$SPARK_HOME/bin" >> /etc/profile
#刷新使配置文件立即生效
source /etc/profile
cd /opt/apache-spark/spark-2.4.8-bin-hadoop2.7/conf
cp spark-env.sh.template spark-env.sh
echo "配置JAVA_HOME环境"
echo "JAVA_HOME=/opt/jdk/jdk1.8.0_162" >> spark-env.sh
cd /opt/apache-spark/spark-2.4.8-bin-hadoop2.7/sbin
./stop-all.sh
echo "启动Spark中....."
./start-all.sh
cd /opt/apache-spark/spark-2.4.8-bin-hadoop2.7/bin
jps