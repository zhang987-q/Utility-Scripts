#!/bin/bash

local_ip=`hostname -I`
echo "##########IP##########"
echo $local_ip
size=`dmidecode -t Memory|egrep -w  "Size"|grep -v "No Module Installed"|awk '{print $2}'|head -n1`
sum=`dmidecode -t Memory|egrep -w  "Size"|grep -v "No Module Installed"|wc -l`
pingpai=`dmidecode -t Memory|grep Manufacturer|grep -v Unknown|awk '{print $NF}'|head -n1`
speed=`dmidecode -t Memory|grep Speed|grep -v Unknown|grep -v Configured|awk -F ':' '{print $2}'|head -n1`
echo "----------MEM----------"
echo "size: $size G"
echo "sum: $sum"
echo "brand: $pingpai"
echo "speed:$speed"
##cpu
name=`lscpu|grep "Model name"|awk -F ':' '{print $2}'`
cpusum=`lscpu|grep "Thread(s) per core"|awk '{print $NF}'`
echo "----------CPU----------"
echo "model:$name"
echo "sum: $cpusum"

##GPU
echo "----------GPU----------"
echo "$(nvidia-smi -L)"

#disk
ld=`lsblk|grep disk|awk '{print $1}'`
echo "----------DISK----------"
for i in $ld;
do
	diskname=`smartctl -a /dev/$i|grep "Model"|awk -F ':' '{print $NF}'`
	SN=`smartctl -a /dev/$i|grep "Serial Number"|awk -F ':' '{print $NF}'`
	disksize=`smartctl -a /dev/$i|grep "Capacity"|head -n1|awk -F ':' '{print $2}'`
	echo "disk number: $i"
	echo "brand: $diskname"
	echo "SN: $SN"
	echo "size: $disksize"
done

