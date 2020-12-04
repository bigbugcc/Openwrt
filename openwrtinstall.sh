#!/bin/bash
path=$(cd `dirname $0`; pwd)
#编译环境
sudo apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch python3 python2.7 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler g++-multilib antlr3 gperf wget curl swig rsync &&
#拉取Lean大源码
git clone https://github.com/coolsnowwolf/lede &&
cd ./lede &&
git pull && 
./scripts/feeds update -a && 
./scripts/feeds install -a && cd path &&
cd ./package/openwrt-packages && git pull && cd ../../ &&
cd ./package/openwrt-passwall && git pull && cd ../../ &&
cd ./package/luci-app-mentohust && git pull && cd ../../ &&
cd ./package/MentoHUST-OpenWrt-ipk && git pull && cd ../../ &&
make -j8 download V=s && 
make -j1 V=s

