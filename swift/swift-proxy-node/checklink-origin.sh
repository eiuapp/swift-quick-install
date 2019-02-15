#!/bin/bash 

# shell script: checklink.sh 
# function: auto check the link of server IP and PORT 
# date:   2016.04.07 
# modify: 2016.04.07 
# copyright by Li Jian. 
# https://blog.csdn.net/james_lee1314/article/details/51103721
# https://www.jianshu.com/p/92adf516a62d

# 根据系统类型的不同，加载系统环境变量 
if [ `uname` = "Linux" ] 
then 
  PROFILE=.bash_profile 
else 
  PROFILE=.profile 
fi

. $HOME/$PROFILE 

#在脚本执行目录下创建日志文件 .log 和检测的最终结果文件.dat 
resultfile=$PWD/checklink.dat 
log_file=$PWD/checklink.log 

#判断脚本执行的时候传递的参数个数是否正确，包括ip地址和端口号port两个参数 
if [ $# -ne 2 ] 
then 
    echo `date +"%Y.%m.%d %T"`"the parameter numbers are not correct,exit!" >>${log_file} 
    exit 
fi 

#读取传递的脚本参数 
IP=$1 
port=$2 

#判断两个参数是否为空 
if [ -z $IP -o -z $port ] 
then 
    echo `date +"%Y.%m.%d %T"`"the parameter should not be null,exit!" >>${log_file} 
    exit 
fi 

#通过Ping命令先检测指定的ip地址是否能连通，通过ping命令发送四个包(可以是发送另外的数量)，限制超时时间为3秒钟(也可以是其他值，具体要看能忍受多长时间的延迟)，主要根据丢包的比例来决定该ip地址是否能连通，比如ping 百度返回id结果如下：

# zxin10@ubuntu:~/lijian$ ping www.baidu.com -c 4 -w 3
# PING www.a.shifen.com (180.97.33.108) 56(84) bytes of data.
# 64 bytes from 180.97.33.108: icmp_seq=1 ttl=128 time=3.79 ms
# 64 bytes from 180.97.33.108: icmp_seq=2 ttl=128 time=5.32 ms
# 64 bytes from 180.97.33.108: icmp_seq=3 ttl=128 time=3.92 ms


# --- www.a.shifen.com ping statistics ---
# 3 packets transmitted, 3 received, 0% packet loss, time 2004ms

RATE=`ping -c 4 -w 3 $IP | grep 'packet loss' | grep -v grep | awk -F',' '{print $3}' | awk -F'%' '{print $1}'`     #得到丢包的比例的数值 
#RATE=`ping -c 4 -w 3 $IP | grep 'packet loss' | grep -v grep | cut -f3 -d, | cut -f1 -d%` 


if [ $RATE -ge 50 ]     #这个值具体可以设置成75、50等等，这里设置成包全丢的情况下为不通 
then 
    echo `date +"%Y.%m.%d %T"`" ping the $IP is not connected, FAILURE" >${log_file} 
    echo "FAILURE"           #全丢了说明该IP地址不通 
else 
    # 否则telnet命令检测指定端口号PORT是否连通，如果可以连通，则立马quit退出连接，将连接结果和错误信息等都写入到结果文件中
    telnet $IP $port<<@@@ 2>${resultfile} 1>&2                
quit 
@@@


    RESULT=`cat ${resultfile} 2>/dev/null | grep "Connection closed by foreign host" | wc -l`        #匹配看结果文件中手否有这句话 
    echo `date +"%Y.%m.%d %T"`"the result of telnet is $RESULT" >${log_file} 
     
    if [ $RESULT -eq 1 ] 
    then 
        echo `date +"%Y.%m.%d %T"`" telnet the $IP and $port SUCCESS" >>${log_file}         #如果有的话就说明该端口是通的，返回结果字符串SUCCESS到文件并同时打印大屏幕上 
        echo "SUCCESS" 
    else 
        echo `date +"%Y.%m.%d %T"`" telnet the $IP and $port FAILURE" >>${log_file}           #否则就说明该端口是不通的，打印FAILURE 
        echo "FAILURE" 
    fi 
fi 


rm -f ${resultfile}            #删除结果文件，日志文件保留