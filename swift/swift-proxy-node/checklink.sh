#!/bin/bash

#在脚本执行目录下创建日志文件 .log 和检测的最终结果文件.dat 
resultfile=$PWD/checklink.dat 
log_file=$PWD/checklink.log 


#读取传递的脚本参数 
IP=$1 
port=$2 

# IP="192.168.11.116"
# port=22
RATE=`ping -c 4 -w 3 $IP | grep 'packet loss' | grep -v grep | awk -F',' '{print $3}' | awk -F'%' '{print $1}'`     #得到丢包的比例的数值 
#RATE=`ping -c 4 -w 3 $IP | grep 'packet loss' | grep -v grep | cut -f3 -d, | cut -f1 -d%` 

echo " ${RATE} lost"
if [ $RATE -ge 50 ];     #这个值具体可以设置成75、50等等，这里设置成包全丢的情况下为不通 
then 
    echo `date +"%Y.%m.%d %T"`" ping the $IP is not connected, FAILURE" >> ${log_file} 
    echo "ping FAILURE"           #全丢了说明该IP地址不通 
else 

    echo "ping SUCCESS"           #ping该IP地址 通 
    #否则telnet命令检测指定端口号PORT是否连通，如果可以连通，则立马quit退出连接，将连接结果和错误信息等都写入到结果文件中 
    telnet $IP $port<<@@@ 2>${resultfile} 1>&2               
quit 
@@@
    # echo "$(cat ${resultfile})"

    RESULT=`cat ${resultfile} 2>/dev/null | grep "Connection closed by foreign host" | wc -l`        #匹配看结果文件中手否有这句话 
    # echo `date +"%Y.%m.%d %T"`"the result of telnet is $RESULT" >${log_file} 
    
    if [ $RESULT -eq 1 ]; 
    then 
        echo `date +"%Y.%m.%d %T"`" telnet the $IP and $port SUCCESS" >> ${log_file}         #如果有的话就说明该端口是通的，返回结果字符串SUCCESS到文件并同时打印大屏幕上 
        echo "telnet SUCCESS" 
    else 
        echo `date +"%Y.%m.%d %T"`" telnet the $IP and $port FAILURE" >> ${log_file}           #否则就说明该端口是不通的，打印FAILURE 
        echo "telnet FAILURE" 
    fi 
fi 