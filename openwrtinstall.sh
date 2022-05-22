#!/bin/bash
project_path=$(cd `dirname $0`; pwd)
lede_path="$project_path/lede"

#编译环境
sudo apt-get install $(curl -fsSL https://raw.githubusercontent.com/bigbugcc/openwrts/master/openwrt-env)

cd $project_path
#拉取Lean大源码
if [ ! -d "./lede" ];then
    echo "***正在Clone源码***"
    git clone https://github.com/coolsnowwolf/lede $project_path/lede
else
    echo "***lede源码目录已存在***"
fi

cd $project_path/lede

echo "***插件下载***"
##添加常用插件
curl https://raw.githubusercontent.com/bigbugcc/openwrts/master/package.sh | bash

echo "***修改配置文件***"
## 修改默认IP为192.168.10.1
## 添加Hello World、luci-theme-infinityfreedom、passwall
## 替换默认主题luci-theme-argon
curl https://raw.githubusercontent.com/bigbugcc/openwrts/master/configure.sh | bash

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