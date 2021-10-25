#! /bin/sh

##  watchDir.sh -List the current directory contents and container info, sleep, repeat
##
##  One might logically expect features such as:
##   1. Accept a command line option specifying a directory name to watch
##   2. Launch the watched directory in a new window
##
## DATE     WHO COMMENT
## ======== === =========================================================
## 20090522 RJP Incept

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

