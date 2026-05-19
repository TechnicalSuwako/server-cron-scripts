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
  x86_64|amd64) ARC="x86_64" ;;
  aarch64|arm64) ARC="aarch64" ;;
  *) exit 1 ;;
esac

IP=$(ifconfig re0 | awk '/inet / {print $2; exit}')
VER=$(wget -qO- https://ziglang.org/download/index.json |
      sed 's/[",:]//g' |
      awk '/^[[:space:]]*[0-9]+\.[0-9]+/ {print $1; exit}')
CURVER=$(zig version)
DATE=$(date +"%Y年%m月%d日")

echo "${IP} サーバーZigバージョンが更新されました。（${DATE}）
---------------
" > /root/zig.txt

if [ "$VER" = "$CURVER" ]; then
  echo "最新Zigバージョンが既にインストールされています。" >> /root/zig.txt
else
  wget https://ziglang.org/download/$VER/zig-$ARC-$OS-$VER.tar.xz >> /root/zig.txt
  xzcat zig-$ARC-$OS-$VER.tar.xz | tar xf - >> /root/zig.txt
  cd zig-$ARC-$OS-$VER
  rm -rfv /usr/local/lib/zig >> /root/zig.txt
  mv -v lib /usr/local/lib/zig >> /root/zig.txt
  mv -v zig /usr/local/bin >> /root/zig.txt
  rm -rfv zig-$ARC-$OS-$VER zig-$ARC-$OS-$VER.tar.xz >> /root/zig.txt
  zig version >> /root/zig.txt
  echo "Zigバージョンを更新に成功です。" >> /root/zig.txt
fi

cat /root/zig.txt | mail -s "${IP} Zigバージョン更新 (${DATE})" reports@076.ne.jp
rm -rf /root/zig.txt
