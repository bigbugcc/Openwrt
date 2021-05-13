#!/bin/bash
project_path=$(cd `dirname $0`; pwd) &&

cd $project_path/ &&

#更新源仓库
git pull &&

./scripts/feeds update -a &&
./scripts/feeds install -a &&


#存放插件App的文件夹名（需放在package目录下）
appsname="otherapp"

folder="package/$appsname"

 softfiles=$(ls $folder)
 #更新appsname目录下的插件
echo "========== 开始检查更新app源码 =========="
for sfile in ${softfiles}
do 
     echo "${sfile}:"
     cd $folder/${sfile} && git pull && cd ../../../
done

#配置文件目录
softfiles=$(ls $project_path/configs)

if [ ! -d "$project_path/bin" ];then
		echo "*****运行首次编译*****"
          cat $project_path/configs/empty.config > $project_path/.config
		  make -j8 download V=s
		  make -j1 V=s
fi

#更新appsname目录下的插件
for sfile in ${softfiles}
do 
    echo "========== 开始编译: ${sfile} =========="
     cat $project_path/configs/$sfile  > $project_path/.config
     make -j8 download V=s 
	echo "*****启用多线程编译*****"
	make -j$(($(nproc) + 1)) V=s
done
