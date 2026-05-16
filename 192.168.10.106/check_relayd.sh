#!/bin/sh

checker=$(rcctl check relayd)

if [ "$checker" = 'relayd(failed)' ]; then
  DATE=$(date +"%Y年%m月%d日")

  echo "192.168.10.106 relaydがクラッシュにより再起動されました。 (${DATE})
---------------
" > /root/relayd.txt

  /etc/rc.d/relayd restart >> /root/relayd.txt

  cat /root/relayd.txt | mail -s "192.168.10.106 relayd再起動 (${DATE})" reports@076.ne.jp
  rm -rf /root/relayd.txt
fi
