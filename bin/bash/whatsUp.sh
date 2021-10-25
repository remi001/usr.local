#! /bin/sh

## whatsUp.sh -show memory and other info for particular processes
##
## Such as App Servers and Databases
##
## DATE     WHO COMMENT
## ======== === =========================================================
## 20090522 RJP Incept
## 20130226 RJP Exchanged nawk for gawk (awk by any other ...)
##              uname and date have moved from /usr/bin to /bin


APP_SERVER=`/bin/uname -n`

if [ ${APP_SERVER} = "${NP_HOST_NAME}" ]; then
    DB_SERVER="tdb01.region001.company.com"
    WL_INSTANCE_NAME="weblogic9-7925"
##  WL_INSTANCE_NAME="weblogic103-10122"
    WL_INSTANCE_PORT="10122"
elif [ ${APP_SERVER} = "qswl1" ]; then
    DB_SERVER="qhdb01.region001.company.com"
    WL_INSTANCE_NAME="weblogic103-10122"
    WL_INSTANCE_PORT="10122"
else
    DB_SERVER="pkg1.region002.company.com"
    WL_INSTANCE_NAME="weblogic103-10001"
    WL_INSTANCE_PORT="10001"
fi

WL_DOM_PATH=/app/weblogic-${WL_INSTANCE_PORT}/user_projects/domains/my_domain

PATTERNS_DIR=/export/home/javadev/bin/patterns


while true
do
  HOST=`hostname`
  TSTAMP=`/bin/date "+%Y%m%d%H%M%S"`
  LOG_DATE=`/bin/date '+%a %m/%d/%Y %H:%M:%S'`

  echo " "
  echo "-------------------------------------------------------------------------------- "
  echo "<${HOST}>\t${TSTAMP}"

  # vmstat 2 2
  # iostat 2 2
  # mpstat 2 2

  ALLSES=`netstat -a | grep -ic ESTABLISHED`
  W_OWL=`netstat -a | grep -ic 10001`
  W_ORA=`netstat -a | grep -i ${DB_SERVER} | grep -ic 1521`

# top -b -U weblogic | fgrep -v -f ${PATTERNS_DIR}/top.ignore.patterns

  echo "<PORTLIST>"
# echo "$HOST Has Established sessions for all ports: $ALLSES"
  echo "$HOST Has Established sessions for port 10001: $W_OWL \t(Weblogic)"
  echo "$HOST Has Established sessions for port  1521: $W_ORA \t(Oracle)"
  echo "</PORTLIST>"

  echo " "
  echo "******************************************************************************** "

  SERVER_SWAP_USED=`top -b | grep "Memory" | gawk '{ printf( "%d",  $6 ) }'`
  SERVER_SWAP_FREE=`top -b | grep "Memory" | gawk '{ printf( "%d", $10 ) }'`

  printf "SERVER_SWAP_USED ....\t[${SERVER_SWAP_USED}]\n"
  printf "SERVER_SWAP_FREE ....\t[${SERVER_SWAP_FREE}]\n"

  echo "******************************************************************************** "
  echo " "


  # Find the PID of the JVM for our WL Instance
  WL_JVM_PID=`/usr/bin/ps -ef | grep -v grep | grep -i java | grep ${WL_INSTANCE_NAME} | gawk '{print $2}'`

  # Find and extract the line for the WL_JVM_PID in top
  WL_JVM_TOP=`top -b -n 40 | grep ${WL_JVM_PID}`

  # Extract the memory allocated to the WL_JVM_PID
  WL_MEM_SIZE=`top -b -U weblogic | grep ${WL_JVM_PID} | gawk '{ printf( "%d", $6 ) }'`
  WL_MEM_RESV=`top -b -U weblogic | grep ${WL_JVM_PID} | gawk '{ printf( "%d", $7 ) }'`


  printf "WL JVM PID ......\t[${WL_JVM_PID}]\n"
  printf "WL_JVM_TOP ......\t[${WL_JVM_TOP}]\n"
  printf "\n"
  printf "WL_MEM_SIZE ....\t[${WL_MEM_SIZE}]\n"
  printf "WL_MEM_RESV ....\t[${WL_MEM_RESV}]\n"

  echo "******************************************************************************** "
  echo " "

  echo "------------------------ PID activity for ${APPLN_NAME} WL instances ------------------- "
  #ps -ef | grep ${APPLN_NAME} | grep java | sort
  ps -u weblogic\
     -o pid -o s=ST -o etime=ELAPSED... -o args\
     | fgrep -f ${PATTERNS_DIR}/${APPLN_NAME}_java.include.patterns | sort

  echo " "
  echo "******************************************************************************** "
  top -b -U weblogic
  echo "******************************************************************************** "
  echo " "

  echo "</${HOST}>"
  echo "-------------------------------------------------------------------------------- "
  echo " "
  sleep 20

done
