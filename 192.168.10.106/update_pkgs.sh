#!/bin/sh

DATE=$(date +"%Y年%m月%d日")
IP=$(ifconfig wg0 | awk '/inet / {print $2; exit}')

echo "${IP} サーバーパッケージが更新されました。 (${DATE})
---------------
" > /root/pkg.txt

/usr/sbin/pkg_add -ui >> /root/pkg.txt
/usr/sbin/syspatch >> /root/pkg.txt

cat /root/pkg.txt | mail -s "${IP} パッケージ更新 (${DATE})" reports@076.ne.jp
rm -rf /root/pkg.txt
