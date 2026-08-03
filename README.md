# Milk Platform Personal Edition Milk平台个人版

Milk Platform 是面向个人实验环境和已授权服务器的 Xray 多节点配置管理平台。

它提供统一的配置编排、节点管理、流量查看、健康检查、备份恢复和订阅生成能力，帮助用户更方便地维护自己的服务器。

## 主要功能

1. 统一管理多台已授权服务器上的 Xray 服务。
2. Agent 安装时自动备份并兼容已有配置，降低迁移风险。
3. 图形化创建 VLESS Reality、XHTTP、Shadowsocks 等服务。
4. 可视化配置转发关系和路由规则。
5. 支持单主机配置备份、恢复以及平台状态备份。
6. 根据已配置服务生成常用客户端订阅格式。
7. Agent 心跳、配置快照和服务状态监测。
8. 按主机、入站和客户端查看流量使用情况。
9. 提供受控的客户端流量查看页面，和IDC厂商同步按照月固定日期重置受控客户端流量。
10. 提供基础连通性和健康状态检测。
11. TG通知：主机离线通知、流量查询反馈、客户端到期通知、客户端流量警告。
> 本项目只面向个人自有或已获授权的服务器环境。

演示站：[https://panel.z7777.dpdns.org/test](https://test.z7777.dpdns.org/test)

## 一条命令安装 Master

Linux amd64 VPS 执行：

```bash
curl -fsSL https://raw.githubusercontent.com/Milk-WX/MILK-PANEL/main/install-milkpanel.sh | sudo env MILKPANEL=1 bash
```
安装器会自动完成：

1. 下载并校验 `SHA256SUMS`。
2. 安装 `milk-master.service`。
3. 询问管理员用户名。
4. 生成长随机管理员密码，并在首次安装完成时打印一次。
5. 安装 SSH 管理命令 `milk`。

安装完成后打开：

```text
http://你的VPS_IP:8080/ui/
```

请立即保存终端输出的管理员密码。重复升级不会覆盖已有账号密码。

## SSH 管理

登录 Master VPS 后执行：

```bash
sudo milk
```

菜单提供：

```text
1. 升级面板
2. 卸载面板
0. 退出
```

卸载需要输入 `UNINSTALL` 二次确认；配置、状态和日志会保留。备份请在网页面板内下载 `state.json`。

## 接入 Agent 节点

Master 配置公开二进制仓库：

```env
NEUXS_MASTER_AGENT_GITHUB_REPOSITORY=Milk-WX/MILK-PANEL
NEUXS_MASTER_AGENT_GITHUB_REF=main
```

然后在 Milk 面板“云主机”页面创建 Agent 安装器，复制页面生成的一次性命令。命令格式为：

```bash
curl -fsSL 'Master生成的一次性地址' | sudo env MILKPANEL=1 INSTALL_XRAY=1 bash
```

节点 Token 不写入公开仓库，也不会暴露给 GitHub。每个安装器绑定成功后自动失效，避免同一地址重复接入多台 VPS。

## 发布文件

| 文件 | 用途 |
| --- | --- |
| `milk-master-linux-amd64` / `milk-master-linux-arm64` | Master 主控程序 |
| `milk-agent-linux-amd64` / `milk-agent-linux-arm64` | Agent 节点程序 |
| `milk-personal-linux-amd64.tar.gz` | amd64 完整安装包 |
| `SHA256SUMS` | 发布文件校验值 |

## 说明

- 固定 GitHub 安装入口目前面向 Linux amd64；ARM64 请使用对应二进制和安装包。
- `mihomo` 健康探针是可选组件，下载失败不会阻止 Master 启动。
- GitHub 仓库只发布二进制和安装资产，源码不在此仓库中。
## 免责声明
本项目仅用于学习、实验和个人服务器管理。
使用者应遵守所在地区法律法规、云服务商条款以及相关软件许可证。作者不提供未授权服务器管理、网络限制规避或商业运营服务。
