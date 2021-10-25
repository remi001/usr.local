#! /bin/bash

#############################################################################
##
## TEST IF FILES EXIST IN THE inFiles DIRECTORY
##
## Problem if ( -f *.txt ) only works if there is only one .txt file
## in the directory being checked
##
#############################################################################

DEBUG="ON"
SRC_DIR="./src"
FILE_SPEC="*.txt"

set nonomatch
file_count=0
processed_count=0


### CHECK THAT THE SOURCE FILE SAMPLES ARE IN PLACE
###   if [ -f "${SRC_DIR}"/${FILE_SPEC} ]; then
###
echo -e "."
if [ -d "${SRC_DIR}" ]; then
	echo -e ". INFO: The Source File Directory exists [${SRC_DIR}]"
else
	echo -e ". ERROR: No files to process in [${SRC_DIR}]"
fi

### CONFIRM THAT THERE ARE AT LEAST SOME FILES TO PROCESS
echo -e "."
if [ -n "$(ls -A ${SRC_DIR} 2>/dev/null)" ]; then
	echo -e ". INFO: [${SRC_DIR}] contains files (or is a file)"

	if [ ${DEBUG}="ON" ]; then
		echo -e "."
		echo -e ". INFO: LISTING ALL FILES IN [${SRC_DIR}]:"
		ls -la ${SRC_DIR}
		echo -e "."
	fi
else
	echo -e ". ERROR: [${SRC_DIR}] is empty (or does not exist)"
fi


echo -e "."
echo -e ". INFO: Counting the number of files like [${FILE_SPEC}] in the target [${SRC_DIR}]"
for fileName in ${SRC_DIR}/${FILE_SPEC}; do

	file_count=`expr ${file_count} + 1`

	if [ ${DEBUG}="ON" ]; then
		echo -e ". INFO: FOUND FILE #[${file_count}] : [${fileName}]:"
	fi
done
echo ". INFO: Counted [${file_count}] files"

echo "."
if [ ${file_count}>=1 ]; then
	echo ". PROCEED"
else
	echo ". ABORT"
fi


#############################################################
## Check for the existance of the files
#############################################################
echo -e "."
echo -e ". INFO: Checking for Source files like [${FILE_SPEC}] in [${SRC_DIR}]..."

for fileName in ${SRC_DIR}/${FILE_SPEC}; do

	### IF FILE EXISTS
	if [ -e ${fileName} ]; then
		if [ ${DEBUG}="ON" ]; then
			echo ". DEBUG: File Exists ... [${fileName}]"
		fi

		### IF FILE IS NOT A DIRECTORY
		if [ ! -d ${fileName} ]; then

			processed_count=`expr ${processed_count} + 1`

			if [ ${DEBUG}="ON" ]; then
				echo ". DEBUG: File is NOT A DIRECTORY ... [${fileName}]"
			fi
		else
			echo -e ". DEBUG: SKIPPING DIRECTORY [${fileName}]."
		fi
	fi
	echo -e "."
done


echo -e "."
if [ ${processed_count} -eq 0 ]; then
	echo -e ". ERROR: PROCESSED FILE COUNT IS ZERO"
else
	echo -e ". SUCCESS: PROCESSED [${processed_count}] files"
fi
echo -e "."


###
### Tricks for knowing if a directory contains files
###
### 1) This trick is 100% bash and invokes (spawns) a sub-shell. 
###    The idea is from Bruno De Fraine and improved by teambob's comment.
###
### shopt -s nullglob dotglob; f=${SRC_DIR}/*; ((${#f}))
### 
### 2) THIS similar alternative and more details (and more examples) 
###  on the 'official' FAQ for #bash IRC channel:
###
### files=$(shopt -s nullglob dotglob; echo ${SRC_DIR}/*)
### if [ (( ${#files} )) ]; then
###   echo "contains files"
### else 
###   echo ". [${SRC_DIR}] is empty, does not exist, or is a file"
### fi
###
### NOTE: There is no difference between 
###         an empty directory and a non-existing one 
###       Even when the provided path is a file
###
### 3) THIS similar alternative and more details (and more examples) 
###  on the 'official' FAQ for #bash IRC channel:
###
### This trick is inspired from nixCraft's article posted in 2007. Add 2>/dev/null to suppress the output error "No such file or directory".
### See also Andrew Taylor's answer (2008) and gr8can8dian's answer (2011).
###
### if [ (shopt -s nullglob dotglob; f=(*); ((${#f[@]}))) ]; then
###   echo ". [${SRC_DIR}] contains files"
### else 
###   echo ". [${SRC_DIR}] is empty, does not exist, or is a file"
### fi
### [ -n "$(ls -A ${SRC_DIR})" ]
