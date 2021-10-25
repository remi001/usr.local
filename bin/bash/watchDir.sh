#! /bin/sh

## List current directory contents and container info, sleep, repeat
##  Might logically be features such as:
##    1.  Took a command line option specifying a directory name
##    2.  Launch the directory in a new window

echo -e "\n Watching `pwd`\n"


if [ "${1}x" = "x" ]; then
  sleepTime=10
  echo -e "[optionally enter a refresh rate (in seconds)]. \n"
else
  sleepTime=${1}
  echo -e "\t [Refresh rate [${1}] seconds] \n"
  sleep 3
fi

echo -e ". param 1 ........ [${1}]"
echo -e ". sleepTime ...... [${sleepTime}] (seconds)"
echo -e "."
echo -e ". ... Press <Ctrl>+<C> to exit."

sleep 2

while [$a == $a];
  do clear;
  echo -e "\n `uname -n`:`pwd`\t`date '+%Y-%m-%d %R:%S'`\n";
  ls -al;
  echo "";
  echo -e "."
  echo -e ". ... Press <Ctrl>+<C> to exit."
  sleep ${sleepTime};
done

