
## 新GitLab代码库
10.1.248.14   
dmck
dmck@2026

地址：http://10.1.248.14/zbzs
账号：root
密码：bzzb@2026~!@

### 清理gitlab容器产生的日志
sudo truncate -s 0 /var/lib/docker/containers/95fc210ccd2f3c75812bfa694ab79f43f95140a60b7c0be811f1d842029072a6/95fc210ccd2f3c75812bfa694ab79f43f95140a60b7c0be811f1d842029072a6-json.log

### 配置 Docker 日志大小限制【（限制单个日志最大 50MB，保留 3 个文件）】
sudo nano /etc/docker/daemon.json

    ```
    {
        "log-driver": "json-file",
        "log-opts": {
            "max-size": "50m",
            "max-file": "3"
        }
    }
    ```
ctrl+o    ctrl+x