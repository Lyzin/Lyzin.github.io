---
title: Python异步编程
date: 2022-06-28 13:53:31
updated: 2022-06-28 13:53:31
tags: Python
cover: /posts_cover_img/python/python_logo.jpeg
categories: Python异步编程
---

## 一、异步编程原理

### 1、I/O概念

> 参考：https://zhuanlan.zhihu.com/p/572120426

> 什么是I/O？
>
> - 顾名思义，它所指的是Input/Output，即输入/输出，对文件实现输入/输出称为I/O
> - I/O操作的基本对象为文件
>   - 文件既可以是设备文件，也可以是普通文件。
>   - Linux系统中，I/O的类型可以分为标准I/O与文件I/O。标准I/O和文件I/O是为了实现对文件读写而封装的两套不同的用户程序编程接口。
>     - 标准I/O采用间接系统调用（库函数）的方式实现对文件的读写。
>     - 文件I/O采用直接系统调用的方式实现对文件的读写。
>   - 同时针对I/O的操作模式，也实现了阻塞I/O、非阻塞I/O、多路复用I/O以及异步I/O，这四种典型的模型。

> I/O不会占用CPU！！！
>
> I/O（Input/Output）就是指输入输出操作，包括读写磁盘、网络传输、键盘输入等。
>
> 在很多时候，I/O操作涉及到与外部设备（如硬盘、网络接口等）的通信，需要等待外部设备响应或数据传输完成，等待过程称为阻塞（Blocking），在这个过程中，不需要一直占用CPU，CPU可以去做其他事情。
>
> 同时，操作系统也提供了一些异步（Asynchronous）I/O操作的方式，可以在I/O操作进行的同时进行其他操作，提高系统效率。
>
> 因此，I/O操作不会一直占用CPU，但会占用一定的系统资源。
>
> https://www.zhihu.com/tardis/bd/ans/2963372182?source_id=1001

> I/O概述
>
> https://blog.csdn.net/weixin_48120109/article/details/116245336

> 关于I/O——内存与CPU与磁盘之间的关系
>
> https://blog.csdn.net/weixin_43381316/article/details/125407298

> Linux高级系统编程— I/O— I/O的基本概念、Linux标准I/O
>
> https://zhuanlan.zhihu.com/p/572120426

### 2、协程简介

> 协程（coroutine）
>
> - 不是计算机本身提供的能力，而是通过程序员自己人为通过代码创建实现的
> - 也叫做<font style="color:blue;font-weight:700">微线程</font>，是一种用户态内的上下文切换技术
>     - 本质就是通过一个线程实现代码块互相切换执行

### 

> 以下是ChatGPT4的回答

```json
在Python中，异步编程主要利用的是协程（coroutines），这是用于I/O密集型任务的一种编程模型。协程利用的是单线程内部的上下文切换，而不是多线程或者多进程。异步编程的关键就在于，当我们遇到I/O等待时，如网络请求、数据库查询等，该协程将被挂起，CPU则去处理其它的协程，这样就大大提高了效率。

当你说的“事件1需要时间执行的操作继续执行”，你可能是在理解协程如何继续执行已经开始但被阻塞的任务。这里面涉及到了Python的事件循环（event loop）。当你的协程开始进行I/O操作时，如读写文件，查询数据库等，这个操作会告诉事件循环我现在要开始一个可能要阻塞一段时间的任务了，然后它就会"让出"CPU，切换去执行其他的协程。当那个I/O操作完成时，事件循环会自动地切换回来，让这个协程从阻塞的地方继续执行下去。

对于Python的协程，需要一个事件循环来驱动它继续运行。Python标准库下的 asyncio 就提供了事件循环的实现，当有I/O等待发生时，如 asyncio.sleep，在等待过程中它会把CPU让给事件循环，由事件循环决定去执行哪个协程。

所以对于你的问题，“为啥事件1需要时间执行的操作还可以继续执行”，实际上是事件循环在协程挂起后继续驱动其他协程运行，当那个I/O操作完成后，事件循环再切换回来，继续执行之前的协程。因此，在等待I/O的时候并没有阻塞进程，而是用来执行其他任务了，这样就提高了程序的并发性。

希望这个解答能解决你的疑惑。如果还有其他问题，欢迎继续提问。
```



## 二、代码示例

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

## 三、FastAPI

> https://github.com/zhanymkanov/fastapi-best-practices#7-dont-make-your-routes-async-if-you-have-only-blocking-io-operations

