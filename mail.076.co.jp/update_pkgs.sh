#!/bin/sh

export DEBIAN_FRONTEND=noninteractive
DATE=$(date +"%Y年%m月%d日")

echo "mail.076.co.jp サーバーパッケージが更新されました。 (${DATE})
---------------
" > /root/apt.txt

apt update >> /root/apt.txt
apt upgrade -y >> /root/apt.txt
apt autoremove -y >> /root/apt.txt

cat /root/apt.txt | mail -s "mail.076.co.jp パッケージ更新 (${DATE})" -r "server@076.co.jp" reports@076.co.jp
rm -rf /root/apt.txt
