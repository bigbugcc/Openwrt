#Lean大openwrt 全自动编译脚本
(lean大默认的插件库已经移除了很多app,其中有几个好用的插件，需要的要手动添加到Package目录下)
1.自动下载openwrt依赖和源码
2.自动添加固件中常用的插件

插件(感谢大佬们的硬核支持)
Passwall
Adguardhome
OpenAppFilter
MentoHUST

脚本运行
./openwrtinstall.sh
等待片刻即可

二次编译
直接运行lede目录下的make.sh(一键更新openwrt源码及插件库)即可，适合萌新。

注意事项
编译过程请务必全程科学上网。

关于第一次编译的心得
建议第一次编译请不要添加任何app选项（单核速度太慢）
请第二次再添加app 或者组件，然后编译时火力全开（测试目前还没有发现因为多线程导致的错误！）
