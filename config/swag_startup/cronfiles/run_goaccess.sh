#!/bin/sh
cd /config/log/nginx
/bin/gzip -ck access.log >access.log.tmp.gz
/bin/zcat /config/log/nginx/access.log.*.gz | /bin/grep vdjbase | /usr/bin/goaccess - -o /config/www/manage/vdjbase_usage.html --log-format=COMBINED --ignore-crawlers
/bin/zcat /config/log/nginx/access.log.*.gz | /bin/grep ogrdb | /usr/bin/goaccess - -o /config/www/manage/ogrdb_usage.html --log-format=COMBINED --ignore-crawlers

if ! [ $(find "/config/www/manage/ogrdb_usage.html") ]
then
    /usr/bin/python /app/healthchecks.py infra-goaccess fail -m "ogrdb_usage.html not created"
	exit
else
	echo "ogrdb_usage.html exists"
fi	

if ! [ $(find "/config/www/manage/vdjbase_usage.html") ]
then
    /usr/bin/python /app/healthchecks.py infra-goaccess fail -m "vdjbase_usage.html not created"
	exit
else
	echo "vdjbase_usage.html exists"
fi	

if [ $(find "/config/www/manage/ogrdb_usage.html" -mmin +60) ]
then
	/usr/bin/python /app/healthchecks.py infra-goaccess fail -m "ogrdb_usage.html not updated"
	exit
else
	echo "ogrdb_usage.html has been updated"
fi
	
if [ $(find "/config/www/manage/vdjbase_usage.html" -mmin +60) ]
then
	/usr/bin/python /app/healthchecks.py infra-goaccess fail -m "vdjbase_usage.html not updated"
	exit
else
	echo "vdjbase_usage.html has been updated"
fi
	

/usr/bin/python /app/healthchecks.py infra-goaccess success

