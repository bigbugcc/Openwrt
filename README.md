# Lean大openwrt 全自动编译脚本
(lean大默认的插件库已经移除了很多好用的app插件，需要的要手动添加到Package目录下)
1. 自动下载openwrt依赖和源码
2. 自动添加固件中常用的插件
3. 自动编译固件
4. 自动替换Openwrt的Them   
5. 已经加载好配置模板一键编译多版本固件

---
## 固件配置文件(configs 若不需要删除configs目录下的配置文件即可)
x86   
NanoPi R4S   
Raspberry Pi3 B+   
Raspberry Pi4    

---
## 插件
Passwall   
Adguardhome   
OpenAppFilter   
MentoHUST   
OpenAppFilter   
Onliner   
OpenWrt-package  (经典程序包)   

## 脚本运行
```
chmod +x ./openwrtinstall.sh
./openwrtinstall.sh
```

## 二次编译
直接运行lede目录下的make.sh(一键更新openwrt源码及插件库)即可，适合萌新。

### 注意事项
编译过程请务必全程科学上网,如需修改配置文件请make menuconfig
```
# 进入lede根目录
cd lede/

# 加载需要修改的配置文件
cat configs/x86.config > ./.config

# 打开配置菜单
make menuconfig

# 最后修改完成save到configs/x86.config即可
```

## 关于第一次编译的心得
建议第一次编译请不要添加任何app选项（单核速度太慢）
请第二次再添加插件和组件，然后编译时火力全开（测试目前还没有发现因为多线程导致的错误！）
