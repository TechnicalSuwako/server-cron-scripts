#!/bin/sh

export VERSION=5.3.0

# フロントエンド
rm -rf /usr/local/share/mitra/*.tar.gz /usr/local/share/mitra/www-BCKP
wget https://codeberg.org/silverpill/mitra-web/releases/download/v$VERSION/mitra-web_$VERSION.tar.gz -o /usr/local/share/mitra
tar zxfv /usr/local/share/mitra/mitra-web_$VERSION.tar.gz
mv /usr/local/share/mitra/www /usr/local/share/mitra/www-BCKP
mv /usr/local/share/mitra/dist /usr/local/share/mitra/www

# バックエンド
cd /home/mitra/mitra
doas -u mitra git pull
doas -u mitra DEFAULT_CONFIG_PATH="/etc/mitra/config.yaml" cargo build --release --features production
rcctl stop mitra && cp /home/mitra/mitra/target/release/mitra /usr/local/bin && rcctl start mitra
