---
title: mongoDB使用
date: 2023-09-27 11:09:36
updated: 2023-09-27 11:09:36
tags: 
- MongoDB
- mongoDB
cover: /posts_cover_img/database/MongoDB.svg
categories: MongoDB
---

## 一、MongoDB介绍

### 1、什么是MongoDB

> 

### 2、Docker创建MongoDB

> docker镜像地址：https://hub.docker.com/_/mongo
>
> - 这个镜像中有如何创建容器、如何设置MongoDB容器用户和密码、如何将MongoDB容器数据落盘有详细记录

#### 2.1 拉取MongoDB镜像

```bash
docker pull mongo
```

![image-20230927111413287](mongoDB使用/image-20230927111413287.png)

#### 2.2 创建mongoDB容器

```bash
docker run -itd --name mongo -v /my/own/datadir:/data/db -p 27017:27017 -e MONGO_INITDB_ROOT_USERNAME=mongoadmin -e MONGO_INITDB_ROOT_PASSWORD=mongo123 mongo
```

```json
我有如下的json，根children节点的字段为list，我想提取data.text文本，如何提取？
"""{"children":[{"data":{"text":"PRD","id":1695784786243},"children":[{"data":{"text":"https://confluence.zhenguanyu.com/pages/viewpage.action?pageId=510461312","id":1695784786245}},{"data":{"text":"需求背景","id":1695784786248},"children":[{"data":{"text":"Q1-Q2端内召回/新客直播的曝光触达率和成单量有较明显相较于过往峰值10%，有明显降低（过往的高点虽然不持续，但是也意味着这里有优化空间）","id":1695784786250}}]},{"data":{"text":"斑马现有直播卡片入口","id":1695784786253},"children":[{"data":{"text":"直播间状态","id":1695784786256}},{"data":{"text":"正在观看人数","id":1695784786258}}]}]}]}"""
```

```
有如下的json，我想提取的格式是这个样的该如何去做
1、PRD-https://confluence.zhenguanyu.com/pages/viewpage.action?pageId=510461312
2、PRD-需求背景-Q1-Q2端内召回/新客直播的曝光触达率和成单量有较明显相较于过往峰值10%，有明显降低（过往的高点虽然不持续，但是也意味着这里有优化空间）
3、PRD-斑马现有直播卡片入口-["直播间状态","正在观看人数"]

"""{"children":[{"data":{"text":"PRD","id":1695784786243},"children":[{"data":{"text":"https://confluence.zhenguanyu.com/pages/viewpage.action?pageId=510461312","id":1695784786245}},{"data":{"text":"需求背景","id":1695784786248},"children":[{"data":{"text":"Q1-Q2端内召回/新客直播的曝光触达率和成单量有较明显相较于过往峰值10%，有明显降低（过往的高点虽然不持续，但是也意味着这里有优化空间）","id":1695784786250}}]},{"data":{"text":"斑马现有直播卡片入口","id":1695784786253},"children":[{"data":{"text":"直播间状态","id":1695784786256}},{"data":{"text":"正在观看人数","id":1695784786258}}]}]}]}"""
```

