#! /bin/bash

if [ $# -ne 4 ]
then
  echo "./exp.Trevni.trace.analyze.sh <exp> <log output dir> <file descriptor> <column file group>"
  echo "<exp>: exp1, exp2, exp3, ..."
  exit
fi

EXP=$1
LOGDIR=$2
FD=$3
CFG=$4

EXP_COMMON_CONF_PATH="./expConf/common.conf"
echo "Loading parameters from $EXP_COMMON_CONF_PATH"
source $EXP_COMMON_CONF_PATH

EXP_CONF_PATH="./expConf/$EXP.conf"
echo "Loading parameters from $EXP_CONF_PATH"
source $EXP_CONF_PATH

for READ_COLUMN_STR in "${COLUMNS_STR[@]}"
do
  for ACCESS_PATTERN in "r" "c"
  do
    for IO_BUFFER_SIZE in "${IO_BUFFER_SIZE_LIST[@]}"
    do
      STRACE_LOG=$LOGDIR/strace.$TREVNI_PREFIX.$FILE_PREFIX.c$ROW_COUNT.ap$ACCESS_PATTERN.io$IO_BUFFER_SIZE.$READ_COLUMN_STR.out
      python ../straceAnalyzer/strace_analyzer.py $STRACE_LOG $FD $CFG
    done
  done
done
