#!/bin/bash

#JIRA_HOME
JIRA_HOME_SRC="/var/atlassian/application-data/jira"
#JIRA_HOME_SRC="/data/jiraapp/jira"

#JIRA_BACK
JIRA_HOME_BACK="/data/backup/config/application-data/jira"

#JIRA_INSTALL
JIRA_INSTALL_SRC="/opt/atlassian/jira"
#JIRA_INSTALL_SRC="/data/jiraapp/jira"

#JIRA_BACK
JIRA_INSTALL_BACK="/data/backup/config/jiraapp"

#/data/jiraapp/jira/bin
cp $JIRA_INSTALL_SRC/bin/user.sh $JIRA_INSTALL_SRC/bin/setenv.sh $JIRA_INSTALL_BACK/bin/.

cp /data/jiraapp/jira/bin/user.sh /data/jiraapp/jira/bin/setenv.sh /data/backup/config/jiraapp/bin/.

#/data/jiraapp/jira/conf
cp $JIRA_INSTALL_SRC/conf/context.xml $JIRA_INSTALL_SRC/conf/server.xml $JIRA_INSTALL_SRC/conf/web.xml $JIRA_INSTALL_BACK/conf/.

#/data/jiraapp/jira/atlassian-jira/WEB-INF
cp $JIRA_INSTALL_SRC/atlassian-jira/WEB-INF/web.xml $JIRA_INSTALL_BACK/atlassian-jira/WEB-INF/.
cp $JIRA_INSTALL_SRC/atlassian-jira/WEB-INF/classes/jira-application.properties $JIRA_INSTALL_BACK/atlassian-jira/WEB-INF/classes/.
cp $JIRA_INSTALL_SRC/atlassian-jira/WEB-INF/classes/log4j.properties $JIRA_INSTALL_BACK/atlassian-jira/WEB-INF/classes/.
cp $JIRA_INSTALL_SRC/atlassian-jira/WEB-INF/classes/seraph-config.xml $JIRA_INSTALL_BACK/atlassian-jira/WEB-INF/classes/.

#/data/application-data/jira
cp $JIRA_HOME_SRC/dbconfig.xml $JIRA_HOME_BACK/.
cp $JIRA_HOME_SRC/jira-config.properties $JIRA_HOME_BACK/.

#/data/application-data/jira/plugins
cp -r $JIRA_HOME_SRC/plugins/installed-plugins $JIRA_HOME_BACK/plugins/.

#Apache
#/etc/httpd
#cp /etc/httpd/conf/httpd.conf /data/backup/httpd/conf/.
#cp /etc/httpd/conf.d/ssl.conf /data/backup/httpd/conf.d/.

USER="jira"
FIND_FOLDER=/data/backup/backup-`date +"%Y%m%d"`

if [ -d $FIND_FOLDER ] #파일 유무 체크
then
	echo "Make.tar file"
	tar -cvf $FIND_FOLDER/application-backup-`date +"%m-%d-%Y"`-`date +"%H:%M:%S"`.tar /data/backup/config
elif [ ! -d $FIND_FOLDER ] 
then
	echo "tar file"
	mkdir $FIND_FOLDER
	chown $USER:$USER $FIND_FOLDER			
	#Create .tar file
	tar -cvf $FIND_FOLDER/application-backup-`date +"%m-%d-%Y"`-`date +"%H:%M:%S"`.tar /data/backup/config
fi

chmod -R 755 /data/backup/
