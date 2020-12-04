#!/bin/bash
project_path=$(cd `dirname $0`; pwd) &&
cd $project_path/ &&
git pull && 
./scripts/feeds update -a && 
./scripts/feeds install -a &&
cd ./package/openwrt-packages && git pull && cd ../../ &&
cd ./package/openwrt-passwall && git pull && cd ../../ &&
cd ./package/luci-app-mentohust && git pull && cd ../../ &&
cd ./package/MentoHUST-OpenWrt-ipk && git pull && cd ../../ && 
cd ./package/luci-app-adguardhome && git pull && cd ../../ &&
cd ./package/OpenAppFilter && git pull && cd ../../ &&
make -j8 download V=s && 
make -j1 V=s
