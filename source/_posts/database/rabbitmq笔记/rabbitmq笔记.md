---
title: RabbitMQ笔记
date: 2021-05-16 19:31:21
tags: RabbitMQ
cover: /posts_cover_img/database/rabbitmq_logo.png
categories: RabbitMQ笔记
---



## 一、安装rabbitmq

### 1、docker安装

> 推荐使用docker安装rabbitmq

```shell
There is a second set of tags provided with the management plugin installed and enabled by default, which is available on the standard management port of 15672, with the default username and password of guest / guest:

$ docker run -d --hostname my-rabbit --name some-rabbit rabbitmq:3-management
You can access it by visiting http://container-ip:15672 in a browser or, if you need access outside the host, on port 8080:

$ docker run -d --hostname my-rabbit --name some-rabbit -p 8080:15672 rabbitmq:3-management
You can then go to http://localhost:8080 or http://host-ip:8080 in a browser.
```

```shell
docker run -itd --name rabbitmqly -p 8080:15672 rabbitmq:3-management
```

### 2、启动测试

> 打开页面:http://localhost:8080
>
> 用户名和密码都是`guest `

![image-20220216160533303](rabbitmq%E7%AC%94%E8%AE%B0/image-20220216160533303.png)
