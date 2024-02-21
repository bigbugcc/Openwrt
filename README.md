# Lean大openwrt 全自动编译脚本
(lean大默认的插件库已经移除了很多好用的app插件，需要的要手动添加到Package目录下)
1. 自动下载openwrt依赖和源码
2. 自动添加固件中常用的插件
3. 自动编译固件
4. 自动替换Openwrt的Them   
5. 已经加载好配置模板一键编译多版本固件
6. 自带更新脚本`make.sh`方便管理

---
## WSL2子系统编译
[<a herf="https://bughero.net/archives/rpi4_s3.html"> WSL编译教程 </a>]
## 脚本控制台
![主界面](./assets/display.png)

## 使用
```
# 首次运行后稍等片刻
chmod +x ./openwrtinstall.sh
./openwrtinstall.sh

# 二次运行直接进入lede目录
./make.sh
# 
```

## 菜单说明
1. x86_64
2. x86_64Lite
3. Raspberry Pi4
4. Raspberry Pi3B+
5. Rockchip(R4S、R2S、OPiR1Plus)
6. Use the previous .config to compile  (二次编译同一个固件)
7. Open OpenWRT Make-Menu               (打开OpenWRT配置菜单)
8. Clean Compile Cahe                   (清除OpenWRT编译缓存)

## 固件支持
x86   
x86Lite  
NanoPi R4S   
NanoPi R2S   
Raspberry Pi3 B+   
Raspberry Pi4    
Orange Pi R1 Plus  
---

## 插件
- PassWall / SSR Plus
- AdGuard Home
- Mentohust
- ~~luci-app-vssr~~   
- luci-adbyby-plus
- luci-app-unblockmusic
- luci-app-ddns
- luci-app-pushbot (全能推送)
- luci-app-onliner
- luci-app-ttyd
- luci-app-turboacc
- luci-app-upnp
- luci-app-netdata
- luci-usb-printer
- luci-app-nps
- luci-app-frpc
- luci-app-n2n
- luci-app-syncdial (多播插件)
- luci-app-turboacc
- luci-app-kms  
- luci-app-docker   
- luci-app-serverchan   
- luci-app-control-timewol (定时wol唤醒)   
- luci-app-aliyundrive-webdav (阿里云盘)  
- luci-app-filebrowser   
- luci-app-nfs   

## 二次编译
直接运行lede目录下的make.sh(一键更新openwrt源码及插件库)即可，适合萌新。

## 注意事项
1. 编译过程请务必全程科学上网,如需修改配置文件请make menuconfig   
2. `make.sh`文件每次启动都会自动更新源码以及所有的插件
(自行添加的插件需放入`package\otherapp`目录下)
