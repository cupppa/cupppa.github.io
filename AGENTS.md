# Agent 工作入口

这是一个使用 Org Mode 构建的静态个人网站。

## 路由

- 文章内容：读取 `org/` 与 `docs/style.md`。
- 构建逻辑：读取 `build-site.el`、`build.sh` 与 `scripts/check-site.sh`。
- 发布逻辑：读取 `.github/workflows/publish.yml`。
- 历史快照：`backup/` 仅供参考，不是当前内容源。
- 已知问题：先读取 `LESSONS.md`，避免重复引入已知故障。

## 工作规则

1. 修改前先读取相关源文件和本文件。
2. 只修改源文件，不直接编辑 `public_html/` 或 `backup/`。
3. 文章修改后必须运行 `./build.sh` 和 `./scripts/check-site.sh`。
4. 构建或检查未运行时，不得声称发布已验证。
5. 不擅自反转已经确定的标题、观点、文章语气或发布决定。
6. 发现重复出现的问题，先记录到 `LESSONS.md`；重复三次后升级为正式规范或自动检查。

## 完成标准

一个内容任务只有在以下条件都满足后才算完成：

- Org 源文件已修改。
- 本地构建成功。
- 生成物检查成功。
- 变更范围没有包含生成目录或历史快照。
- 需要发布时，GitHub Actions 已成功完成并可检查线上页面。
