# DMA
```sh
$ pkg_add dma
```

## /etc/dma/auth.conf
```
server@076.ne.jp|mail.076.ne.jp:(パスワード)
```

--------------------------

## /etc/dma/dma.conf
```
SMARTHOST mail.076.ne.jp
PORT 587
ALIASES /etc/dma/aliases
AUTH /etc/dma/auth.conf
SECURETRANSFER
STARTTLS
MASQUERADE server@076.ne.jp
```

--------------------------

```sh
$ cp /etc/mail/aliases /etc/dma/aliases
$ echo "root: server@076.ne.jp" >> /etc/dma/aliases
```

## /etc/mailer.conf
```
sendmail    /usr/local/sbin/dma
mailq       /usr/local/sbin/dma
newaliases  /usr/local/sbin/dma
```
