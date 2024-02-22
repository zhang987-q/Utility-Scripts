#!/bin/bash

local_ip=`hostname -I`
echo "##########IP##########"
echo $local_ip
##内存
size=`dmidecode -t Memory|egrep -w  "Size"|grep -v "No Module Installed"|awk '{print $2}'|head -n1`
sum=`dmidecode -t Memory|egrep -w  "Size"|grep -v "No Module Installed"|wc -l`
pingpai=`dmidecode -t Memory|grep Manufacturer|grep -v Unknown|awk '{print $NF}'|head -n1`
speed=`dmidecode -t Memory|grep Speed|grep -v Unknown|grep -v Configured|awk -F ':' '{print $2}'|head -n1`
echo "----------内存----------"
echo "大小: $size G"
echo "条数: $sum"
echo "品牌: $pingpai"
echo "频率:$speed"
##cpu
name=`lscpu|grep "Model name"|awk -F ':' '{print $2}'`
cpusum=`lscpu|grep "Thread(s) per core"|awk '{print $NF}'`
echo "----------CPU----------"
echo "型号:$name"
echo "颗数: $cpusum"

##GPU
echo "----------GPU----------"
echo "$(nvidia-smi -L)"

#disk
ld=`lsblk|grep disk|awk '{print $1}'`
echo "----------硬盘----------"
for i in $ld;
do
	diskname=`smartctl -a /dev/$i|grep "Model"|awk -F ':' '{print $NF}'`
	SN=`smartctl -a /dev/$i|grep "Serial Number"|awk -F ':' '{print $NF}'`
	disksize=`smartctl -a /dev/$i|grep "Capacity"|head -n1|awk -F ':' '{print $2}'`
	echo "盘符: $i"
	echo "品牌: $diskname"
	echo "SN: $SN"
	echo "大小: $disksize"
done

