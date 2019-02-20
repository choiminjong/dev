#!/bin/bash

while read CI_FILE 
do 
	IFS='|' eval 'array=($CI_FILE)'
	#echo "${array[0]} => ${array[1]}"
	
	#파일 유무 체크
	if [ -f ${array[1]} ] 
	then
		echo "File exist > [${array[1]}]"
	else	
		#파일이 존재하지않으면 JOP STOP
		echo "Not exists. "${array[1]}
		exit 1
	fi	
done < /home/jira-conf/jira/cp_file.txt 


while read CI_FILE 
do 
	IFS='|' eval 'array=($CI_FILE)'
	
	echo "moving files"
	
	echo ${array[0]} ${array[1]}
	\cp ${array[0]} ${array[1]}
	
	
	#echo "GIT_DIR=>"${array[0]}
	#echo "DEFAULT_DIR=>"${array[1]}	
done < /home/jira-conf/jira/cp_file.txt 