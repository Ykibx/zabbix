#!/bin/bash

to=$1
subject=$2
file="/tmp/mail$RANDOM"
echo $3 > $file

sed -i -e 's/ //g' -e 's/\r/\n/g' $file

date "+%F %T" >> /app/zabbix/logs/sendmail.log
echo "$to" "$subject" >> /app/zabbix/logs/sendmail.log
cat "$file" >> /app/zabbix/logs/sendmail.log

cat "$file" | /bin/mail -s "$subject" "$to"
rm -f $file