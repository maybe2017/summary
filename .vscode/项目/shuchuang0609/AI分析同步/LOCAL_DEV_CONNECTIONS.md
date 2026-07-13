# 本地开发环境连接说明

最后确认日期：2026-06-24

## Docker 容器

- MySQL: `mysql-bzzb`
- Redis: `redis-bzzb`
- MinIO: `minio`

可先查看容器状态：

```bash
docker ps --format '{{.Names}}\t{{.Image}}\t{{.Ports}}'
```

## MySQL

- Host: `127.0.0.1`
- Port: `3306`
- User: `root`
- Password: `rootroot`
- 主要业务库: `zbzs`
- 其他库: `liangban`, `zbzs_bz`

说明：

- 项目部署配置文件里写的是 `mysql-dyh` 和密码 `dSR3jB66n5`，那是部署环境参数。
- 本机当前实际运行的 Docker 容器使用的是 `mysql-bzzb`，真实 root 密码来自容器环境变量 `MYSQL_ROOT_PASSWORD=rootroot`。

连接示例：

```bash
docker exec mysql-bzzb mysql --default-character-set=utf8mb4 -uroot -prootroot -D zbzs
```

```bash
mysql --default-character-set=utf8mb4 -h127.0.0.1 -P3306 -uroot -prootroot zbzs
```

常用检查命令：

```bash
docker exec mysql-bzzb mysql -uroot -prootroot -e "SHOW DATABASES;"
```

## Redis

- Host: `127.0.0.1`
- Port: `6379`
- Password: 当前未发现密码要求

连接示例：

```bash
docker exec redis-bzzb redis-cli
```

```bash
redis-cli -h 127.0.0.1 -p 6379
```

检查命令：

```bash
docker exec redis-bzzb redis-cli INFO server
```

## MinIO

- API Endpoint: `http://127.0.0.1:9000`
- Console: `http://127.0.0.1:9001`
- Root User: `minioroot`
- Root Password: `minioroot1`
- 容器数据目录: `/data`
- 宿主机挂载目录: `/Users/mayu/Documents/workspace/data/minio/data`

说明：

- 这些参数来自容器环境变量 `MINIO_ROOT_USER` 和 `MINIO_ROOT_PASSWORD`。
- 当前只确认了容器与端口、账号配置；项目代码中的对象存储实现仍偏向 OSS 兼容接口，后续若需要可再补桶名和实际文件路径检查。

## 这次分析里确认的权限/组织数据入口

- 系统权限主表：
  - `sys_user`
  - `sys_depart`
  - `sys_role`
  - `sys_permission`
  - `sys_user_role`
  - `sys_role_permission`
  - `sys_user_depart`
- 业务值班旧表：
  - `dyh_role`
  - `dyh_user`
  - `dyh_user_role`
  - `dyh_system`
  - `dyh_duty`
  - `dyh_business_duty`
  - `dyh_management_units`

## 结论提示

- 当前系统真实在用的人岗权限，主要还是看 `sys_*` 这套 Jeecg 权限表。
- `dyh_*` 更像早期或局部功能保留的数据模型，尤其 `dyh_duty` 直接按姓名字段 `sld/zhz/zbz` 存排班，不是当前主权限体系的核心绑定方式。
