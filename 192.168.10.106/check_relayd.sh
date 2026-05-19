#!/bin/sh

checker=$(rcctl check relayd)

if [ "$checker" = 'relayd(failed)' ]; then
  DATE=$(date +"%Y年%m月%d日")
IP=$(ifconfig wg0 | awk '/inet / {print $2; exit}')

  echo "${IP} relaydがクラッシュにより再起動されました。 (${DATE})
---------------
" > /root/relayd.txt

  /etc/rc.d/relayd restart >> /root/relayd.txt

  cat /root/relayd.txt | mail -s "${IP} relayd再起動 (${DATE})" reports@076.ne.jp
  rm -rf /root/relayd.txt
fi
