#!/bin/bash
##Web server restrar

#행이존재하는지 체크
#ps aux|grep java|grep jira|grep -v grep| wc -l

#Jira pid 체크

#ps aux|grep java|grep jira|grep -v grep|awk '{print $2}'
#[ $A -eq $B ] A와B의 값이 같은 경우
#[ $A -ne $B ] A와B의 값이 다른 경우
#[ $A -gt $B ] A가B보다 큰경우
#[ $A -lt $B ] A가B보다 작은경우
#[ $A -ge $B ] A가B보다 크거나 같은 경우
#[ $A -le $B ] A가B보다 작거나 같은 경우

c=1
t=1


echo -en "\n#### Script start ####\n"

while [ $c -eq 1 ]
do
        echo -en "\n#### 1.while begin ####\n"

        #pid가 살아있으면 1이 반환 없으면 0이 반환
        start_pid=`ps aux|grep java|grep jira|grep -v grep| wc -l`
        echo "pid" $start_pid

        if [ $start_pid -eq 1 ]
        then
                echo -en "\n#### Jira stop #### \n"

                /opt/atlassian/jira/bin/stop-jira.sh

                if [ $start_pid -eq 0 ]
                then
                        echo -en "\n#### Jira stop end #### \n"
                        break
                fi
        fi

        if [ $start_pid -eq 0 ]
        then
                echo -en "\n#### End whil./.e end ####\n"
                t=`expr $t + 1`
                break
        fi

        echo -en "\n####1.end ####\n"
done



#프로세스가 죽었을때 체크
while [ $t -eq 2 ]
do
		#로그 확인
		end_pid=`ps aux|grep java|grep jira|grep -v grep| wc -l`
		
		#서비스 재실행
		
        if [ $end_pid -eq 0 ]
        then
              /opt/atlassian/jira/bin/start-jira.sh	
        fi

		n=1
		while(( $n <= 2 ))
		do
			echo -en ">"
			sleep 1	
			
			jira_start=`tail -n 50 /opt/atlassian/jira/logs/catalina.out | grep "org.apache.catalina.startup.Catalina.start Server startup in" | grep -v grep | wc -l`
						
			if [ $jira_start -eq 1 ]
			then
				n=`expr $jira_start + 1`
				
				if [ $n -eq 2 ]
				then
					  echo -en "break"
					  t=`expr $t + 1`
					  break	
				fi			
			fi
		done

		if [ $t -eq 3 ]
		then
			break			
		fi
			
done

echo -en "\n#### Script end ####\n"
