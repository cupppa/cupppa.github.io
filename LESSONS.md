# Lessons

## 2026-11-03：Org 发布缓存不能依赖用户目录

- 现象：本地构建尝试删除 `~/.org-timestamps/org-site:main.cache` 时因权限限制失败。
- 原因：`org-publish` 默认把时间戳缓存写到用户目录，构建不完全自包含。
- 修复：在 `build-site.el` 中将 `org-publish-timestamp-directory` 固定到仓库内的 `.org-timestamps/`，并加入 `.gitignore`。
- 验证：重新执行 `./build.sh`，再执行 `./scripts/check-site.sh`。
- 规则：构建状态、缓存和临时文件必须放在工作区或 CI 明确配置的缓存目录中。

## 记录规则

每条经验包含：日期、现象、原因、修复、验证和可推广规则。相同问题在不同维护周期出现三次后，应升级为正式规范或自动检查。
