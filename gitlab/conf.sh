#!/bin/bash

#DEFAULT FOLDER
DEFAULT_DIR="/opt/atlassian/jira/conf"
#DEFAULT_DIR="/data/jiraapp/jira/conf"

#GIT FOLDER
GIT_DIR="/home/jira-conf/jira"


#짜르기 
CI_FILE_ARY=$(echo $CI_COMMIT_TITLE | tr "|" "\n")

for CI_FILE in $CI_FILE_ARY
do
	if [ -f $DEFAULT_DIR/$CI_FILE ] #파일 유무 체크
	then
		echo "File exist > [$CI_FILE]"
	else	
		#파일이 존재하지않으면 JOP STOP
		echo "Not exists. "$CI_FILE
		exit 1
	fi	
done

#파일이동
for CI_FILE in $CI_FILE_ARY
do
	echo "moving files"
	#\cp $GIT_DIR/$CI_FILE $DEFAULT_DIR/$CI_FILE
	
	echo "GIT_DIR=>"$GIT_DIR/$CI_FILE
	echo "DEFAULT_DIR=>"$DEFAULT_DIR/$CI_FILE	
done
