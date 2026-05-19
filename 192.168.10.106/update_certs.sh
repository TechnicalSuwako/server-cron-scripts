#!/bin/sh

DATE=$(date +"%Y年%m月%d日")
IP=$(ifconfig wg0 | awk '/inet / {print $2; exit}')

echo "${IP} SSL証明書が更新されました。 (${DATE})
---------------
" > /root/cert.txt

/usr/sbin/acme-client -v 076.moe >> /root/cert.txt
/usr/sbin/acme-client -v sns.076.moe >> /root/cert.txt
/usr/sbin/acme-client -v 076.ne.jp >> /root/cert.txt
/usr/sbin/acme-client -v 076.co.jp >> /root/cert.txt
/usr/sbin/acme-client -v technicalsuwako.moe >> /root/cert.txt
/usr/sbin/acme-client -v monka1.nl >> /root/cert.txt
/usr/sbin/acme-client -v mondzorgkerk.nl >> /root/cert.txt
/usr/sbin/acme-client -v fair.moe >> /root/cert.txt
/usr/sbin/acme-client -v cw-games.org >> /root/cert.txt

/etc/rc.d/relayd stop >> /root/cert.txt

cp -v /etc/ssl/076.moe.crt /etc/prosody/certs/ >> /root/cert.txt
cp -v /etc/ssl/private/076.moe.key /etc/prosody/certs/ >> /root/cert.txt

/etc/rc.d/relayd start >> /root/cert.txt
/etc/rc.d/httpd stop >> /root/cert.txt
/etc/rc.d/httpd start >> /root/cert.txt
/etc/rc.d/prosody restart >> /root/cert.txt

cat /root/cert.txt | mail -s "${IP} SSL証明書更新 (${DATE})" reports@076.ne.jp
rm -rf /root/cert.txt
