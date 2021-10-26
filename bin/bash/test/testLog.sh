#! /bin/bash

###
### Test the LOG Function
###

APP_LOG_DIR="./log"
APP_LOG_FILE="testLog.log"
APP_LOG_FQN="${APP_LOG_DIR}/${APP_LOG_FILE}"

TRACE=false
DEBUG=true

source /usr/local/bin/bash/include/log.sh
source /usr/local/bin/bash/include/say.sh


say "."

### TEST THE FUNCTIONS
say "TRACE: Testing the Log function..."
log "DEBUG: Log File's 'Fully Qualified Name (FQN)': [${APP_LOG_FQN}]"

say "DEBUG: Listing the Log at [${APP_LOG_FQN}]"
cat ${APP_LOG_FQN}

say "."
say "DEBUG: Echo This"

