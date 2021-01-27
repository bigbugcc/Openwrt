#!/bin/bash
project_path=$(cd `dirname $0`; pwd) &&
#编译环境
sudo apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch python3 python2.7 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler g++-multilib antlr3 gperf wget curl swig rsync &&
#拉取Lean大源码
git clone https://github.com/coolsnowwolf/lede &&
cd $project_path &&
mv ./make.sh ./lede &&

cd ./lede/package/otherapp &&
#在线用户
git clone https://github.com/rufengsuixing/luci-app-onliner &&
#科学上网插件
git clone --depth=1 https://github.com/xiaorouji/openwrt-passwall &&
git clone --depth=1 -b master https://github.com/vernesong/OpenClash &&
#大学生必备插件
git clone --depth=1 https://github.com/BoringCat/luci-app-mentohust &&
git clone --depth=1 https://github.com/KyleRicardo/MentoHUST-OpenWrt-ipk&&
#广告过滤插件
git clone https://github.com/rufengsuixing/luci-app-adguardhome &&
git clone https://github.com/destan19/OpenAppFilter && #(luci-app-flowoffload shortcut-fe luci-app-sfe)
#Lienol App
git clone https://github.com/Lienol/openwrt-package &&

cd ../../ &&
chmod +x ./make.sh && ./make.sh
