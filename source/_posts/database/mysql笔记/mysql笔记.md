---
title: MySQL笔记
date: 2021-05-16 19:31:21
tags: MySQL
cover: /posts_cover_img/database/mysql_logo.png
categories: MySQL笔记
---

## 一、mysql安装

> 推荐使用Docker安装mysql
>
> [https://registry.hub.docker.com/_/mysql](https://registry.hub.docker.com/_/mysql)

### 1、拉取mysql镜像

```shell
# 拉取最新的mysql镜像
docker pull mysql
```

### 2、创建mysql容器

#### 2.1 设置国内时区

> 时区参考：[https://blog.csdn.net/w8y56f/article/details/115445442](https://blog.csdn.net/w8y56f/article/details/115445442)

> 因为mysql镜像里的时区默认是UTC时区，这样和国内就差了8个小时，所以为了后面创建了mysql容器能够获取时间和国内一致，所以需要提前修改时区
>
> 基于当前的mysql镜像创建一个支持国内时区的镜像，然后基于创建的镜像启动容器，就支持国内时区了
>
> 

##### 2.1.1 新镜像的DockerFile

> 下面镜像的DockerFile用来创建支持国内的时间的镜像，需要提前拉取`mysql:latest`镜像

```bash
# Desc: 用来构建自定义的Docker镜像
# Author: 刘阳
# Time: 2021-04-21 17:59:00

# 基础镜像，来自官方的centos7版本，默认的centos镜像是centos8版本
mysqlFROM mysql:latest

# 基础描述信息
LABEL version="V1.0"
LABEL author="刘阳"
LABEL description="基础镜像来自官方mysql，设置时区为中国，然后编码方式为utf8"

# 设置工作目录
WORKDIR /root/

# 指定执行命令的用户
USER root

# 时区变量
ENV TZ="Asia/Shanghai"
```

##### 2.1.2 用DockerFile创建镜像

```bash
# 步骤一：创建一个目录，将上面的DockerFile内容复制进去，并且文件命名为Dockerfile
# 步骤二：当上面存放Dockerfile的文件目录下执行下面命令，后面的.(点)不能忘了，因为是用来关系上下文的
docker build -t mysqlzh:v1.0 .
# 构建完成后查看镜像就有了支持国内时区的mysql镜像
docker image ls -a
```

![image-20220711133734301.png](mysql%E7%AC%94%E8%AE%B0/image-20220711133734301.png)

> 到这里镜像创建完毕，就可以使用这个镜像开始创建`mysql`容器了

#### 2.2 创建Mysql容器

> 使用新的`mysqlzh`镜像来创建`mysql`容器
>
> 字符序解释看这里：[https://www.cnblogs.com/lxyit/p/9359325.html](https://www.cnblogs.com/lxyit/p/9359325.html)

```shell
docker run  -dit -u root --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci mysqlzh:v1.0 
# --name mysql 表示创建的容器名字是mysql
# -u root 表示容器的用户是root
# -p 3306:3306 表示将容器的3306映射到宿主机的3306端口
# MYSQL_ROOT_PASSWORD后面跟的是数据库用户root的登录密码
# --character-set-server=utf8mb4 表示设置mysql字符集支持是utf-8编码，可以支持中文
# --collation-server=utf8mb4_unicode_ci 表示字符序（collation），定义了字符的比较规则
```

![image-20220711134149094.png](mysql%E7%AC%94%E8%AE%B0/image-20220711134149094.png)

> 从上图的Image的ID可以看出和使用DockerFile创建的镜像是同一个

### 3、命令行连接mysql

#### 3.1 登录mysql

> 可以使用`mycli`这个连接工具，安装以来python环境

```shell
# 输入创建mysql容器时设置的root密码，就可以登录mysql中了
mycli -h127.0.0.1 -uroot -p
```

#### 3.2 查看时区

```bash
show variables like '%time_zone%'
```

![image-20220711141248016](mysql%E7%AC%94%E8%AE%B0/image-20220711141248016.png)

> 可以看到时区：
>
> - system_time_zone是CST
>     - CST表示China Standard Time UT+8:00 中国标准时间
> - time_zone 的值是SYSTEM
>     - 表示跟system_time_zone取值一样，安装MySQL后默认就是SYSTEM，就是新镜像里设置的Asia/Shanghai时间

#### 3.3 查看字符集

```bash
show variables like '%character%';
```

![image-20220711140015891.png](mysql%E7%AC%94%E8%AE%B0/image-20220711140015891.png)

> 可以看到数据库都是utf8编码

## 二、mysql语法

### 1、
