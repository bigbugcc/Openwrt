#!/bin/bash
project_path=$(cd `dirname $0`; pwd)
lede_path="$project_path/lede"

svn_export() {
	# 参数1是分支名, 参数2是子目录, 参数3是目标目录, 参数4仓库地址
	trap 'rm -rf "$TMP_DIR"' 0 1 2 3
	TMP_DIR="$(mktemp -d)" || exit 1
	[ -d "$3" ] || mkdir -p "$3"
	TGT_DIR="$(cd "$3"; pwd)"
	cd "$TMP_DIR" && \
	git init >/dev/null 2>&1 && \
	git remote add -f origin "$4" >/dev/null 2>&1 && \
	git checkout "remotes/origin/$1" -- "$2" && \
	cd "$2" && cp -a . "$TGT_DIR/"
}

#编译环境
sudo apt-get install $(curl -fsSL https://raw.githubusercontent.com/bigbugcc/openwrts/master/openwrt-env)

cd $project_path
#拉取Lean大源码
if [ ! -d "./lede" ];then
    echo "***正在Clone源码***"
    git clone --depth 1 https://github.com/coolsnowwolf/lede $project_path/lede
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

echo "***下载配置文件***"
## 配置文件仓库 https://github.com/bigbugcc/OpenWrts/tree/main/configs
svn_export "main" "configs" "configs" https://github.com/bigbugcc/openwrts 

echo "***更新安装组件***"
./scripts/feeds update -a && ./scripts/feeds install -a


cd $project_path

if [ -f "$project_path/make.sh" ];then 
	chmod +x ./make.sh
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