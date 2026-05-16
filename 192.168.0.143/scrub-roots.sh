#!/bin/sh

DATE=$(date +"%Y年%m月%d日")

echo "192.168.0.143 NASプールがスクラビングされました。 (${DATE})
---------------
" > /root/scrub.txt

zpool scrub zroot >> /root/scrub.txt
zpool scrub yroot >> /root/scrub.txt
zpool scrub xroot >> /root/scrub.txt

echo "ディスク状況：
" >> /root/snap.txt
zpool status >> /root/scrub.txt

cat /root/scrub.txt | mail -s "192.168.0.143 プールスクラビング (${DATE})" reports@076.ne.jp
rm -rf /root/scrub.txt
