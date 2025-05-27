
## sftp通道建立连接时报错, 在channel.connect()时报("session is down")
1. https://bbs.csdn.net/topics/390939673
2. SFTP（SSH文件传输协议）的访问路径权限应该是750或755，而不是777（Caused by: comjcraft jsch.JSchException: session is down）
3. https://www.jianshu.com/p/f61042d5601


## 421
考虑连接数超载

### SFTP服务器为ipv6时
1. 注意ip地址用`[]`包裹
2. java服务启动脚本中，查看是否有`-Djava.net.preferIPv4Stack=true`，或代码中查询是否有 `System.setProperty("java.net.preferIPv4Stack", "true");`