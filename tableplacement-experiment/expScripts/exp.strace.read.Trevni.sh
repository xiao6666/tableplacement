#! /bin/bash

if [ $# -ne 4 ]
then
  echo "./exp1.read.sh <exp> <io buffer size> <read column str>"
  echo "<exp>: exp1, exp2, exp3, ..."
  exit
fi

EXP=$1
IO_BUFFER_SIZE=$2
READ_COLUMN_STR=$3

EXP_COMMON_CONF_PATH="./expConf/common.conf"
echo "Loading parameters from $EXP_COMMON_CONF_PATH"
source $EXP_COMMON_CONF_PATH

EXP_CONF_PATH="./expConf/$EXP.conf"
echo "Loading parameters from $EXP_CONF_PATH"
source $EXP_CONF_PATH

echo "Printing system infomation ..."
uname -a
cat /etc/lsb-release

echo "=================================================================="
echo "I/O buffer size:" $IO_BUFFER_SIZE
echo "Read columns str:" $READ_COLUMN_STR
echo "free && sync && echo 3 > /proc/sys/vm/drop_caches && free"|sudo su > /dev/null
iostat -d -t $DEVICE
strace -F -f -ttt -T java -jar ../target/tableplacement-experiment-0.0.1-SNAPSHOT.jar ReadTrevni -t $TABLE -i $DIR/$TREVNI_PREFIX.$FILE_PREFIX.c$ROW_COUNT -p read.column.string $READ_COLUMN_STR -p io.file.buffer.size $IO_BUFFER_SIZE
echo "free && sync && echo 3 > /proc/sys/vm/drop_caches && free"|sudo su > /dev/null
iostat -d -t $DEVICE