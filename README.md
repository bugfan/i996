## 任何的功能/bug/想法/建议,都可以到这里提 https://github.com/bugfan/i996/issues/new

## 客户端代码已开源，服务端在整理中。。。

## i996

基于Shell/Bat和Golang开发的一款免费,免安装的内网穿透/建议签发ssl证书工具。

## 首页地址

https://www.i996.me

## 主要用途

内网穿透 签发证书 签通配证书 远程办公 居家办公 web服务对外发布 前后端远程联调 调试微信小程序等

<br>

## ✨✨ 功能 ✨✨

#### 内网穿透

1. 支持https/tcp/h2/h3/http/websocket/ssh/ftp/smtp(注意⚠️:udp暂不支持)
2. 无需在本地机器安装客户端程序,拿来即用
3. 支持动态变更目标地址和端口
4. 对外提供公网域名和免费https证书
5. 域名固定(可更换刷新)
6. http头转发设置
7. 终端断线自动重连
8. 自定义域名
9. cname绑定私有域名
10. 请求日志打印
11. 全平台支持 Mac/Linux/Windows

#### ~~网络加速~~ (暂时遗弃)
1. ~~Github加速器~~

#### 签发通配证书(新添功能)
1. 自定义待签发的域名
2. 以文件夹方式下载证书(bash)
3. 以http接口方式返回证书(json)
4. 续签证书


## 内网穿透使用步骤 🚀
1. 关注微信公众号“敲代码斯基”获取公网域名和访问Token

![image](https://github.com/bugfan/i996/blob/main/img/qdmsj.jpg)

2. 打开一个终端窗口，将以下命令粘贴进去，替换Token参数部分，回车(建议使用v2版本,v2转发效率高)
- Mac/Linux/Windows-WSL/Windows-Git
```
curl i996.me | bash -s Token 
(👆等价于 curl v1.i996.me | bash -s Token)
或者
curl v2.i996.me | bash -s Token
```
- Windows 自带终端
```
curl i996.me/Token | cmd
(👆等价于curl v1.i996.me/Token | cmd,也等价于curl win.i996.me/Token | cmd)
或者
curl v2.i996.me/Token | cmd
```

(如果有防火墙之类的软件可能会提示失败)

3. 访问公众号提供的公网地址即可访问你本地web服务【https://xxxx.i996.me -> i996公网服务器 -> 内网本地web服务】

## 签发通配证书使用步骤 ✈️
#### 只需两步,让你轻松拥有免费泛域名证书/通配证书,下面以域名是abc.com,token是xxxx为例👇
```
步骤一:
在你dns上增加一条CNAME记录,Name为_acme-challenge,Value为xxxx.abc.com
最终需要验证的域名为_acme-challenge.abc.com

步骤二:
在终端输入这些玩意即可拿到证书
curl https://ssl.i996.me/xxxx|bash
或者
curl 'https://ssl.i996.me/xxxx?type=json'

【提示😊】可以把步骤二里面的命令改成用自己程序去请求;也可以配置到linux计划任务中,给nginx服务器用。
```

<br>

# 使用截图👇
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

![image](https://github.com/bugfan/i996/blob/main/img/1.13.jpg)

<br>

![image](https://github.com/bugfan/i996/blob/main/img/cert2.jpg)

<!-- ### 如果觉得还不错请我喝瓶红牛😄 -->

### 欢迎请我喝瓶红牛,如果您觉得[i996](https://github.com/bugfan/i996)对你有帮助,给予一定的捐助来维持项目和服务长期发展

<img src="https://github.com/bugfan/i996/blob/main/img/wxpay3.jpeg" width="266" hight="430" alt="frp-Android-02.png"> <img src="https://github.com/bugfan/i996/blob/main/img/alipay3.jpeg" width="266" hight="430" alt="frp-Android-02.png">

### 技术交流群

![image](https://github.com/bugfan/i996/blob/main/img/contact.jpg)
