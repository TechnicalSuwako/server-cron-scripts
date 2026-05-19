#!/bin/sh

DATE=$(date +"%Y年%m月%d日")
IP=$(ifconfig re0 | awk '/inet / {print $2; exit}')

echo "${IP} NASプールのスクラビングが完了しました。 (${DATE})
---------------
" > /root/scrub.txt

echo "ディスク状況：
" >> /root/snap.txt
zpool status >> /root/scrub.txt

cat /root/scrub.txt | mail -s "${IP} プールスクラビング完了 (${DATE})" reports@076.ne.jp
rm -rf /root/scrub.txt
