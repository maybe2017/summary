
### Keepalive机制：TCP协议层 vs 应用层
1. tcp的keep alive 是内核实现的保活机制，探测对方存活报文。【TCP Keepalive是协议原生功能，但默认不活跃且间隔长，适合兜底】
    ```
    // 避免 半连接 问题
    探测空闲连接是否仍然有效，避免因网络中断或对端崩溃导致连接长期挂起。

    // 原理
    当连接空闲时间超过tcp_keepalive_time（默认7200秒/2小时），内核发送Keepalive探测包（空ACK包）。
    若连续tcp_keepalive_probes次（默认9次）未收到响应，判定连接死亡，关闭连接。
    ```

2. http的keep alive 目的是为了复用Tcp链接，称为http长连接。【独立，两者共存互补（如RabbitMQ同时依赖AMQP心跳和TCP保活）】
    ```
    应用层需要精细控制（如更短的心跳间隔），比TCP Keepalive更快检测故障
    需在保活时传递业务信息（如RabbitMQ心跳）
    避免修改系统参数（如云环境无权限调整sysctl）
    ```
