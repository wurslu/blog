# 创建新文章常用说明

## 写新文章

创建新文章：
bash# 创建新文章（自动生成模板）
hugo new posts/文章标题.md

## 或者按分类创建

hugo new posts/tech/hugo-tutorial.md
hugo new posts/life/my-thoughts.md
文章头部（Front Matter）模板：
markdown---
title: "文章标题"
date: 2025-06-20T21:45:00+08:00
draft: false # true=草稿，false=发布
tags: ["Hugo", "博客", "技术"] # 标签
categories: ["技术"] # 分类
description: "文章简短描述"
cover:
image: "images/cover.jpg" # 封面图片
alt: "封面图片描述"
caption: "图片说明"
author: "你的名字"
showToc: true # 显示目录
TocOpen: false # 目录默认展开
weight: 1 # 文章权重（数字越小越靠前）

---

这里是文章正文内容...
🏷️ 标签和分类管理
在文章中添加标签和分类：
markdown---
title: "我的新文章"
tags: ["Hugo", "前端", "JavaScript"]
categories: ["技术分享"]

---

查看所有标签和分类：

访问 /tags/ 查看所有标签
访问 /categories/ 查看所有分类
点击标签/分类可以看到相关文章

📁 文件夹结构管理
推荐的目录结构：
content/
├── posts/
│ ├── tech/ # 技术文章
│ │ ├── hugo-guide.md
│ │ └── javascript-tips.md
│ ├── life/ # 生活随笔
│ │ ├── travel-diary.md
│ │ └── book-review.md
│ └── projects/ # 项目介绍
│ └── my-app.md
├── about/ # 关于页面
│ └── index.md
└── archives/ # 归档页面
└── index.md
创建特殊页面：
bash# 创建关于页面
hugo new about/index.md

## 创建归档页面

hugo new archives/index.md
🖼️ 图片管理
方法 1：静态图片
static/
├── images/
│ ├── avatars/
│ ├── covers/
│ └── posts/
│ └── 2025/
│ └── my-post/
│ ├── image1.jpg
│ └── image2.png
在文章中引用：
markdown![图片描述](/images/posts/2025/my-post/image1.jpg)
方法 2：页面包资源（推荐）
content/posts/
└── my-post/
├── index.md # 文章内容
├── cover.jpg # 封面
└── images/ # 文章图片
├── demo1.png
└── demo2.jpg
在文章中引用：
markdown![图片描述](images/demo1.png)
⚙️ 常用配置
在 hugo.toml 中添加菜单：
toml[menu]
[[menu.main]]
name = "首页"
url = "/"
weight = 10

[[menu.main]]
name = "文章"
url = "/posts/"
weight = 20

[[menu.main]]
name = "标签"
url = "/tags/"
weight = 30

[[menu.main]]
name = "分类"
url = "/categories/"
weight = 40

[[menu.main]]
name = "关于"
url = "/about/"
weight = 50
🚀 日常工作流

1. 写文章流程：
   bash# 1. 创建新文章
   hugo new posts/my-new-post.md

2. 编辑文章内容

3. 本地预览 hugo server -D

4. 确认无误后，设置 draft: false

5. 提交到 Git

git add .
git commit -m "Add new post: my-new-post"
git push

## 只预览发布的文章

hugo server

## 绑定到所有网络接口（局域网访问）

hugo server -D --bind 0.0.0.0 3. 构建静态文件：
bash# 构建到 public 目录
hugo

## 清理并构建

hugo --cleanDestinationDir
这些是最常用的功能，你先试试创建几篇文章熟悉一下！有什么具体问题随时问我。
