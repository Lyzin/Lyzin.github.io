---
title: kafka使用
date: 2024-09-17 09:48:14
updated: 2024-09-17 09:48:14
tags: kafka
cover: /posts_cover_img/golang/kafka_logo.png
categories: kafka
---

## 一、kafka安装

### 1、docker安装

#### 1.1 拉取镜像

> https://hub.docker.com/r/bitnami/kafka

### 2、创建容器

#### 1.1 docker run模式

> 下面命令是单机模式的kafka
>
> 参考：https://blog.csdn.net/u010088278/article/details/127824196
>
> 比如kafka部署在A机器，远程IP是192.168.0.120:9094，那本地代码想连接，就必须按如下配置
>
> - KAFKA_CFG_ADVERTISED_LISTENERS中配置EXTERNAL://192.168.0.120:9094 表示外部链接的IP，因为是容器部署，所以IP是外部宿主机的IP

```bash
docker run -d \
  --name kafka \
  --restart always \
  --hostname kafka-server \
  --memory 1g \
  --cpus 1.0 \
  -e KAFKA_ENABLE_KRAFT=yes \
  -e KAFKA_CFG_NODE_ID=1 \
  -e KAFKA_CFG_PROCESS_ROLES=controller,broker \
  -e KAFKA_CFG_LISTENERS=PLAINTEXT://:9092,CONTROLLER://:9093,EXTERNAL://:9094 \
  -e KAFKA_CFG_ADVERTISED_LISTENERS=PLAINTEXT://kafka-server:9092,EXTERNAL://192.168.0.120:9094 \
  -e KAFKA_CFG_LISTENER_SECURITY_PROTOCOL_MAP=CONTROLLER:PLAINTEXT,EXTERNAL:PLAINTEXT,PLAINTEXT:PLAINTEXT \
  -e KAFKA_CFG_CONTROLLER_QUORUM_VOTERS=1@kafka-server:9093 \
  -e KAFKA_CFG_CONTROLLER_LISTENER_NAMES=CONTROLLER \
  -p 9092:9092 \
  -p 9094:9094 \
  bitnami/kafka:3.3.2
```

```bash
  -e KAFKA_ENABLE_KRAFT=yes  开启KRaft
  -e KAFKA_CFG_NODE_ID=1 \  单机，所以节点ID为1
  -e KAFKA_CFG_PROCESS_ROLES=controller,broker \  kafka与外界交互只用broker
  -e KAFKA_CFG_LISTENERS=PLAINTEXT://:9092,CONTROLLER://:9093,EXTERNAL://:9094 \  监听地址，注意EXTERNAL://:9094是给外部链接的端口
  -e KAFKA_CFG_ADVERTISED_LISTENERS=PLAINTEXT://kafka-server:9092,EXTERNAL://192.168.0.120:9094 \ 注意EXTERNAL://:192.168.0.120:9094 是给外部链接的地址和端口
  -e KAFKA_CFG_LISTENER_SECURITY_PROTOCOL_MAP=CONTROLLER:PLAINTEXT,EXTERNAL:PLAINTEXT,PLAINTEXT:PLAINTEXT \
  -e KAFKA_CFG_CONTROLLER_QUORUM_VOTERS=1@kafka-server:9093 \
  -e KAFKA_CFG_CONTROLLER_LISTENER_NAMES=CONTROLLER \
  -p 9092:9092 \
  -p 9094:9094 \
```

#### 1.2 docker-compose模式

> 下面命令是单机模式的kafka

```bash
kafka:
    image: bitnami/kafka:3.3.2
    container_name: kafka
    restart: always
    hostname: kafka-server
    mem_limit: 1g
    cpus: '1.0'
    environment:
      - KAFKA_ENABLE_KRAFT=yes
      - KAFKA_CFG_NODE_ID=1
      - KAFKA_CFG_PROCESS_ROLES=controller,broker
      - KAFKA_CFG_LISTENERS=PLAINTEXT://:9092,CONTROLLER://:9093,EXTERNAL://:9094
      - KAFKA_CFG_ADVERTISED_LISTENERS=PLAINTEXT://kafka-server:9092,EXTERNAL://192.168.0.120:9094
      - KAFKA_CFG_LISTENER_SECURITY_PROTOCOL_MAP=CONTROLLER:PLAINTEXT,EXTERNAL:PLAINTEXT,PLAINTEXT:PLAINTEXT
      - KAFKA_CFG_CONTROLLER_QUORUM_VOTERS=1@kafka-server:9093
      - KAFKA_CFG_CONTROLLER_LISTENER_NAMES=CONTROLLER
    ports:
      - "9092:9092"
      - "9094:9094"
    networks:
      - dev-unit-network
```



## 二、go使用kafka

> https://github.com/segmentio/kafka-go

### 1、
