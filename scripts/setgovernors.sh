#!/bin/bash

NEWGOV=performance
BASE=/sys/devices/system/cpu
END=cpufreq/scaling_governor

printhelp() {
  echo "Usage: "
  echo ""
  echo "#./setgovernors.sh [-p|-o|-u|-c|-s]"
  echo ""
  echo "-p: performance"
  echo "-o: ondemand"
  echo "-u: userspace"
  echo "-c: conservative"
  echo "-s: powersave" 
}

if [ $# -ge 1 ]
then
  OPT=$1
  if [ "$OPT" == "-p" ]; then NEWGOV="performance"; 
  elif [ "$OPT" == "-o" ]; then NEWGOV="ondemand"; 
  elif [ "$OPT" == "-u" ]; then NEWGOV="userspace"; 
  elif [ "$OPT" == "-c" ]; then NEWGOV="conservative";
  elif [ "$OPT" == "-s" ]; then NEWGOV="powersave";
  else echo "Unrecognised option $OPT"; printhelp; exit
  fi 
else
  printhelp
  exit
fi

echo "Trying to set $NEWGOV governor"

for CPU in `ls $BASE | grep "cpu.$" `
do
  echo $NEWGOV > $BASE/$CPU/$END
done 

for CPU in `ls $BASE | grep "cpu.$" `
do
  cat $BASE/$CPU/$END
done 
