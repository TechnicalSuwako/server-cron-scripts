#!/bin/sh

OS="$(uname -s)"
case "$OS" in
  FreeBSD) OS="freebsd" ;;
  OpenBSD) OS="openbsd" ;;
  Linux) OS="linux" ;;
  Darwin) OS="macos" ;;
  *) exit 1;;
esac

ARC="$(uname -m)"
case "$ARC" in
  x86_64|amd64) ARC="amd64" ;;
  aarch64|arm64) ARC="arm64" ;;
  *) exit 1 ;;
esac

IP=$(ifconfig wg0 | awk '/inet / {print $2; exit}')
FVER=$(wget -qO- https://go.dev/VERSION?m=text | head -n1)
VER=${FVER#go}
SER=$(echo "$VER" | sed 's/\([0-9]*\)\.\([0-9]*\).*/\1\2/')
CURVER=$(go env GOVERSION | cut -c3-)
DATE=$(date +"%Y年%m月%d日")

echo "${IP} サーバーGoバージョンが更新されました。（${DATE}）
---------------
" > /root/go.txt

if [ "$VER" = "$CURVER" ]; then
  echo "最新Goバージョンが既にインストールされています。" >> /root/go.txt
else
  wget https://go.dev/dl/go$VER.$OS-$ARC.tar.gz >> /root/go.txt
  tar zxfv go$VER.$OS-$ARC.tar.gz >> /root/go.txt
  rm -rfv /usr/local/go$SER >> /root/go.txt
  mv -v go /usr/local/go$SER >> /root/go.txt
  ln -s /usr/local/go$SER/bin/go /usr/local/bin/go$SER
  ln -s /usr/local/go$SER/bin/gofmt /usr/local/bin/gofmt$SER
  rm -rfv /usr/local/bin/go >> /root/go.txt
  rm -rfv /usr/local/bin/gofmt >> /root/go.txt
  ln -s /usr/local/bin/go$SER /usr/local/bin/go
  ln -s /usr/local/bin/gofmt$SER /usr/local/bin/gofmt
  go version >> /root/go.txt
  rm -rfv go$VER.$OS-$ARC.tar.gz >> /root/go.txt
fi

cat /root/go.txt | mail -s "${IP} Goバージョン更新 (${DATE})" reports@076.ne.jp
rm -rf /root/go.txt
