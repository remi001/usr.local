#! /bin/bash

###
###  LOGGING Function with Tests
####

APP_LOG_DIR="./log"
APP_LOG_FILE="testLog.log"
APP_LOG_FQN="${APP_LOG_DIR}/${APP_LOG_FILE}"

TRACE=false
DEBUG=true

###
### CHECK that the LOG directory Exists
###
if [ ! -d "${APP_LOG_DIR}" ]; then
	echo -e "."
	echo -e ". INFO: Creating Log File Directory .... [${APP_LOG_DIR}]"
	mkdir ${APP_LOG_DIR}
	
	### Initialize the Log file
	echo -e '-------------------'     >> ${APP_LOG_FQN}
	echo -e `date '+%Y-%m-%d %R:%S'`  >> ${APP_LOG_FQN}
	echo -e '-------------------'     >> ${APP_LOG_FQN}
fi

#############################################################
## Echo the passed string to the log file BUT
##   ONLY if the boolean variables 'DEBUG' is true
## Receives one parameter, the text info to writ to the log file
#############################################################
function log() {
    local TS=`date '+%Y-%m-%d %R:%S'`
	
	if ${TRACE} ; then 
		echo ". TRACE: IN $0.log()" >> ${APP_LOG_FQN} 
	fi

	if ${DEBUG} || ${TRACE} ; then 
		### $1 is the first passed parameter
		echo -e "${TS} $1"  >> ${APP_LOG_FQN}
	fi

	if ${TRACE} ; then 
	    echo ". TRACE: OUT $0.log()"   >> ${APP_LOG_FQN} 
	fi
	return
}

#############################################################
## Echo the string if the boolean variable 'doEcho' is true
## Takes one parameter, the thing to echo
#############################################################
function say() {
	local TRACE=false

	if ${TRACE} ; then echo ". TRACE: IN $0.say()"; fi

	if ${doEcho} ; then 
		### $1 is the first passed parameter
		echo -e ". $1"
	fi

	if ${TRACE} ; then echo ". TRACE: OUT $0.say()"; fi
	return
}

say "."

### TEST THE FUNCTIONS
say "TRACE: Testing the Log function..."
log "DEBUG: Log File's 'Fully Qualified Name (FQN)': [${APP_LOG_FQN}]"

say "DEBUG: Listing the Log at [${APP_LOG_FQN}]"
cat ${APP_LOG_FQN}

say "."
say "DEBUG: Echo This"

