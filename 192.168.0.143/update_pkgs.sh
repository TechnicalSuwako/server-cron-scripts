#!/bin/sh

DATE=$(date +"%Y年%m月%d日")

echo "192.168.0.143 NASパッケージが更新されました。 (${DATE})
---------------
" > /root/pkg.txt

/usr/sbin/pkg update >> /root/pkg.txt
/usr/sbin/pkg upgrade -y >> /root/pkg.txt
/usr/sbin/freebsd-update cron >> /root/pkg.txt

cat /root/pkg.txt | mail -s "192.168.0.143 パッケージ更新 (${DATE})" reports@076.ne.jp
rm -rf /root/pkg.txt
