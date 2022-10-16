#!/bin/sh
cd /config/log/nginx
/bin/gzip/gzip -ck access.log >access.log.tmp.gz
/bin/zcat /config/log/nginx/access.log.*.gz | /bin/grep vdjbase | /usr/bin/goaccess - -o /config/www/manage/vdjbase_usage.html --log-format=COMBINED --ignore-crawlers
/bin/zcat /config/log/nginx/access.log.*.gz | /bin/grep ogrdb | /usr/bin/goaccess - -o /config/www/manage/ogrdb_usage.html --log-format=COMBINED --ignore-crawlers
