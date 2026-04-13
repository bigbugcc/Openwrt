# OpenWrt 全自动编译脚本

**[English](./README.md)**

基于 [Lean's LEDE](https://github.com/coolsnowwolf/lede) 源码的本地全自动编译工具，配置文件引用自 [bigbugcc/OpenWrts](https://github.com/bigbugcc/OpenWrts/tree/main/configs)。

## 功能特性

- 自动安装编译依赖环境
- 自动拉取 LEDE 源码
- 自动添加常用插件（passwall2、OpenClash、iStore 等）
- 自动同步上游配置文件（多平台 `.config`）
- 交互式菜单，支持一键编译多版本固件
- 内置 `make.sh` 管理脚本，二次编译自动更新源码及插件

---

## 脚本控制台

![主界面](./assets/display.png)

---

## 快速开始

> ⚠️ 请不要在 root 用户下执行！

```bash
sudo mkdir -p /workdir && cd /workdir

# 设置目录所有者
sudo chown $USER:$GROUPS /workdir

# 赋予执行权限并运行
chmod +x ./openwrtinstall.sh
./openwrtinstall.sh

# 二次编译（直接进入 lede 目录执行）
./make.sh
```

---

## 编译菜单说明

| 序号 | 选项 |
|:----:|------|
| 1 | x86_64 |
| 2 | Raspberry Pi 5 |
| 3 | Raspberry Pi 4 |
| 4 | Raspberry Pi 3B+ |
| 5 | Rockchip (R68S、R2S、R4S、R5C、R5S、OPiR1Plus) |
| 6 | 使用当前 .config 直接编译 |
| 7 | 打开 OpenWrt 配置菜单 (make menuconfig) |
| 8 | 清除编译缓存 |

---

## 支持的平台

| 平台 | 说明 |
|------|------|
| x86_64 | 标准版 / Lite 精简版 |
| Raspberry Pi 3B/3B+ | 树莓派 3 系列 |
| Raspberry Pi 4B | 树莓派 4 系列 |
| Raspberry Pi 5 | 树莓派 5 系列 |
| NanoPi R2S / R4S | FriendlyARM |
| NanoPi R5C / R5S | FriendlyARM |
| FastRhino R68S | 飞牛路由 |
| Orange Pi R1 Plus | 香橙派 |

### 固件默认设置

- 路由器地址：`192.168.10.1`
- 默认用户名：`root`
- 默认密码：`password`

---

## 内置插件

🍕 代理 / 科学上网
- PassWall2
- SSR Plus
- OpenClash
- Hello World

🛡️ 广告过滤
- AdGuard Home
- luci-adbyby-plus

🎵 其他
- luci-app-unblockmusic (解锁网易云音乐)
- luci-app-pushbot (全能推送)
- luci-app-ddns
- luci-app-onliner
- luci-app-ttyd
- luci-app-turboacc
- luci-app-upnp
- luci-app-netdata
- luci-usb-printer
- luci-app-nps
- luci-app-frpc
- luci-app-n2n
- luci-app-syncdial (多播)
- luci-app-kms
- luci-app-docker
- luci-app-serverchan
- luci-app-control-timewol (定时 WOL 唤醒)
- luci-app-aliyundrive-webdav (阿里云盘)
- OpenAppFilter (应用过滤)
- Mentohust
- iStore 应用商店

---

## 二次编译

直接运行 `lede/` 目录下的 `make.sh`，会自动更新 LEDE 源码及所有插件后进入编译菜单，适合日常维护使用。

> 自行添加的插件请放入 `package/otherapp/` 目录下。

---

## 注意事项

1. 编译过程请全程保持网络畅通（建议科学上网）
2. 如需自定义固件配置请使用菜单第 7 项（`make menuconfig`）
3. `make.sh` 每次启动均会自动拉取最新源码及更新所有插件

---

## 相关项目

- [coolsnowwolf/lede](https://github.com/coolsnowwolf/lede)
- [bigbugcc/OpenWrts](https://github.com/bigbugcc/OpenWrts)
- [luci-theme-argon](https://github.com/jerrykuku/luci-theme-argon)
- [iStore](https://github.com/linkease/istore)
- [OpenClash](https://github.com/vernesong/OpenClash)
- [PassWall2](https://github.com/Openwrt-Passwall/openwrt-passwall2)
