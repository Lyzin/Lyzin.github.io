---
title: Go Zap日志库
date: 2022-05-25 08:43:00
updated: 2022-05-25 08:43:00
tags:
- Go
- Zap
cover: /posts_cover_img/golang/go_zap.png
categories: Go Zap日志库
---

## 一、Zap介绍与安装

### 1、zap介绍

> zap是uber公司开源的一款日志库，主要使用`Golang`语言编写，目前在[github](https://github.com/uber-go/zap)上已经有15k+以上的星星，具有速度快、支持结构化、分级的特点

> https://www.liwenzhou.com/posts/Go/zap/

### 2、zap安装

> 注意：zap只支持Go当前的两个最新的小版本
>
> 该笔记使用时是`Go1.17版本`

```bash
go get -u go.uber.org/zap
```

## 二、Zap使用

### 1、zap特点

> [Zap](https://github.com/uber-go/zap)是非常快的、结构化的，分日志级别的Go日志库。
>
> - 它同时提供了结构化日志记录和printf风格的日志记录
> - 它非常的快

### 2、zap性能

> 来自于github的zap官方库数据
>
> 对于在热路径中记录的应用程序来说，基于反射的序列化和字符串格式化是非常昂贵的--它们是CPU密集型的，并且会进行许多小的分配。换句话说，使用编码/json和fmt.Fprintf来记录大量的interface{}s会使你的应用程序变慢。
>
> Zap采取了一种不同的方法。它包括一个无反射、零分配的JSON编码器，基本的Logger努力避免序列化开销和尽可能的分配。通过在这个基础上构建高级的SugaredLogger，Zap让用户选择何时需要计算每一次分配，何时喜欢更熟悉的、松散类型的API。
>
> 正如它自己的基准测试套件所衡量的那样，zap不仅比同类的结构化日志包更有性能，而且还比标准库更快。像所有的基准测试一样，请谨慎对待这些测试。

![image-20220612213749516](go_zap%E6%97%A5%E5%BF%97%E4%BD%BF%E7%94%A8/image-20220612213749516.png)

![image-20220612213815355](go_zap%E6%97%A5%E5%BF%97%E4%BD%BF%E7%94%A8/image-20220612213815355.png)

### 3、zap日志器分类

> Zap提供了两种类型的日志记录器—`Sugared Logger`和`Logger`。
>
> 在性能很好但不是很关键的上下文中，使用`SugaredLogger`。它比其他结构化日志记录包快4-10倍，并且支持结构化和printf风格的日志记录。
>
> 在每一微秒和每一次内存分配都很重要的上下文中，使用`Logger`。它甚至比`SugaredLogger`更快，内存分配次数也更少，但它只支持强类型的结构化日志记录。

#### 3.1 Logger

> 注意事项：
>
> - 通过调用`zap.NewProduction()`/`zap.NewDevelopment()`或者`zap.Example()`创建一个Logger。
> - 上面的每一个函数都将创建一个logger。唯一的区别在于它将记录的信息不同。例如production logger默认记录调用函数信息、日期和时间等。
> - 通过Logger调用Info/Error等。
> - 默认情况下日志都会打印到应用程序的console界面。





#### 3.2 Sugared Logger
