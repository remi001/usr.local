#! /bin/bash

#############################################################################
###  Demonstrate how to use the For/Each loop
###    and how to list files in a directory
###    and how to search for a text snippet in each file
#############################################################################

DEBUG="OFF"

SRC_DIR="./inFiles"
FILE_SPEC="awkTest*"
SEARCH_TEXT="R02C02"

printf "\n"
printf "\t INFO: Searching for the text [${SEARCH_TEXT}] in files in [${SRC_DIR}/${FILE_SPEC}] \n\n"

for fileName in ${SRC_DIR}/${FILE_SPEC}; do

	if [ ${DEBUG} = "ON" ]; then
		printf "\t DEBUG: Found File [${fileName}] \n"
		##cat ${fileName}
		printf "\n"
	fi

	## Look for the SEARCH_TEXT within the file
	## NOTE: Only two files have the search text key "R02C02"
	if grep -q ${SEARCH_TEXT} ${fileName}; then
		printf "\t INFO: File [${fileName}] does     contain the text [${SEARCH_TEXT}] (TEST PASSED) \n"
    else
		printf "\t INFO: File [${fileName}] does not contain the text [${SEARCH_TEXT}] (TEST PASSED) \n"	
	fi

done

printf "\n"
