---
title: Go RPC
date: 2022-08-01 16:32:29
updated: 2022-08-01 16:32:29
tags:
- Go
- RPC
cover: /posts_cover_img/golang/go_package.jpeg
categories: Go RPC
---

## 一、RPC协议

> https://www.jianshu.com/p/5ade587dbc58
>
> https://zhuanlan.zhihu.com/p/506415782
>
> https://www.cnblogs.com/wongbingming/p/11086773.html

### 1、RPC概念

> RPC（Remote Procedure Call Protocol）是远程过程调用的缩写，通俗的说就是调用远处服务器的一个函数，与之相对应的是本地函数调用
>
> PRC的理解：
>
> - 想调用本地函数一样，去调用远程服务器上的函数
> - 进程间通信–应用层协议(http协议同层)，底层使用TCP实现

### 2、本地调用和RPC调用区别

#### 2.1 本地调用

> 当在本地调用代码时，就是定义函数，然后函数名()调用
>
> 下面代码：
>
> - 先定义了一个`useError`函数
> - 然后在main函数中调用
> - 这是在本地调用的方式

```go
package main

import (
	"example.com/studygo/cerror"
	"fmt"
)

func useError(x, y uint8) (uint8, error) {
	if x < 10 {
		err := cerror.New("x小于0", "2022-08-08")
		return 0, err
	}
	return x + y, nil
}

func main() {
	u1, err := useError(9, 12)
	fmt.Printf("u1:%v ,u1 type:%T\n", u1, u1)
	fmt.Printf("err:%v ,err type:%T\n", err, err.Error())
}
```

![image-20220810233821783](go_rpc%E4%BD%BF%E7%94%A8/image-20220810233821783.png)

> - 本地过程调用发生在同一进程中的，所以可以正常调用
> - 但是我们无法直接在另一个构建的程序直接调用上面代码中的`userError`函数，因为它们是两个程序，内存空间是相互隔离的

#### 2.2 RPC调用

> RPC调用解决了什么问题
>
> - 为了解决类似远程、跨内存空间、的函数/方法调用
> - 比起以往的通过HTTP的Restful-API风格调用，使用RPC能够让我们调用远程方法像调用本地方法一样无差别
>     - 基于RESTful风格的API通常是基于HTTP协议，传输数据采用JSON等文本协议
>     - RPC可以使用TCP协议，传输数据采用二进制协议来说，相比RESTful的API来说性能会更好

> 实现RPC的步骤以及办法
>
> - 确定要执行的函数？ 
>     - 在本地调用中，函数主体通过函数指针函数指定，然后调用对应的函数，编译器通过函数指针函数自动确定被调用函数在内存中的位置。
>     - 在 RPC 中，调用不能通过函数指针完成，因为它们的内存地址可能完全不同。
>         - 调用方和被调用方都需要维护一个{ function <-> ID }映射表，以确保调用正确的函数。
> - 如何传递调用的参数？ 
>     - 本地过程调用中传递的参数是通过堆栈内存结构实现的
>     - RPC不能直接使用内存传递参数，因此参数或返回值需要在传输期间序列化并转换成字节流，因为网络传输都是使用的二进制格式，所以需要序列化或反序列化
> - 如何进行网络传输？ 
>     - 函数的调用方和被调用方通常是通过网络连接的
>     - function ID 和序列化字节流需要通过网络传输
>         - 只要能完成调用，调用方和被调用方就不受现有特定网络协议的限制。
>         - 比如有的RPC框架使用TCP协议，有的的使用HTTP协议

## 二、go内置rpc包

### 1、rpc包实现rpc调用步骤

> go语言内置的net/rpc包可以通过网络导出一个需要被远程调用的对象方法
>
> - 编写一个需要被远程调用的对象方法
>     - 所以导出对象和对象方法都需要首字母大写
> - rpc服务器注册一个对象，暴露到外部网络可见，并且服务名称就是被导出的对象类型的名称
> - 接着对象的导出方法就可以支持远程调用访问

### 2、rpc代码调用示例

#### 2.1 rpc服务端代码

```go
package main

import (
	"fmt"
	"net"
	"net/rpc"
)

// 定义导出对象结构体
type SayHiService struct{}

// 定义导出对象的方法，建议定义为指针接收者
func (s *SayHiService) SayGreet(sayStr string, reply *string) error {
	fmt.Printf("我说啦：:%v\n", sayStr)
	*reply = "你好呀，" + sayStr
	return nil
}

func main() {
  RpcSayHiService := new(SayHiService)
  
  // 
	_ = rpc.Register(RpcSayHiService)
	listener, err := net.Listen("tcp", ":1234")
	if err != nil {
		fmt.Printf("listen tcp rpc err:%v\n", err)
	}
	conn, err := listener.Accept()
	fmt.Printf("conn==>:%v\n", conn)
	if err != nil {
		fmt.Printf("conn rpc err:%v\n", err)
	}
	rpc.ServeConn(conn)
}
```

#### 2.2 rpc客户端代码

```go
package main

import (
	"fmt"
	"net/rpc"
)

func main() {
	address := "127.0.0.1:1234"
	client, err := rpc.Dial("tcp", address)
	if err != nil {
		fmt.Printf("client dial err:%v\n", err)
		return
	}

	var reply string
	sayStr := "忠实的仆人"
	err = client.Call("SayHiService.SayGreet", sayStr, &reply)
	if err != nil {
		fmt.Printf("client call err:%v\n", err)
		return
	}
	fmt.Printf("reply val:%v\n", reply)
}
```

