#!/bin/sh

export DEBIAN_FRONTEND=noninteractive
DATE=$(date +"%Y年%m月%d日")

echo "mail.076.ne.jp サーバーパッケージが更新されました。 (${DATE})
---------------
" > /root/apt.txt

/bin/apt update >> /root/apt.txt
/bin/apt upgrade -y >> /root/apt.txt
/bin/apt autoremove -y >> /root/apt.txt

cat /root/apt.txt | mail -s "mail.076.ne.jp パッケージ更新 (${DATE})" -r "server@076.ne.jp" reports@076.ne.jp
rm -rf /root/apt.txt
