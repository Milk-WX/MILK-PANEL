# Milk Platform v3.01 · Personal Binary

Milk Platform 是面向个人自有或已获授权服务器的 Xray 多节点管理面板。本目录只发布 Linux 二进制和安装资产，不包含项目源码。

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

## V3.01 重点

- 新增管理员登录白名单，默认关闭，可在管理员菜单的“登录白名单”中启用。
- 支持单个 IPv4、单个 IPv6、IPv4 CIDR 和 IPv6 CIDR；配置保存前会完成格式校验与规范化。
- 代理部署可识别可信转发头中的真实访问 IP，页面会显示当前识别到的来源地址。
- 开启白名单时强制包含当前管理员地址，避免配置保存后立即把当前浏览器锁在面板外。
- 管理员 Token API 保留为恢复通道；网页用户名/密码登录受白名单约束。
- 白名单属于目标 Master 本机安全设置，不进入 `state.json` 导出；导入状态时也不会覆盖目标机白名单。
- 延续 V3.0 的回程测试、报告外显、IPv4/IPv6 双栈、订阅编排、完整 Xray JSON 导入和 systemd/OpenRC Agent 安装能力。

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
| `install-milkpanel.sh` | GitHub 一键安装入口 |
| `milk` | SSH 管理命令 |
| `SHA256SUMS` | 发布资产 SHA256 校验 |
| `V3.01-CHANGELOG.md` | V3.01 变更与升级说明 |

## 升级与固定版本

`main` 始终提供最新稳定版。固定安装 V3.01 可指定 Git 引用：

```bash
curl -fsSL https://raw.githubusercontent.com/Milk-WX/MILK-PANEL/v3.0.1/install-milkpanel.sh | sudo env MILKPANEL=1 MILK_GITHUB_REF=v3.0.1 bash
```

升级前请先在网页面板下载 `state.json` 备份。V3.01 不会主动开启白名单，升级后现有登录方式保持不变。

## 说明

- 发布包面向 Linux amd64/arm64。
- 仓库只发布二进制和安装资产，源码不在此发布仓库中。
- 请仅用于自有或已获授权的服务器和网络环境。

