#!/bin/bash
## battery-graph custom script
# takes multiple battery-stats log files as parameters and combine them
# i.e: battery-graph-multi.sh /var/log/battery-stats*

TMPFILE="/tmp/battery-stats-tmp"
> $TMPFILE
CURRENT=""

if [ ! -f $1 ];
then
  echo "File $1 not found"
  exit -1
fi

for i in $*; do
  if [[ "$i" == "/var/log/battery-stats" ]];
  then
    CURRENT="$i"
  else
    cat "$i" >> $TMPFILE
  fi
done
if [[ -n "$CURRENT" ]]; then
  cat "$CURRENT" >> $TMPFILE
fi
$(dirname "$0")"/battery-graph-current.sh" $TMPFILE
