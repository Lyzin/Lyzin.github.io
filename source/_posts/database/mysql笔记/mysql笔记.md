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
>
> 黑马程序员
>
> [https://www.bilibili.com/video/BV1Kr4y1i7ru?spm_id_from=333.999.0.0&vd_source=501c3f3a75e1512aa5b62c6a10d1550c](https://www.bilibili.com/video/BV1Kr4y1i7ru?spm_id_from=333.999.0.0&vd_source=501c3f3a75e1512aa5b62c6a10d1550c)

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
FROM mysql:latest

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
docker run  -dit -u root --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456  mysqlzh:v1.0 --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci 
# --name mysql 表示创建的容器名字是mysql
# -u root 表示容器的用户是root
# -p 3306:3306 表示将容器的3306映射到宿主机的3306端口
# MYSQL_ROOT_PASSWORD后面跟的是数据库用户root的登录密码

# 下面两个参数必须放到镜像名后面，如果创建容器时出现3306端口占用，需要先关掉端口被占用的程序，再来创建容器
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

## 二、mysql基础

> 老男孩 老郭
>
> https://www.bilibili.com/video/BV1bJ411k7ET?p=27&vd_source=501c3f3a75e1512aa5b62c6a10d1550c

> 黑马程序员：
>
> https://www.bilibili.com/video/BV1vi4y137PN/?spm_id_from=333.999.0.0&vd_source=501c3f3a75e1512aa5b62c6a10d1550c
>
> https://www.bilibili.com/video/BV1M541147Cn?p=9&vd_source=501c3f3a75e1512aa5b62c6a10d1550c
>
> https://www.bilibili.com/video/BV1Kr4y1i7ru?p=4&vd_source=501c3f3a75e1512aa5b62c6a10d1550c
>
> 数据库调优
>
> https://www.bilibili.com/video/BV1zJ411M7TB?p=4&vd_source=501c3f3a75e1512aa5b62c6a10d1550c

### 1、数据库操作

#### 1.1 创建数据库

> - default character set utf8：
>     - 数据库字符集，设置数据库的默认编码为utf8，utf8中间不要"-"
> - default collate utf8_general_ci:
>     - 数据库校对规则，ci是case insensitive的缩写，意思是大小写不敏感；
>     - 相对的是cs，即case sensitive，大小写敏感；

```
MySQL root@localhost:(none)> create database goods default utf8 collate utf8_general_ci;
Query OK, 1 row affected
Time: 0.062s
```

#### 1.2 查看数据库

> 查看数据库：show databases;

```mysql
MySQL root@localhost:(none)> show databases;
+--------------------+
| Database           |
+--------------------+   |
| information_schema |
```

#### 1.2 进入数据库

> 使用数据库：use 数据库名称

```mysql
MySQL root@localhost:(none)> use goods;
You are now connected to database "goods" as user "root"
Time: 0.007s
```

#### 1.4 删除数据库

> 删除数据库：drop database 数据库名称

```mysql
MySQL root@localhost:goods> drop database goods;
You're about to run a destructive command.
Do you want to proceed? (y/n): y
Your call!
Query OK, 0 rows affected
Time: 0.124s
```

### 2、数据表的操作

#### 2.1 创建表

> 创建表需要使用： `create table 表名`语句

```mysql
create table 表名(
	列名 类型,
    列名 类型,
    列名 类型
) default charset=utf8;
```

##### 2.1.1 建表语句注释

> 在建表语句中，两个`-`表示注释

##### 2.1.2 not null

```mysql
-- mysql中 not null 表示不允许为空
create table m1(
	name not null -- 表示name字段不可以为空
)default charset=utf8;
```

##### 2.1.1 null

```mysql
-- mysql中null表示允许为空
create table m1(
	name null -- 表示name字段可以为空
)default charset=utf8;
```

##### 2.1.4 default

> 插入数据时，如果没有给该字段设置值，该字段的值就是设置的默认值

```mysql
create table m1(
	name default sam -- 表示name字段默认值是sam
)default charset=utf8;
```

##### 2.1.5 primary key

> 主键的意思，不允许为空，不可以重复

```mysql
create table m1(
	id int primary key -- id是主键
    name default sam -- 表示name字段默认值是sam
)default charset=utf8;
```

##### 2.1.6 auto_incremnet

> 表示该字段的值会随着插入数据自己进行自增

```mysql
create table m1(
	id int primary key auto_increment -- id是主键且自增
    name default sam -- 表示name字段默认值是sam
)default charset=utf8; 
```

#### 2.2 查看表

> 查看表需要经过两步
>
> - 第一步：进入数据库 use 数据库名称
> - 第二步：查看数据库 show tables

```mysql
use 数据库名称;
show tables;
```

#### 2.3 删除表

##### 2.3.1 drop

```mysql
-- 会将表和表里的数据全部删除
drop table 表名
```

##### 2.3.2 delete

```mysql
-- 会将表里的数据全部删除，表仍然留着
delete from 表名
```

##### 2.3.3 truncate

> 速度很快，不可回滚

```mysql
-- 会将表里的数据全部删除，表仍然留着
truncate table 表名
```

#### 2.4 修改表

##### 2.4.1 添加列

```mysql
-- 给表增加字段
alter table 表名 add 列名 类型;

-- 给表增加字段并设置默认值
alter table 表名 add 列名 类型 default 默认值;

-- 给表增加字段并设置默认值，且该列不能为空
alter table 表名 add 列名 类型 not null default 默认值;
```

##### 2.4.2 删除列

```mysql
alter table 表名 drop column 列名;
```

##### 2.4.3 修改列的类型

```mysql
alter table 表名 modify column 列名 类型
```

##### 2.4.4 修改列的类型和名称

```mysql
alter table 表名 change 原列名 新列名 新类型;

-- 下面语句时将tb1的原name列修改为username，并且给username设置了类型为varchar(32)
alter table tb1 change name username varchar(32);
```

##### 2.4.5 修改列的默认值

```mysql
alter table 表名 alter 列名 set default 新默认值;
```

##### 2.4.6 删除列的默认值

```mysql
alter table 表名 alter 列名 drop default;
```

#### 2.5 表的字段类型

> 下面列出来的是经常用到的建表语句字段

##### 2.5.1 int

> int表示整型
>
> - int 表示有符号，取值范围`-2147483648 ~ 2147483648`
>     - 有符号表示可以为`负值`
> - int unsigned 表示无符号，取值范围`0 ~ 4294967295`
>     - 无符号表示必须是正整数，从0开始计数
> - int(5)zerofill 仅用于显示，当不满足5位时，给左边补0
>     - 比如02不满足五位，就会显示为：00002
> - 需要注意，当给字段设置类型后，超过了类型的范围，就会报`out of range value for column 列名`的错误

```mysql
create table m1(
	id int primary key  -- 表示id是一个int整数
    name default sam
)default charset=utf8;
```

##### 2.5.2 tinyint

> 用来表示整型，不能范围比较小
>
> - tinyint 表示有符号，取值范围`-128 ~ 127`
> - tinyint unsigned 表示无符号，取值范围`0 ~ 255`
> - tinyint(5)zerofill 和int使用一样

##### 2.5.3 bigint

> 用来表示整型，范围更大
>
> - bigint 表示有符号，取值范围`-922337203685477808 ~ 922337203685477808`
> - bigint unsigned 表示无符号，取值范围`0 ~ 18446744073709551615`
> - bigint(5)zerofill 和int使用一样

##### 2.5.4 decimal

> 用来表示小数，准确的小数，decimal需要写两个值，第一个是数字总个数(总个数=整数部分数字个数+小数部分数字个数)，第二个是小数点后的个数
>
> - 第一个数最大值是65
>     - 如果有符号，不算进去
> - 第二个数最大值时30
>
> - 如果插入数据时小数点的位数大于列的字段设置的值，那么对进行四舍五入

```mysql
create table m1(
	id int primary key  -- 表示id是一个int整数
    price decimal(4, 2) -- 4表示price最多接收的数字个数，2表示小数点后的位数
)default charset=utf8;
```

##### 2.5.6 char

> - 定长字符串，`char(m)`表示字符串的长度，最多可以容纳`255`个字符
>     - 字符可以是一个英文字母，可以是一个汉字，只要满足设置的`m`长度，都可以被存进去
> - 定长理解
>     - 存储固定字符长度的内容
>     - 即使内容长度小于m，也会占用`m`个长度，不够会用空格来补齐，但是查询时，会将空白自动去除
>     - 如果超过了`m`的长度，就会报错

##### 2.5.7 varchar

> - 可变长字符串，`varchar(m)`表示字符串的长度，最多可以容纳`65535`个字符
> - 变长理解
>     - 插入的值长度小于m，会按照真实数据长度存储
>     - 如果超过了`m`设置的值，就会报错
> - 这里可以借助`length`函数查询字段所占用的字符长度

##### 2.5.8 text

> 用来保存变长的大字符串
>
> 用来存储文章、新闻才会用到

##### 2.5.9 datetime

> 用来表示时间日期，存储和取出的时间不做任何转换
>
> 范围：1000-01-01 00:00:00 到 9999-12-31 23:59:59

```mysql
表示格式：YYYY-MM-DD HH:MM:SS
比如： 2022-01-02 10:00:22
```

```mysql
MySQL root@localhost:goods> create table user(
                         ->  id int not null auto_increment primary key,
                         ->  create_time datetime,
                         ->  update_time timestamp) default charset=utf8;
```

##### 2.5.10 timestamp

> timestamp会把客户端时间插入的时间从当前时区转换为UTC时间进行存储，查询时又会将时间转换为客户端当前时区进行返回
>
> - 范围：1970-01-01 00:00:00 到 2037年

```mysql
MySQL root@localhost:goods> create table user(
                         ->  id int not null auto_increment primary key,
                         ->  create_time datetime,
                         ->  update_time timestamp) default charset=utf8;
```

![image-20220807214513402](mysql%E7%AC%94%E8%AE%B0/image-20220807214513402.png)

> 从上面图中查看：
>
> - create_time是datetime类型，update_time是timestamp类型

##### 2.5.11 current_timestamp

> 官网解释：[current_timestamp](https://dev.mysql.com/doc/refman/5.7/en/timestamp-initialization.html)

> 下面来自官网的翻译
>
> - TIMESTAMP或DATETIME列的定义可以为默认值和自动更新值都指定当前的时间戳，也可以为其中一个而不是另一个，或者两者都不指定。不同的列可以有不同的自动属性组合。下面的规则描述了这些可能性。
> - 在DEFAULT CURRENT_TIMESTAMP和ON UPDATE CURRENT_TIMESTAMP这两种情况下，该列的默认值是当前的时间戳，并自动更新为当前的时间戳。

```mysql
CREATE TABLE t1 (
  ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  dt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
```

> - timestamp
>     - 表示该字段在插入和更新时都不会自动设置为当前时间。
> - timestamp default current_timestamp
>     - 字段插入时如果没有时间则自动设置为当前时间，更新没有变化。
> - timestamp on update current_timestamp
>     - 字段插入不会自动设置，字段更新时没有指定时间则自动设置为当前时间。
> - default current_timestamp on update current_timestamp (常用)
>     - 插入和修改字段时如果没有指定时间则会自动设置为当前时间

> current_timestamp使用示例
>
> - create_time默认是当前时间
> - update_time默认也是当前时间，但是当数据表数据有修改时，该字段会更新为修改的时间

```mysql
DROP TABLE IF EXISTS `user_address`;
CREATE TABLE `user_address` (
    `id` int not null auto_increment comment '主键Id',
    `user_id` int not null comment '用户uid',
    `name` varchar(32) not null comment '用户名',
    `city` varchar(64) not null comment '城市',
    `create_time` timestamp not null default current_timestamp comment '创建时间',
    `update_time` timestamp not null default current_timestamp on update current_timestamp comment '更新时间',
    primary key(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```

### 3 表数据的增删改查

#### 3.1 新增数据

```mysql
-- 插入一条数据
insert into 表名(列名,列名,列名) values(对应列的值,对应列的值,对应列的值);

-- 插入多条数据
insert into 表名(列名,列名,列名) values(对应列的值,对应列的值,对应列的值),(对应列的值,对应列的值,对应列的值);
```

#### 3.2 删除数据

```mysql
-- 清空所有表数据
delete from 表名

-- 按条件删除数据
delete from 表名 where 条件
```

#### 3.3 更新数据

```mysql
-- 将表中该列全部修改为该值
update 表名 set 列名=值;

-- 修改多个列的值
update 表名 set 列名=值,列名=值;

-- 按照条件进行更新
update 表名 set 列名=值 where 条件;
```

#### 3.4 查询数据

```mysql
-- 查看表里所有数据
select * from 表名;

-- 查询符合条件的所有数据
select * from 表名 where 条件;

-- 查询符合条件的列数据
select 列名 from 表名 where 条件;
```

### 4、必会语句







### 5、表关系

> 表关系有下面三种
>
> - 单表关系
> - 一对多关系
> - 多对多关系

#### 5.1 单表关系

> 单独一张表就可以存储数据，不需要其他表的数据

#### 5.2 一对多表关系

> `一对多`需要两张表存储数据，并且两张表有`一对多`或`多对一`关系

##### 5.2.1 创建表时添加外键约束

> 下面的depart表的id字段关联了employee表的depart_id字段，且depart表的id字段关联了employee表的多条数据
>
> - 比如depart的id等于1，关联了employee表的`sam`、`jam`两条数据，这就形成了一对多的表关系

```sql
-- 部门表depart字段
id  int
depart_name varchar(32)

-- 员工表employee字段
id  int
name varchar(32)
age int
depart_id
```

![image-20220809081143388](mysql%E7%AC%94%E8%AE%B0/image-20220809081143388.png)



> - 在一对多关系中，会给一对多关系中`多`的表添加一个**`外键约束`**，保证某一列的值必须是其它表中的特定已存在的值
>
> - 如果在给`关系【多】`的表中插入数据时，如果关联字段插入时，在`关系【一】`的表里不存在时，就会报错

```sql
-- 下面是depart表
create table depart(
	id int not null auto_increment primary key,
    depart_name varchar(15) not null
)default charset=utf8;

-- 下面是employee表
create table employee(
	id int not null auto_increment primary key,
    name varchar(15) not null,
    age int not null,
    depart_id int not null,
    constraint fk_employee_depart foreign key (depart_id) references depart(id) -- 创建外键约束
)default charset=utf8;
```

```sql
-- 创建外键约束语法
constraint fk_employee_depart foreign key (depart_id) references depart(id)

-- constraint 约束
-- fk_employee_depart 表示外键的名字，是"foreignkey_当前表名_需要被关联表名”格式
-- foreign key 表示外键
-- (depart_id) 表示当前表需要被外键约束的字段
-- references depart(id) 表示需要被关联的表和字段，格式：需要被关联表名(约束字段)
```

##### 5.2.2 表存在添加外键约束

> 当表存在时，想要添加外键约束

```sql
alter table employee add constraint fk_employee_depart foreign key (depart_id) references depart(id)
```

##### 5.2.3 删除添加的外键约束

```sql
alter table employee drop foreign key fk_employee_depart;

-- fk_employee_depart 是外键名字
```

##### 5.2.4 外键约束示例

> 查看depart表和employee表语句

```sql
-- depart表
CREATE TABLE `depart` (
  `id` int NOT NULL AUTO_INCREMENT,
  `depart_name` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8

-- employee表
CREATE TABLE `employee` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL,
  `age` int NOT NULL,
  `depart_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_employee_depart` (`depart_id`),
  CONSTRAINT `fk_employee_depart` FOREIGN KEY (`depart_id`) REFERENCES `depart` (`id`) -- 添加了外键约束
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8
```

![image-20220809084323004](mysql%E7%AC%94%E8%AE%B0/image-20220809084323004.png)



> 当depart表中存在id为1的数据时，给employee表插入数据，并且depart_id为1

```sql
-- 先给depart表插入数据，并且id为1，因为是第一次插入数据，id默认从1开始
insert into depart(depart_name) values("研发");

-- 再给employee表插入数据，指定depart_id为1
insert into employee(name, age, depart_id) values("sam", 21, 1);

-- 此时depart表和employee表插入数据都没问题
```

![image-20220809084627766](mysql%E7%AC%94%E8%AE%B0/image-20220809084627766.png)

> 但给employee表插入数据时，指定depart_id为2，但是id为2的数据再depart表中不存在，就会提示插入数据错误

```sql
insert into employee(name, age, depart_id) values("jam", 22, 2);
```

> - 会提示报错：(1452, 'Cannot add or update a child row: a foreign key constraint fails (`lyuse`.`employee`, CONSTRAINT `fk_employee_depart` FOREIGN KEY (`depart_id`) REFERENCES `depart` (`id`))')
> - 翻译：(1452, '无法添加或更新子行：外键约束失败 (`lyuse`.`employee`, CONSTRAINT `fk_employee_depart` FOREIGN KEY (`depart_id`) REFERENCES `depart` (`id`)))

![image-20220809084820490](mysql%E7%AC%94%E8%AE%B0/image-20220809084820490.png)

#### 5.3 多对多表关系

> `多对多`需要三张表来存储数据，两张单表+关系表，创造出两个单表之间多对多关系

##### 5.3.1 创建表时添加外键约束

> 下面的表
>
> - course表是课程表，单表
> - student表是学生信息表，单标
> - class表是学生选课表，是关联表
>     - 关联了学生id和课程id
>     - 其中既有学生id关联了多个课程id的数据
>     - 也有多个课程id关联了多个学生id的数据
>     - 这就形成了多对多的表关系

![image-20220809085611898](mysql%E7%AC%94%E8%AE%B0/image-20220809085611898.png)

```sql
-- course表
CREATE TABLE `course` (
  `id` int NOT NULL AUTO_INCREMENT,
  `course_name` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8

-- stuudent表
CREATE TABLE `student` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(15) NOT NULL,
  `age` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8


-- class表
CREATE TABLE `class` (
  `id` int NOT NULL AUTO_INCREMENT,
  `student_id` int NOT NULL,
  `course_id` int NOT NULL,
  PRIMARY KEY (`id`),
  constraint fk_class_student foreign key (student_id) references student(id), -- 添加student表外键约束
  constraint fk_class_course foreign key (couser_id) references couser(id),  -- 添加course表外键约束
) ENGINE=InnoDB DEFAULT CHARSET=utf8
```

##### 5.3.2 表存在添加外键约束

```sql
alter table class add constraint fk_class_student foreign key (student_id) references student(id), -- 添加student表外键约束
alter table class add constraint fk_class_course foreign key (couser_id) references couser(id),  -- 添加course表外键约束
```

##### 5.3.3 删除添加的外键约束

```sql
alter table class drop foreign key fk_class_student;
alter table class drop foreign key fk_class_course;
```

##### 5.3.4 外键约束示例

> 

