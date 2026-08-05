# Milk Platform v2.0 · Personal Binary

Milk Platform 是面向个人自有或已获授权服务器的 Xray 多节点管理面板。
本仓库只发布 Linux 二进制和安装资产，不包含项目源码。

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

重复执行安装命令会保留现有账号和状态。登录后可在面板中修改密码；备份请从面板下载。

## V2.0 重点

- 节点分享名称统一为 `主机名-协议(+安全层)-Client`，复制节点、V2RayN、Clash/Mihomo、Sing-box 和小火箭输出共用同一命名规则。
- 订阅创建、增加/减少节点和删除均经过统一执行流水线，按节点展示创建、配置、Agent、Xray 四阶段回执。
- 入站 JSON 导入保留完整 Xray 配置语义，包含出站和路由；导入、手动编辑、快速生成使用同一协议校验链路。
- 转发绑定、客户端删除和健康检测使用同一份关联数据，减少残留映射和错误回显。
- 客户端月度流量周期按到期日锚定，周期到点清零并自动恢复未到最终到期日的客户端。
- 节点详情、流量外显、备份恢复、TG 通知和客户端查询入口统一到当前 Master 控制台。
- Agent 安装支持已有 Xray 接管、配置备份、Xray 应用回执，并兼容 systemd/OpenRC 环境。
- Master 安装和 SSH `milk` 管理命令支持升级、彻底卸载和重新生成管理员凭据。

## 接入 Agent

在 Milk 面板“云主机”页面生成一次性 Agent 安装命令，然后在目标 VPS 执行：

```bash
curl -fsSL 'Master 生成的一次性地址' | sudo env MILKPANEL=1 INSTALL_XRAY=1 bash
```

安装器会先备份已有 Xray 配置，成功绑定后由 Agent 负责配置应用、服务重启和状态回报。Token 不写入公开仓库。

## 发布文件

| 文件 | 用途 |
| --- | --- |
| `milk-master-linux-amd64` / `milk-master-linux-arm64` | Master 主控二进制 |
| `milk-agent-linux-amd64` / `milk-agent-linux-arm64` | Agent 节点二进制 |
| `milk-personal-linux-amd64.tar.gz` | amd64 完整安装包 |
| `milk-personal-linux-arm64.tar.gz` | arm64 完整安装包 |
| `SHA256SUMS` | 发布文件校验值 |

完整变更记录见 [`V2.0-CHANGELOG.md`](V2.0-CHANGELOG.md)。

## 免责声明

本项目仅用于学习、实验和个人服务器管理。使用者应遵守所在地区法律法规、云服务商条款以及相关软件许可证。
