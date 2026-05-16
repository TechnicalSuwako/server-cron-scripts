#!/bin/sh

DATE=$(date +"%Y年%m月%d日")

echo "192.168.10.103 サーバーパッケージが更新されました。 (${DATE})
---------------
" > /root/pkg.txt

/usr/sbin/pkg_add -ui >> /root/pkg.txt
/usr/sbin/syspatch >> /root/pkg.txt

cat /root/pkg.txt | mail -s "192.168.10.103 パッケージ更新 (${DATE})" reports@076.ne.jp
rm -rf /root/pkg.txt
