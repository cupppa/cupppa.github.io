# 内容规范

## 目录

- `org/index.org`：首页。
- `org/posts/`：文章正文和文章索引。
- `org/categories/`：分类索引和分类页面。
- `org/about.org`：关于页面。
- `org/assets/`：公开图片、样式和附件，按资源类型归档。
- `org/assets/css/site.css`：站点级样式；只添加必要的页面样式。
- `backup/`：历史快照，不是内容源。

## 文章

每篇文章使用以下元数据：

```org
#+title: 文章标题
#+date: YYYY-MM-DD
#+updated: YYYY-MM-DD
#+description: 一句话摘要。
#+category: tech
#+filetags: :tag1:tag2:
```

约定：

- 文件名为 `YYYY-MM-DD-short-name.org`。
- `date` 是首次发布日期，`updated` 是最近一次实质性更新日期；只修改正文或配置时更新 `updated`。
- `category` 只填一个主分类；当前分类为 `tech` 技术实践，其他分类有内容后再建立。
- 标签使用小写英文短名，每篇 0 到 5 个。
- 新文章加入 `org/posts/index.org` 和对应分类页。
- 修改文章正文时保留原文件路径和 URL。
- 导航使用 Org 列表，包在 `<nav class="site-nav">` 中；桌面端与页面标题同行并右对齐，窄屏自动换行。
- 文章和页面正文列表不使用 `site-nav`，避免被导航样式影响。

## 发布前

```sh
./build.sh
./scripts/check-site.sh
```

只修改 Org 源文件；不直接修改 `public_html/` 或 `backup/`。构建和检查未通过，不发布。
