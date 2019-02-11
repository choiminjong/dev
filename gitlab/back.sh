#!/bin/bash

#USER
USER=jira

#BACK FOLDER
SRC_DIR="/opt/atlassian/jira/conf/back"
FIND_TIME=conf-`date +"%Y%m%d"`
TEMP_DIR=$SRC_DIR/$FIND_TIME

#DEFAULT FOLDER
DEFAULT_DIR="/opt/atlassian/jira/conf"

#GIT FOLDER
GIT_DIR="/home/jira-conf/jira"

echo "CI_COMMIT_TITLE=>"$CI_COMMIT_TITLE
echo "CI_COMMIT_MESSAGE=>"$CI_COMMIT_MESSAGE

if [ $SRC_DIR ] #파일 명 인자 체크
then
	if [ -d $TEMP_DIR ] #파일 유무 체크
	then
		echo "파일이 존재합니다."
		
		if [ -f $DEFAULT_DIR/$CI_COMMIT_TITLE ] #파일 유무 체크
		then
			echo "존재하는 파일 이동"
			\cp $DEFAULT_DIR/$CI_COMMIT_TITLE $TEMP_DIR/$CI_COMMIT_TITLE.`date +"%Y-%m-%d"`-`date +"%H:%M:%S"`
			\cp $GIT_DIR/$CI_COMMIT_TITLE $DEFAULT_DIR/$CI_COMMIT_TITLE
		fi
		
	elif [ ! -d $TEMP_DIR ] 
	then
		echo "파일이 존재안합니다."
		
		if [ -f $DEFAULT_DIR/$CI_COMMIT_TITLE ] #파일 유무 체크
		then
			echo "존재하는 파일 이동"
			mkdir $TEMP_DIR
			chown $USER:$USER $TEMP_DIR			
			\cp $DEFAULT_DIR/$CI_COMMIT_TITLE $TEMP_DIR/$CI_COMMIT_TITLE.`date +"%Y-%m-%d"`-`date +"%H:%M:%S"`
			\cp $GIT_DIR/$CI_COMMIT_TITLE $DEFAULT_DIR/$CI_COMMIT_TITLE
		fi
	fi	
fi

