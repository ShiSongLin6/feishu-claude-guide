---
name: feishu-cn-lark-cli-setup
description: 在 Claude 桌面应用里接入国内版飞书（feishu.cn），尤其是手工建应用授权失败（"无法授予的权限""当前账号无法使用"）时使用：改用官方 lark-cli 加官方 skill。
---

# 国内版飞书接入 Claude 桌面应用

## 已验证的结论
- 在个人/豆包类账号下手工创建"企业自建应用"，再用 lark-mcp 走 OAuth，可能反复报"无法授予的权限"，补权限、发版本都没用。
- 官方 `lark-cli` 用自己的一键注册流程创建应用，同一账号授权成功。优先走这条路，不要继续修手工应用。

## 步骤
1. **先查是否已有**：看用户目录下 `~/.lark-cli/config.json` 是否有应用和登录用户；日志在 `~/.lark-cli/logs/`。只读应用 ID、用户名、状态，不读密钥和令牌（密钥在系统凭据库里）。
2. **安装**：`npm install -g @larksuite/cli`，检查 `lark-cli --version`。
3. **登录**：`lark-cli config init`，然后 `lark-cli auth login --recommend`；查看状态用 `lark-cli auth status`。用户身份显示 `needs_refresh` 会在下次调用时自动续期。
4. **安装 skill**：`npx skills add larksuite/cli -y -g --agent claude-code`。如果报 `spawn git ENOENT`，说明电脑没装 Git：在能访问 GitHub 的环境里克隆仓库，把 `skills/` 下带 `SKILL.md` 的 `lark-*` 文件夹打包，让用户解压到 `~/.claude/skills`。
5. **用对会话类型**：skill 里的命令要在**用户的 Windows 上直接执行**。聊天/协作沙盒（Linux 虚拟机）和云端会话碰不到用户电脑上的 `lark-cli`，应使用 Code 模式里**在本机运行**的会话（不要选云端）。若提示找不到 `lark-cli`，告诉它完整路径（例如便携 Node 目录下的 `lark-cli.cmd`）。聊天模式用本地 MCP 桥接属于实验性做法，未验证，不作为默认方案。

## 注意
- `~/.claude` 是 Claude 的保护目录，助手无法写入，最后一步要用户双击脚本完成。
- 不要运行旧的 lark-mcp 配置脚本，会往 Claude 配置里写入无效项。
- 装第三方 skill 前先扫一遍内容；写入、删除类操作先向用户确认。
