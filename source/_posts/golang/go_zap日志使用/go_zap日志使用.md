---
title: Golang Zap日志库
date: 2022-05-25 08:43:00
updated: 2022-05-25 08:43:00
tags:
- Golang
- Zap
cover: /posts_cover_img/golang/go_zap.png
categories: Golang Zap日志库
---

## 一、Zap介绍与安装

### 1、zap介绍

> zap是uber公司开源的一款日志库，主要使用`Golang`语言编写，目前在[github](https://github.com/uber-go/zap)上已经有15k+以上的星星，具有速度快、支持结构化、分级的特点

### 2、zap安装

> 注意：zap只支持Go的两个最新的小版本

```bash
go get -u go.uber.org/zap
```

## 二、Zap使用

### 1、Zap日志器

