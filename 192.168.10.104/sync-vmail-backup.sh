#!/bin/sh

DATE=$(date +"%Y年%m月%d日")

echo "192.168.10.104から192.168.10.143へメールバックアップが正常にプッシュされました。 (${DATE})
---------------
" > /home/suwako/mailbckp.txt

chmod -R 755 /home/suwako/vmail/mail.076.co.jp/vmail/backup/mysql >> /home/suwako/mailbckp.txt
chmod -R 755 /home/suwako/vmail/mail.076.ne.jp/vmail/backup/mysql >> /home/suwako/mailbckp.txt
chown -R suwako:suwako /home/suwako/vmail >> /home/suwako/mailbckp.txt
echo "０７６スタジオ（コーポレート）" >> /home/suwako/mailbckp.txt
doas -u suwako rsync -vaHz --delete /home/suwako/vmail/mail.076.co.jp 192.168.0.143:/zroot/vmail >> /home/suwako/mailbckp.txt
echo "０７６スタジオ（ネットワーク）" >> /home/suwako/mailbckp.txt
doas -u suwako rsync -vaHz --delete /home/suwako/vmail/mail.076.ne.jp 192.168.0.143:/zroot/vmail >> /home/suwako/mailbckp.txt

cat /home/suwako/mailbckp.txt | mail -s "192.168.10.104 メールバックアップをNASへプッシュ (${DATE})" reports@076.ne.jp
rm -rf /home/suwako/mailbckp.txt
