#!/bin/bash
project_path=$(cd `dirname $0`; pwd)

cd $project_path
echo "---------------$project_path -----------------------"

#更新源仓库
git pull
./scripts/feeds update -a
./scripts/feeds install -a

#存放插件App的文件夹（需放在package目录下otherapp）
folder="$project_path/package/otherapp"

softfiles=$(ls $folder)
#更新appsname目录下的插件
echo "========== 开始检查更新app源码 =========="
for sfile in ${softfiles}
do 
     echo "${sfile}:"
     cd $folder/${sfile} && git pull
done

cd $project_path

#配置文件目录
softfiles=$(ls $project_path/configs)

echo "----------当前目录 $(cd `dirname $0`; pwd)  ---------------"
if [ ! -d "$project_path/bin" ];then
		echo "*****运行首次编译*****"
          cat $project_path/configs/empty.config > .config
		make -j8 download V=s
		make -j1 V=s
fi

#编译configs目录下的所有配置
for sfile in ${softfiles}
do 
    echo "========== 开始编译: ${sfile} =========="
     cat $project_path/configs/$sfile  > $project_path/.config
     make -j8 download V=s 
	echo "*****启用多线程编译*****"
	make -j$(($(nproc) + 1)) V=s
done
