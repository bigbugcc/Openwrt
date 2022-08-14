#!/bin/bash
project_path=$(cd `dirname $0`; pwd)
cd $project_path

# 更新源码
function updatesource {
 echo -e "====== 更新源码以及组件 ======"
 git pull
./scripts/feeds update -a
./scripts/feeds install -a

#更新App插件
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
}

function x86_64 {
 cat configs/x86_64.config > .config && makes
}

function x86_64Lite {
 cat configs/x86_64Lite.config > .config
 cat configs/External_Lite.config >> .config
 make defconfig
 make -j8 download V=s && make -j4 V=s
 break
}

function Raspberry4 {
 cat configs/RPi4.config > .config && makes
}

function Raspberry3 {
 cat configs/RPi3B.config > .config && makes
}

function Rockchip {
 cat configs/Rockchip.config > .config && makes
}

## 通用配置
function makes {
 cat configs/External.config >> .config && make defconfig
 make -j8 download V=s && make -j4 V=s
 break
}

function menu {
 clear
 echo
 echo -e "
                                           _.oo.
                   _.u[[/;:,.         .odMMMMMM'
                .o888UU[[[/;:-.  .o@P^    MMM^
               oN88888UU[[[/;::-.        dP^  
              dNMMNN888UU[[[/;:--.   .o@P^         
            ,MMMMMMN888UU[[/;::-. o@^         
             NNM[ BigBugcc ][/.o@P^        ___              __      _____ _____         
             888888888UU[[[/o@^-..        / _ \ _ __  ___ _ \ \    / / _ \_   _|                                 
            oI8888UU[[[/o@P^:--..        | (_) | '_ \/ -_) ' \ \/\/ /|   / | |
         .@^  YUU[[[/o@^;::---..          \___/| .__/\___|_||_\_/\_/ |_|_\ |_|  
       oMP     ^/o@P^;:::---..                 |_|                              
    .dMMM    .o@^ ^;::---...                                                     
   dMMMMMMM@^`       `^^^^                                         
  YMMMUP^  
   ^^
    "
 echo -e "\t\t Openwrt Compile Menu\n"
 echo -e "\t1. x86_64"
 echo -e "\t2. x86_64Lite"
 echo -e "\t3. Raspberry Pi4"
 echo -e "\t4. Raspberry Pi3B+"
 echo -e "\t5. Rockchip(R4S、R2S、OPiR1Plus)"
 echo -e "\t0. Exit menu\n\n"
 echo -en "\t\tEnter an option: "
 read option
}
updatesource
while [ 1 ]
do
 menu
 case $option in
 0)
 break ;;
 1)
 x86_64 ;;
 2)
 x86_64Lite ;;
 3)
 Raspberry4 ;;
 4)
 Raspberry3 ;;
 5)
 Rockchip ;;
 *)
 clear
 echo "Sorry, wrong selection" ;;
 esac
 echo -en "\n\n\t\t\tHit any key to continue"
 read -n 1 line
done
clear
