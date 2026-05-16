#!/bin/sh

export SER="126"
export VER="1.26.3"
export ARC="amd64"
export OS="freebsd"

wget https://go.dev/dl/go$VER.$OS-$ARC.tar.gz
tar zxfv go$VER.$OS-$ARC.tar.gz
rm -rf /usr/local/go$SER
mv go /usr/local/go$SER
ln -s /usr/local/go$SER/bin/go /usr/local/bin/go$SER
ln -s /usr/local/go$SER/bin/gofmt /usr/local/bin/gofmt$SER
rm -rf /usr/local/bin/go
rm -rf /usr/local/bin/gofmt
ln -s /usr/local/bin/go$SER /usr/local/bin/go
ln -s /usr/local/bin/gofmt$SER /usr/local/bin/gofmt
go version
rm -rf go$VER.$OS-$ARC.tar.gz
