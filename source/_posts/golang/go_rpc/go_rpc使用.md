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

> RPC（Remote Procedure Call Protocol）是远程过程调用的缩写，通俗的说就是调用远处服务器的一个函数，与之相对应的是本地函数调用。
>
> RPC：进程间通信–应用层协议(http协议同层)，底层使用TCP实现
>
> PRC的理解：
>
> - 想调用本地函数一样，去调用

#### 1.1 本地调用示例

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

