## 任何的功能/bug/想法/建议,都可以到这里提 https://github.com/bugfan/i996/issues/new

## 客户端代码已开源，服务端在整理中。。。

## i996

基于Shell/Bat和Golang开发的一款免费,免安装的内网穿透工具。i996意指 “我爱996😄”

## 首页地址

https://www.i996.me

## 主要用途

内网穿透 远程办公 居家办公 web服务对外发布 前后端远程联调 调试微信小程序等

<br>

## ✨ Features

### 内网穿透

1. 支持https/h2/h3/http(注意⚠️:tcp/udp/nas等这些东西目前暂时不考虑支持)
2. 无需在本地机器安装客户端程序,拿来即用
3. 支持动态变更目标地址和端口
4. 对外提供公网域名和免费https证书
5. 域名固定(可更换刷新)
6. http头转发设置
7. 终端断线自动重连
8. 自定义域名
9. cname绑定私有域名
10. 全平台支持 Mac/Linux/Windows

### 网络加速
1. Github加速器

## 🚀 Quick Start
1. 打开一个终端窗口，将以下命令粘贴进去，替换Token参数部分，回车
- Mac/Linux
```
curl -s i996.me | bash -s Token
```
- Windows 自带终端
```
curl -s win.i996.me/Token | cmd
```
- Windows WSL/Linux
```
curl -s i996.me | bash -s Token
```
(如果有防火墙之类的软件可能会提示失败)

2. 关注微信公众号“敲代码斯基”获取公网域名和访问Token

![image](https://github.com/bugfan/i996/blob/main/img/qdmsj.jpg)

3. 访问公众号提供的公网地址即可访问你本地web服务【https://xxxx.i996.me -> i996公网服务器 -> 内网本地web服务】

<br>

## Mac/Linux(终端窗口) 执行截图

![image](https://github.com/bugfan/i996/blob/main/img/sh.jpeg)

## Windows(终端窗口) 执行截图

![image](https://github.com/bugfan/i996/blob/main/img/win.jpeg)

## 公众号截图

![image](https://github.com/bugfan/i996/blob/main/img/gzh.jpg)

### 如果觉得还不错请我喝瓶红牛😄

![image](https://github.com/bugfan/i996/blob/main/img/buy.jpeg)
