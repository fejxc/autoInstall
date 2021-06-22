# autoInstall
## 脚本安装jdk、spark、hadoop等

### 使用说明

### 1.克隆项目

``git clone https://github.com/fejxc/autoInstall.git`` 到本地

### 2.下载spark2 和jdk8 

链接: https://pan.baidu.com/s/1fdy5hkwmI-StqhOrJWOoqQ  密码: 4q5c

<img src="README/image-20210608215635534.png" alt="spark和jdk下载" style="zoom:50%;" />

### 3.下载后安装包到家的根目录～

### 4.执行脚本安装jdk8和spark2

``cd autoInstall``

`` sudo chmod +x *.sh``

``./InstallJdkSpark.sh``

``sudo shutdown -r now``

#### 注意：在安装过程中可能会出现3次要求输入当前用户密码

​				**重启后java环境生效**

### 5.重启后执行例子

#### 5.1执行之前修改 word-count.py中的 input = sc.textFile(``"file://book.txt"``)改为自己本地的路径

``cd /opt/apache-spark/spark-2.4.8-bin-hadoop2.7/bin``

``./spark-submit   ~/autoInstall/word-count.py``

#### 5.2执行之前修改 stu-count.py中

```python
people = spark.read.option("header", "true").option("inferSchema", "true")\
    .csv("file:///home/happy/Downloads/data")
```

``happy``改为自己的登录用户名

运行 stu-count.py之前确保安装了python2.7+

``sudo apt install python`` 安装python2.7

