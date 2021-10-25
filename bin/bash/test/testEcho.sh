#! /bin/bash

###
### TEST EXAMPLES of using ECHO and PRINTF
###
###  ALSO TESTS HOW LOGIC WORKS WITH SEVERAL VARIABLE TYPES
###

echoString=true
echoNum=1
counter=0
echoBool=true


echo -e "."
printf "\t echoBool-#1 .... [${echoBool}]  \n"

### The boolean echo CAN BE EVALUATED IN SEVERAL WAYS
### EVAL AS BOOLEAN, EXPLICITLY:
if [ ${echoBool} == true ]; then
	printf "\t echoBool-#2 .... [${echoBool}]  \n"
fi

### EVAL AS BOOLEAN, PLAIN & SIMPLE:
if [ ${echoBool} ]; then
	printf "\t echoBool-#3 .... [${echoBool}]  \n"
fi


# EVAL echoString STRING
echo -e "."
if [ ${echoString} == "true" ] ; then
  echo -e ". DEBUG: echoString IS ON"
else
  echo -e ". DEBUG: echoString IS OFF"
fi
echo

# EVAL echoNum, a numeric variable
echo -e ". DEBUG: echoNum value is [${echoNum}]"
if [ ${echoNum} == 1 ]; then
  echo -e ". echoNum IS ON"
else
  echo -e ". echoNum IS OFF"
fi

###
### You can do math on shell variables
###
echo -e ". DEBUG: counter value is [${counter}] at First"
counter=`expr $counter + 1`
echo -e ". DEBUG: counter value is [${counter}] after increment"
counter=`expr $counter - 1`
echo -e ". DEBUG: counter value is [${counter}] after decrement"
echo -e "."
