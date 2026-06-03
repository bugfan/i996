# 免费内网穿透
## 任何的功能/bug/想法/建议,都可以到这里提 https://github.com/bugfan/i996/issues/new

## 客户端代码已开源，服务端在整理中。。。

## i996内网穿透

基于Shell/Bat和Golang开发的一款免费,免安装的内网穿透/ssl证书签发工具。

## 首页地址

https://tun.i996.me

## 主要用途

内网穿透 签发证书 签通配证书 远程办公 居家办公 web服务对外发布 前后端远程联调 调试微信小程序等

<br>

## 🙇‍♀️🙇 如果你想要更稳定/更舒心的体验请使用会员版本，也算是对i996的支持

想要成为会员请访问👉 [https://tun.i996.me/#vip](https://tun.i996.me/#/vip) ,已配置支付回调,打赏后自动成为会员用户,无需手动操做！！！

## ✨✨ 功能 ✨✨

#### 内网穿透

1. 支持https/tcp/h2/h3/http/websocket/ssh/ftp/smtp(注意⚠️:udp暂不支持)
2. 无需在本地机器安装客户端程序,拿来即用
3. 支持动态变更目标地址和端口
4. 对外提供公网域名和免费https证书
5. 域名固定(可更换刷新)
6. TCP端口固定(可自行更换)
7. http头转发设置
8. 终端断线自动重连
9. 自定义域名
10. cname绑定私有域名
11. cname域名以https方式加载
12. 请求日志打印
13. 支持国密链接访问(国密GM for SM2.SM3.SM4)
14. 自定义Token
15. 全平台支持 Mac/Linux/Windows
16. 客户端 Mac/Linux/Windows/Android/iOS (详见 https://tun.i996.me/#download )

#### ~~网络加速~~ (暂时遗弃)
1. ~~Github加速器~~

#### ~~签发通配证书~~(曾经有，最近刚刚遗弃，后续会单独弄成一个证书签发平台，由web管理)
1. ~~自定义待签发的域名~~
2. ~~以文件夹方式下载证书(bash)~~
3. ~~以http接口方式返回证书(json)~~
4. ~~续签证书~~


## 内网穿透使用步骤 🚀
1. 关注微信公众号“敲代码斯基”获取启动命令

![image](https://github.com/bugfan/i996/blob/main/img/qdmsj.jpg)

2. 打开一个终端窗口，将公众号分配给你的命令粘贴进去，回车(建议使用v2版本,v2转发效率高)
- Mac/Linux/Windows-WSL/Windows-Git
```
curl https://i996.me | bash -s Token 
(👆等价于 curl https://v1.i996.me | bash -s Token)
或者
curl https://v2.i996.me | bash -s Token
```
- Windows 自带终端
```
curl https://i996.me/Token | cmd
(👆等价于curl https://v1.i996.me/Token | cmd,也等价于curl https://win.i996.me/Token | cmd)
或者
curl https://v2.i996.me/Token | cmd
```

(如果有防火墙之类的软件可能会提示失败)

3. 访问公众号提供的公网地址即可访问你本地web服务【https://xxxx.i996.me -> i996公网服务器 -> 内网本地web服务】

## 签发通配证书使用步骤 ✈️
#### 只需简单三步,让你轻松拥有免费泛域名证书/通配证书,下面以域名是abc.com,token是xxxx为例👇
```
步骤一：
在公众号回复acme:abc.com

步骤二:
在你dns上增加一条CNAME记录,Name为_acme-challenge,Value为xxxx.abc.com
最终需要验证的域名为_acme-challenge.abc.com

步骤三:
在终端输入这些玩意即可拿到证书
curl https://ssl.i996.me/xxxx|bash
或者
curl 'https://ssl.i996.me/xxxx?type=json'

【提示😊】可以把步骤三里面的命令改成用自己程序去请求;也可以配置到linux计划任务中,给nginx服务器用。
```

<br>

# 使用截图👇
（注意⚠️:尽量以公众号返回的命令为主，下面截图里面的命令有可能是旧的）
## 版本一 (支持http/https)

### Mac/Linux(终端窗口) 执行截图

![image](https://github.com/bugfan/i996/blob/main/img/sh.jpeg)

### Windows(终端窗口) 执行截图

![image](https://github.com/bugfan/i996/blob/main/img/win.jpeg)

## 版本二 (支持tcp/ftp/rdp/ssh/stmp/http(s)/h2/h3/websocket)

### Mac/Linux/Windows(Git-Bash/wsl-linux)截图

![image](https://github.com/bugfan/i996/blob/main/img/v2.jpg)

### Windows-CMD截图

![image](https://github.com/bugfan/i996/blob/main/img/v2-bat.jpg)

<br>

## 公众号截图

![image](https://github.com/bugfan/i996/blob/main/img/1.23.jpg)

<br>

![image](https://github.com/bugfan/i996/blob/main/img/cert2.jpg)

<!-- ### 如果觉得还不错请我喝瓶红牛😄 -->

### 欢迎请我喝瓶红牛,如果您觉得[i996](https://github.com/bugfan/i996)对你有帮助,给予一定的捐助来维持项目和服务长期发展

<img src="https://github.com/bugfan/i996/blob/main/img/wxpay3.jpeg" width="266" hight="430" alt="frp-Android-02.png"> <img src="https://github.com/bugfan/i996/blob/main/img/alipay3.jpeg" width="266" hight="430" alt="frp-Android-02.png">

### 技术交流群

- 技术交流一群（已满）

![image](https://github.com/bugfan/i996/blob/main/img/contact.jpg)

- 技术交流二群 (已满)
<img src="https://github.com/bugfan/i996/blob/main/img/contact2.jpg" width="262" hight="465" alt="frp-Android-02.png">

- 技术交流三群
<img src="https://github.com/bugfan/i996/blob/main/img/contact3.jpg" width="262" hight="465" alt="frp-Android-02.png">
