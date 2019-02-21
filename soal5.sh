DATE=`date '+%H:%M_%Y-%m-%d'`
awk 'BEGIN{IGNORECASE = 1;} NF<13 ! /sudo/ && /cron/ {print $0}' /var/log/syslog  > ~/modul1/"$DATE""_syslog.bak"