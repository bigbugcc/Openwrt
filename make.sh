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
 for sfile in ${softfiles}
 do 
     echo "${sfile}:"
     cd $folder/${sfile} && git pull && cd ../../../
done

make -j8 download V=s && 

if [ -d "bin" ];then
		echo "*****启用多线程编译*****"
		make -j$(($(nproc) + 1)) V=s
	else
		echo "*****首次编译单线程*****"
		make -j1 V=s
fi

