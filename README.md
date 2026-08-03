# Milk 平台个人版

把多台 VPS、Xray 入站、客户端流量和订阅，收进一个轻量的 Master 控制面。节点只运行 Milk Agent + Xray，配置下发、状态回执、流量统计和回滚都由 Master 统一编排。

> 这是个人版二进制发布仓库，不包含项目源码。

## 一条命令安装 Master

新建 Linux amd64 VPS，直接执行：

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
