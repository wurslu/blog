+++
date = '2025-06-21T09:20:47+08:00'
draft = true
title = '连接云服务器'
tags = ['云服务器','']
+++

## 前置条件

1. 拥有一台云服务器，在厂商平台处查看 IP 地址，用户名以及密码。
2. 拥有一台网络良好的电脑。

## 开始

1. 打开你的命令行工具。如果你是 Windows，比如 PowerShell；在 Macos 上，打开你的 终端.app。![终端example](https://urlu-blog.s3.bitiful.net/tech%2Ftermial-example.webp)
2. 使用 ssh 工具，连接你的云服务器。常用命令格式：`ssh -p 端口号，默认22 用户名@服务器ip`，例如 `ssh -p 22 root@1.1.1.1`。
3. 如果你的 ssh 端口是 22，也可以省略 `-p`，那么就是 `ssh root@1.1.1.1`。
4. `Enter`后稍等，输入密码，连接成功！现在，你在终端输入的所有命令将在你的云服务器环境下执行。你可以尝试一些简单的命令。例如 `ls -la`。
5. 如果你想关闭连接，你将使用 `exit`。
