#!/bin/bash
#批量添加指定数量的用户
# Author: fejxc （E-mail: 1031364436@qq.com）

read -p "Please input user name: " -t 30 name
#让用户输入用户名，把输入保存入变量name
read -p "Please input the number of users: " -t 30 num 
#让用户输入添加用户的数量，把输入保存入变量num


if [ ! -z "$name" -a ! -z "$num" ]
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
                        /usr/sbin/userdel  $name$i  &>/dev/null
done
        fi  
fi