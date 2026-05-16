#!/bin/sh

export VER="0.16.0"
export ARC="x86_64"
export OS="freebsd"

wget https://ziglang.org/download/$VER/zig-$ARC-$OS-$VER.tar.xz
tar xfv zig-$ARC-$OS-$VER.tar.xz
cd zig-$ARC-$OS-$VER
rm -rf /usr/local/lib/zig
mv lib /usr/local/lib/zig
mv zig /usr/local/bin
rm -rf zig-$ARC-$OS-$VER zig-$ARC-$OS-$VER.tar.xz
zig version
