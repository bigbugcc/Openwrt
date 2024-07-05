#!/bin/bash
config_num=1
project_path=$(
   cd $(dirname $0)
   pwd
)
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
   for sfile in ${softfiles}; do
      echo "${sfile}:"
      cd $folder/${sfile} && git pull
   done
   cd $project_path
}

##清除编译缓存
function cleanCache {
   make clean && make dirclean
}

function openMenu {
   make defconfig && make menuconfig
}

# 通用配置
function defconfig {
   cat configs/LuciApp.config >>.config
}

# 轻量配置
function defconfigLite {
   cat configs/LuciApp_Lite.config >>.config
}

# 编译
function makes {
   make defconfig
   make -j8 download V=s && make -j4 V=s
   echo "========== 编译结束 =========="
}

function selectconfig {
   clear
   echo
   echo -e "-------- Select Config Type: -------- \n"
   echo -e "\t1. Standard"
   echo -e "\t2. Lite"
   echo
   echo -e "------------------------------------- \n"
   echo -en " Enter an option:"
   read config_num
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
   dMMMMMMM@^$()^^^^                                         
  YMMMUP^                 
   ^^ ------------------------ https://github.com/bigbugcc -----------------------------
    "
   echo -e "\t\t Openwrt Compile Menu\n"
   echo -e "\t1. x86_64"
   echo -e "\t2. Raspberry Pi4"
   echo -e "\t3. Raspberry Pi3B+"
   echo -e "\t4. Rockchip(R68S、R2S、R4S、R5C、R5S、OPiR1Plus)"
   echo -e "\t5. Use the previous .config to compile"
   echo -e "\t6. Open OpenWRT Make-Menu"
   echo -e "\t7. Clean Compile Cahe"
   echo -e "\t0. Exit menu\n\n"
   echo -en "\t\tEnter an option: "
   read option
}
updatesource

while [ 1 ]; do
   menu
   case $option in
   0)
      break;;
   1)
      cat configs/x86_64.config >.config;;
   2)
      cat configs/RPi4.config >.config;;
   3)
      cat configs/RPi3B.config >.config;;
   4)
      cat configs/Rockchip.config >.config;;
   5)
      makes
      break;;
   6)
      openMenu;;
   7)
      cleanCache;;
   *)
      clear
      echo "Sorry, wrong selection";;
   esac

   # 选择配置类型
   selectconfig
   if [ $config_num -eq 2 ]; then
      echo -e "-- Start lite build ... --"
      defconfigLite
   else
      echo -e "-- Start deconfig build ... --"
      defconfig
   fi
   makes
   echo -en "\n\n\t\t\tHit any key to continue"
   read -n 1 line
done