#! /bin/bash

#############################################################################
###
### Sometimes configuration is easier when you can
###     see the elements as they happen
###
### In this case if there are lots of email addresses to add
###    then a map/array can be used to load them
###
#############################################################################

ECHO=true
DEBUG="ON"

#--
#-- Build a map for the Logging DISTRIB_LIST
#--
recip[0]="developer_001"
recip[1]="developer_002"

if [ ${DEBUG}="ON" ]; then
	printf "\t DEBUG: STARTING \n"
	printf "\t\t DEBUG ... [${DEBUG}] \n"
	printf "\t\t ECHO .... [${ECHO}]  \n"
	printf "\n"
fi


### The ECHO (boolean) CAN BE EVALUATED IN SEVERAL WAYS
### AS BOOLEAN, EXPLICITLY:
if [ ${ECHO} == true ]; then
	printf "\t\t ECHO2 .... [${ECHO}]  \n"
fi
### AS BOOLEAN, PLAIN & SIMPLE:
if [ ${ECHO} ]; then
	printf "\t\t ECHO3 .... [${ECHO}]  \n"
fi

printf "\n"

i=0
for email in ${recip[*]}; do

	if [ ${ECHO} ]; then
		printf "\t \$i ........... [${i}] \n"
		printf "\t \$email ....... [${email}] \n"
		printf "\n"
	fi

	###
	### CREATE THE DISTRIBUTION LIST/ARRAY/MAP
	###
	### IF THIS IS THE FIRST ITERATION
	if [ `expr ${i}` -eq 0 ]; then
		DISTRIB_LIST="${email}@company.com"
	else
		DISTRIB_LIST="${DISTRIB_LIST},${email}@company.com"
	fi

	### INCREMENT the 'i' (iteration) counter
	i=`expr ${i} + 1`
done

export DISTRIB_LIST

if [ "${ECHO}" == "true" ]; then
	printf "\t INFO: \$DISTRIB_LIST ... [${DISTRIB_LIST}]"
	printf "\n"
fi
