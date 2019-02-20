#!/bin/bash

while read CI_FILE 
do 
	IFS='|' eval 'array=($CI_FILE)'
	
	#건너뛰기 
	if [[ ${array[0]} =~ "#" ]]; then
		echo "matched > [${array[0]}]"
	else
		#NULL CHECK
		if [ ! -z "${array[0]}" ] ; then
			#파일 유무 체크
			if [ -f ${array[1]} ] 
			then
				echo "File exist > [${array[1]}]"
			else	
				#파일이 존재하지않으면 JOP STOP
				echo "Not exists. "${array[1]}
				exit 1
			fi	
		fi	
	fi
done < /home/jira-conf/jira/cp_file.txt 


while read CI_FILE 
do 
	IFS='|' eval 'array=($CI_FILE)'
	
	#건너뛰기 
	if [[ ${array[0]} =~ "#" ]]; then
		echo "matched > [${array[0]}]"
	else
		#NULL CHECK
		if [ ! -z "${array[0]}" ] ; then
			#파일 유무 체크
			if [ -f ${array[1]} ] 
			then
				echo "move==> "${array[0]} ${array[1]}
				\cp ${array[0]} ${array[1]}
			fi	
		fi	
	fi
done < /home/jira-conf/jira/cp_file.txt 

