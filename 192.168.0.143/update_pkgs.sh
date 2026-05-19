#!/bin/sh

DATE=$(date +"%Y年%m月%d日")
IP=$(ifconfig re0 | awk '/inet / {print $2; exit}')

echo "${IP}NASパッケージが更新されました。 (${DATE})
---------------
" > /root/pkg.txt

/usr/sbin/pkg update >> /root/pkg.txt
/usr/sbin/pkg upgrade -y >> /root/pkg.txt
/usr/sbin/freebsd-update cron >> /root/pkg.txt

cat /root/pkg.txt | mail -s "${IP} パッケージ更新 (${DATE})" reports@076.ne.jp
rm -rf /root/pkg.txt
