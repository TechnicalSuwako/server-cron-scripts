#!/bin/sh

DATE=$(date +"%Y年%m月%d日 %H:%M")

echo "mail.076.co.jp メールバックアップ (${DATE})
---------------
" > /root/backup.txt

if [ $? -eq 0 ]; then
    STATUS="完了"
else
    STATUS="＜失敗＞"
fi

rsync -vaHz --delete /var/vmail suwako@192.168.10.104:/home/suwako/vmail/mail.076.co.jp >> /root/backup.txt

cat /root/backup.txt | mail -s "mail.076.co.jp メールバックアップ ${STATUS} (${DATE})" -r "server@076.co.jp" reports@076.co.jp
rm -rf /root/backup.txt
