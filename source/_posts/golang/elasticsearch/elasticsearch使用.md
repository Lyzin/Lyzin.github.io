---
title: elasticsearch使用
date: 2024-09-11 13:49:03
updated: 2024-09-11 13:49:03
tags: elasticsearch
cover: /posts_cover_img/golang/elastic.png
categories: elasticsearch
---

## 一、安装elasticsearch

### 1、docker安装

#### 1.1 拉取镜像

> 官方安装教程：https://www.elastic.co/guide/en/elasticsearch/reference/7.5/docker.html
>
> 拉取镜像
>
> https://hub.docker.com/_/elasticsearch/tags

```bash
docker pull elasticsearch:7.17.24
```

#### 1.2 创建单节点的容器

> https://www.elastic.co/guide/en/elasticsearch/reference/7.5/docker.html
>
> 启动容器
>
> elasticsearch容器内数据存储目录：/usr/share/elasticsearch/data

```bash
# elasticsearch
# /home/ly/docker_volumn/elasticsearch/data:/usr/share/elasticsearch/data 数据映射
docker run -itd -p 9200:9200 -p 9300:9300 -v /home/ly/docker_volumn/elasticsearch/data:/usr/share/elasticsearch/data -m 512m -e "discovery.type=single-node" elasticsearch:7.17.24
```

### 2、kibana

> https://hub.docker.com/_/kibana

```bash
docker pull kibana:7.17.24
```

> 启动容器
>
> kibana配置文件目录：/usr/share/kibana/config

```bash
# kibana
# -v /home/ly/docker_volumn/kibana/config:/usr/share/kibana/config 配置文件映射
docker run -itd --name kibana -v /home/ly/docker_volumn/kibana/config:/usr/share/kibana/config -m 256m -p 5601:5601 kibana:7.17.24
```
