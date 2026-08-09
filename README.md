# Milk Platform v3.0 · Personal Binary

#Milk Platform 是面向个人实验环境和已授权服务器的 Xray 多节点配置管理平台。

#它提供统一的配置编排、节点管理、流量查看、健康检查、备份恢复和订阅生成能力，帮助用户更方便地维护自己的服务器。

#主要功能

-1.统一管理多台已授权服务器上的 Xray 服务。

-2.Agent 安装时自动备份并兼容已有配置，降低迁移风险。

-3.图形化创建 VLESS Reality、XHTTP、Shadowsocks 等服务。

-4.可视化配置转发关系和路由规则。

-5.支持单主机配置备份、恢复以及平台状态备份。

-6.根据已配置服务生成常用客户端订阅格式。

-7.Agent 心跳、配置快照和服务状态监测。

-8.按主机、入站和客户端查看流量使用情况。

-9.提供受控的客户端流量查看页面，和IDC厂商同步按照月固定日期重置受控客户端流量。

-10.提供基础连通性和健康状态检测。

-11.TG通知：主机离线通知、流量查询反馈、客户端到期通知、客户端流量警告。

-本项目只面向个人自有或已获授权的服务器环境。

-演示站：https://panel.z7777.dpdns.org/test 演示对部分功能做了简化处理，请以实际安装为准

## 一键安装 Master

Linux amd64 VPS 执行：

```bash
curl -fsSL https://raw.githubusercontent.com/Milk-WX/MILK-PANEL/main/install-milkpanel.sh | sudo env MILKPANEL=1 bash
```

安装器会下载并校验发布包，安装 `milk-master.service`，询问管理员用户名，生成随机初始密码，并显示面板公网地址、管理员用户名和初始密码。

安装完成后打开：

```text
http://你的VPS公网IP:8080/ui/
```

## V3.0 重点

- 新增回程测试中心：Traceroute 线路识别、93 点省级三网持续 TCPing、北上广三网测速按顺序执行。
- Agent 负责真实探测并随心跳回执，Master 持久化任务、队列状态、报告 ID、测试时间和外显链接。
- 回程测试页增加当前队列，按主机展示三阶段进度；页面刷新不会依赖浏览器内存维持任务。
- 外显 `Milk-Quality` 报告提供线路、ASN、吞吐、重传、RTT、持续延迟和丢包矩阵，并支持复制 Markdown。
- 持续 TCPing 目录固定为 31 个省级地区 × 电信/联通/移动，共 93 个 IPv4 目标，不包含教育网单点。
- 节点地址支持 IPv4、IPv6 和双栈识别；订阅和客户端分享链接可按节点地址能力输出。
- Agent 安装继续支持 systemd/OpenRC、已有 Xray 接管、配置备份与回执；Master 保留统一任务审计和状态备份。

## 接入 Agent

在 Milk 面板“云主机”页面生成一次性 Agent 安装命令，然后在目标 VPS 执行：

```bash
curl -fsSL 'Master 生成的一次性地址' | sudo env MILKPANEL=1 INSTALL_XRAY=1 bash
```

安装器会先备份已有 Xray 配置，成功绑定后由 Agent 负责配置应用、服务重启、状态与网络测试回报。Token 不写入公开仓库。

## 发布文件

| 文件 | 用途 |
| --- | --- |
| `milk-master-linux-amd64` / `milk-master-linux-arm64` | Master 主控二进制 |
| `milk-agent-linux-amd64` / `milk-agent-linux-arm64` | Agent 节点二进制 |
| `milk-personal-linux-amd64.tar.gz` / `.zip` | amd64 完整安装包 |
| `milk-personal-linux-arm64.tar.gz` / `.zip` | arm64 完整安装包 |
| `SHA256SUMS` | 发布文件校验值 |

完整变更记录见 [`V3.0-CHANGELOG.md`](V3.0-CHANGELOG.md)。

## 免责声明

本项目仅用于学习、实验和个人服务器管理。使用者应遵守所在地区法律法规、云服务商条款以及相关软件许可证。
