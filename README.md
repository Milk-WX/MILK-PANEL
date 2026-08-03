# Milk Panel personal binaries

This repository intentionally contains release binaries only; project source is not included.

## One-click Agent install

Configure the Master to read this public repository:

```env
NEUXS_MASTER_AGENT_GITHUB_REPOSITORY=Milk-WX/MILK-PANEL
NEUXS_MASTER_AGENT_GITHUB_REF=main
```

Then create an Agent installer in the Milk web panel and copy its generated command. The command uses `MILKPANEL=1 INSTALL_XRAY=1` and the one-time Master URL; no GitHub token is exposed to the Agent.

## Fixed Master install

For a new amd64 Master VPS:

```bash
curl -fsSL https://raw.githubusercontent.com/Milk-WX/MILK-PANEL/main/install-milkpanel.sh | sudo env MILKPANEL=1 bash
```

The bootstrap verifies `SHA256SUMS`, installs the Master package, asks for the administrator username, and prints a generated password once.

## Master SSH management

After installing the Master package, run `sudo milk` on the VPS:

```text
1. Upgrade panel
2. Uninstall panel
0. Exit
```

Backups are downloaded from the web panel. The SSH uninstall action preserves configuration and state directories.
