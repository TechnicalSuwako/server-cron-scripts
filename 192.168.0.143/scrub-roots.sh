#!/bin/sh

DATE=$(date +"%Y年%m月%d日")
IP=$(ifconfig re0 | awk '/inet / {print $2; exit}')

echo "${IP} NASプールがスクラビングされました。 (${DATE})
---------------
" > /root/scrub.txt

zpool scrub zroot >> /root/scrub.txt
zpool scrub yroot >> /root/scrub.txt
zpool scrub xroot >> /root/scrub.txt

echo "ディスク状況：
" >> /root/snap.txt
zpool status >> /root/scrub.txt

cat /root/scrub.txt | mail -s "${IP} プールスクラビング (${DATE})" reports@076.ne.jp
rm -rf /root/scrub.txt
