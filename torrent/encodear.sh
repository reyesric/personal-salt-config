#!/bin/bash
TMPFILE=`tempfile`
nice mencoder "$1" -oac mp3lame -ovc xvid -vf scale -zoom -xy 720 -xvidencopts bitrate=1500:me_quality=6:threads=2:pass=1 -sub "$2" -subfont-text-scale 2.8 -subcp latin1 -subpos 85 -passlogfile $TMPFILE -o /dev/null -quiet
nice mencoder "$1" -oac mp3lame -ovc xvid -vf scale -zoom -xy 720 -xvidencopts bitrate=1500:me_quality=6:threads=2:pass=2 -sub "$2" -subfont-text-scale 2.8 -subcp latin1 -subpos 85 -passlogfile $TMPFILE -o "$3" -quiet
rm  $TMPFILE
echo "Proceso terminado" | mail -s "encode de $3 terminado" chiquito@gmail.com
