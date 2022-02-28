#!/bin/bash
project_path=$(cd `dirname $0`; pwd)
lede_path="$project_path/lede"

#编译环境
sudo apt-get -y install build-essential asciidoc binutils bzip2 gawk gettext git libncurses5-dev libz-dev patch python3 python2.7 unzip zlib1g-dev lib32gcc1 libc6-dev-i386 subversion flex uglifyjs git-core gcc-multilib p7zip p7zip-full msmtp libssl-dev texinfo libglib2.0-dev xmlto qemu-utils upx libelf-dev autoconf automake libtool autopoint device-tree-compiler g++-multilib antlr3 gperf wget curl swig rsync &&

cd $project_path
#拉取Lean大源码
if [ ! -d "./lede" ];then
    echo "***正在Clone源码***"
    git clone https://github.com/coolsnowwolf/lede $project_path/lede
else
    echo "***lede源码目录已存在***"
fi

echo "***插件下载***"
cd $lede_path/package
git clone  https://github.com/bigbugcc/OpenwrtApp
git clone  https://github.com/destan19/OpenAppFilter
git clone  https://github.com/xiaorouji/openwrt-passwall
git clone  https://github.com/zzsj0928/luci-app-pushbot
#替换默认主题
rm -rf $lede_path/package/lean/luci-theme-argon
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git  $lede_path/package/lean/luci-theme-argon

echo "***修改默认配置文件***"
cd $lede_path/
# 修改默认IP为192.168.10.1
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate 

# Hello World
echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default

# luci-theme-infinityfreedom
echo 'src-git infinityfreedom https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom.git' >>feeds.conf.default

echo "***更新安装组件***"
./scripts/feeds update -a && ./scripts/feeds install -a

cd $project_path

if [ -f "$project_path/make.sh" ];then 
	chmod +x ./make.sh
	mv ./configs ./lede
	mv ./make.sh ./lede
    $project_path/lede/make.sh
    else
        if [ -f "$project_path/lede/make.sh" ];then 
                echo "搜索到make.sh文件，正在执行！"
                chmod +x $project_path/lede/make.sh
                "$(cd `dirname $0`; pwd)"/lede/make.sh 
            else
                echo "错误！不存在make.sh文件，将不会自动编译固件" 
    	fi
fi