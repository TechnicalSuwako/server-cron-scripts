#!/bin/sh

DATE=$(date +"%Y年%m月%d日")
IP=$(ifconfig re0 | awk '/inet / {print $2; exit}')

echo "${IP} NASバックアップのスナップショットが作成されました。 (${DATE})
---------------
" > /root/snap.txt

# スナップショットの作成日
today=$(date +"%Y%m%d")

# 一週間前のスナップショットの削除
lastweek=$(date -v -7d +"%Y%m%d")

# 作成
zfs snapshot zroot/repo@backup-$today >> /root/snap.txt
zfs snapshot zroot/vmail@backup-$today >> /root/snap.txt

zfs snapshot yroot/mainpc@backup-$today >> /root/snap.txt
zfs snapshot yroot/repo@backup-$today >> /root/snap.txt
zfs snapshot yroot/monero@backup-$today >> /root/snap.txt
zfs snapshot yroot/svn@backup-$today >> /root/snap.txt
zfs snapshot yroot/got@backup-$today >> /root/snap.txt

# 破壊
zfs destroy zroot/repo@backup-$lastweek >> /root/snap.txt
zfs destroy zroot/vmail@backup-$lastweek >> /root/snap.txt

zfs destroy yroot/mainpc@backup-$lastweek >> /root/snap.txt
zfs destroy yroot/repo@backup-$lastweek >> /root/snap.txt
zfs destroy yroot/monero@backup-$lastweek >> /root/snap.txt
zfs destroy yroot/svn@backup-$lastweek >> /root/snap.txt
zfs destroy yroot/got@backup-$lastweek >> /root/snap.txt

echo "スナップショット一覧：
" >> /root/snap.txt
zfs list -t snapshot >> /root/snap.txt

cat /root/snap.txt | mail -s "${IP} スナップショットバックアップ (${DATE})" reports@076.ne.jp
rm -rf /root/snap.txt
