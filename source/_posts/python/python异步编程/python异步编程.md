---
title: Python异步编程
date: 2022-06-28 13:53:31
updated: 2022-06-28 13:53:31
tags: Python
cover: /posts_cover_img/python/python_logo.jpeg
categories: Python异步编程
---

## 一、协程

### 1、协程简介

> 协程（coroutine）
>
> - 不是计算机本身提供的能力，而是通过程序员自己人为通过代码创建实现的
> - 也叫做<font style="color:blue;font-weight:700">微线程</font>，是一种用户态内的上下文切换技术
>     - 本质就是通过一个线程实现代码块互相切换执行

### 2、普通代码执行

```python
def f1():
    print(f"this is f1")


def f2():
    print(f"this is f2")


f1()
f2()

# 执行结果就是依次显示
this is f1
this is f2
```

> 从上面代码可以看出，是依次执行的代码，这样相当于是串联的，这样效率比较低下

### 3、python实现协程的几种方法

> 协程的官方文档：[https://docs.python.org/zh-cn/3.7/library/asyncio-task.html](https://docs.python.org/zh-cn/3.7/library/asyncio-task.html)

> 协程实现的几种方法
>
> 1. greenlet：是一个比较早期的模块
> 2. yield关键字：表示是一个生成器
> 3. asyncio装饰器：在python3.4中使用，后面会在3.10中移除
> 4. async、await关键字：python3.5+ 推荐使用的，后续版本也会持续使用

#### 3.1 greenlet

```python
```



#### 3.2 yield

```python
```



#### 3.3 asyncio装饰器

>
> 官方解释：[asyncio装饰器](https://docs.python.org/zh-cn/3.7/library/asyncio-task.html#generator-based-coroutines)
>
> 对基于生成器的协程的支持 **已弃用** 并计划在 Python 3.10 中移除。
>
> 基于生成器的协程是 async/await 语法的前身。它们是使用 `yield from` 语句创建的 Python 生成器，可以等待 Future 和其他协程。
>
> 基于生成器的协程应该使用 [`@asyncio.coroutine`](https://docs.python.org/zh-cn/3.7/library/asyncio-task.html#asyncio.coroutine) 装饰，虽然这并非强制。

```python

注解 对基于生成器的协程的支持 已弃用 并计划在 Python 3.10 中移除。
基于生成器的协程是 async/await 语法的前身。它们是使用 yield from 语句创建的 Python 生成器，可以等待 Future 和其他协程。

基于生成器的协程应该使用 @asyncio.coroutine 装饰，虽然这并非强制。


```



### 4、async关键字实现协程示例

> 本质：可以通过人为控制，在函数代码之间进行切换

> 
