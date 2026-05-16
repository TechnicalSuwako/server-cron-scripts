#!/bin/sh

DATE=$(date +"%Y年%m月%d日")

echo "mail.076.ne.jp SSL証明書が更新されました。 (${DATE})
---------------
" > /root/cert.txt

/bin/systemctl stop nginx >> /root/cert.txt
/usr/bin/certbot renew >> /root/cert.txt
/bin/systemctl start nginx >> /root/cert.txt
/bin/systemctl restart postfix >> /root/cert.txt
/bin/systemctl restart dovecot >> /root/cert.txt

cat /root/cert.txt | mail -s "mail.076.ne.jp SSL証明書更新 (${DATE})" -r "server@076.ne.jp" reports@076.ne.jp
rm -rf /root/cert.txt
