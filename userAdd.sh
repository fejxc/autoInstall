#!/bin/bash
#批量添加指定数量的用户
# Author: fejxc （E-mail: 1031364436@qq.com）

read -p "Please input user name: " -t 30 name
#让用户输入用户名，把输入保存入变量name
read -p "Please input the number of users: " -t 30 num 
#让用户输入添加用户的数量，把输入保存入变量num
read -p "Please input the password of users: " -t 30 pass
#让用户输入初始密码，把输入保存如变量pass

if [ ! -z "$name" -a ! -z "$num" -a ! -z "$pass" ]
#判断三个变量不为空
        then
        y=$(echo $num | sed 's/[0-9]//g')
		#定义变量的值为后续命令的结果
		#后续命令作用是，把变量num的值替换为空。如果能替换为空，证明num的值为数字
		#如果不能替换为空，证明num的值为非数字。我们使用这种方法判断变量num的值为数字
        if [ -z "$y" ]
		#如果变量y的值为空，证明num变量是数字
                then
                for (( i=1;i<=$num;i=i+1 ))
				#循环num变量指定的次数
                    do  
                        /usr/sbin/useradd $name$i -s /bin/bash -m &>/dev/null
						#添加用户，用户名为变量name的值加变量i的数字
			echo $name$i:$pass | chpasswd >> ~/user.log
                        #echo $pass | /usr/bin/passwd --stdin $name$i &>/dev/null                  
                        #passwd的--stdin参数ubuntu不支持，其实debian就不支持这个
						#给用户设定初始密码为变量pass的值


                    	chage -d 0 $name$i &>/dev/null
						#强制用户登录之后修改密码
done
        fi  
fi