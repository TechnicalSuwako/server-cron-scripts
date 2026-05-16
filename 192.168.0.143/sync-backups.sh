#!/bin/sh

DATE=$(date +"%Y年%m月%d日")

echo "192.168.0.143 NASバックアップが同期されました。 (${DATE})
---------------
" > /root/sync.txt

# Z-Y
rsync -vaHzop --delete /zroot/mainpc /yroot >> /root/sync.txt
rsync -vaHzop --delete /zroot/vmail /yroot >> /root/sync.txt
rsync -vaHzop --delete /zroot/monero /yroot >> /root/sync.txt
rsync -vaHzop --delete /zroot/repo /yroot >> /root/sync.txt
rsync -vaHzop --delete /zroot/got /yroot >> /root/sync.txt
rsync -vaHzop --delete /zroot/svn /yroot >> /root/sync.txt

# Y-X
rsync -vaHzop --delete /yroot/mainpc /xroot >> /root/sync.txt
rsync -vaHzop --delete /yroot/vmail /xroot >> /root/sync.txt
rsync -vaHzop --delete /yroot/monero /xroot >> /root/sync.txt
rsync -vaHzop --delete /yroot/repo /xroot >> /root/sync.txt
rsync -vaHzop --delete /yroot/got /xroot >> /root/sync.txt
rsync -vaHzop --delete /yroot/svn /xroot >> /root/sync.txt

cat /root/sync.txt | mail -s "192.168.0.143 バックアップ同期 (${DATE})" reports@076.ne.jp
rm -rf /root/sync.txt
