---
title: Golang基础编程
date: 2021-05-16 19:31:21
tags: 
- Golang
cover: /posts_cover_img/golang/golang_code.jpeg
categories: Golang基础编程
---



## 一、GO语言简介与配置

> ### 推荐资料：
>
> https://www.liwenzhou.com/ （七米老师博客，推荐）
>
> https://www.qcrao.com/
>
> https://golang.design/
>
> https://golang.design/go-questions/（程序员面试笔试宝典）
>
> https://www.flysnow.org/
>
> https://www.cnblogs.com/sunsky303/default.html?page=2

### 1、Go包的官方地址

> 官网：[https://golang.org/dl/](https://golang.org/dl/)
>
> 国内镜像站：[https://golang.google.cn/dl](https://golang.google.cn/dl)
>
> 流程图地址：[https://app.diagrams.net/](https://app.diagrams.net/)
>
> Golang内置库文档：[https://studygolang.com/pkgdoc](https://studygolang.com/pkgdoc)

### 2、Go优势

> 交叉编译、编译快速
>
> 开发效率高
>
> 执行性能好
>
> 天生支持并发
>
> 使用`UTF-8`编码方式来存放代码

### 3、学习心得

> 使用`golang Idea`编辑器或`vs code`，但是不要开启自动提示功能，使用省电模式，因为一开始就自己手写所有语法才能记得住
>
> 本笔记代码建议是`缩进4个空格`，但笔记代码缩进有可能不是2格，写代码时需要注意！

### 4、GO版本

![image-20211026110955968](go%E7%AC%94%E8%AE%B0.assets/image-20211026110955968.png)

### 5、GOPATH

> `gopath`是环境变量，用来表明写的`go`项目的工作目录
>
> `gopath`最好设置一个，所有代码都放到`gopath`的`src`目录下

- 创建GO项目的步骤

  > 1. 创建一个目录作为存放`Go`语言代码，比如：`/xx/go`
  > 2. 在环境变量中新增 `GOPATH:/xx/go`
  > 3. 在`/xx/go`下新建三个文件夹，分别为
  >    1. `bin`：用来存放我们写好的go代码编译后的二进制文件
  >    2. `src`：存放`go`语言的源代码，以及第三方下载的源代码
  >       1. 常见的`src`中代码目录结构就是：`golang.org`(网站域名) -> `username`(作者机构) -> 项目1/项目2(项目名) -> 模块A/模块B/模块C/模块D
  >    3. `pkg`：存放编译后的库文件或缓存文件
  > 4. 最后把`/xx/go/bin`目录添加到`PATH`里即可

### 6、MAC配置自定义GOPATH

> 通过`go env`查看go的所有环境变量，包括`gopath`

- 先看默认的`go env`

![image-20211026113415106](go%E7%AC%94%E8%AE%B0.assets/image-20211026113415106.png)

> - 可以看到默认的`GOPATH`是在: `/Users/xxx/go`下面，是`go`默认的`GOPATH`，同时可以到这个目录里去看，会看到有三个目录，也就是我们需要手动创建的三个目录
>
> ![image-20211026113713432](go%E7%AC%94%E8%AE%B0.assets/image-20211026113713432.png)
>
> - `GOROOT`是`GO`安装包的位置
>
> - 接下来创建自己的`GOPATH`

#### 6.1 创建目录

- 创建go目录以及那三个目录

![image-20211026113846716](go%E7%AC%94%E8%AE%B0.assets/image-20211026113846716.png)

#### 6.2 添加环境变量

> 1. 编辑：`vim   ~/.zshrc`
>
> 2. 添加如下内容
>
>    ```bash
>    export GOPATH=/Users/xxx/Desktop/Code/go_study
>    export PATH=${GOPATH}/bin:$PATH
>    ```
>
> 3. 重新加载配置文件：`source  ~/.zshrc`

#### 6.3 查看GOPATH

> 1. 重新查看`GOPATH`，可以看到`GOPATH`已经修改过来了

![image-20211026114200717](go%E7%AC%94%E8%AE%B0.assets/image-20211026114200717.png)

### 7、Windows配置GOPATH

> 在官网下载`GO`的安装包，默认安装完会配置默认的`GOROOT`和`GOPATH`

- 默认的`GOPATH`

  ![image-20211103003520566](go%E7%AC%94%E8%AE%B0.assets/image-20211103003520566.png)

- 在环境变量中默认显示`GOPATH`和`GOPATH`下的`bin`

  - 在环境变量里打开会显示成这样：`GOPATH=%USERPROFILE%\go`

    ![image-20211103004055548](go%E7%AC%94%E8%AE%B0.assets/image-20211103004055548.png)

  - 然后看到`%USERPROFILE%\go`解析出来就是`C:\User\XXX\go`

  ![image-20211103003651813](go%E7%AC%94%E8%AE%B0.assets/image-20211103003651813.png)

  - 打开PATH可以看到最后一条是：`%USERPROFILE%\go\bin`
  - 所以需要修改为自己的`GOPATH`和`GOPATH\bin`

  ![image-20211103003726031](go%E7%AC%94%E8%AE%B0.assets/image-20211103003726031.png)

#### 7.1 修改自己的GOPATH值

> 在存放`go`代码的位置创建目录，将对应的目录地址填写过来

![image-20211103004455355](go%E7%AC%94%E8%AE%B0.assets/image-20211103004455355.png)

#### 7.2 修改`GOPATH\bin`

> 需要在`PATH`这个环境变量修改，修改成：`%GOPATH%\bin`，表示进到在上面设置的`GOPATH`的`bin`目录下

![image-20211103004636063](go%E7%AC%94%E8%AE%B0.assets/image-20211103004636063.png)

#### 7.3 检查`GOPATH`

> 看到已经修改过来了

![image-20211103004908553](go%E7%AC%94%E8%AE%B0.assets/image-20211103004908553.png)

### 8、创建代码目录

> 按照上述说明的进行创建目录

![image-20211026115327001](go%E7%AC%94%E8%AE%B0.assets/image-20211026115327001.png)

### 9、最新配置Go开发

> https://www.bilibili.com/video/BV1bV41177KD?spm_id_from=333.999.0.0

### 10、Goland配置go root

> 低版本的`goland`配置高版本的`go sdk`会提示报错：
>
> `"The selected directory is not a valid home for Go Sdk"`
>
> 比如
>
> - goland版本是2018.1
> - go sdk是1.17.8
>
> 此时goland添加go sdk就会报错，可按如下解决

> 找到go sdk安装目录下的`go\src\runtime\internal\sys\zversion.go`
>
> 添加如下代码保存

```go
// zversion.go ,TheVersion 为安装的go sdk版本
const TheVersion = `go1.17.8`
```

> 保存后重启goland编辑器，然后就可以配置go sdk了

### 11、goproxy设置

> 参照七牛云设置即可
>
> [https://goproxy.cn/](https://goproxy.cn/)

```go
// windows打开PowerShell并执行
C:\> $env:GO111MODULE = "on"
C:\> $env:GOPROXY = "https://goproxy.cn"

// 但是这样设置在goland中使用的终端是普通的命令行.exe，不是powershell，可能不会生效，所以需要这样设置
go env -w GO111MODULE=on
go env -w GOPROXY="https://goproxy.cn"
```

## 二、运行代码

### 1、第一行代码

> 代码注释:
>
> ```go
> // 单行注释
> 
> /*
> 多行注释
> 多行注释
> 多行注释
> */
> ```

```go
package main

import "fmt"

func main() {
		fmt.Println("hello world!")
}
```

![image-20211026110718850](go%E7%AC%94%E8%AE%B0.assets/image-20211026110718850.png)

### 2、编译build

> 构建`go`代码:`go build`
>
> - 是通过`GOPATH`去找代码，`GOPATH`在哪，`GO BUILD`就执行在哪
>
> 通过`-o`可以指定编译的可执行程序的名字: `go build -o 'hello'`

### 3、运行run

> 直接运行代码
>
> `go run xxx.go`

### 4、安装install

> 分为两步
>
> - 先编译得到一个可执行编译文件
> - 然后将可执行文件拷贝到`GOPATH/bin`目录

### 5、单引号与双引号

> - 在`go`语法中，双引号是常用的来表达字符串，如果你使用了单引号，编译器会提示出错
>   - `invalid character literal (more than one character)`
>   - 这个报错提示了无效的字符字面，超过了一个字符，因为字符串一般是大于一个字符的数量的字符串
>     - 单引号只能包含一个字符，例如`'b'` ，程序会输出`98`表示字符`b`的`ascii`码
>     - `ascii`码是用数字对应字母的

> - 如果非要使用单引号输出必须使用string函数转换,如下

```go	
fmt.Println(string('b'))
```

> `Printf`和`Println`的区别
>
> `Printf`输出后不换行,`Println`输出后自动换行
> `Printf`格式化输出,`Println`直接输出内容

### 6、跨平台编译代码

> `GO`代码可以跨平台编译
>
> 只需要指定对应目标操作系统的平台和处理器架构就可以了

#### 6.1 `mac`编译`linux`程序

```bash
# 编译linux程序64位
CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build

# 编译windows程序64位
CGO_ENABLED=0 GOOS=win dows GOARCH=amd64 go build
```

#### 6.2 `linux`编译`mac`和`windows`程序

```bash
# 编译mac程序64位
CGO_ENABLED=0 GOOS=darwin GOARCH=amd64 go build

# 编译windows程序64位
CGO_ENABLED=0 GOOS=windows GOARCH=amd64 go build
```

#### 6.3 `windows`下编译`mac`程序

```bash
set CGO_ENABLED=0 set GOOS=darwin set GOARCH=amd64 go build
```

## 三、变量与常量

### 1、第一行代码解释

```go
// 这里是指声明的包
// main包表示可以编译执行的二进制文件
// 非main包表示是给别人用的
package main

// 引入一个fmt包，用来提供打印功能
// 引入的包必须是双引号
import "fmt"

// 在函数外只能放置标识符(变量、常量、函数、类型)的声明，不可以放语句
// 语句比如: a + b = c

// main包必须有一个main函数，是整个程序的入口，所有代码都从main函数里进行执行
// main函数没有参数，也没有返回值
func main() {
		fmt.Println("hello, go!")
}
```

### 2、标识符/关键字

#### 2.1 标识符

> 表示定义的具有特殊意义的单词，比如变量名、常量名、函数名等等
>
> `Go`中由字母、数字、下划线(_)组成

#### 2.2 关键字

> 编程语言内部定义好的关键字
>
> 比如：`import`、`break、func`等等

### 3、变量声明

> `GO`语言中的变量是静态类型，需要先声明再使用

#### 3.1 变量声明的几种方式

##### 3.1.1  `var`关键字

###### 1、声明变量不赋值

> - 适用于任何地方来声明变量，比如函数外，函数内，适合声明全局变量
> - 这种方式声明变量会有默认值，常见的如下
>   - 字符串类型初始值为`""`
>   - 整型类型初始值为0
>   - 布尔类型初始值为`false`
> - 变量名不可以重复声明
>
> ```go
> // 变量声明格式
> var 变量名 变量类型
> 
> // 变量声明推荐使用小驼峰
> var isMyName string
> 
> // 声明后给变量赋值
> name = "sam"
> age = 18
> isOk = true
> ```

###### 2、声明变量的同时赋值

> - 适用于任何地方来声明变量，比如函数外，函数内，适合声明全局变量
> - 并且变量的值就是赋值的值
>
> ```go
> // 变量声明推荐使用小驼峰
> var isMyName string = "sam"
> ```

###### 3、自动推导变量类型

> - 这种方式不需要指定变量类型，直接赋值即可，`go`会自动推导出变量类型
> - 适用于任何地方来声明变量，比如函数外，函数内，适合声明全局变量，不过为了能够清楚看出变量是什么类型，还是指定变量类型比较好
>
> ```go
> // 变量声明推荐使用小驼峰
> var isMyName = "sam"
> ```

###### 4、批量声明变量

> - 因式分解形式来声明变量后会有一个初始值，也是批量声明变量
>
> - 格式
>
> ```go
> var (
> 	变量名 类型
>   	变量名 类型
>   	变量名 类型
> )
> ```
>
> - 注意点：
>
> ```go
> // 使用批量声明变量必须指定变量类型，否则会报错
> // 需要指定期望的变量类型
> syntax error: unexpected newline, expecting type
> ```

###### 5、一行声明多个变量

> - 可以使用var关键字一行声明变量，但是必须指定变量类型
> - 格式
>
> ```go
> var 变量a,变量b,变量c,变量d 变量类型
> ```
>
> - 注意点
>
> ```go
> // 使用批量声明变量必须指定变量类型，否则会报错
> // 需要指定期望的变量类型
> syntax error: unexpected newline, expecting type
> ```

##### 3.1.2 短变量声明

> - `go`语言中可以使用短变量声明方式进行声明变量，会自动推到变量类型
>
> - 格式
>
> ```go
> 变量名 := 变量值
> ```
>
> - 注意
>
> ```go
> // 这种方式只适用于函数体内，如果在函数体外定义，就会报错
> // 提示不能在函数体外声明变量
> non-declaration statement outside function body
> ```

```go
// 如下，短变量声明
sf := "sf"
```

#### 3.2 注意点

> - 变量声明注意点
>   - `var`  变量声明，可以适用于函数内外 
>   - `:=`  短变量声明，只能在函数内声明
>   - `_`  匿名变量多用于占位，表示忽略某个值
>   - 同一个作用域不可重复声明同名的变量
>
> - 一个花括号就是一个作用域
>   - 需要注意的是`Go`语言中变量声明必须使用，不使用就编译不过去
>   - 这里需要注意的是全局变量可以声明但不使用，在函数外面使用`var`声明的变量
>   - 非全局变量声明后赋值且必须使用，在函数内声明变量
>
> - 因为编译器会减少编译后的体积，所以声明了变量但未使用就会编译不通过
>
>
> - `Go`语言没有什么缩进格式要求，当然好的代码格式是比较方便阅读的

### 4、匿名变量

> 匿名变量可以想象成linux中的标准输入，表示我不需要查看该输出，相当于忽略
>
> 如果想要忽略某个值，可以使用匿名变量，匿名变量使用一个下划线`_`表示
>
> 匿名变量不占用命名空间，不会分配内存，所以匿名变量之间不存在重复声明
>
> 匿名变量适用于批量声明变量

```go
package main

import "fmt"

const (
	a1 = 100
	a2
	_   // 这里就代表将这个值以匿名变量跳过
	a3 = iota
)

func main() {
    fmt.Println("第一个批量定义常量")
    fmt.Printf("%v\n", a1)
    fmt.Printf("%v\n", a2)
    fmt.Printf("%v\n", a3)
}
```

### 5、常量

> 程序运行期间固定不变的值
>
> 推荐在函数外部进行声明
>
> 常量声明以后不可以再重新赋值

#### 5.1 常量声明

```go
package main

import "fmt"

// 常量是指程序运行期间永不变的值
const pi = 3.1415926

func main() {
		fmt.Println(pi)
}
```

```go
// 并且常量定义后不能重新赋值
package main

import "fmt"

const pi = 3.1

func main() {
    pi = 45  // 对常量进行重复赋值
    fmt.Printf("%v\n", pi)
}
// 输出报错如下图
// 翻译过来就是不能指定给pi，已声明未const
```

![image-20211206141410106](go%E7%AC%94%E8%AE%B0.assets/image-20211206141410106.png)

#### 5.2 批量声明

> 因式分解形式进行批量声明常量
>
> 批量声明变量，如果后面没写值就和上一行一样的值

```go
package main

import "fmt"

// 批量声明
const (
    CODE_OK = 200
    CODE_NOT_FOUND = 404
)

// 批量声明变量，如果后面没写值就和上一行一样的值
const (
    n1 = 100
    n2
    n3 = 300
    n4
)
func main() {
    fmt.Println(CODE_OK) // 200
    fmt.Println(CODE_NOT_FOUND) // 404

    // <--->
    fmt.Println(n1) // 100
    fmt.Println(n2) // 100
    fmt.Println(n3) // 300
    fmt.Println(n4) // 300
}
```

#### 5.3 `iota`

> `iota`是常量计数器，只能在`conts`常量中使用
>
> - `const`中每新增一行常量声明，将使`iota`的计数加一，初始的`iota`值为0
>   - 这里要注意当批量声明`const`时，如果第一个常量没有显式的写值等于`iota`，当下面的`x`常量值写了等于`iota`,那么该x常量的值就是`iota`从`0`开始到这个`x`的值,而不是从`0`开始，因为`iota`也说明了只要`const`中新增一行，`iota`就会加一

```go
package main

import "fmt"

//批量声明变量，如果后面没写值就和上一行一样的值
const (
    n1 = iota // 0
    n2        // 1
    n3        // 2
)


const (
    b1 = iota // 0
    b2        // 1
    _         // 2 匿名变量表示不需要这个值，可以丢弃掉
    b3        // 3
)

func main() {
    fmt.Println(n1) // 0
    fmt.Println(n2) // 1
    fmt.Println(n3) // 2
    // ----
    fmt.Println(b1) // 0
    fmt.Println(b2) // 1
    fmt.Println(b3) // 3
}
```

#### 5.4 iota的几种场景

> - `iota`的核心:
>  - 每新增一行常量声明，将使`iota`的计数加一
>   - 并且`const`重新出现`iota`才会置为0

```go
package main

import "fmt"

// iota插队: `const`中每新增一行常量声明，将使`iota`的计数加一，
const (
    b1 = iota
    b2 = 100 // 表示在const中新增一行，并且是在同一个const中
    b3 = iota
)

// 多个常量声明在一行
const (
    // d1和d2在同一行，所以iota是0，所以d1:0 + 1 = 1, d2: 0 + 2 = 2
    d1, d2 = iota + 1, iota + 2

    // d1和d2在同一行，所以iota是0，所以d3:1 + 1 = 2, d4: 1 + 2 = 3
    d3, d4 = iota + 1, iota + 2
)


func main() {
    fmt.Println(b1) // 0
    fmt.Println(b2) // 1
    fmt.Println(b3) // 2

    // <--->
    fmt.Println(d1) // 1
    fmt.Println(d2) // 2
    fmt.Println(d3) // 2
    fmt.Println(d4) // 3
}
```



## 四、数据类型

### 1、整型

> https://www.jianshu.com/p/793efa912d4e
>
> https://www.jianshu.com/p/d02f454f6439#comments
>
> https://www.jianshu.com/p/d02f454f6439?ivk_sa=1024320u
>
> https://www.jianshu.com/p/a011fb51f2f4
>
> https://www.cnblogs.com/tmtony/p/11804575.html
>
> 整型分为以下两个大类，按长度分为：
>
> - 有符号整型：`int8、int16、int32、int64` 
>
> - 对应的无符号整型：`uint8、uint16、uint32、uint64`
>
> 其中，`uint8`就是我们熟知的`byte`型，`int16`对应C语言中的`short`型，`int64`对应C语言中的`long`型。

```go
package main

import "fmt"

func main() {
    // 定义整型变量
    i1 := 101
    fmt.Printf("%d\n", i1) // 表示输出10进制数, 101
    fmt.Printf("%b\n", i1) // 10进制转换为2进制, 1100101
    fmt.Printf("%o\n", i1) // 10进制转换为8进制, 145
    fmt.Printf("%x\n", i1) // 10进制转换为16进制, 65

    // 八进制,表示0-7的数字，一般以0开头，用于文件权限
    i2 := 077
    fmt.Printf("%d\n", i2) // 表示将8进制转换为10进制，63

    // 十六进制，表示0-f的值，一般以0x开头,用于内存地址
    i3 := 0x1234567
    fmt.Printf("%d\n", i3) // 表示将16进制转换为10进制，19088743

    // 声明int8的类型,指定数字为什么类型，否则就是int类型
    i4 := int8(9)
    fmt.Printf("%d\n", i4) // 9
    fmt.Printf("%T\n", i4) // int8
}
```

### 2、浮点数

> 1、Go语言支持两种浮点型数：`float32`和`float64`
>
> 2、这两种浮点型数据格式遵循`IEEE 754`标准：
>
> -  `float32` 的浮点数的最大范围约为 `3.4e38`，可以使用常量定义：`math.MaxFloat32`
> - `float64` 的浮点数的最大范围约为 `1.8e308`，可以使用一个常量定义：`math.MaxFloat64`
>
> 3、打印浮点数时，可以使用`fmt`包配合动词`%f`
>
> 4、默认`Go`语言的小数都是`float64`
>
> 5、`float32`的变量值不能赋值给`float64`位

```go
package main
import (
	"fmt"
	"math"
)

func main() {
    fmt.Printf("%f\n", math.Pi) // 3.141593
    // %.2f 表示保留小数点后两位
    fmt.Printf("%.2f\n", math.Pi) // 3.14
    fmt.Printf("%T\n", math.Pi) // float64

    // 定义float32类型
    s2 := float32(1.3245)
    fmt.Printf("%f\n", s2) // 1.324500
    fmt.Printf("%T\n", s2) // float32
}
```

### 3、布尔值

> Go语言中以`bool`类型进行声明布尔型数据，布尔型数据只有`true（真）`和`false（假）`两个值。
>
> **注意：**
>
> 1. 布尔类型变量的默认值为`false`。
> 2. Go 语言中不允许将整型强制转换为布尔型。
> 3. 布尔型无法参与数值运算，也无法与其他类型进行转换。

```go
package main

import "fmt"

func main() {
    var s1 bool // 只声明布尔值不赋值，默认值是false
    s2 := true
    fmt.Printf("%T\n", s1) // bool
    fmt.Printf("%T\n", s1) // bool
    fmt.Printf("%v\n", s1) // false
    fmt.Printf("%v\n", s2) // true
}
```

### 4、字符串

> `Go`语言中的字符串以原生数据类型出现，使用字符串就像使用其他原生数据类型（int、bool、float32、float64 等）一样
>
> `Go`语言里的字符串的内部实现使用`UTF-8`编码
>
> 字符串的值为`双引号(")`中的内容
>
> `Go`语言中字符串必须是双引号`(")`，单引号`(')`表示字符
>
> `golang`中`string`底层是通过`byte数组`实现的
>
> 中文字符在`unicode`下占`2个字节`，在`utf-8编`码下占`3个字节`，而`golang`默认编码正好是`utf-8`,所以一个中文表示3个字符

#### 4.1 字符串

```go
package main

import "fmt"

func main() {
    // 字符串
    s1 := "hello"
    fmt.Printf("%T\n", s1) // string
    fmt.Printf("%#v\n", s1) // hello

    // 单独的字母，汉字、符号表示一个字符
    s2 := 'h'
    s3 := 'e'
    fmt.Printf("%T\n", s2) // int32
    fmt.Printf("%v\n", s2) // 104
    fmt.Printf("%v\n", s3) // 101

    // 字节: 1字节=8bit(8个二进制位)
    // 1个字符'A'等于1个字节
    // 1个utf8编码的汉字'沙' 一般占3个字节
}
```

#### 4.2 转义符号

```go
`\r	回车符（返回行首）
\n	换行符（直接跳到下一行的同列位置）
\t	制表符
\'	单引号
\"	双引号
\\	反斜杠`
```

```go
package main

import "fmt"

func main() {
	path := "\"D:\\Go\\src\\code.xx.name\\day01\""
	fmt.Printf("%v\n", path) // "D:\Go\src\code.xx.name\day01"
}
```

#### 4.3 多行字符串

> 输出多行字符串，需要使用反引号，在`esc`键位下方的按键
>
> 反引号的内容会原样输出，可以用来输出文件路径

```go
package main

import "fmt"

func main() {
	s1 := `this is
	a
	good
	day!
	`
	fmt.Printf("%v\n", s1)
	fmt.Printf("%#v\n", s1)
}
```

#### 4.4 字符串长度

> `len(str)`返回一个`int`型

```go
package main

import "fmt"

func main() {
	s1 := "hi, go~"
	fmt.Printf("%v\n", len(s1)) // 7
}
```

#### 4.5 字符串拼接

> 返回一个新的字符串变量

```go
package main

import "fmt"

func main() {
	s2 := "good"
	s3 := " day"
	// 拼接法1： +号
	s4 := s2 + s3
	fmt.Printf("%v\n", s4) // good day
	
	// 拼接法2：使用fmt包的Sprintf接收两个变量值然后拼接后返回给一个变量
	s5 := fmt.Sprintf("%s%s", s2, s3)
	fmt.Printf("%v\n", s5) // good day
}
```

#### 4.6 分割

> 需要引入包`strings`
>
> 分割后返回值为一个切片`list`

```go
package main

import "fmt"
import "strings"

func main() {
	s1 := "hi\\go\\haha"
	s2 := strings.Split(s1, "\\")
	fmt.Printf("%v\n", s2) // [hi go haha]
}
```

#### 4.7 包含

> 返回值是`true/false`

```go
package main

import "fmt"
import "strings"

func main() {
	s1 := "hi\\go\\haha"
	
	// 包含
	s2 := strings.Contains(s1, "go")
	fmt.Printf("%v\n", s2) // true
	
	// 不包含
	s3 := strings.Contains(s1, "gos")
	fmt.Printf("%v\n", s3) // false
}
```

#### 4.8 前缀/后缀

> 返回值是`true/false`

```go
package main

import "fmt"
import "strings"

func main() {
	s1 := "hi\\go\\haha"

	// 判断前缀是否是以hi开头
	s2 := strings.HasPrefix(s1, "hi")
	fmt.Printf("%v\n", s2) // true

	// 判断后缀是否是以gos结尾
	s3 := strings.HasSuffix(s1, "gos")
	fmt.Printf("%v\n", s3) // false
}
```

#### 4.9 子串位置

> 返回子串的索引位置

```go
package main

import "fmt"
import "strings"

func main() {
	s1 := "hi\\go\\haha"

	// 返回子串的第一个字符出现的索引位置
	s2 := strings.Index(s1, "hi")
	fmt.Printf("%v\n", s2) // 0

	// 返回子串最后一个字符出现的索引位置
	s3 := strings.LastIndex(s1, "go")
	fmt.Printf("%v\n", s3) // 3
}
```

#### 4.10 join

> `join`可以将数组以某个格式拼接起来，比如：`-`、`+`等

```go
package main

import "fmt"
import "strings"

func main() {
	// 先将字符串切割为数组
	s1 := "hi\\go\\haha"
	s2 := strings.Split(s1, "\\")
	// 再将数组join连接成字符串
	s3 := strings.Join(s2, "+")
	fmt.Printf("%v\n", s3) // hi+go+haha
}
```

#### 4.11 字符串修改

> 首先字符串不可以修改，不过可将字符串修改为其他类型再进行修改
>
> 将字符串先转换为一个切片，切片里保存的就是字符
>
> 然后对切换的字符进行重新赋值后再输出就达到了字符串修改
>
> `rune`类型是`int32`类型的
>
> `byte`是`uint8`类型的

```go
package main

import "fmt"

func main() {
	s2 := "白萝卜"
	s3 := []rune(s2) // 把字符串强制转换成了一个rune切片,切换里保存的就是字符
	s3[0] = '红'
	s4 := string(s3)
	fmt.Printf("%v\n", s4) // 红萝卜
}
```

#### 4.12 强制类型转换

```go
package main

import "fmt"

func main() {
	// 类型转换
	// 整型和浮点型转换
	s1 := 10
	s2 := float64(s1)
	fmt.Printf("%v\n", s2) // 10
	fmt.Printf("%T\n", s2) // float64
}
```

### 5、rune类型

> `rune`官方解释：rune is an alias for int32 and is equivalent to int32 in all ways. It is used, by convention, to distinguish character values from integer values
>
> - int32的别名，几乎在所有方面等同于int32，一般用来表示字符的
> - 可以使用`%c`取到对应的字符
> - 用于区分字符值（rune用来表示字符值）和整数值

```go
type rune = int32
```

```go
package main

import "fmt"

func main() {
	
	var str = "hello 你好"
	fmt.Println("len(str):", len(str)) // 12	
}
```

> - 结果是12，从字符串字面量看 len(str) 的结果应该是8
>   - 因为`go`是`utf-8`编码，而`go`底层字符串是用`byte`编码的，一个汉字表示3个字符
>   - 所以`str`的长度是`hello(5个字符)`+`空格(1个字符)`+`你好(6个字符)`=`12个字符`
> - 所以可以将字符串转为rune类型，来计算字符串长度

```go
package main

import (
	"fmt"
)

func main() {
	str := "hello 世界"
	str1 := []rune(str)
	for _, v := range str1 {
		fmt.Printf("v:%c\n", v)
	}
	fmt.Printf("str1:%v\n", str1)
	fmt.Printf("str1 len:%v\n", len(str1))
}
```

> 从执行结果来看，返回的字符串长度是8，符合我们的预期了

![image-20220413190349824](go%E7%AC%94%E8%AE%B0.assets/image-20220413190349824.png)

## 五、流程控制

### 1、if语句

> 常见的`if`判断语句
>
> 格式：
>
> ```go
> if 表达式 {
>   	语句1
> } else {
>   	语句2
> }
> ```

#### 1.1 单个if语句

```go
package main

import "fmt"

func main() {
	// 类型转换
	// 整型和浮点型转换
	s1 := 10
	if s1 == 10 {
		fmt.Printf("s1 等于 %v\n", s1)
	} else {
		fmt.Printf("s1 不等于 %v\n", s1)
	}
}

// 输出结果
// s1 等于 10
```

#### 1.2 嵌套if语句

> 格式：
>
> ```go
> if 表达式 {
>   	语句1
> } else if 表达式 {
>   	语句2
> } else {
>   	语句3
> }
> ```

```go
package main

import "fmt"

func main() {
	// 类型转换
	// 整型和浮点型转换
	s1 := 10
	if s1 > 10 {
			fmt.Printf("s1 大于 %v\n", s1)
	} else if s1 < 10 {
			fmt.Printf("s1 小于 %v\n", s1)
	} else {
			fmt.Printf("s1 等于 %v\n", s1)
	}
}
```

#### 1.3 特殊写法

> 可以将变量写到if判断里，以减少内存占用
>
> 并且在if语句外是无法访问到if里的变量值

```go
package main

import "fmt"

func main() {
	// 将变量和if写在一行，这个s1变量的作用域只在if判断里生效，if判断外无法进行变量访问
	// 这样可以减少内存占用
	if s1 := 10; s1 == 10 {
			fmt.Printf("s1 等于 %v\n", s1)
	} else {
			fmt.Printf("s1 不等于 %v\n", s1)
	}
	
	// 在这里是没法访问到s1的，因为s1在if的作用域里
	fmt.Printf("%v\n", s1) // undefined: s1
}
```

### 2、for语句

#### 2.1 基础格式

> 格式：
>
> ```go
> for 初始语句;条件表达式;结束语句{
>     		循环体语句
> }
> ```

```go
package main

import "fmt"

func main() {
	for i:= 0; i < 10; i++{
			fmt.Printf("%v\n", i)
	}
}

// 结果
/*
    0
    1
    2
    3
    4
    5
    6
    7
    8
    9
*/
```

#### 2.2 `for`变种1

> 将初始值提到`for`循环外面

```go
package main

import "fmt"

func main() {
	i := 5
	for ;i < 10; i++{
			fmt.Printf("%v\n", i)
	}
}

// 结果
/*
    5
    6
    7
    8
    9
*/
```



#### 2.3 `for`变种2

> 将初始值提到`for`循环外面
>
> 将结束语句放到`for`循环内部

```go
package main

import "fmt"

func main() {
	i := 5
	for i < 10{
			fmt.Printf("%v\n", i)
			i++
	}
}

// 结果
/*
    5
    6
    7
    8
    9
*/
```

#### 2.4 无限循环

> 切记不要轻易尝试，这是死循环，`go`性能很高，很容易将机器性能打满
>
> 死循环代码格式
>
> ```go
> for {
> 	循环语句
> }
> ```

```go
for {
		fmt.Println("hello world")
}
```

> 当前也可以给`for`后面跟条件判断语句,有点类似于其他语言的`while`语句，达成某种条件后退出循环

```go
package main

import "fmt"

func main() {
	s := 0
	for s < 3 {
		fmt.Printf("这是for循环\n")
		s++
	}
}

// 输出结果为三个for循环结果
/*
这是for循环
这是for循环
这是for循环
*/
```



### 3、`for range`循环

#### 3.1 基础格式

> - `Go`语言中可以使用`for range`遍历数组、切片、字符串、`map`及通道（`channel`），通过`for range`遍历的返回值有以下规律：
>   - 数组、切片、字符串返回索引和值
>   - `map`返回键和值
>   - 通道（`channel`）只返回通道内的值
>
> - `for`循环中输出每个字符，那必须使用`%c`来输出字符

> 代码格式

```go
// 这里面的i是循环的索引值
// v是值

s := "Hello测几"
for i, v := range s {
	fmt.Printf("%d : %c",i, v)
} 
```

```go
package main

import "fmt"

func main() {
	// for range 循环
	s := "Hello悦悦"
	for i, v := range s {
		if i < 1 {    
			fmt.Printf("%d\n", i)  // 索引值 0
			fmt.Printf("%T\n", v)  // int32 ,所以需要转换成字符类型
			fmt.Printf("%c\n", v)  // H
		}
	}
}
```

#### 3.1 只有一个变量

> 当`for range`中只有一个变量时，那这个变量是索引值而不是元素值

```go
fmt.Println("for range 只有一个变量")
	for v := range rangeNameStr {
		fmt.Println(v)
	}
```

#### 3.3 匿名变量接收索引值

> 在`3.2`中描述只有一个变量时，这个变量是索引值而不是元素值，当不想要索引值时，可以使用匿名变量来接收索引值
>
> 这里就是匿名变量的用处，可以作为一个

```go
fmt.Println("for range 使用匿名变量接收索引")
for _, v := range rangeNameStr {
    fmt.Printf("%c", v)
}
```

### 4、`for`循环例子

> 9x9乘法口诀

```go
package main

import "fmt"

func main() {
	for i := 1; i < 10; i++ {
		for j := 1; j <= i; j++ {
			z := i * j
			fmt.Printf("%d * %d = %d\t ", i, j, z)
		}
		fmt.Println()
	}
}
```

### 5、break

> `break`用来表示直接退出循环

```go
package main

import "fmt"

func main() {
	for i := 1; i < 10; i++ {
		if i == 5 {
			break
		} else {
			fmt.Printf("i = %d\n", i)
		}
	}
	fmt.Print("done")
}

// 结果
i = 1
i = 2
i = 3
i = 4
i = 5
// 可以看到等于5就退出循环了
```

### 6、continue

> 跳过这一次循环

```go
package main

import "fmt"

func main() {
	for i := 1; i < 10; i++ {
		if i == 5 {
			continue
		} else {
			fmt.Printf("i = %d\n", i)
		}
	}
	fmt.Print("done")
}

// 结果,可以看到5被跳过不输出
/*
    i = 1
    i = 2
    i = 3
    i = 4
    i = 6
    i = 7
    i = 8
    i = 9
*/
```

### 7、switch

> 主要是简化大量判断
>
> 当大量`if`需要判断某个变量等于某个值，然后执行一些功能块时，就可用`switch`语句来简化代码
>
> `switch`和`case`两个关键字是同一列，不需要`case`在`switch`下缩进

```go
package main

import "fmt"

func main() {
    // 多个if判断可以使用switch语句
    age := 18
    if age == 1 {
      fmt.Println("age = 1")
    } else if age == 2 {
      fmt.Println("age = 2")
    } else {
      fmt.Println("age = 3")
    }

    // switch简化大量判断
    switch age {
    case 1:
      fmt.Println("age = 1")
    case 2:
      fmt.Println("age = 2")
    default:
      fmt.Println("age not found")
    }
}
```

#### 7.1 `switch`变种

> 可以在`swicth`语句的`case`里放置多个值

```go
package main

import "fmt"

func main() {
    // 多个if判断可以使用switch语句
    age := 8

    // switch的case可以放置多个值
    switch age {
    case 1, 3, 5, 7, 9:
    	fmt.Println("age = 1")
    case 2, 4, 6, 8, 10:
    	fmt.Println("age = 2")
    default:
    	fmt.Println("age not found")
    }
}

```

### 8、`goto`(了解)

> `goto`表示跳到某个位置，在代码里可以指定对应标签
>
> 建议：`goto`尽量少用

```go
package main

import "fmt"

func main() {
    // goto 语句，表示调到这个位置
    // goto 后面跟着标签Label，这可以直接跳出多个循环
    for i := 0; i < 10; i++ {
      if i == 3 {
      	  fmt.Printf("i = %d\n", i)
      	  goto LABEL_BREAK
      }
    }
    LABEL_BREAK:
    fmt.Println("done!")
}

```

## 六、运算符

### 1、算数运算符

> 常见的加减乘除余

```go
package main

import "fmt"

var (
    a int
    b int
    c int
)

func main() {
    a = 4
    b = 2
    // 加法
    fmt.Println(a + b) // 6

    // 减法
    fmt.Println(a - b) // 2

    // 乘法
    fmt.Println(a * b) // 8

    // 除法
    fmt.Println(a / b) // 2

    // 取余
    fmt.Println(a % b) // 0
}
```

### 2、递减与递增

> - 变量递增：`a++`
>   - 单独的语句， 不能放在=的右边赋值， 等价于：a = a + 1
>
> - 变量递减：`a--`
>   - 单独的语句， 不能放在=的右边赋值， 等价于：a = a - 1
>
> - 注意：
>   - 变量与`++`/`--`符号之间可以留一个空格，或者不留都可以进行递增或递减运算，个人建议可以不留空格

```go
package main

import "fmt"

func main() {
	fmt.Printf("--->\n")
	s1 := 10
	s1++
	fmt.Printf("%v\n", s1)
}
```

### 3、关系运算符

> 关系运算可以包含等于、不等于、大于等于、小于等于、大于、小于这几种关系
>
> 关系运算返回的一定是`bool`类型

```go
package main

import "fmt"

var (
    a int
    b int
    c int
)


func main() {
    a = 4
    b = 2

    // 关系运算符

    // 等于
    fmt.Println( a == b) // false

    // 不等于
    fmt.Println( a != b) // true

    // 大于等于
    fmt.Println( a >= b) // true

    // 小于等于
    fmt.Println( a <= b) // false

    // 大于
    fmt.Println( a > b) // true

    // 小于
    fmt.Println( a < b) // false
}

```

### 4、逻辑运算符

> 和其他语言一样，`go`语言可以进行多个逻辑判断

#### 4.1 与运算	

> `&& `表示与
>
> 两个条件都为真才为真

```go
package main

import "fmt"	

var (
    a int
    b int
    c int
)


func main() {
    a = 4
    b = 2

    // 与运算符
    if a > 3 && b < 3 {
        fmt.Println("aaa")
    } else {
        fmt.Print("bbb")
    }
}

```

#### 4.2 或运算

> `||`表示或运算
>
> 只要有一个条件为真则为真

```go
package main

import "fmt"

var (
    a int
    b int
    c int
)


func main() {
    a = 4
    b = 2

    // 或运算符
    if a > 3 || b < 3 {
      fmt.Println("aaa")
    } else {
      fmt.Print("bbb")
    }
}

```

#### 4.3 非运算

> `!`表示非，取反

```go
package main

import "fmt"

var (
    a int
    b bool
)

func main() {
    a = 4
    b = true

    // 或运算符
    if !b {
      fmt.Println("aaa")
    } else {
      fmt.Print("bbb")
    }
}
```

> 需要注意`非运算`只能跟布尔类型的值，其他的类型会报错，不能对一个变量直接判断是否为true/false
>
> 这个和其他语言是最不一样的地方，`python`中是可以对其他类型进行非运算判断

```go
package main

import "fmt"

func main() {
	s1 := 10
	s2 := "sam"
	if !s1 {
		fmt.Printf("不是10")
	} else if !s2 {
		fmt.Printf("不是10")
	}
}
```

![image-20211206161257244](go%E7%AC%94%E8%AE%B0.assets/image-20211206161257244.png)

### 5、位运算

> 针对的是二进制数

#### 5.1 按位与

> 符号：`&`
>
> 两位都为1才为1

```go
package main

import "fmt"

func main() {
	// 5的二进制： 101
	// 2的二进制：  10
	
	// 按位与 (两位都为1才为1)
	// 5的二进制数每一位和2的二进制的每一位进行运算
	// 5    1 0 1
	// 2      1 0
	// --------------
	//      0 0 0
	// 结果是3个0，那么
    // 0 X 2^2 + 0x2^1 + 0x2^0 = 0 + 0 + 0 = 0
    // 所以 5 & 2就是0
	fmt.Println(5 & 2) // 000
}
```

#### 5.2 按位或

> 符号: `|`
>
> 两位有一个为1就为1

```go
package main

import "fmt"

func main() {
	// 5的二进制： 101
	// 2的二进制：  10

	// 按位与 (两位有一个为1就为1)
	// 5的二进制数每一位和2的二进制的每一位进行运算
	// 5    1 0 1
	// 2      1 0
	// --------------
	//      1 1 1
	// 1 X 2^2 + 1x2^1 + 1x2^0 = 4 + 2 + 1 = 7
	fmt.Println(5 | 2) // 7
}
```

#### 5.3 按位异或

> 符号: `^`
>
> 两位不一样就为1

```go
package main

import "fmt"

func main() {
	// 5的二进制： 101
	// 2的二进制：  10

	// 按位异或 (两位不一样就为1)
	// 5的二进制数每一位和2的二进制的每一位进行运算
	// 5    1 0 1
	// 2      1 0
	// --------------
	//      1 1 1
	// 1 X 2^2 + 1x2^1 + 1x2^0 = 4 + 2 + 1 = 7
	fmt.Println(5 ^ 2) // 7
}
```

#### 5.4 左移

> 符号：`<<`
>
> 将二进制数往左移动指定的数字,移动后的空出来的位数由0补全

> 比如5的二进制： 101
>
> 将5往左位移动1位,相当于将5的二进制101整体往左移动一位，移动后空出来的位置由0补全，所以就变成了101 + 0 = 1010
>
> 详细计算见下

```go
package main

import "fmt"

func main() {
	// 5的二进制： 101
	// 往左移动1位, 变成了 1010
	// 5 << 1 等价于
	// 1 x 2^3 + 0 x 2^2 + 1 x 2^1 + 1 x 2^0 = 8 + 0 + 2 + 0 = 10
	fmt.Println(5 << 1) // 10

	// 往左移动2位, 变成了 10100
	// 5 << 2 等价于
	// 1 x 2^4 + 0 x 2^3 + 1 x 2^2 + 0 x 2^1 + 0 x 2^0  = 16 + 0 + 4 + 0 + 0 = 20
	fmt.Println(5 << 2) // 20

	// 往左移动3位, 变成了 101000
	// 5 << 2 等价于
	// 1 x 2^5 + 0 x 2^4 + 1 x 2^3 + 0 x 2^2 + 0 x 2^1 + 0 x 2^0  = 32 + 0 + 8 + 0 + 0 + 0 = 40
	fmt.Println(5 << 3) // 40
}
```

#### 5.5 右移

> 符号：`>>`
>
> 将二进制数往右移动指定的数字,相当于将二进制数从右边删除对应的位数，这样来看就相当于是往右边移动了

> 比如5的二进制： 101
>
> 将5往右位移动1位,相当于将5的二进制101整体往右减少一位，那么101右边减少一位就变成了10， 101最右边的1被减去了
>
> 详细计算见下

```go
package main

import "fmt"

func main() {
	// 5的二进制： 101

	// 往左移动1位, 变成了 10
	// 5 >> 1 等价于
	// 1 x 2^1 + 0 x 2^0 = 2 + 0 = 2
	fmt.Println(5 >> 1) // 2

	// 往左移动2位, 变成了 1
	// 5 >> 1 等价于
	// 1 x 2^0 = 1
	fmt.Println(5 >> 2) // 1

	// 往左移动3位, 变成了 0
	// 5 >> 1 等价于
	// 0 x 2^0 = 0
	fmt.Println(5 >> 3) // 0
	// 依次往下继续右移也会一直为0
	fmt.Println(5 >> 4) // 0
}
```

#### 5.5 左移与右移理解

> 类比在计算器上输入数字的例子，在计算器里输入数字:`23`
>
> - 想让23往左移动，那么就需要
>   - 左移一位，23后面补0，变为230
>   - 左移二位，230后面补0，变为2300
>   - 左移三位，2300后面补0，变为23000
>   - 这样来看屏幕就相当于把23往左移动了
>   - 当然也要注意，当定义的整数位数的长度不能被左移超过，如果超过也没什么意义
> - 想让23往右移动，那么就需要：
>   - 右移一位，23先把3删除，变为2
>   - 右移二位，2把自己删除，变为0
>   - 右移三位，0继续删除自己然后补0，所以会一直为0
>   - 这样来看屏幕就相当于把23往右移动了，有点类似于删除的感觉，当右移位数超过该值的位数，最终一直会为0

#### 5.6 左移与右移例子

> 可以用来定义数量集
>
> 这里的`<<`表示左移操作，`1<<10`表示将1的二进制表示向左移10位，也就是由`1`变成了`10000000000`，也就是十进制的1024
>
> 同理`2<<2`表示将2的二进制表示向左移2位，也就是由`10`变成了`1000`，也就是十进制的8
>
> 左移与右移常用于权限配置这一类设置

```go
package main

import "fmt"

// 定义数量集
// << 表示左移符号，向左移动几位
const (
    _ = iota
    KB = 1 << (10 * iota) // 表示向左移动10位，也就是2的10次方，转换为二进制就是1024
    MB = 1 << (10 * iota)
    GB = 1 << (10 * iota)
    TB = 1 << (10 * iota)
)

func main() {
    fmt.Println(KB) // 1024
    fmt.Println(MB) // 1048576
}
```

### 6、赋值运算符

> 给变量赋值
>
> `+=` 相加后再赋值
>
> `-=` 相减后再赋值
>
> `*=` 相乘后再赋值
>
> `/=` 相除后再赋值
>
> `%=` 求余后再赋值

```go
package main

import "fmt"

func main() {
	s1 := 13
	s1 += 1
	fmt.Printf("%v\n", s1) // 14

	s1 -= 1
	fmt.Printf("%v\n", s1) // 13
}
```

## 七、复合数据类型

### 1、数组

> 数组类似于其他语言的列表，比如`python`的`list`、`shell`语言的数组，但又完全不一样
>
> 常用来存储元素，元素是基本数据类型：字符串、整型、布尔值
>
> `一个数组只能指定一种数据类型，不支持一个数组中有多种数据类型的元素存在`
>
> - 注意
>   - `go`中的数组需要指定长度和类型
>   - 并且长度和元素类型是数组整个类型的一部分，这是和其他语言的不一样的地方
>
> - 数组使用场景不多，用的比较多的是切片

#### 1.1 数组声明

> - 数组声明
>   - 数组声明只是相当于定义了一个数组，并没有给数组指定具体的值，数组声明的所有元素值都是`go`语言中的零值
>   - 数组声明以后长度和类型都确定好了，不能再修改
>   - 数组只声明，不初始化，那这个数组每种类型的元素都有一个零值(默认值)，没有具体的值，默认零值如下
>     - 字符串类型初始值为`""`
>     - 整型类型初始值为`0`
>     - 布尔类型初始值为`false`

##### 1.1.1 `var`关键字声明数组

```go
// 格式
var 数组名 [数组长度]数组类型

// 数组名：定义的数组变量名
// 数组长度：一个具体的数字，可以为0，但是没有意义
// 数组类型：支持int/string/bool三种常见类型
```

```go
package main

import "fmt"

func main() {
	var arr1 [3]int
	var arr2 [3]string
	var arr3 [3]bool
	fmt.Printf("%v\n", arr1) // [0 0 0]

	// 可以看到arr1的类型不仅包含长度，还包含了元素类型
	fmt.Printf("%T\n", arr1) // [3]int

	fmt.Printf("%v\n", arr2) // [     ]
	fmt.Printf("%T\n", arr2) // [3]string

	fmt.Printf("%v\n", arr3) // [false false false]
	fmt.Printf("%T\n", arr3) // [3]bool
}
```

##### 1.2.1 短变量声明数组

> 除了`var`关键字声明数组，也可以用短变量方式声明数组
>
> - 短变量声明数组有两种格式
>   - 第一种：指定确定的数组长度值
>   - 第二种：用`...`代替确定的数组长度值，表示数组值的个数由go自动推导长度，这种方式声明的数组个数都是0

```go
数组名 := [数组长度]数组类型{}

/* 
	数组名：定义的数组变量名
	数组长度：一个具体的数字，可以为0，但是没有意义，必须是一个数字，不能是三个点
	数组类型：支持int/string/bool三种常见类型
	{} : 用短变量声明一定要有，不带会报错
*/
```

```go
package main

import "fmt"

func main() {
	// 方法1
	// 指定长度，此时该数组长度就是指定的长度
	s1 := [3]int{}
	fmt.Println(s1) // [0 0 0]
	fmt.Println(len(s1)) // 3
}
```

#### 1.2 数组初始化赋值

> 为什么要对数组初始化？
>
> - 定义完数组后，`go`会自动给数组元素设置初始的零值(默认值)，这应该不是我们想要的，所以要对数组已经设置的值进行重新赋值，所以需要初始化赋值，相当于覆盖了默认值
> - 数组定义以后每种类型的元素都有一个零值(默认值)
>   - 字符串类型初始值为`""`
>   - 整型类型初始值为`0`
>   - 布尔类型初始值为`false`
>
> 下面代码是初始化数组的三种方式
>
> - 初始化赋值方式
>   - 第一种：先声明，再初始化
>   - 第二种：短变量方式声明并且初始化，一步完成
>   - 第三种：根据索引来初始化，其他元素用零值(默认值)补全
>
> - 注意：
>   - 其实数组不管哪种方式声明并且初始化赋值
>     - 既可以分步骤执行，先声明，再初始化完成
>     - 也可以声明和初始化赋值在一行代码完成
>     - 使用哪种方式取决于自己
>   - 用短变量方式直接定义数组，但是必须要对数组进行初始化(也就是要一定带上{}符号，表示创建了一个数组)，否则会下面的错误
>     - 错误提示：`./main.go:7:8: type []int is not an expression`

##### 1.2.1 `var`初始化赋值

> 推荐使用：
>
> - 通过`var`关键字需要分两步
>   - 先声明
>   - 再初始化赋值数组

```go
package main

import "fmt"

func main() {
	// 声明数组
	var arr1 [3]int
	fmt.Println(arr1) // [0 0 0]

	// 数组初始化赋值
	arr1 = [3]int{1, 2, 3}
	fmt.Println(arr1) // [1 2 3]
}
```

> 不推荐：
>
> - 当然也可以将声明和初始化一步完成

```go
package main

import "fmt"

func main() {
	// 不推荐：一行代码完成声明和初始化赋值
	var arr2 [3]int = [3]int{4, 5, 6}
	fmt.Println(arr2) // [4, 5, 6]
}
```

##### 1.2.2 短变量初始化赋值

> 推荐使用：
>
> - 短变量方式声明和初始化赋值一行代码完成，推荐使用`[...]`形式
>   - 可以在`[]`设置确认的长度值
>   - 可以在`[]`用三个`...`代替(`[...]`)，表示数组值的个数由`go`自动推导长度

```go
package main

import "fmt"

func main() {
	// ！！！推荐：一行代码完成，三个点表示数组值的个数由go自动推导长度
	arr2 := [...]int{4, 5, 6}
	fmt.Println(arr2) // [4, 5, 6]
	
    // 数组初始化赋值
    arr1 := [3]int{1, 2, 3}
	fmt.Println(arr1) // [1 2 3]
}
```

> 不推荐使用分步骤先声明、再赋值

##### 1.2.3 固定索引值初始化赋值

> 指定固定索引值进行声明初始化数组，其余元素有零值补全

```go
package main

import "fmt"

func main() {
	// 一行代码完成
	arr1 := [...]int{0:3, 4:3}
	fmt.Println(arr1) // [4, 5, 6]
}
```

#### 1.3 数组比较

> `数组长度和元素类型是数组整个类型的一部分`,所以长度不同，即使类型相同的数组也不能进行比较
>
> 这是和其他语言的不一样的地方

```go
package main

import "fmt"

func main() {
	var arr1 [3]int
	var arr2 [3]int
	var arr3 [4]int

	fmt.Println(arr1 == arr2) // true
	fmt.Println(arr1 == arr3)  // invalid operation: arr1 == arr3 (mismatched types [3]int and [4]int)
}

// arr1 == arr3 不能比较，会报错，因为长度也是数组的一部分,那么arr1和arr3不相等
// 会报错：invalid operation: arr1 == arr3 (mismatched types [3]int and [4]int)
// 翻译过来就是：无效操作：arr1 == arr3（类型[3]int和[4]int不匹配）
```

![image-20211206173943254](go%E7%AC%94%E8%AE%B0.assets/image-20211206173943254.png)

#### 1.4 数组的遍历

> 对数组进行变量，使用`for`循环

> c语言风格for循环

```go
package main

import "fmt"

func main() {
	var arr1 [3]string
	arr1 = [3]string{"sam", "bob", "lily"}

	// c语言风格for循环
	for i := 0; i < len(arr1); i++ {
		fmt.Printf("%v: %v\n",i, arr1[i])
	}
}

// 输出
/*
    0: sam
    1: bob
    2: lily
*/
```

> `for range`循环数组
>
> `for range`只有一个变量时，这个值为索引值

```go
package main

import "fmt"

func main() {
	// for range遍历
	arr2 := [...]string{"jix", "sem", "eop"}
	for i, v := range arr2 {
		fmt.Printf("%v:%v\n", i, v)
	}
}

// 输出
/*
    0:jix
    1:sem
    2:eop
*/
```

#### 1.5 多维数组

##### 1.5.1 定义多维数组

```go
package main

import "fmt"

func main() {
	// 多维数组
	// [[1 2] [3 4] [5 6]]
	var arr1 [3][2]int
	fmt.Println(arr1) // [[0 0] [0 0] [0 0]]

	// 初始化
	arr1 = [3][2]int{
		[2]int{1, 2},
		[2]int{3, 4},
		[2]int{5, 6},
	}
	fmt.Println(arr1) // [[1 2] [3 4] [5 6]]
}
```

##### 1.5.2 遍历多维数组

```go
package main

import "fmt"

func main() {
	// 多维数组
	// [[1 2] [3 4] [5 6]]
	var arr1 [3][2]int
	fmt.Println(arr1) // [[0 0] [0 0] [0 0]]

	// 初始化
	arr1 = [3][2]int{
		[2]int{1, 2},
		[2]int{3, 4},
		[2]int{5, 6},
	}
	fmt.Println(arr1) // [[1 2] [3 4] [5 6]]

	// C语言风格
	for i := 0; i < len(arr1); i++ {
		for j:= 0; j < len(arr1[i]); j++ {
			fmt.Printf("每个元素: %v\n", arr1[i][j])
		}
	}

	// for range风格
	for _, v1 := range arr1 {
		fmt.Printf("\n最外层的元素: %v\n", v1)
		for _, v2 := range v1 {
			fmt.Printf("最里面的元素: %v\n", v2)
		}
	}
}
```

![image-20211206181116451](go%E7%AC%94%E8%AE%B0.assets/image-20211206181116451.png)



#### 1.6 数组是值类型

> 将一个`A数组`赋值给另一个`B数组`，这样就相当于是将`A`数组完全复制了一份给`B数组`
>
> 修改`B数组`的元素，不会影响`A数组`，相当于`B数组`是`A数组`的副本，完全拷贝了`A数组`一份

```go
package main

import "fmt"

func main() {
	// 数组是值类型
	s1 := [...]int{1, 2, 3}
	s2 := s1
	s2[0] = 100

	fmt.Println(s1) // [1 2 3]
	fmt.Println(s2) // [100 2 3]
}
```

#### 1.7 数组例题

> 求数组元素的所有和

```go
func addArrSum() {
	s1 := [...]int{1, 2, 3, 4, 5}
	sum := 0
	for _, v := range s1 {
		sum = sum + v
	}
	fmt.Printf("sum = %v", sum)
}
```

> 求数组和为数组中指定的两个元素的下标
>
> 例如：[1,2,3,4,5]
>
> 求和为5的两个元素的下标

```go
package main

import "fmt"

func main() {
	s1 := [...]int{1, 2, 3, 4, 5}
	const sum = 5
	for i:= 0; i < len(s1); i++ {
		for j := i + 1; j < len(s1); j++ {
			if s1[i] + s1[j] == sum {
				fmt.Printf("(%v, %v)\n", i, j)
			} else {
				continue
			}
		}
 	}
}

/*		
输出
	(0, 3)
	(1, 2)
*/
```

### 2、切片

> `!!!比较重要`
>
> - 切片是一个用于相同类型元素的可变长的序列
> - 是数组类型的一层包装，更加灵活，支持自动增加数组长度
> - 切片属于`引用类型`
>   - 内部包含: `地址`、`长度`和`容量`
> - 切片可以快速操作数据集合

#### 2.1 声明切片

> 切片声明时只指定了类型，不需要指定切片长度，别的声明、初始化赋值切片格式都和数组一致，不做过多赘述
>
> - 不过切片底层还是数组
>
> - 切片声明以后
>   - 切片是没有零值(默认值)的，这个和数组是很大的区别
>   - 因为该切片长度为0，容量也为0
>   - 切片没有零值(默认值)，那这个切片的值是空，一个元素都没有，该切片的值就是`nil`，在其他编程语言里表示空，`redis`里表示空就是用`nil`表示
>   - 声明切片和nil相比较等于关系，一定是`true`

```go
// 声明切片格式
var 切片变量名 []T

// 切片名： 也叫变量名
// [] ：表示不需要设置切片长度
// T：表示切片中的元素类型
// 可以看到声明切片就不需要指定长度了
```

```go
package main

import "fmt"

func main() {
	// 切片
    
    // 定义整型类型的切片
	var s1 []int
    
    // 定义字符串类型的切片
	var s2 []string
    
    // 定义布尔类型的切片
	var s3 []bool

	fmt.Printf("%#v\n", s1) // []int(nil)
    fmt.Printf(s1 == nil) // true
	fmt.Printf("%T\n", s1) // []int

	fmt.Printf("%v\n", s2) // []
	fmt.Printf("%T\n", s2) // []string


	fmt.Printf("%v\n", s3) // []
	fmt.Printf("%T\n", s3) // []bool
}
```

#### 2.2 切片初始化

> 切片初始化和数组初始化是一样进行操作的，切片不需要在`[]`中写长度
>
> 支持三种方式
>
> - 第一种：先声明，再初始化
> - 第二种：短变量方式声明并且初始化，一步完成，一定要带花括号(`{}`)
>
> - 第三种：根据索引来初始化，其他元素用零值(默认值)补全

```go
package main

import "fmt"

func main() {
	// 定义整型类型的切片
	var s1 []int
	s1 = []int{1,2,3,4,5}
	fmt.Printf("%v\n", s1) // [1 2 3 4 5]
	fmt.Printf("%T\n", s1) // []int

	// 短变量声明切片
	s2 := []int{1,2,3,4,5}
	fmt.Printf("%v\n", s2) // [1 2 3 4 5]
	fmt.Printf("%T\n", s2) // []int

	// 指定固定索引值
	s3 := []int{0:4, 4:9}
	fmt.Printf("%v\n", s3) // [4 0 0 0 9]
	fmt.Printf("%T\n", s3) // []int
}
```

#### 2.3 由数组得到切片

> 可以由原始数组得到切片，和`python`的切片操作一致
>
> - 切片`s[x:y]`
>   - 表示`左包含右不包含`(左闭右开)，俗称"顾头不顾腚"
>   - 那么`切片s`就是从`原始数组`的`x索引开始`，到`原始数组`的`(y-1)索引结束`的这一段元素

```go
package main

import "fmt"

func main() {
	// 定义一个数组
	s1 := [...]int{1,2,3,4,5,6,7,8,9}

	// 切片1
	s2 := s1[0:4]
	fmt.Println(s2) // [1 2 3 4]

	// 切片2
	s3 := s1[:4] // 等价于 s1[0:4]
	fmt.Println(s3) // [1 2 3 4]

	// 切片3
	s4 := s1[:len(s1)] // 等价于 s1[:len(s1)],因为是左闭右开，所以右边的值会比索引小1
	fmt.Println(s4) // [1 2 3 4 5 6 7 8 9]

	// 切片3
	s5 := s1[:] // 表示切片了整个数组，相当于是复制了整个数组，但是注意切片是引用类型
	fmt.Println(s5) // [1 2 3 4 5 6 7 8 9]
}
```

#### 2.4 切片长度和容量

> - 切片长度：`len(切片变量名)`，求出切片的元素个数
>
> - 切片容量：`cap(切片变量名)`, 是指将从原始数组被切片的第一个元素开始，到切片原始数组的的最后一个元素的全部元素个数
>   - 切片容量表示了可以往右边切元素，直到切到原始数组最后一个元素，也就是说可以切片的总体容量

```go
package main

import "fmt"

func main() {
	// 切片
	// 由数组得到切片
	s1 := [...]int{1,2,3,4,5,6,7,8,9}

	// 表示切片了整个数组，相当于是复制了整个数组，但是注意切片是引用类型
	s2 := s1[:4]
	fmt.Printf("%v\n", s2) // [1 2 3 4]
	fmt.Printf("%v\n", len(s2)) // 4
	fmt.Printf("%v\n", cap(s2)) // 9

	s3 := s1[4:7]
	fmt.Printf("%v\n", s3) // [5 6 7]
	fmt.Printf("%v\n", len(s3)) // 3
	fmt.Printf("%v\n", cap(s3)) // 5
}
```

![image-20211206194456407](go%E7%AC%94%E8%AE%B0.assets/image-20211206194456407.png)

![image-20211206194604406](go%E7%AC%94%E8%AE%B0.assets/image-20211206194604406.png)



#### 2.5 切片再切片

> 可以对切片再进行切片，但是索引长度不能超过原数组长度，否则会出现数组索引越界情况 
>
> - `切片是引用类型，指向了底层数组`:
>   - 引用类型：表示切片和原始数组都指向了同一个数组
>   - 修改了底层数组的元素值，那么切片对应位置元素的值也会被修改

```go
package main

import "fmt"

func main() {
	var s1 []int
	s1 = []int{1,2,3,4,5,6}

	// 先对定义的切片s1进行切片s2
	s2 := s1[2:]
	fmt.Printf("%v\n", s2)
	fmt.Printf("len(s2)=%v cap(s2)=%v\n", len(s2), cap(s2))

	// 再对切片s2再进行切片出来s3
	s3 := s2[1:2]
	fmt.Printf("%v\n", s3)
	fmt.Printf("len(s3)=%v cap(s3)=%v\n", len(s3), cap(s3))

	// 切片是引用类型，指向了底层数组
	// 可以看到修改了原始切片s1，对应的s2切片的值也会修改成和s1一样
	s1[4] = 400
	fmt.Printf("%v\n", s2)
}
```

#### 2.6 `make`函数定义切片

> 上面的`切片声明`、`由数组获得切片`都是基于数组而产生切片，这两种方式创建的切片，长度和容量是由原始数组限制了，不能超过原始数组的长度和容量，没法在指定切片的时候就指定切片的长度和容量，那有没有直接定义切片的方式，那就是`make`函数
>
> - `make`函数是内置函数，可以动态创建切片
>   - 为什么说动态呢？
>     - 因为`make`提供了两个参数：`size`和`cap`，可以自由指定切片长度和容量
>     - 定义以后的切片根据`size`值通过零值(默认值)填充切片
>     - 定义后初始化切片，切片的容量可以不受`cap`值的限制，可以在初始化时定义大于`cap`值数量的元素，那么这个初始化以后的切片的长度和容量会根据初始化时填写的元素数量动态变化
>     - 那为什么`make`函数定义切片时还需要指定`size`和`cap`，个人理解是定义切片时只是作为一个初始值，但是初始化切片(往切片里塞元素值)时可以无限增大，这就是动态创建切片
>     - 但是`make`函数定义切片时可以省略`cap`参数值(不传`cap`值表示和`size`值一样)，不能不传`len`参数，会报错提示缺少`len`参数
>       - `./main.go:6:12: missing len argument to make([]int)`
> - `make`函数定义后，需要进行初始化，初始化和声明切片的方式一样，但是不能超过容量长度，否则会爆错
> - 注意
>   - make函数定义切片是，size参数值不能大于cap参数值，否则会报错
>     - ```./main.go:6:12: len larger than cap in make([]int)```

```go
// make函数创建切片
make([]T, size, cap)

// []T: 表示切片的类型
// size: 表示切片的长度，也就是len()切片元素个数返回的值
// cap: 表示切片的容量，也就是cap()切片容量返回的值
// 当size、cap参数只写一个数字时，表示size和cap都是同一个值
```

```go	
package main

import "fmt"

func main() {
    // 只写size的值，表示size和cap参数值都是同一个
	s1 := make([]int, 5)
	fmt.Printf("%v\n",s1) // [0 0 0 0 0]
	fmt.Printf("len(s1)=%v cap(s1)=%v\n",len(s1), cap(s1)) // len(s1)=5 cap(s1)=5
	
    // 下面表示切片长度为0，容量为10
    // s2=[]，表示底层数组就是空的,但是这个切片的容量长度是10
	s2 := make([]int, 0, 10)
	fmt.Printf("%v\n",s2) // 
	fmt.Printf("len(s2)=%v cap(s2)=%v\n",len(s2), cap(s2))  // len(s1)=0 cap(s1)=10
}
```

```go
package main

import "fmt"

func main() {
	s1 := make([]int, 5, 10)
	s2 := make([]string, 5, 10)
	s3 := make([]bool, 5, 10)
	fmt.Printf("%v\n", s1)
	fmt.Printf("%v\n", s2)
	fmt.Printf("%v\n", s3)

	// 通过make函数初始化的切片，对切片进行初始化
	s1 = []int{1,2,3}
	fmt.Printf("%v\n", s1)
}
```

#### 2.7 切片比较运算

> 因为切片是`引用类型`，不能使用`==`来进行两个切片的全部元素是否相等比较
>
> 切片只能和`nil`进行比较

```go
package main

import "fmt"

func main() {
	s1 := make([]int, 5)

	s2 := make([]int, 5)
	fmt.Println(s1 == s2)
}

// 下图的报错提示了slice只能用nil来比较
```

![image-20211207130223515](go%E7%AC%94%E8%AE%B0.assets/image-20211207130223515.png)



#### 2.8 切片`nil`值

> - 只有声明切片方式得到的切片的值是`nil`
>
> - 切片值是`nil`
>   - 这个切片的长度和容量都是0
>   - 表示这个切片是没有底层数组的
> - 不能说`长度为0`、`容量为0`的切片一定是`nil`

```go
package main

import "fmt"

func main() {
	// 声明一个切片，它的值才是nil
	var s1 []int
	fmt.Println(s1 == nil) // true
	fmt.Printf("s1=%#v len(s1)=%v cap(s1)=%v\n", s1, len(s1), cap(s1)) // s1=[]int(nil) len(s1)=0 cap(s1)=0

	// 短变量声明并初始化一个切片，可以看到s2的长度和容量都是0，但是s2不等于nil
	s2 := []int{}
	fmt.Printf("s2=%#v len(s2)=%v cap(s2)=%v\n", s2, len(s2), cap(s2)) // s2=[]int{} len(s2)=0 cap(s2)=0
	fmt.Println(s2 == nil) // false

	// make函数构造一个切片
	s3 := make([]int, 0)
	fmt.Println(s3 == nil) // false
	fmt.Printf("s3=%#v len(s3)=%v cap(s3)=%v\n", s3, len(s3), cap(s3)) // s3=[]int{} len(s3)=0 cap(s3)=0
}
```

#### 2.9 判断切片是否为空

> 判断切片是否为空，不能用`nil`判断，而是要用`len() == 0`

```go
package main

import "fmt"

func main() {
	// 声明一个切片，它的值才是nil
    // s1长度是0
	var s1 []int
	fmt.Printf("s1=%#v len(s1)=%v cap(s1)=%v\n", s1, len(s1), cap(s1)) // s1=[]int(nil) len(s1)=0 cap(s1)=0
	fmt.Println(len(s1) == 0) // true

	// 短变量声明并初始化一个切片，可以看到s2的长度和容量都是0，s2的长度是0
	s2 := []int{}
	fmt.Printf("s2=%#v len(s2)=%v cap(s2)=%v\n", s2, len(s2), cap(s2)) // s2=[]int{} len(s2)=0 cap(s2)=0
	fmt.Println(len(s2) == 0) // true

}
```

![image-20211207132221179](go%E7%AC%94%E8%AE%B0.assets/image-20211207132221179.png)



#### 2.10 切片赋值

> 可以将切片作为另一个变量的值
>
> 可以看出来`s2`引用了`s1`切片，`s1`的第三个元素值变化了，那么`s2`的第三值也会变化
>
> 切片不保存值，切片只是一个框，切片的值指向底层的数组

```go
package main

import "fmt"

func main() {
	s1 := []int{1,2,3,4}
	s2 := s1

	fmt.Println("修改切片s1之前")
	fmt.Println(s1) // [1 2 3 4]
	fmt.Println(s2) // [1 2 3 4]


	s1[2] = 1000
	fmt.Println("\n修改切片s1以后")
	fmt.Println(s1) // [1 2 1000 4]
	fmt.Println(s2) // [1 2 1000 4]
}
```

#### 2.11 切片遍历

> 可以使用`for`循环对切片进行遍历,和遍历数组一样

```go
package main

import "fmt"

func main() {
	s1 := make([]int, 5, 10)

	// 通过make函数初始化的切片，对切片进行初始化
	s1 = []int{1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14}
	fmt.Printf("%v\n", s1)
	fmt.Printf("len(s1)=%v cap(s1)=%v\n", len(s1), cap(s1))

	// c语言风格
	fmt.Println("\nc语言风格")
	for i := 0; i < len(s1); i++ {
		fmt.Printf("%v:%v\n", i, s1[i])
	}

	// for range形式
	fmt.Println("\nfor range形式")
	for i, v := range s1 {
		fmt.Printf("%v:%v\n", i, v)
	}
}
```

#### 2.12 切片`append`添加元素

> - 调用`append`函数必须要用原数组变量名接收返回值
>- 追加元素时，原来的底层数组放不下时，`go`会将底层数组更换一个新的数组内存地址，并且新的数组内存地址进行了自动扩容，那么更换了个那就必须接收，所以要用原来的切片变量名来进行接收
> - 自动扩容有时候是原来数组长度的2倍
>- `append`函数可以追加一个元素，追加多个元素，追加切片
>   - 相当于是两个切片相加

```go
// 格式
切片 = append(切片变量名，需要追加的元素)
```

```go
package main

import "fmt"

func main() {
	// 定义切片
	s1 := []string{"sam", "bob", "lily"}
	fmt.Printf("%v\n", s1)
	fmt.Printf("len(s1)=%v  cap(s1)=%v\n", len(s1), cap(s1)) // len(s1)=3  cap(s1)=3

	// 调用append函数必须要用原数组变量名接收返回值
	// 追加一个元素
	s1 = append(s1, "six_people")
	fmt.Printf("%v\n", s1) // [sam bob lily six_people]
	fmt.Printf("len(s1)=%v  cap(s1)=%v\n", len(s1), cap(s1)) // len(s1)=4  cap(s1)=6

	// 追加多个元素
	s1 = append(s1, "aliy", "wide")
	fmt.Printf("%v\n", s1) // [sam bob lily six_people wide wide]
	fmt.Printf("len(s1)=%v  cap(s1)=%v\n", len(s1), cap(s1)) // len(s1)=4  cap(s1)=6
}
```

> 将一个切片追加到另一个切片
>
> `append`函数里追加另一个切片
>
> - `s1 = append(s1, s2...)`
> - `s2...`表示将s2切片拆开，不是省略号

```go
package main

import "fmt"

func main() {
	// 定义切片
	s1 := []string{"sam", "bob", "lily"}
	fmt.Printf("%v\n", s1)
	fmt.Printf("len(s1)=%v  cap(s1)=%v\n", len(s1), cap(s1)) // len(s1)=3  cap(s1)=3

	// 追加一个切片
	s2 := []string{"lining", "xiaohong"}
    
    // s2... 表示将s2拆开，不是省略号，将s2切片整个都追加到s1切片
	s1 = append(s1, s2...)
	fmt.Printf("%v\n", s1) // [sam bob lily lining xiaohong]
	fmt.Printf("len(s1)=%v  cap(s1)=%v\n", len(s1), cap(s1)) // len(s1)=7  cap(s1)=12

}
```

#### 2.13 切片`copy`

> 由于切片是引用类型，当把一个切片指向另一个切片时，修改一个切片的值，另一个切片也会跟着修改
>
> 为了解决这种问题，引入了`copy`函数
>
> - `copy`函数可以快速的将一个切片完整复制到另一个切片空间中
> - 即使修改了原始的切片元素值，`copy`过去的切片对应位置的元素值也不会修改

```go
// 格式
copy(目标切片， 源切片 []T)
```

```go
package main

import "fmt"

func main() {
	// 定义切片
	s1 := []int{1, 2, 3}
	s2 := s1
	s3 := make([]int, 3)
    // copy切片，s3是目标切片，s1是源切片
	copy(s3, s1)
    
    // 修改源切片s1的第一个元素值为100
	s1[0] = 100
	fmt.Printf("s1 = %v\n", s1) //  [100 2 3]
	fmt.Printf("s2 = %v\n", s2) //  [100 2 3]
	fmt.Printf("s3 = %v\n", s3) //  [1 2 3]
}

// 可以看到s3 copy了s1切片后，即使s1的元素值修改了，s3的也不会变
```

#### 2.14 切片append删除元素

> `go`语言中没有特定删除切片指定元素的方法，需要自己写
>
> - `切片`修改的是底层数组
> - 切片修改了某个值，底层数组的值也会进行修改，因为切片是引用类型，指向的也是底层的数组

```go
// 格式
a := []int{1,2,3,4,5,6}
a = append(a[:index], a[index+1:]...)

// 这三个点(...)是表示把切片元素拆开追加到另一个数组里，不是省略号的意思
```

```go
package main

import "fmt"

func main() {
	// 删除切片指定索引位置元素
	s1 := []int{1, 2, 3, 4, 5}

	// 比如删除索引位置为2，值为3的元素
	s1 = append(s1[:2], s1[3:]...)
	fmt.Printf("%v\n", s1)
}
```

> 注意:
>
> - `append`切片删除元素时，给`append`里传入的第一个值一定必须是切片类型，不能是其他类型，否则会下面的报错，提示`append`第一个元素必须是切片(`slice`)

![image-20211221193527755](go%E7%AC%94%E8%AE%B0.assets/image-20211221193527755.png)

```go
package main

import "fmt"

func main() {
	// 定义数组
	s1 := [...]int{1,2,3,4,5,6}
	// 拿到切片
	s2 := s1[:]
	// 删除元素3前:
	// 切片s2是 [1 2 3 4 5 6]
	// len(s2) = 6, cap(s2)=6
	fmt.Println(s2, len(s2), cap(s2))

	// 切片是引用类型，如果对切片进行了删除值的操作
	// 那么底层数组的值也会被修改，但是切片不保存值
	// 切片操作的是底层数组

	// 删除元素3前，s2[0]的内存地址：0xc00000c450
	fmt.Printf("%p\n", &s2[0])
	s2 = append(s2[:2], s2[3:]...)  // 操作的是底层数组

	// 删除元素3后，s2[0]的内存地址：0xc00000c450
	fmt.Printf("%p\n", &s2[0])

	// 可以看出来，删除元素前后，切片的内存地址没有变
	// 那么也说明了切片不存值，对应操作的也是底层数组

	// 删除元素3后:
	// 切片s2变成了 [1 2 4 5 6]
	// len(s2) = 5, cap(s2)=6
	fmt.Println("s1:", s1, len(s1), cap(s1))
	fmt.Println("s2:", s2, len(s2), cap(s2))

	// 比如修改切片s2的第一个元素值
	//s2[0] = 100
	fmt.Printf("s2[0]的内存地址: %p\n", &s2[0])
	fmt.Printf("底层数组s1: %v\n", s1)
	fmt.Printf("切片s2: %v\n", s2)
}
```

![image-20211208141932267](go%E7%AC%94%E8%AE%B0.assets/image-20211208141932267.png)

#### 2.15 切片是引用类型验证

> `切片是引用类型，指向了底层数组`
>
> 下面是切片属于引用类型的验证
>
> - 可以看到从`数组s1`进行了切片得到了`切片s2`
> - 然后对切片后得到的`切片s2`进行了第一个元素重新赋值
> - 以及对`原始数组s1`的第三个元素重新赋值
> - 最后输出`数组s1`和`数组s2`的元素都为一致
>
> 由此可以看出切片是引用类型，不管是修改了切片的某个元素值，还是修改了原始数组的某个元素值，原始数组或切片共同位置的元素也会进行同步修改
>
> 对于引用类型，若使用var进行声明变量，`必须使用make函数对其进行分配内存,`若不初始化，该变量默认值为nil，向其添加元素时会导致panic。

```go
package main

import "fmt"

func main() {
	// 切片
	// 由数组得到切片
	s1 := [...]int{1,2,3,4,5,6,7,8,9}

	// 表示切片了整个数组，相当于是复制了整个数组，但是注意切片是引用类型
	s2 := s1[:]

	// 修改s2的第一元素的值
	s2[0] = 100
    
    // 修改s1的第三元素的值
	s1[2] = 399
	// 可以看到s1和s2的第一个元素的值都被修改了
	fmt.Println(s2) // [100 2 399 4 5 6 7 8 9]
	fmt.Println(s1) // [100 2 399 4 5 6 7 8 9]
}
```

#### 2.16 切片本质

> 切片本质就是一个框，框住了一段连续的内存区域，真正的数据是保存在底层数组中
>
> 切片是引用类型
>
> 切片不保存具体的值
>
> 切片对应一个底层数组
>
> 底层数组是一段连续的内存区域

#### 2.17 切片练习题

##### 2.17.1 `for`循环生成切片

```go
package main

import "fmt"

func main() {
	// 创建切片,下面是长度为5，有5个0的切片
	s1 := make([]int, 5, 10)
	for i := 0; i < 10; i++{
		s1 = append(s1, i)
	}
	fmt.Printf("%v", s1) // 追加到5个0后面，所以结果是: [0 0 0 0 0 0 1 2 3 4 5 6 7 8 9]
}
```

##### 2.17.2 实现lstrip()函数

> 编写删除字符串首部的空格代码，和`python`的`lstrip()`一样

```go
func strLeftStrip(s string) string {
	//  去除字符串首位左侧的空格
	if !strings.HasPrefix(s, " ") {
		return s
	}
	// 将s转换为切片
	sToSlice := strings.Split(s, "")
	sToSlice = append(sToSlice[:0], sToSlice[1:]...)
	ret := strings.Join(sToSlice, "")
	return ret
}
```

##### 2.17.3 实现rstrip()函数

> 编写删除字符串尾部的空格代码，和`python`的`rstrip()`一样

```go
func strRightStrip(s string) string {
	//  去除字符串首位左侧的空格
	if !strings.HasSuffix(s, " ") {
		return s
	}
	// 将s转换为切片
	sToSlice := strings.Split(s, "")
	sToSlice = append(sToSlice[0:len(sToSlice) - 1], "")
	ret := strings.Join(sToSlice, "")
	return ret
}
```

##### 2.17.4 实现strip()函数

> 编写删除字符串首部和尾部的空格代码，和`python`的`strip()`一样

```go
func strStrip(s string) string {
	if !strings.HasSuffix(s, " ") && !strings.HasPrefix(s, " ") {
		return s
	}
	// 先处理左侧首部空格
	s = strLeftStrip(s)
	
	s = strRightStrip(s)
	return s
}
```

### 3、指针

> https://studygolang.com/articles/29273
>
> https://blog.csdn.net/yonggeit/article/details/102521391

> `go`语言中不存在指针运算，仅可以操作指针
>
> - `指针`：
>   - 是指某一个指针类型的一个值，通过`&变量名`获取到的值就是`指针`(表示这个`变量名`指向的内存地址)
>   - 一个指针可以存一个内存地址，所以指针也就是内存地址
>   - 一个指针中存储的内存地址为另外一个值(也叫变量)的地址

#### 3.1 指针操作

##### 3.1.1 获取指针

> `&` : 取变量的内存地址，内存地址是一个16进制数
>
> `%p`: 是指直接使用`fmt`打印指针值，打印的时候需要在变量前面加`&`符号
>
> - 十六进制(前缀0x)表示
> - 一般是用来打印指针的，`fmt.Printf(“%p\n”, &s1)`



![image-20211221174834896](go%E7%AC%94%E8%AE%B0.assets/image-20211221174834896.png)

```go
package main

import "fmt"

func main() {
	// 查看内存地址符号：&
	age := 18

	//age的值:18
	fmt.Printf("age值:%v\n", age)

	//直接打印age的内存地址: 0xc00000a098
	fmt.Printf("&符号获取age的内存地址: %v\n", &age)

	//直接打印age的内存地址: 0xc00000a098
	fmt.Printf("&符号获取age的内存地址: %p\n", &age)

	// age的内存地址: *int
	fmt.Printf("&符号获取age的内存地址类型: %T\n", &age)
}
```

> 从上面代码可以看出来
>
> - 使用%v和%p打印变量age的内存地址都可以，因为%v表示接收任意类型的变量，而%p专门打印16进制的值，所以后面打印内存地址都使用%p
> - 可以看到打印变量age的内存地址的类型是`*int`
>     - 以后遇到变量类型的前面有个星号，那就表示是该类型对应的指针类型

##### 3.1.2 根据指针获取值

> `*` : 根据指针(内存地址)取值，获取到的是这个内存地址指向的原始值
>
> - 注意：
>   - 给函数中传入一个指针类型形参，就表示这个形参是一个内存地址
>   - 所以在函数内部，要取得这个内存地址的值，就需要使用`*变量名`拿到内存地址对应的具体值，然后进行操作

```go
package main

import "fmt"

func main() {
	// 查看内存地址符号：&
	age := 18

	//age的值:18
	fmt.Printf("age值:%v\n", age)

	//直接打印age的内存地址: 0xc00000a098
	fmt.Printf("&符号获取age的内存地址: %p\n", &age)

	ageVal := *(&age)
	// 获取age的原始值: 18
	fmt.Printf("获取age的原始值: %v\n", ageVal)
}
```

##### 3.1.3 变量重新赋值指针不变

> - 从下面代码可以看出来，代码运行期间：
>   - 变量`a`定义后会申请一块内存空间，用来存变量`a`的值
>   - 那么申请的内存空间的地址在代码运行期间永远不会变，但是变量`a`的值可以变，就是说变量`a`可以进行重复赋值，但是变量`a`的内存地址永不会变
> - 就是说变量`a`申请好内存地址以后，可以放任意值进去，也可以对放进去的值进行修改(也叫重新赋值)，但是变量`a`的内存地址申请好以后是永远不会变的

```go
package main

import "fmt"

func main() {
	// 查看内存地址符号：&
	age := 18

	//age的值:18
	fmt.Printf("age值:%v\n", age)

	//&符号获取age的内存地址: 0xc00000a098
	fmt.Printf("&符号获取age的内存地址: %p\n", &age)

	age = 28
	//age变量重新赋值的内存地址: 0xc00000a098
	fmt.Printf("age变量重新赋值的内存地址: %p\n", &age)
}
```

##### 3.1.4 指针打印理解

> 在fmt包中，有两种格式都可以打印内存地址
>
> `%v`万能打印占位符，什么类型都可以打印
>
> `%p`专门打印16进制0x开头的值，所以后面打印内存地址就使用`%p`，专门的占位符打印内存地址

#### 3.2 指针类型

> 如果定义变量的是什么类型，那么他的指针就是什么类型，常见的就是`string`、`int`、`bool`三种指针类型，后面会有结构体类型

```go
package main

import "fmt"

var (
	strData string
	intData int
	boolData bool
)

func main() {
	// 如果定义变量的是什么类型，那么他的指针就是什么类型
	// string类型指针
	strData = "hello"
	strDataAddr := &strData
	fmt.Printf("%v\n", strDataAddr) // 是hello的内存地址: 0x113cf30
	fmt.Printf("%T\n", strDataAddr) // *string 类型的指针
	
	// int类型指针
	intData = 13
	intDataAddr := &intData
	fmt.Printf("%v\n", intDataAddr) // 是13的内存地址: 0x116bd30
	fmt.Printf("%T\n", intDataAddr) // *int 类型指针
	
	// bool类型指针
	boolData = true
	boolDataAddr := &boolData
	fmt.Printf("%v\n", boolDataAddr) // 是bool的内存地址: 0x116bca1
	fmt.Printf("%T\n", boolDataAddr) // *bool 类型指针
}
```

#### 3.3 变量接收内存地址值

> 在一个数据类型获取内存地址时，可以把获取到的内存地址用一个纯新变量来接收
>
> 注意：
>
> - 此时纯新变量的值就是获取到的内存地址
> - 而纯新变量自己的内存地址是自己，而不是获取到内存地址
>
> 从下图来看：
>
> - a变量赋值18
> - 获取a的内存地址后，赋值给b
>     - 此时b的值就是a的内存地址
>     - b的类型就是指针类型，因为b的值是a的内存地址
> - 但是b自己的内存地址和b的值是两个值，这一块要注意，有时候会搞混

![image-20220424080913306](go%E7%AC%94%E8%AE%B0.assets/image-20220424080913306.png)

```go
package main

import "fmt"

func main() {
	// 查看内存地址符号：&
	age := 18

	//age的值:18
	fmt.Printf("age值:%v\n", age)

	// &符号获取age的内存地址: 0xc00000a098
	fmt.Printf("&符号获取age的内存地址: %p\n", &age)

	ageMer := &age
	// ageMer变量接收age内存地址的值: 0xc00000a098
	fmt.Printf("ageMer变量接收age内存地址的值: %p\n", ageMer)
	
	// ageMer变量接收age内存地址的值: *int
	fmt.Printf("ageMer变量接收age内存地址的值: %T\n", ageMer)

	// ageMer的内存地址: 0xc000006030
	fmt.Printf("ageMer的内存地址: %p\n", &ageMer)
}
```

### 4、`new`(很少用)

> `new`函数用来申请内存地址
>
> `new`很少用，一般用来给基础数据类型申请内存，string\int, 返回的是对应类型指针 

```go
package main

import "fmt"

func main() {
	// var 声明变量时需要指定类型，下面是给a1指定的类型是 指针类型，表示我想定义一个空指针变量, 然后对这个空指针经过*号获取原来的值进行重新赋值
	// 但是指针类型的零值是nil，
	// 所以会报错：panic: runtime error: invalid memory address or nil pointer dereference，翻译过来: 解除对空指针的引用
	//var a1 *int
	//fmt.Printf("%v\n", a1)
	//*a = 100

	// new函数申请内存地址
	var a2 = new(int)
	// 申请了一个内存地址
	fmt.Printf("%v\n", a2)  // 0xc00001e098
	// *a2表示根据内存地址找到对应的值
	fmt.Printf("%v\n", *a2) // 0
	// 重新对这个内存地址对应的值进行赋值,因为它是一个int类型的内存地址,所以int类型的零值是0，所以输出为0
	// 再对这个内存地址对应的值重新赋值为100，其实可以把(*a2)理解为一个变量名，一开始它的值是0，下面重新又赋一个值100
	*a2 = 100
	// 再次打印出该内存地址对应的值
	fmt.Printf("%v\n", *a2) // 100
}
```

### 5、`make`和`new`的区别

> `make`也是用于内存分配，区别于`new`
>
> `make`区别点:
>
> - 只用于切片`slice`、`map`、`chanl`的内存创建
> - 并且返回的是上面这三种类型本身，不是他们的指针类型, 因为这三种属于引用类型

### 6、`map`

> `map`是一种无序的基于`key-value`的数据结构
>
> `map`属于引用类型
>
> 必须初始化才可以用
>
> `map`和`python`里的`dict`很类似

#### 6.1 `var`关键字声明`map`

```go
// 格式
map[KeyType]ValueType

// KeyType:表示键类型
// ValueType:表示值类型
```

> 从下面代码可以看到
>
> - `var`关键字声明的`map`本来就是`map[]`，本质的值是`nil`,所以和`nil`比较是`true`
> - `map`的类型是包含了`KeyType`和`ValueType`，`key-value`的`type`也是`map`整个类型的一部分

```go
package main

import "fmt"

func main() {
	// 声明map
	var m1 map[string]int
	fmt.Printf("%v\n", m1) // map[]
	fmt.Printf("%#v\n", m1) // map[string]int(nil)
    fmt.Printf("m1==nil:%v\n", m1==nil) // m1==nil:true
	fmt.Printf("%T\n", m1) // map[string]int
}
```

> `map`类型初始值是`nil`，不能直接给`map`来赋值，会报错的

```go
package main

import "fmt"

func main() {
	// 定义map
	var m1 map[string]int
	m1["age"] = 18
	fmt.Printf("%v\n", m1["age"])

}
// 会看到有一个panic错误
```

![image-20211208233358205](go%E7%AC%94%E8%AE%B0.assets/image-20211208233358205.png)



#### 6.2 `map`初始化

##### 6.2.1 `var`关键字初始化

> 如果只是用var声明了一个`map`,并没有初始化，那这个`map`的值是`nil`，表示还没有初始化（也就是没有在内存里开辟空间）
>
> 需要使用`make()`函数来分配内存，也就是初始化`map`

> 先来看看`make()`函数初始化格式

```go
make(map[KeyType]ValueType, [cap])
// make的第一个参数：map[KeyType]ValueType 表示是一个map类型
// make的第二个参数： [cap]表示map的容量，非必填参数，但还需要给指定一个容量
```

```go
package main

import "fmt"

func main() {
	// 定义map
	var m1 map[string]int
	m1 = make(map[string]int, 10) // 
	m1["age1"] = 18
	m1["age2"] = 28
	m1["age2"] = 900
	fmt.Printf("%v\n", m1) // map[age1:18 age2:900]
	fmt.Printf("%v\n", m1["age1"]) // 18
	fmt.Printf("%v\n", m1["age2"]) // 900
}
```

> 从上面代码可以看出，在初始化好`map`以后：
>
> - 可以正常填充键值对
> - 当键有多个一样时，最终在`map`里只会留下最后一个相同的`key-value`
> - 因为容量是可以自动扩容的，所以建议在使用`make`函数定义容量时，估算好容量，避免自动扩容，因为自动扩容会增大运行速度

##### 6.2.2 短变量初始化

> `map`也可以使用短变量进行初始化，省去了声明的步骤，一步做到声明+初始化

```go
package main

import (
	"fmt"
)

func main() {
	// map
	m1 := make(map[int]string, 5)
	m1[0] = "bob"
	m1[1] = "sam"
	m1[2] = "alop"
	
	fmt.Printf("%v\n", m1) // map[0:bob 1:sam 2:alop]
}

```

#### 6.3 `map`获取`key-value`

> `map`取值也是用中括号里面放`key`来取值，和`python`一样
>
> 注意：
>
> - 取值时是可以接收两个值，第一个是值本身，第二个是这个值是否存在的布尔说明，如果存在则返回`true`，不存在则返回`false`
>   - `v1, ok := m1["age1"]` 这个ok是约定成俗的一个接收`key`是否存在的变量，就和`python`面向对象里的`self`一样,换成别的也可以
>     - 所以就可以用`ok`这个值来判断`key`是否存在
>   - 当获取的`key`不存在时，`ok`是`false`,并且查找的值是值类型的零值(默认值)

```go
package main

import "fmt"

func main() {
	// 定义map
	var m1 map[string]int
	m1 = make(map[string]int, 10)
	m1["age1"] = 18
	m1["age2"] = 28
	m1["age3"] = 900
	fmt.Printf("%v\n", m1)
	fmt.Printf("%v\n", m1["age1"])
	fmt.Printf("%v\n", m1["age2"])

	v1, ok := m1["age1"]
	fmt.Printf("v1=%v ok=%v\n", v1, ok) // v1=18 ok=true
	fmt.Printf("v1=%T ok=%T\n", v1, ok) // v1=int ok=bool
	if ok {
		fmt.Printf("age1的val:%v\n", v1)
	} else {
		fmt.Printf("age1这个key不存在\n")
	}

	// 如果key不存在直接去获取，那么拿到的是对应值类型的零值(默认值)
	v2， ok := m1["age"]
	fmt.Printf("v2=%v\n", v2) // v2=0 ok=false
}
```

#### 6.3 `map`遍历

> 使用`for range`来遍历`map`

```go
package main

import "fmt"

func main() {
	// 定义map
	var m1 map[string]int
	m1 = make(map[string]int, 10)
	m1["age1"] = 18
	m1["age2"] = 28
	m1["age3"] = 900

	// 遍历map的key-value
	fmt.Printf("遍历map的key-value\n")
	for k,v := range m1 {
		fmt.Printf("%v:%v\n",k,v)
	}

	// 只遍历map的key
	fmt.Printf("\n只遍历map的key\n")
	for k := range m1 {
		fmt.Printf("%v\n",k)
	}

	// 只遍历map的value
	fmt.Printf("\n只遍历map的value\n")
	for _, v := range m1 {
		fmt.Printf("%v\n",v)
	}
}
```

#### 6.5 删除键值对

> 使用`delete函数`删除`map`的键值对
>
> 当删除的`key`不存在时，不做任何处理

```go
// 格式
delete(map, key)

// map: 表示要删除的map
// key: 表示要删除的键值对的键
```

```go
package main

import "fmt"

func main() {
	// 定义map
	var m1 map[string]int
	m1 = make(map[string]int, 10)
	m1["age1"] = 18
	m1["age2"] = 28
	m1["age3"] = 900

	// 删除键值对
	delete(m1, "age1")
	fmt.Printf("%v\n", m1) // map[age2:28 age3:900]

	// 删除不存在的键
	delete(m1, "age")
	fmt.Printf("%v\n", m1) // map[age2:28 age3:900]
}
```

#### 6.6 `map`和切片互相转换

> `map`里可以放切片，同时切片里可以放`map`

##### 6.6.1 切片的元素值是`map`

> 切片的每个元素的值都是`map`类型
>
> 注意：
>
> - 因为定义的切片的元素是`map`，所以要对每个元素还要进行分配内存初始化(`make`函数分配内存)

```go
package main

import (
	"fmt"
)

func main() {
	// 元素类型为map的切片
	
	// 先对切片初始化，分配内存空间
	var s1  = make([]map[string]int, 5, 5)
	
	// 需要先对切片里，内部的map进行初始化
	s1[0] = make(map[string]int, 1)
	s1[1] = make(map[string]int, 1)
	s1[2] = make(map[string]int, 1)
	
	// 重新赋值
	s1[0]["name1"] = 13
	s1[1]["name2"] = 23
	s1[2]["name3"] = 33
	
	fmt.Printf("%v\n", s1)
	fmt.Printf("%v\n", s1[2]["name3"])
}

```

##### 6.6.2 `map`的元素值是切片

> `map`的每个元素的值都是切片

```go
package main

import (
	"fmt"
)

func main() {
	// map的键值对的值是切片类型
	
	// 定义并初始化map,并且ValueType是一个切片类型: []int
	var m1  = make(map[string][]int, 5)
	
	fmt.Printf("%v\n", m1) // map[]
	
	// 对切片类型进行初始化
	m1["name1"] = make([]int, 5, 5)
	m1["name2"] = make([]int, 5, 5)
	
	// 对切片进行重新赋值
	m1["name1"] = []int{1,2,3}
	m1["name2"] = []int{4,5,6}
	
	fmt.Printf("%v\n", m1) // map[name1:[1 2 3] name2:[4 5 6]]
}

```

#### 6.7 `map`练习题

>  `map`可以用来统计长段字符串里每个单词出现的次数，下面是`go`/`python`版本

```go
// go版本
package main

import (
	"fmt"
	"strings"
)

func main() {
	// how do you do每个单词出现的次数
	longStr := "how do you do"
	
	// 将字符串转换成切片
	longStrToList := strings.Split(longStr, " ")
	
	// 声明一个空map
	longStrToMap := make(map[string]int, 6)
	for _, v := range longStrToList {
		_, ok := longStrToMap[v]
		if !ok {
			longStrToMap[v] = 1
		} else {
			longStrToMap[v]++
		}
	}
	fmt.Printf("\n%v\n", longStrToMap)
}
```

![image-20211209122734426](go%E7%AC%94%E8%AE%B0.assets/image-20211209122734426.png)

```python
# python版本
def cal_words_times():
    # 统计"how do you do"每个单词出现的次数
    say_hi = "how do you do"
    say_hi_list = say_hi.split(" ")

    say_hi_dict = {}
    for i in say_hi_list:
        if not i in say_hi_dict:
            say_hi_dict[i] = 1
        else:
            say_hi_dict[i] += 1
    return say_hi_dict
```

![image-20211209122721022](go%E7%AC%94%E8%AE%B0.assets/image-20211209122721022.png)

> 其实能够看出来，`go`和`python`语法有较多类似的地方，核心编程思想都是一样的，就是看如何用不同语言去实现

## 八、函数

> 比较重要的语法: `函数`
>
> 支持匿名函数、闭包

### 1、函数定义

```go
// 函数格式
func 函数名(参数) (返回值) {
    函数体
}
// 函数名：见名知意的函数名
// 参数： 参数由参数名和参数变量组成，多个以逗号隔开
// 返回值：由返回值变量和其类型组成，也可以只写返回类型，多个返回值用()包裹，用逗号(,)隔开
// 函数体：具体函数代码实现
```

#### 1.1 有参数和返回值变量

> 参数可以命名也可以不命名，
> 命名的返回值：
>
> - 相当于是在函数中提前声明一遍变量，比如下面的`ret`
>   - 可以在函数中直接使用,因为在函数定义时已经声明了`ret`这个变量
>   - 并且return时不需要显式指出`ret`这个变量名，因为都在函数定义时已经指明了返回值名字叫`ret`
> - 并且需要用`括号`将命名的返回值包裹起来`(ret int)`
>   - 表示返回值的变量名是`ret`，并且是一个`int`类型
> - 当然不管是形参、还是返回值变量名可以定义，也可不定义，不定义就只写返回类型，但是需要在函数`return`时显式的指定返回值

```go
// 有参数有返回值
func f1(a int, b int) (ret int) {
	ret = a + b
	return ret
}
```

#### 1.2 函数定义变种

> 下面的几种变种都是围绕`1.1`来扩展的

##### 1.2.1 有形参但没有返回值

> 只有`形参`，没有返回值
>
> 没有返回值的函数，不能用变量接收函数，直接`函数名+()`执行就可以

```go
package main

import (
	"fmt"
)

func main() {
	add(1,2)
	add(10,20)
}

func add(a int, b int){
	c := a + b
	fmt.Printf("%v + %v = %v\n",a,b,c)
}
```

##### 1.2.2 没有形参但有返回值

> 只有返回值，没有形参

```go
package main

import (
	"fmt"
)

func main() {
	ret := add()
	fmt.Printf("ret = %v\n", ret)
}

func add() int{
	c := 1 + 3
	return c
}

```

##### 1.2.3 没有形参和返回值

```go
package main

import (
	"fmt"
)

func main() {
	add()
	// fmt.Printf("ret = %v\n", ret)
}

func add(){
	s := 45
	fmt.Printf("%v\n", s)
}
```

##### 1.2.4 返回值没有指定变量名

```go
package main

import (
	"fmt"
)

func main() {
	ret := add()
	fmt.Printf("ret = %v\n", ret)
}

func add() int{
	s := 45
	return s
}
```

##### 1.2.5 返回值有多个

> - 返回值有多个，用括号包裹，然后逗号隔开
> - 在执行函数时，返回多少个值，必须用多少个值来接收
>   - 或者考虑将多个返回值组装成`切片`或者`map`返回

```go
package main

import "fmt"

func main() {
	x,y,z := add(1,2)
	fmt.Printf("%v\n", x) // 1
	fmt.Printf("%v\n", y) // 2
	fmt.Printf("%v\n", z) // 3
}

func add(x,y int) (int,int,int) {
	z := x + y
	return x, y, z
}
```

##### 1.2.6 形参类型省略

> 当传入多个形参的类型都一样时，可以值留最后一个形参的类型，前面的都可以省略，这个只适用于同种类型

```go
package main

import "fmt"

func main() {
	ret := add(1,2)
	fmt.Printf("%v\n", ret) // 3
}

func add(x, y int) (ret int) {
	ret = x + y
	return ret
}
```

#### 1.3 可变长参数

> 很像`python`里的可变长参数`args`和`kwargs`,可以接收`n`个参数进来，接收进来是一个`切片类型`,切片的类型依据传进函数的值类型是什么就是什么类型切片
>
> 可变长参数使用三个点(`...`)表示,如下面的形参的`y`
>
> 可变长参数必须放在形参后面

```go
// 格式
func 函数名(形参 ...T)

// 形参: 形参名
// ...T: 可变长参数的类型
```

```go
package main

import (
	"fmt"
)

func main() {
	x, y := add(1,2,3)
	fmt.Printf("x = %v\n", x)
	fmt.Printf("y = %v\n", y)
}

func add(x int, y ...int) (int, []int){
	fmt.Printf("x: %v\n", x) 
	fmt.Printf("y: %v\n", y) //[2, 3]
	fmt.Printf("y type: %T\n", y) // []int
	return x,y
}
```

> 可变长参数的函数，在别的函数内部调用他的时候，因为a是一个切片，所以需要将他打散再传进去，否则传递进去的是一个切片套切片
>
> 参数打散传递进去，需要对切片使用`切片…`

```go
package main


import (
	"fmt"
)

func reciveArgs(a ...interface{}) {
	fmt.Printf("a=%v\n", a)
}

func useReciveArgs(a ...interface{}) {
	// 因为a是一个空接口类型的切片，传递给reciveArgs需要打散传递进去，使用a...
	reciveArgs(a...) // a=[19 bob [1 2 3 4]]
	
	// 如果不打散，直接传递a进去，就是会把a作为一个整体给递给reciveArgs，这不是我们想要的
	reciveArgs(a) // a=[[19 bob [1 2 3 4]]]
	
}

func main() {
	useReciveArgs(19, "bob", []int{1,2,3,4})
}
```

#### 1.4 形参没有默认值

> `go`语言中形参是没有默认值，不像`python`的函数，可以在形参指定一个默认值

#### 1.5 变量作用域

##### 1.5.1 全局作用域

> 全局作用域是指定义在函数外部区域，这里的变量可以在全局的任意位置访问到
>
> - 函数中查找变量的规则顺序：
>   1. 先在函数内部查找
>   2. 如果可以找到，就是用函数内部定义的变量
>   3. 如果找不到，那就在函数外部的全局变量查找，找到则是用
>   4. 在函数内部、函数外部都找不到，会报`undefined`的错误

```go
package main

import (
	"fmt"
)

var x int = 10  // 定义的是全局变量

func main() {
	/*
	函数中查找变量的规则顺序
	1、先在函数内部查找
	2、如果可以找到，就是用函数内部定义的变量
	3、如果找不到，那就在函数外部的全局变量查找，找到则是用
	4、在函数内部、函数外部都找不到，会报undefined的错误
	*/
	x = 123
	fmt.Printf("x=%v\n", x) // 123
}
```

> 如果变量在函数内外都没有定义，因为找不到该变量，会报`undefined`错误

```go
package main

import (
	"fmt"
)

var x int = 10  // 定义的是全局变量

func main() {
	x = 123
	fmt.Printf("x=%v\n", x) // 123
	
	// 输出变量y
	fmt.Printf("y=%v\n", y) // undefined
}
```

![image-20211213144417133](go%E7%AC%94%E8%AE%B0.assets/image-20211213144417133.png)

##### 1.5.2 局部作用域

> 局部作用域就是在函数内部区域的
>
> 局部作用域和全局作用域变量重名，优先使用局部作用域，表示是`就近原则`

##### 1.5.3 语法块作用域

> `go`语言中一些语法块也有自己的作用域，比如:`if循环`、`for循环`、`switch语句`常见的这三种
>
> 如果在语法块外部访问语法块内部的变量，都会报`undefined`错误

```go
package main

import (
	"fmt"
)

func main() {
	x := 13
	if x > 13 {
		y := 23
		fmt.Printf("y=%v\n", y) // if语句内的变量只能if语句内访问到，if外面访问不到
	}
	
	fmt.Printf("y=%v\n", y) // undefined: y

	s1 := []int{1,2,3,4,5}
	for _, v := range s1 {
		d := 99
		fmt.Printf("v=%v\n", v)
		fmt.Printf("d=%v\n", d)
	}
	fmt.Printf("d=%v\n", d) // undefined: d
	
}
```

#### 1.6 形参是函数类型

> 函数传入的形参时需要指定类型，形参的类型除了`int`/`string`/`boolean`，还可以是函数类型
>

> 那什么是函数类型？下面代码展示了什么是函数类型
>
> - 从`main`函数可以看出
>   - `f1`函数的类型是`func()`
>   - `f2`函数的类型是`func() int`
>   - `f3`函数的类型是`func(int, string) int`
> - 所以函数类型是什么依据与函数定义时，设置的形参类型和返回值类型

```go
package main

import (
	"fmt"
)


func f1() {
	fmt.Printf("这是f1")
}

func f2() int {
	x := 4
	return x
}

// 函数作为参数传入到函数里
func f3(x int, y string) int{
	fmt.Printf("x=%v\n", x)
	fmt.Printf("y=%v\n", y)
	ret := 33
	return ret
}

func main() {
	f1 := f1
	fmt.Printf("f1 = %v\n", f1) // f1的内存地址：0x108b480
	fmt.Printf("f1 Type is:%T\n", f1) // f1函数的类型: func()
	
	f2 := f2
	fmt.Printf("f2 = %v\n", f2) // f2的内存地址：0x108b4e0
	fmt.Printf("f2 Type is:%T\n", f2)// f2函数的类型: func() int
	
	f3 := f3
	fmt.Printf("f3 = %v\n", f3) // f3的内存地址：0x108b4e0
	fmt.Printf("f3 Type is:%T\n", f3)// f3函数的类型: func(int, string) int
}
```

> 知道了函数类型是什么，那么就可以将函数类型作为形参的一种类型传入函数中
>
> - 下面代码的函数`f3`定义时，给形参`x`指定的类型是`func() int`,
>   - `func() int`类型就表示形参`x`的类型是一个函数类型，并且这个函数类型本身是没有形参传入，但是有一个`int`型的返回值
>   - 执行`x()`就相当于是在执行`func() int`这个类型的函数
>     - `func() int`函数有一个返回值是2，那么`x()`的结果就是`4`,所以函数`f3`里的`ret`值就是`4`,并且`ret`是整型，所以可以作为函数`f3`的返回值

```go
package main

import (
	"fmt"
)

func f1() {
	fmt.Printf("这是f1")
}

func f2() int {
	x := 4
	return x
}

// 函数作为参数传入到函数里
func f3(x func() int) int{
	ret := x()
	return ret
}

func main() {
	f1 := f1
	fmt.Printf("f1 = %v\n", f1) // f1的内存地址：0x108b480
	fmt.Printf("f1 Type is:%T\n", f1) // f1函数的类型: func()

	f2 := f2
	fmt.Printf("f2 = %v\n", f2) // f2的内存地址：0x108b4e0
	fmt.Printf("f2 Type is:%T\n", f2)// f2函数的类型: func() int

	f3 := f3(f2)
	fmt.Printf("f3 = %v\n", f3) // f3的内存地址：0x108b4e0
	fmt.Printf("f3 Type is:%T\n", f3)// f3的类型: int
}
```

#### 1.7 函数返回值是函数类型

> 形参的类型可以使函数类型，那么函数返回值也可以是函数类型
>
> `func() int`是一种函数类型，作为了函数返回值，那么最后在`f3`返回时，就可以把符合`func() int`类型的返回值的函数返回，比如`f1`函数

```go
package main

import (
	"fmt"
)

func f1() int{
	return 33
}

func f2() int {
	x := 4
	return x
}

// 函数作为参数传入到函数里
// 返回值是函数类型
func f3(x func() int) func() int{
	return f1
}

func main() {
	f1 := f1
	fmt.Printf("f1 = %v\n", f1) // f1的内存地址：0x108b480
	fmt.Printf("f1 Type is:%T\n", f1) // f1函数的类型: func() int

	f2 := f2
	fmt.Printf("f2 = %v\n", f2) // f2的内存地址：0x108b4e0
	fmt.Printf("f2 Type is:%T\n", f2)// f2函数的类型: func() int

	f3 := f3(f2)
	fmt.Printf("f3 = %v\n", f3) // f3的内存地址：0x108b4e0
	fmt.Printf("f3 Type is:%T\n", f3)// f3函数的类型: func() int
}
```

#### 1.8 匿名函数

> - `匿名函数`出现的原因：在函数内部没法声明一个带名字的函数，但是可以声明匿名函数
> - `匿名函数`定义：
>   - 声明函数时，没有指定函数名的函数叫匿名函数
> - `匿名函数`出现的时机：一般都用在`函数内部`
> - 如果函数只调用一次，那么匿名函数可以是`立即执行函数`
>   - 立即执行函数就是在匿名函数定义后的后面放上括号表示立即执行
> - 注意：
>   - 匿名函数是不指定函数名，但是可以`带形参`和`返回值`

```go
package main

import "fmt"

func main() {
	// 声明匿名函数
	// 在函数内部定义
	f1 := func(a, b int) int{
		c := a + b
		return c
	}
    
	ret := f1(10,20)
	fmt.Printf("ret: %v\n", ret)
	
	// 如果是执行调用一次，可以定义成立即执行函数
	func (x, y int) {
		z := x + y
		fmt.Printf("z = %v\n", z)
	}(12,14)
}
```

#### 1.9 函数闭包

> `函数闭包`是指：函数与外部变量的引用，就叫闭包
>
> 闭包是指当一个函数内部有变量，并且这个函数内部的变量是引用的这个函数外部作用域的一个变量，就是闭包
>
> 常见于一个有名函数里包含了一个匿名函数，匿名函数里使用的变量引用的是有名函数定义的变量，如下代码

```go
package main

import "fmt"

func main() {
	ret := closeBag(3)
	ret() // tmp匿名函数中x的值: 3
}

func closeBag(x int) func(){
	tmp := func() {
		fmt.Printf("tmp匿名函数中x的值: %v", x)
	}
	return tmp
}
```

##### 1.9.1 类比替换形参为函数类型

> 在作用域概念里，当前函数内部引用变量时，优先在自己的函数内部找，没有找到的话，就在函数外层找
>
> - 那么类型到下面的`closeBag`函数就可以看到：
>
>   - `tmp`变量接收一个匿名函数，里面打印一个变量`x`，这个变量在这个匿名函数里没有，就会往外层找，
>
>   - 可以看到外层函数的形参就是有一个变量`x`，那么打印的就是这个形参`x`的值
>   - 从返回值可以看到变量`tmp`的值是匿名函数的`指针`(内存地址)，并且`tmp`的类型是`func()`,是一个函数类型，那么`tmp`加上括号就在执行这个匿名函数

```go
package main

import "fmt"

func main() {
	closeBag(3)
}

func closeBag(x int) {
	tmp := func() {
		fmt.Printf("tmp匿名函数: %v", x)
	}
	fmt.Printf("tmp值: %v\n", tmp) // 0x4965c0
	fmt.Printf("tmp带类型说明的值:%#v\n", tmp) // (func())(0x4965c0)

	// 表示在执行tmp这个匿名函数
	tmp() // tmp匿名函数: 3
}

/* 执行结果:
	tmp值: 0x4965c0
	tmp带类型说明的值:(func())(0x4965c0)
	tmp匿名函数: 3
*/
```

> 那么最外层的形参`x`可以是`int`类型，`x`类型替换一下就可以是`函数类型`
>
> - 要传入一个形参是函数类型，就必须先有一个这样的函数，才可以在`main`函数中进行调用，执行后才可以看到最终的效果
>   - 因为在函数`closeBag`中传入的函数类型是`func(int, int)`,那么定义这种类型的函数就是`f1`
>   - 另外`f1`函数需要接收两个`int`形参，那么在`closeBag`函数中的`tmp`匿名函数时就需要将这两个`int`形参定义
> - 然后执行`closeBag`函数时，除了需要传入符合的函数类型`func(int, int)`外，还需要传入两个`int`变量`a和b`，因为他内部的`x`需要接收两个`int`形参
> - 最后可以看到执行的结果：
>   - 先打印了： `f1函数的内部地址:0x496460`
>   - 接着打印了: `tmp值: 0x496730`
>     - 可以看到tmp的内存地址是他自己的匿名函数的内存地址
>   - 继续打印： `tmp带类型说明的值:(func())(0x496730)`
>     - 可以看到tmp的类型是`func()`,表示他是一个匿名函数类型
>   - 继续打印： `tmp匿名函数中的x: 0x496460`
>     - 注意看这里的x是`tmp`匿名函数里传入的变量`x`,并且这个变量x的值是一个指针(函数内存地址)，该`x`的值和`f1`函数的内存地址一致，那就说明`x`等价于`f1`,所以执行`x(a,b)`就等价于执行`f1(a,b)`函数
>   - 继续打印：`tmp匿名函数中的x: (func(int, int))(0x496460)`
>     - 可以看到`x`的类型是`func(int, int)`,值是`0x496460`，和`f1`函数的内存地址一致
>   - 最后打印：`4 + 5 = 9`
>     - 这里就是在执行`f1`函数里的代码
> - 至此可以看出`tmp`匿名函数就是闭包，接收外部喊出传入的参数，传入的参数类型可以使基础数据类型，也可以是函数类型

```go
package main

import "fmt"

func main() {
	fmt.Printf("f1函数的内部地址:%v\n",f1)
	closeBag(f1, 4, 5)
}

// 因为要传入一个函数类型是: func(int, int)
// 需要先定义一个符合这个类型条件的函数
func f1(a, b int) {
	fmt.Printf("%v + %v = %v\n", a, b, a + b)
}

func closeBag(x func(int, int), a, b int) {
	tmp := func() {
		fmt.Printf("tmp匿名函数中的x: %v\n", x)
		fmt.Printf("tmp匿名函数中的x: %#v\n", x)
		x(a, b)
	}
	fmt.Printf("tmp值: %v\n", tmp)
	fmt.Printf("tmp带类型说明的值:%#v\n", tmp)

	// 执行tmp这个匿名函数
	tmp()
}

/*
	执行结果：
		f1函数的内部地址:0x496460
        tmp值: 0x496730
        tmp带类型说明的值:(func())(0x496730)
        tmp匿名函数中的x: 0x496460
        tmp匿名函数中的x: (func(int, int))(0x496460)
        4 + 5 = 9
*/
```

##### 1.9.2 闭包函数分析

> 下面是闭包函数例子的一个分析

> - 下面的`addr`函数：
>   - `addr`函数自身是没有形参，`addr`函数的返回值是函数类型(`func(int) int`)，表示返回值的类型是一个函数类型，并且这个函数类型返回值自身是先形参接收一个`int`变量，然后返回值是一个`int`
>   - `addr`函数内部定义了一个`int`的`x`,赋值为`100`
>   - 使用变量`tmp`接收一个带形参以及返回值的匿名函数，最后将`tmp`值`return`返回
> - 从`addr`函数执行结果来看
>   - `ret`就是`tmp`，是`addr`函数内部定义的`tmp`这个匿名函数的内存地址，并且该匿名函数符合`func(int) int`函数类型，所以`tmp`的值是一个函数内存地址
>   - 因为`ret`的值是一个函数的内存地址，当拿到了`ret`的内存地址，要执行`ret`函数，那就按`ret`函数接收形参和返回值的格式输入对应的形参值，就可以得到返回值了
>   - 执行`ret`函数，其实就是在执行`tmp`函数，相当于执行`ret(y int) int`,就是在执行``ret(y int) int`这个函数，只需要传入给函数对应的`y`参数就可以了
>   - 最后因为`x`是100，`y`是传入的200，最后`addr`函数执行结果就是：`100 + 200 = 300`

```go
package main

import "fmt"

func main() {
	ret := addr()
	fmt.Printf("main方法执行 ret的值和类型: %#v\n", ret)

	data := ret(200)
	fmt.Printf("data是:%v\n", data)
}

func addr() func(int) int {
	var x int
	x = 100
	tmp := func(y int) int {
		x += y // x += y 等价于 x = x + y
		return x
	}

	fmt.Printf("addr函数内部 tmp的值和类型: %#v\n", tmp)
	return tmp
}

/*
	执行结果：
		addr函数内部 tmp的值和类型: (func(int) int)(0x496610)
        main方法执行 ret的值和类型: (func(int) int)(0x496610)
        data是:300
*/
```

> 既然可以在`addr`里面定义`x`，那就可以将`x`提出来，放到`addr`函数的形参里，这样是把`x`写活了，可以穿入任意的整数值
>
> 再次执行`addr`函数可以看到执行结果和上面的一样

```go
package main

import "fmt"

func main() {
	ret := addr(100)
	fmt.Printf("main方法执行 ret的值和类型: %#v\n", ret)

	data := ret(200)
	fmt.Printf("data是:%v\n", data)
}

func addr(x int) func(int) int {
	tmp := func(y int) int {
		x += y // x += y 等价于 x = x + y
		return x
	}

	fmt.Printf("addr函数内部 tmp的值和类型: %#v\n", tmp)
	return tmp
}

/*
	执行结果:
		addr函数内部 tmp的值和类型: (func(int) int)(0x496610)
        main方法执行 ret的值和类型: (func(int) int)(0x496610)
        data是:300
*/
```

> 既然`x`可以放到`addr`函数的形参里，并且类型是`int`，那么就可以对`x`类型替换为`函数类型`
>
> 分析传入形参是函数类型的`addr`函数:
>
> -  `addr`函数定义一个类型为`func(int, int) int`的形参`x`，表示传入`x`的类型一定是函数类型，这个函数类型接收两个`int`参数，并且有一个`int`类型的返回值
> -  `x`在`addr`函数内部被匿名函数使用，因为`x`本身是一个函数，所以在匿名函数内部就可以调用`x`函数，传入两个`int`形参，那这两个值就可以通过`addr`函数传入
>    -  最后tmp返回的是`addr`函数内部的匿名函数的内存地址，在`main`函数里执行`addr`函数得到匿名函数的内存地址`ret`和`addr`函数内部`temp`函数的内存地址一样，并且`addr`函数内部的匿名函数接收一个`int`类型类型的形参并且返回一个`int`类型的值
>    -  所以在`main`函数中就可以给`ret`继续传入一个`int`值
> -  最终就将`addr`执行完毕，注意给`x`传入函数时一定要符合`addr`函数中`x`的类型

```go
package main

import "fmt"

func main() {
	fmt.Printf("main方法里的f1函数: %#v\n", f1) //  main方法里的f1函数: (func(int, int) int)(0x496570)

	ret := addr(f1, 100, 200)
	fmt.Printf("main方法执行 ret的值和类型: %#v\n", ret) // (func(int) int)(0x4966b0)

	data := ret(200)
	fmt.Printf("data是:%v\n", data)
}

func f1(a int, b int) int {
	return a + b
}

func addr(x func(int, int) int, a int, b int) func(int) int {
	tmp := func(y int) int {
		fmt.Printf("tmp匿名函数中的x: %#v\n", x) // tmp匿名函数中的x: (func(int, int) int)(0x496570)
		ret := x(a, b) + y
		return ret
	}

	fmt.Printf("addr函数内部 tmp的值和类型: %#v\n", tmp) // (func(int) int)(0x4966b0)
	return tmp
}

/*
        执行结果:
           main方法里的f1函数: (func(int, int) int)(0x496570)
           addr函数内部 tmp的值和类型: (func(int) int)(0x4966b0)
           main方法执行 ret的值和类型: (func(int) int)(0x4966b0)
           tmp匿名函数中的x: (func(int, int) int)(0x496570)
           data是:500
*/
```

##### 1.9.3 闭包例子

```go
package main

import (
	"fmt"
	"strings"
)

func f1() {
	fmt.Printf("this is from f1\n")
}

func f2(x, y int) int {
	z := x + y
	return z 
}

func f3(f func()) {
	fmt.Printf("this is from f1\n")
	// 这里执行closeBag返回的匿名函数
	f()
}

func closeBag(f func(int, int) int, x int, y int) func() {
	temp := func() {
		// 这里会执行符合条件的f2函数
		ret := f(x, y)
		fmt.Printf("ret:%v\n", ret)
	}
	return temp
}

func fileSuffixData(sufstr string) func(string) string{
	temp := func(name string) string {
		if ! strings.HasSuffix(name, sufstr) {
			fmt.Printf("文件不是以%v结尾的\n", sufstr)
			fmt.Printf("传入的name:%v \t 传入的sufstr:%v\n", name, sufstr)
			name = name + sufstr
		} else {
			fmt.Printf("文件是以%v结尾的\n", sufstr)
		}
		return name
	}
	fmt.Printf("temp的值:%v\n", temp)
	return temp
}

func main() {
	// 直接执行f1函数
	f1()
	
	f1 := f1
	fmt.Printf("f1: %v\n", f1)
	fmt.Printf("f1: %#v\n", f1)
	fmt.Printf("f1的类型: %T\n", f1) //func()
	
	fmt.Println("\n\n执行闭包函数！！！！\n")
	closeBag := closeBag(f2, 10, 10)
	fmt.Printf("closeBag: %v\n", closeBag)
	fmt.Printf("closeBag Type is: %T\n", closeBag)
	
	f3(closeBag)
	
	jpgSuffix := fileSuffixData(".jpg")
	fmt.Printf("jpgSuffix值是:%v\t jpgSuffix的类型是:%T\n", jpgSuffix, jpgSuffix)
	fmt.Printf("ret:%v", jpgSuffix("name"))
}
```

#### 1.10 函数传参都是值拷贝

> 函数内部传参都是值拷贝形式
>
> - 从下面代码可以看到
>   - 当给函数`f1`传入`x`和在`main`函数里的`x`的内存地址不一样
>   - 所以函数`f1`对`x`的修改只发生在函数内部，退出函数后原来的`x`值不会变
> - 这就是值拷贝

```go
package main

import "fmt"

var (
	strData string
	intData int
	boolData bool
)

func main() {
	// 当传给函数的形参是一个变量时，该变量是值拷贝
	x := 3
	fmt.Printf("f1函数外传递进来的x的内存地址: %p\n", &x)
	f1 := f1(x)
	fmt.Printf("%v\n", f1)             // 结果是: 4
	fmt.Printf("f1函数外最后x的值是: %v\n", x) // 结果是: 3
}

func f1(x int) int{
	// 函数内传参都是值拷贝，所以函数内x的值变化不会影响函数外x的值
	fmt.Printf("f1函数内传递进来的x的内存地址: %p\n", &x)
	x += 1
	return x
}
```

#### 1.11 `defer`关键字

> - defer主要是用来回收资源
>
> - 一个函数中有多个defer存在时，是以`栈(先进后出)`的形式运行，先执行最后一个defer函数，依次反着来

```go
package main

import "fmt"

func main() {
	defer fmt.Printf("第一个defer\n")
	defer fmt.Printf("第二个defer\n")
	defer fmt.Printf("第三个defer\n")
}
```

![image-20220104143521838](go%E7%AC%94%E8%AE%B0.assets/image-20220104143521838.png)

> `defer`主要用于延迟执行，清理回收资源等，在遇到defer语句时：
>
> - 先将该条defer语句后面的代码存起来，不执行
> - 然后继续往下走，当其他代码都执行完以后，再来执行defer语句的代码
>
> 在`go`语言中，`return`在返回值时分为两步：
>
> - 第一步先给返回值赋值
> - `defer`语句就在第一步和第二部中间
> - 第二步给`RET`指令执行返回值

##### 1.11.1 defer例子分析

```go
package main

import "fmt"

func main() {
	fmt.Println(f1())
	fmt.Println(f2())
	//fmt.Printf(f3())
	//fmt.Printf(f4())
}

// f1函数
/*
	rval = x, x = 5, rval = 5
	defer语句中x ++ , x = 6, rval没变
	ret指令返回rval的值就是5
*/
func f1() int {
	x := 5
	defer func() {
		x++
	}()
	return x
}

/*
  f2函数的返回值有显示声明，那么ravl就是x
  这里还涉及到了闭包，所以ret指令返回x的值是为6
  x(rval) = 5
  defer语句中x++，那么 x=6
  ret指令返回 x(ravl)=6
*/
func f2() (x int) {
	defer func() {
		x++
	}()
	return 5
}

/*  f2函数的返回值有显示声明，那么ravl就是y
	return x 就表示 y(rval)等x的值5， 所以 y(rval) = 5
	defer 里对x进行了x++ ,但是 y的值没有变
	ret指令返回y(rval)=5
*/
 */
func f3() (y int) {
	x := 5
	defer func() {
		x ++
	}()
	return x
}

/*
	 f4函数的返回值有显示声明，那么ravl就是x
	return 5就表示 x(rval) = 5
	defer 语句里将x传入，但是函数形参传值都是值拷贝，所以defer里面x++是对x的副本进行了x++，原本x的值不变
	ret指令返回 x(rval)还是等于5
*/
func f4() (x int) {
	defer func(x int){
		x++
	}(x)
	return 5
}
```

##### 1.11.2 defer例子分析二

```go
package main

// Go 语言的 func 声明中如果返回值变量显示声明，也就是 func foo() (ret int) {} 的时候，rval 就是 ret
// rval就等于i的值，等于5
// defer中对i进行了i++, 但是rval仍是5没变
// ret指令返回rval就是5
func f() int {
	i := 5
	defer func() {
		i++
	}()
	return i
}

// f1函数的返回值变量有显示声明为result，所以rval就是result
// 所以result(ret) = 0
// defer 里面对 result ++ ， result = 1
// ret指令返回result(ret)就是1
func f1() (result int) {
	defer func() {
		result++
	}()
	return 0
}

// f2函数的返回值变量有显示声明为r，那么rval就是r
// 那么r(rval) = t = 5，此时r(rval)的值已经确定为5
// defer 里再对 t = t + 5，但是r(rval)的值不会再变，修改的是t的值，不是r(rval)的值
// ret指令返回r(rval)就是5
func f2() (r int) {
	t := 5
	defer func() {
		t = t + 5
	}()
	return t
}

func main() {
	println(f())  // 5
	println(f1()) // 1
	println(f2()) // 5
}
```

##### 1.11.3 defer例子分析三

```go
package main

import "fmt"

func main() {
	a := 1
	b := 2
	defer calc("10", a, calc("10", a, b))
	a = 0
	defer calc("20", a, calc("20", a, b))
	b = 1
}

func calc(index string, a, b int) int{
	ret := a + b
	fmt.Printf("%#v %#v %#v %#v\n",index, a, b, ret)
	return ret
}
// 第一个defer: defer calc("10", a, calc("10", a, b))
// 先执行defer中的calc函数: calc("10", a, b) ==> calc("10", 1, 2) => return得到3，打印 "10", 1, 2, 3
// 第一个defer就变成了: defer calc("10", 1, 3) 此时的defer先不执行存起来

// 接着执行第二个defer: defer calc("20", a, calc("20", a, b))，并且a重新赋值为0, b仍等于2
// 同样先执行第二个defer中的calc函数: calc("20", a, b) ==> calc("20", 0, 2) ==> return得到2， 打印"20", 0, 2, 2
// 第二个defer就变成了: defer calc("20", 0, 2) 此时的defer也先不执行存起来

// 接着继续往下走，将b重新赋值为了1
// 再执行defer语句,有多个defer语句时,逆序执行defer语句代码
// 所以第二个defer语句先执行, defer calc("20", 0, 2) ==> 打印"20", 0, 2, 2
// 接着第二个defer语句执行, defer calc("10", 1, 3) ==> 打印"10", 1, 3, 4

// 最后输出结果就是依次就是
/*
"10", 1, 2, 3
"20", 0, 2, 2
"20", 0, 2, 2
"10", 1, 3, 4
*/
```

#### 1.12 常见内置函数

> 常见的有
>
> - `close`关闭`channel`
> - `len`用来求长度，比如`string/array/slice/map/channel`
> - `new`用来分配内存，主要是分配值类型，比如`int/struct`，返回的是指针
> - `make`用来分配内存，只要用来分配引用类型，比如`channel/map/slice`
> - `append`用来追加元素到数组、切片中
> - `panic`和`recover`用来错误处理

##### 1.12.1 panic

> 用来引出错误，类似于`python`的`raise`，主动抛出错误，表示程序出现严重错误
>
> 比如数据库连接失败

```go
package main

func main() {
	panicStu()
}

func panicStu() {
	panic("哈哈哈，出错了")
}

// 输出
```

![image-20220113232527069](go%E7%AC%94%E8%AE%B0.assets/image-20220113232527069.png)

##### 1.12.2 recover

> 用来出现错误时，恢复程序
>
> 还是少用

```go
package main

import "fmt"

func main() {
	panicStu()
}

func panicStu() {
	defer func() {
		err := recover()
		fmt.Printf("err: %v\n", err)
		fmt.Printf("释放数据库连接")
	}()
	panic("数据库连接失败")
	fmt.Printf("outer")
}

/* 输出
err: 数据库连接失败
释放数据库连接
*/
```

#### 1.13 `fmt `包使用总结

##### 1.13.1 打印方法

> 常见的有三种：
>
> - `print`
> - `printf`
> - `println`
>
> 常用的fmt包输出格式：
>
> - `%v`:是万能输出变量的值，任何类型变量都可以输出
> - `%#v`:输出变量并且与变量的类型
> - `%T`:查看变量的类型
> - `%s`:输出字符串
> - `%d`:输出数字
> - `%p`:输出内存地址
>   - `fmt.Printf("%p\n", &name)`
> - `%f`:输出浮点值
>   - `%.2f`：默认宽度，精度为2(就是小数点后面留两位)

```go
package main

import "fmt"

func main() {
    s1 := 100
    // 查看变量的类型
    fmt.Printf("%T\n", s1) // int

    // 查看变量的值，任何类型都可以看
    fmt.Printf("%v\n", s1) // 100

    // 输出整型的值
    fmt.Printf("%d\n", s1) // 100

    // 将10进制转换为2进制
    fmt.Printf("%b\n", s1) // 1100100

    // 将10进制转换为8进制
    fmt.Printf("%o\n", s1) // 144

    // 将10进制转换为16进制
    fmt.Printf("%x\n", s1) // 64

    // 输出字符,常用与for循环内输出每个元素值
    fmt.Printf("%c\n", s1)

    s2 := "bob"
    // 输出字符串的值
    fmt.Printf("%T\n", s2) // string
    fmt.Printf("%s\n", s2) // bob
    fmt.Printf("%#v\n", s2) // "bob" 即输出了值，也输出了类型
    
    s3 := 12.34
    // 输出浮点值
	fmt.Printf("%f\n", s3) // 12.340000
}
```

##### 1.13.2 获取输入

> `fmt`包可以获取标准输入，类似于`python`的`input`函数
>
> 常见的有三种
>
> - `fmt.Scan` 
>   - 会从标准输入扫描文本，读取空白符分隔的值保存到传递给`Sacn`函数的参数中，换行符为空白符
>   - `Sacn`函数返回成功扫描的数据个数和遇到的任何错误，如果读取的数据个数比提供的参数要，会返回一个错误原因
> - `fmt.Scanf`用法和`Scan`一样
> - `fmt.Scanln`用法和`Scan`一样

```go
// fmt.Scan代码
package main

import "fmt"

func main() {
	var s string
	v, err := fmt.Scan(&s)
	fmt.Printf("v=%v\n, err=%v\n", v, err)
	fmt.Printf("您输入了: %v\n",s)
}
```

> `fmt.Scan`上面代码分析：
>
> - 先定义了一个`s`变量，`s`的值是零值("")
> - 然后将`s`的内存地址传给`Sacn`完成读取
>   - 为什么要传`s`的内存地址？
>     - 因为`Scan`会把标准输入获得的值保存到传递给`Sacn`函数的参数`s`，如果不传入`s`的内存地址，而是直接把`s`传入，那么会直接将`s`的值输出，而不会进行等待标准输入
>     - 只有传入了内存地址，才可以对`s`的原有值进行重新赋值（保存值），这样最后输出的时候才是我们从标准输入里输入的值
> - 如果不传`s`的内存地址，就会报下面的错误，可以看到`Scan`也抛出了`string`类型不是一个指针

![image-20220114000247128](go%E7%AC%94%E8%AE%B0.assets/image-20220114000247128.png)

##### 1.13.3 输入有空格问题解决

> 当标准输入的有空白符时，就会在输出时，只展示第一个空白符的前面的内容
>
> 为了解决这个问题，可以用bufio包来解决

```go
/*
  @Author: lyzin
    @Date: 2022/02/17 22:51
    @File: basic_study
    @Desc: 
*/
package main

import (
	"fmt"
	"bufio"
	"os"
)

func main() {
	var s string
	reader := bufio.NewReader(os.Stdin)
	fmt.Print("请输入内容:")
	// 注意这里不需要短变量声明，而是直接用定义的s变量进行接收输入的内容
	s, _ = reader.ReadString('\n')
	fmt.Printf("你输入了: %v\n", s)
}
```

![image-20220220213806001](go%E7%AC%94%E8%AE%B0.assets/image-20220220213806001.png)

#### 1.14 递归函数

> 递归就是函数自己调用自己
>
> `go`语言中的递归
>
> - 递归适合处理问题规模相同，规模越来越小的场景
> - 需要对递归设置退出条件，否则会出现无限循环

```go
package main

import "fmt"

func main() {
	f := jiechen(3)
	fmt.Printf("f:%v\n", f)
}

// 阶乘
// 5！ = 5 x 4 x 3 x 2 x 1 = 5 x 4!
// 4！ = 5 x 4 x 3 x 2 x 1 = 4 x 3!
// 3！ = 5 x 4 x 3 x 2 x 1 = 3 x 2!
func jiechen(n uint64) uint64 {
	if n <=1 {
		return 1
	}
	ret := n * jiechen(n-1)
	return ret
}
```

##### 1.14.1 递归例子

> 上台阶问题

```go
package main

import "fmt"

func main() {
	f := step(3)
	fmt.Printf("f:%v\n", f)
}

// n个台阶，一次走1步，也可以走2步，有多少走法
//
func step(n uint64) uint64 {
	if n == 1 {
		// 只有一个台阶
		return 1
	}
	if n == 2 {
		// 走法1： 一步跨过2个
		// 走法2： 一步一个台阶
		// 总共2种走法
		return 2
	}
	ret := step(n-1) + step(n-2)
	return ret
}
```

#### 1.15 练习题

> 统计字符串里中文字符出现的次数

```go
package main

import (
	"fmt"
	"unicode"
)

func main() {
	// 判断字符串中汉字的字符数量
	// 思路：
	// 1、拿到字符串的字符
	// 2、判断字符串是否是汉字
	// 3、然后统计中文字符出现的次数
	s := "hello新年是新的年"
	
	ret := 0
	// 1、拿到字符串的字符
	for _, v := range s {
		// 2、判断字符串是否是汉字
		if unicode.Is(unicode.Han, v) {
			ret += 1
		} else {
			continue
		}
	}
	
	fmt.Printf("中文字符出现次数:%v\n", ret) // 6
}
```

## 九、结构体

### 1、自定义类型

> `go`语言中可以在内置类型基础上，自定义自己的类型，用`type`关键字来声明

```go
// 自定义类型格式
type 自定义类型名 T

T表示内置的类型，比如int/string/bool
```

```go
package main

import "fmt"

type myint int

func main() {
	var s myint
	s = 10
	fmt.Printf("s: %v\n", s) // 10
	fmt.Printf("s: %T\n", s) // main.myint属于main函数里的myint类型
}
```

### 2、类型别名

> 可以对原有的内置数据类型起一个别名，在函数中可以用类型别名来代替原有类型名
>
> - 类型别名只在定义的程序中有效
>
> - 比如`rune`就是`int32`的类型别名，底层里`rune`用来表示字符

```go
package main

import "fmt"

// 表示给int类型起了个名字
type myint = int

func main() {
	var s myint
	s = 10
	fmt.Printf("s: %v\n", s) // 10
	fmt.Printf("s: %T\n", s) // 本质还是int

	var m rune
	m = '中'
	fmt.Printf("m: %v\n", m) // 20013
	fmt.Printf("m: %T\n", m) // 本质还是int32
}
```

### 3、结构体

> 在`go`语言中，基础数据类型只能表示单一的属性，当我们需要表示复杂数据属性时，就显得不够用了，所以`go`语言中有一个自定义数据类型，可以用来封装多个基础数据类型，这种类型被称为`结构体(struct)，用来表示混合数据类型
>
> - 结构体用来对标其他语言的面向对象
>   - 结构体是一片连续的内存地址	
> - 结构体类似于其他语言的面向对象编程，有`构造函数`、`方法`这种语法
> - 内置的基础数据类型是用来描述一个值的，而结构体是用来描述一组值的
>   - 比如一个人有名字、年龄、兴趣爱好等属性，本质上是一种聚合型的数据类型，就可以用结构体来表示

```go
// 使用type和struct关键字来定义结构体，具体代码格式如下：
type 类型名 struct {
    字段名 字段类型
    字段名 字段类型
    …
}

/*
	其中：	
		类型名：标识自定义结构体的名称，在同一个包内不能重复。
		字段名：表示结构体字段名。结构体中的字段名必须唯一。
		字段类型：表示结构体字段的具体类型。
*/
```

#### 3.1 结构体定义

> 下面代码就是表示定义一个结构体

```go
package main

import (
	"fmt"
)

type person struct {
	name string
	age int
	hobby []string
}

func main() {
	fmt.Printf("%v\n", person)
}
```

> 注意：
>
> - 定义好的结构体不能直接打印，会提示不是一个表达式
> - 需要使用给一个变量定义为定义好的结构体类型，再去打印就可以正常展示

![image-20220117183743359](go%E7%AC%94%E8%AE%B0.assets/image-20220117183743359.png)

##### 3.1.1 同类型字段一行定义

> 结构体定义时，类型一样的多个值可以写在一行，和函数定义多个类型一样的形参一样
>
> 比如下面的`name`,`gender`都是`string`类型，所以可以定义在一行

```go
package main

import (
	"fmt"
)

type person struct{
	name, gender string
	age int
}

func main() {
}
```

##### 3.1.2 结构体字段默认为零值

> 定义好结构体后：
>
> - 给一个变量指定为定义好的结构体类型，但是没有对该变量进行结构体的初始化，也就是没有给结构体里面的对应字段给值，那么结构体类型里对应字段的值就是字段定义时类型的零值(默认值)
> - 比如下面的p1定义为person类型后，此时p1的类型就是person这个结构体类型了，但是没有对p1，而是直接打印p1
>   - 那么p1的值和类型就是：`main.person{name:"", age:0}`

```go
package main

import (
	"fmt"
)

type person struct{
	name string
	age int
}

func main() {
	var p1 person
	fmt.Printf("p1=%#v\n", p1)
	fmt.Printf("p1=%T\n", p1)
}
```

![image-20220421171413351](go%E7%AC%94%E8%AE%B0.assets/image-20220421171413351.png)

> 从上面的结果可以看出：
>
> - p1里的name字段的值为string类型的零值(空字符串)
> - p1里的age字段的值为int类型的零值(0)
> - p1的类型就是main包的person结构体类型

##### 3.1.3 某个变量为结构体类型理解

> 当某个变量定义为结构体类型的理解：
>
> - 将某个变量类型指定为结构体类型，可以类比到其他语言中的面向对象知识
>   - person结构体就是定义了一个类名为`person`的类，
>   - 指定p1这个变量的类型为结构体`person`时，就是对`person`这个类的进行了初始化，并且将初始化的结果指向了p1，所以p1也就是`person`类的实例对象
>   - 这个p1实例对象定义为person类型时，就是生成了p1这个实例对象，并且将p1这个对象里的name、age字段自动设置为字段类型的零值，后面可以对字段值重新赋值，重新赋值就是结构体的初始化了
> - 从下面的python的面向对象代码对比过来理解
>   - 对一个变量类型定义为结构体类型，就是在使用这个结构体，也就是将一个变量进行类的实例化，不过是实例化过程中，将结构体定义的字段值默认设置为类型零值
>   - 最终变量的类型就是结构体的类型，也就是python里定义的类的类型
>   - 从下面代码可以清晰看出来
> - 所以针对结构体的理解，就可以对比面向对象的知识来理解

```python
# 下面是python的面向对象，可以类比来理解变量类型为结构体类型
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age

    def show_data(self):
        print(f"name={self.name}, age={self.age}")

# 直接打印定义好的类Person，返回的值就是:Person = <class '__main__.Person'>
print(f"Person = {Person}") 

# 初始化一个a1对象，可以理解为是将a1的类型指定为类Person，并且传入两个预设字段name、age，完成类A的初始化
a1 = Person("sam", 19)

# 打印a1，可以看到a1的值就是通过类Person初始化的一个对象，并且a1这个变量有实际的内存地址
# a1 = <__main__.Person object at 0x7fa09295a630>
print(f"a1 = {a1}")

# 打印a1类型，可以看到a1的类型就是类Person这个类
 # a1 = <class '__main__.Person'>
print(f"a1 = {type(a1)}")
```

```go
// go语言定义结构体
package main

import (
	"fmt"
)

// 定义一个person结构体，也就是定义一个名字叫person的类
type person struct{
	name string
	age int
}

func main() {
  // 对变量p1的类型定为person，就表示是在对person类进行初始化，并且将初始化的值给p1
  // 类比到python就是 p1 = person("", 0)
  // 传入的是结构体字段类型的零值
	var p1 person
  
  // 可以看到p1是person结构体实例对象，并且name是空，age是0
	fmt.Printf("p1=%#v\n", p1) // p1=main.person{name:"", age:0}
	
  // 可以看到p1的类型就是结构体类型
  fmt.Printf("p1=%T\n", p1) // p1=main.person
}
```

> 综上：
>
> - 定义一个结构体就是声明了一个类
> - 给一个变量声明了类型为定义的结构体，就是在实例化这个结构体，并且结构体的字段值都是对应类型的零值
>   - `var p1 person`等价于python面向对象中的`a1 = A("sam", 19)`，表示在实例化对象p1
> - 这个变量的类型就是定义的结构体的类型

#### 3.2 结构体初始化

> 1. `type 结构体 struct{}`
>    1. 定义结构体，表示声明了一个结构体
> 2. `var s 结构体`
>    1. 表示在实例化这个结构体，并将实例化结果赋值给变量s
>    2. 此时变量s就可以访问这个结构体的属性和方法了
> 3. 为什么要对结构体初始化?
>    1. 因为指定变量类型为结构体以后，这个变量就是结构体的实例对象，这个变量实例对象里的属性值都是初始零值，零值不是我们需要的
>    2. 所以需要进行初始化，给实例对象里对应字段指定我们需要的值

##### 3.2.1 key-value初始化(常用)

> 以key-value进行结构体初始化，类似于python字典的形式来指定结构体字段和值
>
> - 指定p1类型为person结构体，然后p1接收person结构体以key-value初始化，最终p1就是初始化好的结构体

```go
package main

import (
	"fmt"
)

type person struct{
	name string
	age int
}

func main() {
	var p1 person
  // 以key-value进行结构体初始化
	p1 = person{
		name: "sam",
		age: 29,
	}
	fmt.Printf("p1=%+#v\n", p1)
}

/* 
	执行结果:
	p1=main.person{name:"sam", age:29}	
*/

```

##### 3.2.2 值列表形式初始化

> 值列表形式进行初始化，值的顺序必需要和结构体定义时字段的顺序一致

```go
package main

import (
	"fmt"
)

type person struct{
	name string
	age int
}

func main() {
	var p1 person
  // 值列表形式进行初始化，值的顺序必需要和结构体定义时字段的顺序一致
	p1 = person{
		"sam",
		29,
	}
	fmt.Printf("p1=%+#v\n", p1)
}

/* 
	执行结果:
	p1=main.person{name:"sam", age:29}	
*/
```

> 值列表初始化结构体的值顺序不能乱写，否则会报错，提示类型不匹配

```go
package main

import (
	"fmt"
)

type person struct{
	name string
	age int
}

func main() {
	var p1 person
	p1 = person{
		29,
		"sam",
	}
	fmt.Printf("p1=%+#v\n", p1)
}
```

![image-20220422133536902](go%E7%AC%94%E8%AE%B0.assets/image-20220422133536902.png)

##### 3.2.3 注意事项

> key-value初始化和值列表初始化不能混合使用
>
> 报错提示：`mixture of field:value and value initializers（混合字段:值和值初始化式）`
>
> 结构体初始化除了key-value初始化和值列表初始化，还由比较推荐使用的构造函数初始化，详见3.8

```go
package main

import (
	"fmt"
)

type person struct{
	name string
	age int
}

func main() {
	var p1 person
	p1 = person{
    // name是key-value初始化
		name: "sam",
    // 单独19是值列表初始化
		19,
	}
	fmt.Printf("p1=%+#v\n", p1)
}
```

![image-20220422133924394](go%E7%AC%94%E8%AE%B0.assets/image-20220422133924394.png)

#### 3.3 访问结构体定义字段

> 使用点(`.`)的方式来访问结构体定义的字段

```go
package main

import (
	"fmt"
)

// 定义结构体
type person struct {
	name string
	age int
	hobby []string
}

func main() {
	var p person
	// 通过字段去赋值
	p.name = "sam"
	p.age = 18
	p.hobby = []string{"ft", "bt"}
	fmt.Printf("%v\n", p) // {sam 18 [ft bt]}
	fmt.Printf("%T\n", p) // main.person
	
	fmt.Printf("p.age=%v\n", p.age) // 18
	fmt.Printf("p.hobby=%v\n", p.hobby) // [ft bt]
}
```

#### 3.4 匿名结构体

> 没有名字的匿名结构体，需要先声明，再初始化，常用与临时场景：
>
> - 只用一次就可以使用匿名结构体
> - 匿名结构体的类型是:`struct { name string; age int }`

```go
package main

import (
	"fmt"
)

func main() {
	var s struct{
		name string
		age int
	}
	s.name = "哈哈"
	s.age = 1
	fmt.Printf("s=%v\n",s) // {哈哈 1}
	fmt.Printf("s=%T\n",s) // struct { name string; age int }
	fmt.Printf("s.name=%v\n", s.name) // 哈哈
}
```

#### 3.5 结构体是值类型

> 值类型就是表示是`原有值的复制和拷贝`
>
> - `go`语言中函数的形参传值都是值拷贝，就是通过形参传进来的值的一个副本，二者的内存地址是不一样的，修改了函数内的变量的值，函数外的值是不会变得
> - 所以想要变化的话，需要传入内存地址，也就是指针，才可以进行修改

> 下面代码就可以看到，`f1`函数里对`person`类型的结构体的`age`值重新赋值，但是`f1`函数外面的`p.age`和`f1`函数内的`x.age`内存地址是不一样的，所以无法进行修改

```go
package main

import (
	"fmt"
)

type person struct {
	name string
	age int
}

func f1(x person){
	fmt.Printf("x.age=%p\n", &x.age) // x.age=0xc00000c058
	x.age = 19
}

func main() {
	var p person
	p.name = "sam"
	p.age = 10
	f1(p)
	fmt.Printf("p=%v\n", p) // p={sam 10}
	fmt.Printf("p.age=%v\n", p.age) // p.age=10
	fmt.Printf("p.age=%p\n", &p.age) // p.age=0xc00000c040
}
```

> 所以一定要修改`age`的值，必须在`f1`函数x的类型必须是`person`的指针类型，因为`person`类型的结构体的内存地址的类型就是`*person`
>
> - `f2`函数中`(*x).age=19`：表示根据内存地址找到原始变量，然后修改的就是原始的变量
> - 并且`go`语言中，有语法糖，所以`(*x).age=19`也可以写成`x.age=19`，语法糖会自动根据指针找到对应的变量

```go
package main

import (
	"fmt"
)

type person struct {
	name string
	age int
}

func f1(x person){
	x.age = 19
}

func f2(x *person){
	fmt.Printf("x.age addr=%p\n", &(x.age))
	(*x).age = 19 
}

func main() {
	var p person
	p.name = "sam"
	p.age = 10
	f2(&p)
	fmt.Printf("p=%v\n", p) // p={sam 19}
	fmt.Printf("p.age addr=%p\n", &(p.age)) // p.age=19
	fmt.Printf("p.age=%v\n", p.age) // p.age=19
}
```

#### 3.6 结构体指针

##### 3.6.1 new关键字创建结构体指针

> 可以通过`new`关键字对结构体进行实例化，得到的是结构体的地址

```go
package main

import "fmt"

type person struct {
	name string
	age int
}

func main() {
	// new返回的是对应类型的指针
	var p1 = new(person)
	p1.name = "age"  // 这里的p1本写全了应该是(*p1).name = "age",但是go语言有语法糖，所以可以省略简写: p1.name = "age"
	p1.age = 12
	fmt.Printf("p1:%#v\n", p1) // &main.person{name:"age", age:12}  这是打印p1变量的类型和他所表示值，但是要真正打印出内存地址，需要使用%p
	fmt.Printf("p1 type:%T\n", p1) // *main.person
	fmt.Printf("p1:%p\n", p1) // 因为new返回的是对应类型的指针，所以这里p1保存的值就是一个内存地址:0xc000068420
	fmt.Printf("%p\n", &p1) // 这是求出p1变量的内存地址:0xc00009e018
}
```

> 指针的存储示意图
>

```go
package main

import (
	"fmt"
)

func main() {
	var a int
	a = 100
	b := &a
	// a type: int, b type: *int，b的类型是 int类型的指针
	fmt.Printf("type a:%T\t type b:%T\n", a, b)
	// 将a的十六进制内存地址打印
	fmt.Printf("%p\n", &a) // 0xc000072080表示a的内存地址
	fmt.Printf("%v\n", b) // b本身的值是0xc000072080，也是a的内存地址
	fmt.Printf("%p\n", &b) // 0xc00009e018表示b的值(0xc000072080)的内存地址
}
```

![image-20220130225728855](go%E7%AC%94%E8%AE%B0.assets/image-20220130225728855.png)

##### 3.6.2 快速获取结构体指针(常用)

> 一般在`go`中，快速获取结构体指针的方式就可以在`初始化结构体`的时候加一个`取址符号(&)`,就可以快速获取到结构体的指针
>
> 可以看到下面代码就是在初始化定义结构体的时候加了一个取址符号：
>
> - p1的值就是一个十六进制的内存地址
> - p1的类型就是对应person类型的指针类型

```go
package main

import (
"fmt"
)

type person struct{
	name string
	age int
}

func main() {
  // 获取结构体的指针
	p1 := &person{
		"sam",
		19,
	}
	fmt.Printf("%p\n", p1) // 0xc000004480
	fmt.Printf("%T\n", p1) // *main.person
}
```

#### 3.7 结构体在内存是连续的

> 结构体在内存中占用的内存空间是连续的
>
> 从下面代码可以看到`a、b、c`是连续的，`d`没有连续，这是因为`go`语言中有内存地址对齐的概念，后面再解释

```go
package main

import (
"fmt"
)

type number struct{
	a int8
	b int8
	c int8
	d string
}

func main() {
	p1 := number {
		a: 10,
		b: 20,
		c: 30,
		d: "kim",
	}

	fmt.Printf("%p\n", &(p1.a)) // 0xc000068420
	fmt.Printf("%p\n", &(p1.b)) // 0xc000068421
	fmt.Printf("%p\n", &(p1.c)) // 0xc000068422
	fmt.Printf("%p\n", &(p1.d)) // 0xc000068428
}
// 执行结果
/*
	0xc000068420
    0xc000068421
    0xc000068422
    0xc000068428
*/
```

#### 3.8 结构体构造函数(推荐初始化方式)

> 结构体初始化的时候，除了可以使用变量初始化，也可以使用函数初始化，这个函数就是构造函数，在其他语言里有这个内置的函数，比如python面向对象的`__init__`方法
>
> 1. 构造函数返回一个结构体变量的函数
>2. 构造函数的存在就是为了简化结构体初始化过程，将重复要写的一些代码简化，通过函数来实现结构体初始化
> 3. 核心思想：调用构造函数时，可以立刻返回一个定义好的结构体类型的变量
>4. 构造函数一般是以`new和结构体变量首字母大写`的函数，返回的也是结构体变量

```go
package main

import (
"fmt"
)

type person struct{
	name string
	age int
}

// person结构体构造函数
func newPerson(name string, age int) person{
	return person{
		name: name,
		age: age,
	}
}

func main() {
	p1 := newPerson("sam", 19)
	fmt.Printf("p1=%v\n", p1)
}
```

##### 3.8.1 构造函数返回结构体指针

> 1. 构造函数什么时候返回结构体变量？
>    - 当结构体定义的字段个数比较少的时候后，可以考虑在构造函数返回结构体变量
> 2. 构造函数为什么要返回结构体指针？
>    - 因为结构体属于值类型，就是赋值和传参的时候都是值拷贝
>    - 当定义的结构体字段比较多的时候，结构体本身占用的内存资源就比较多，如果构造函数使用值拷贝的形式，在使用构造函数进行初始化结构体的时候，就会出现结构体会拷贝较多份，额外的占用内存资源
>    - 所以为了减少内存资源占用，推荐在构造函数返回结构体指针
>    - 因为返回结构体指针，其实就是是返回了一个十六进制的数，对一个十六进制的数来回使用，就不会有很大的内存占用
> 3. 构造函数什么时候要返回结构体指针？
>    - 当结构体定义的字段数量比较多的时候，推荐使用构造函数返回结构体指

```go
package main

import "fmt"

type person struct{
	name string
	age int
}

func newPerson(name string, age int) *person{
	return &person{
		name: name,
		age: age,
	}
}

func main() {
	p1 := newPerson("sam", 19)
	
	// 直接打印p1：&{sam 19}
	fmt.Printf("直接打印p1：%v\n", p1)
	
	// p1的类型：*main.person
	fmt.Printf("p1的类型：%T\n", p1)
	
	// p1的内存地址：0xc00000c030
	fmt.Printf("p1的内存地址：%p\n", p1)
	
	// p1原本的值：{sam 19}
	fmt.Printf("p1原本的值：%v\n", (*p1))
}
```

> 结论：
>
> 1. 构造函数返回类型为结构体指针时，初始化的实例变量`p1`的值就是`person`结构体的指针
>    1. 可以看到打印`p1`的类型就是`*main.person`类型的指针
>    2. 既然p1是指针，那么就可以通过`%p`读取到p1的内存地址值
>    3. 并且可以通过`*p1`拿到`p1`这个内存地址对应的原始值：{sam 19}
> 2. 从上面看出，当构造函数返回指针类型时，初始化的变量本身就是结构体的指针类型

##### 3.8.2 结构体指针访问成员变量

> 从3.8.1可以看到构造函数返回指针类型时，初始化的变量本身就是结构体的指针类型，那么访问该结构体实例对象的成员变量时：
>
> - 需要带`(*p1).name`，表示通过p1先拿到p1这个内存地址对应的实际的结构体的值，再来访问`p1`结构体里的name字段
> - 不过go语言中做了优化
>   - 在Go语言中支持对结构体指针直接使用(`.`)来访问结构体的成员，而不需要显式的加`*`来获取到指针指向的原始值，再来调用成员变量

```go
package main

import "fmt"

type person struct{
	name string
	age int
}

func newPerson(name string, age int) *person{
	return &person{
		name: name,
		age: age,
	}
}

func main() {
	p1 := newPerson("sam", 19)
	
	// p1原本的值：{sam 19}
	fmt.Printf("p1原本的值：%v\n", (*p1))
	
	// 原始值访问成员变量
	// p1.name原本的值：sam
	fmt.Printf("p1.name原本的值：%v\n", (*p1).name)
	
  // 指针访问成员变量
	// p1.name的值：sam
	fmt.Printf("p1.name的值：%v\n", p1.name)
}
```

#### 3.9 方法和接收者

> 结构体里的方法对标的是其他语言中面向对象的方法，比如`python`面向对象里的方法
>
> - 方法是作用于特定类型的函数
>   - 特定类型就是需要限定类型，限定的类型就是我们定义的结构体类型
>
> - 接收者是调用该方法的具体类型变量，多用类型名首字母小写
>
> 下面代码里的`方法(p person)就是接收者`,`p`就是表示接收者，表示传入的是结构体对象，一般是用定义的结构体的首字母来作为形参

> 格式：
>
> func (结构体首字母 结构体类型) 函数名(参1，参2){
>
> }

```go
package main

import (
"fmt"
)

type person struct{
	name string
	age int
}

// 构造函数
func newPerson(name string, age int) person{
	return person{
		name: name,
		age: age,
	}
}

// 方法walk，(p person)就是接收者
func (p person) walk() {
	fmt.Printf("%s年龄是%d岁\n", p.name, p.age)
}

func main() {
	p1 := newPerson("sam", 19)
	fmt.Printf("p1=%v\n", p1)
	p1.walk()
}
```

##### 3.9.1 值接收者

> 结构体方法里的接收者如果是值类型时
>
> - 表示接受者是以拷贝的形式传进到方法里，那么方法里的接受者(初始化时得到的结构体对象)是一个拷贝的对象
>   - `拷贝的是实例化的结构体对象`
> - 即使在方法里对结构体对象的某个属性进行了修改，但是这个结构体本身的这个属性是不会变化的，因为值接收者就是复制拷贝，值拷贝的内存地址是完全不一样

```go
package main

import (
	"fmt"
)

type person struct{
	name string
	age int
}

func newPerson(name string, age int) person {
	return person{
		name: name,
		age: age,
	}
}

func (p person) newYear() {
	// p1在newYear方法的内存地址：0xc000118030
	fmt.Printf("p1在newYear方法的内存地址：%p\n", &p)
	p.age += 1
}

func main() {
	// 初始化结构体得到p1对象
	p1 := newPerson("sam", 19)
	
	// p1的值: {sam 19}
	fmt.Printf("p1的值: %v\n", p1)

	// p1在初始化后的内存地址: 0xc000118000
	fmt.Printf("p1在初始化后的内存地址: %p\n", &p1)

	p1.newYear()
	// 过了一年, p1.age:19
	fmt.Printf("过了一年, p1.age: %v\n", p1.age)
}
```

> 从上面代码可以看出：
>
> - p1通过构造函数创建了`person`这个结构体的实例对象
>   - 在初始化后的内存地址:`0xc000118000`
>   - 在`person`结构体的`newYear`方法里，传进入`p`的内存地址是:`0xc000118030`，二者内存地址明显不一样
>   - 所以在`newYear`方法里对`age`字段修改，相当于是修改的`p1`的副本里的`age`字段，所以实际上并没有修改成功

##### 3.9.2 指针接收者

> 在值接收者里，对应方法修改了结构体对象的某个值，因为值拷贝的原因，还是不会进行变化，那么如果真要修改，就要用到了指针接收者
>

```go
package main

import (
	"fmt"
)

type person struct{
	name string
	age int
}

func newPerson(name string, age int) *person {
	return &person{
		name: name,
		age: age,
	}
}

func (p *person) newYear() {
	// p1在newYear方法的内存地址：0xc00000c030
	fmt.Printf("p1在newYear方法的内存地址：%p\n", p)
	p.age += 1
}

func main() {
	// 初始化结构体得到p1对象
	p1 := newPerson("sam", 19)
	
	// p1的值是person实例化后的指针
	// p1的值: &{sam 19}
	fmt.Printf("p1的值: %v\n", p1)

	// p1的内存地址值: 0xc00000c030
	fmt.Printf("p1的内存地址值: %p\n", p1)
	
	p1.newYear()
	// 过了一年, p1.age: 20
	fmt.Printf("过了一年, p1.age: %v\n", p1.age)
}
```

> 从上面代码可以看出：
>
> - person的构造函数返回是person的指针类型
>   - p1自身的值是`&{sam 19}`,表示是结构体指针类型
>   - 那么`%p`就可以打印出`p1`的内存地址值
> - 在person结构体的`newYear`方法里
>   - 拿到`p`的内存地址也是和`p1`一样，那就表示将`p1`传进到了`newYear`这个方法里
>   - 那么执行`p.age += 1`，就表示在修改`p1.age =+ 1`，那就实现了通过结构体方法修改成员变量值的效果
> - 从这里看出，使用指针结构体可以实现对成员变量的修改，后面使用的场景会很多，所以推荐使用指针结构体

#### 3.10 自定义类型加方法

> 方法只能给自定义的类型加方法，比如想给基础类型`int`加一个方法，就需要先创建一个属于自己的`myint`类型，然后对这个类型加方法

```go
package main

import (
	"fmt"
)

type myInt int

func (m myInt) hello() {
	fmt.Printf("this is buildt int func")
}

func main() {
    m := myInt(12) // 这里myInt(12)表示是强制类型转换
	m.hello()
}
```

#### 3.11 结构体匿名字段

> 在定义结构体时只定义变量类型，不写变量名
>
> 使用值列表的形式初始化结构体
>
> 这种情况容易出现不知字段的用途，所以用的较少

```go
package main

import (
	"fmt"
)

// 只声明字段类型，不声明字段名，表示匿名结构体
type person struct{
	string
	int
}

func main() {
	// 使用值列表的形式初始化结构体
	p1 := person{
		"name",
		19,
	}
	// {name 19}
	fmt.Printf("p1=%v\n", p1)
}

```

#### 3.12 结构体嵌套

##### 3.12.1 显式嵌套结构体

> 结构体里可以再嵌套另一个结构体，这样的结构体称作结构体嵌套
>

```go
// 结构体嵌套
// 被嵌套结构体
type 结构体1 struct{
  var1 string
  var2 strint
}

// 嵌套结构体，将结构体1嵌套到结构体2中
type 结构体2 struct{
  var3 string
  var4 结构体1
}

// 实例化结构体2，访问var1，下面是伪代码
// 通过结构体2找到结构体1，再访问结构体1里的var1字段
fmt.Printf("var1的值:%v\n", 结构体2.var4.var1)
```

```go
package main

import (
	"fmt"
)

// 需要被嵌套的结构体
type specs struct{
	color	string
	size	string
}

// 衣服结构体。里面嵌套了一个specs这个结构体
type clothes struct{
	name	string
	price	int
  
  // 嵌套了specs结构体
	specs	specs
}

// 汽车结构体，里面嵌套了一个specs这个结构体
type car struct{
	name 	string
	price 	int
	specs 	specs
}

func newClothes(name, color, size string, price int) clothes{
	return clothes{
		name: name,
		price: price,
		specs: specs{
			color: color,
			size: size,
		},
	}
}

func newCar(name, color, size string, price int) car {
	return car{
		name: name,
		price: price,
		specs: specs{
			color: color,
			size: size,
		},
	}
}

func (c *clothes) wear(userName string) {
	fmt.Printf("%s is wear %s\n", userName, c.name)
}

func (c *car) drive(userName string) {
	fmt.Printf("%s drive a %s\n", userName, c.name)
}

func main() {
	c1 := newClothes("NaKe", "red", "XL", 33)
  
  // c1={NaKe 33 {red XL}}
	fmt.Printf("c1=%v\n", c1)
  
  // c1.name=NaKe
	fmt.Printf("c1.name=%v\n", c1.name)
  
  // c1.price=33
	fmt.Printf("c1.price=%v\n", c1.price)
  
  // c1.specs.color=red
	fmt.Printf("c1.specs.color=%v\n", c1.specs.color)
  
  // c1.specs.size=XL
	fmt.Printf("c1.specs.size=%v\n", c1.specs.size)
  
  // jason is wear NaKe
	c1.wear("jason")
	
	fmt.Println()
	
	c2 := newCar("BMW", "pink", "2HX", 1999999)
  
  // c2={BMW 1999999 {pink 2HX}} 
	fmt.Printf("c2=%v\n", c2)
  
  //c2.name=BMW
	fmt.Printf("c2.name=%v\n", c2.name)
  
  // c2.price=1999999
	fmt.Printf("c2.price=%v\n", c2.price)
  
  // c2.specs.color=pink
	fmt.Printf("c2.specs.color=%v\n", c2.specs.color)
  
  // c2.specs.size=2HX
	fmt.Printf("c2.specs.size=%v\n", c2.specs.size)
  
  // sam drive a BMW
	c2.drive("sam")
}
```

> 代码分析
>
> - `specs`结构体是一个公共结构体，用来表示其他结构体都包含它的所有属性
> - `clothes`结构体，里面嵌套了一个`specs`这个结构体，并且起了个变量名叫`specs`
> - `car`结构体，里面嵌套了一个`specs`这个结构体，并且起了个变量名叫`specs`
> - 对`clothes`结构体写构造函数，需要对`clothes`里的`specs`结构体进行初始化赋值，通过`newClothes`传入的形参值进行传入，最终将`clothes`结构体返回，同理`car`结构体也是一样的
> - 通过`clothes`结构体的构造函数初始化了一个`c1`变量，传入了`name`、`price`、`color`、`size`变量以后，就可以对`c1`进行属性访问了
>   - 需要访问`c1`的`color`属性，不能直接`c1.color`，这样是找不到的，会提示报错：` c1.color undefined (type clothes has no field or method color)`
>     - 因为`c1`本身是没有`color`属性的，`c1`的`color`属性在`specs`这个结构体里
>     - 所以需要`c1.specs.color`这样一级一级去找，`c1.specs.color`里的`specs`是`clothes`结构体里定义的`specs`这个变量名，不是`specs`这个结构体类型
>   - 这样去访问嵌套结构体里的属性是比较清晰明了

##### 3.12.2 匿名嵌套结构体

> 上面访问嵌套结构体时，不能直接通过`c1.color`进行访问`color`属性
>
> 如果直接通过c1.color进行访问color属性，需要对`clothes`里的嵌套结构体改造成`匿名嵌套结构体`
>
> `匿名嵌套结构体`：
>
> - 嵌套结构体里对于被嵌套的结构体，不显式的写一个变量名，而是直接写该被嵌套的结构体
> - 那么在构造函数时，类比到结构体匿名字段，那么这个被嵌套结构体的变量名就是它自己的名字，因为没有给名字，所以用的是自己的名字
> - 那么这样定义的嵌套结构体的好处
>   - 可以通过`c1.color`进行直接访问被嵌套的结构体的`color`属性，这样更加方便

```go
// 匿名嵌套结构体 
type specs struct{
	color	string
	size	string
}

type clothes struct{
	name	string
	price	int
  // 匿名嵌套结构体，不写嵌套体的变量名
  // 等价于： specs specs表示是简写
	specs 
}
```

```go
package main

import (
	"fmt"
)

type specs struct{
	color	string
	size	string
}

type clothes struct{
	name	string
	price	int
	specs // 匿名嵌套结构体，不写嵌套体的变量名
}

type car struct{
	name 	string
	price 	int
	specs // 嵌套结构体specs，不写嵌套体的变量名，表示匿名嵌套
}

func newClothes(name, color, size string, price int) clothes{
	return clothes{
		name: name,
		price: price,
		// 冒号前面的specs就是specs这个结构体的名字，因为是匿名嵌套结构体来的，使用了该结构体的名字作为变量名
		specs: specs{
			color: color,
			size: size,
		},
	}
}

func newCar(name, color, size string, price int) car {
	return car{
		name: name,
		price: price,
		specs: specs{
			color: color,
			size: size,
		},
	}
}

func (c *clothes) wear(userName string) {
	fmt.Printf("%s is wear %s\n", userName, c.name)
}

func (c *car) drive(userName string) {
	fmt.Printf("%s drive a %s\n", userName, c.name)
}

func main() {
	c1 := newClothes("NaKe", "red", "XL", 33)
	
	// c1={NaKe 33 {red XL}}
	fmt.Printf("c1=%v\n", c1)
	
	// c1.name=NaKe
	fmt.Printf("c1.name=%v\n", c1.name)
	
	// c1.price=33
	fmt.Printf("c1.price=%v\n", c1.price)
	
	// 直接使用c1.color、c1.size进行访问嵌套结构体里的属性
	// c1.color=red
	fmt.Printf("c1.color=%v\n", c1.color)
	
	// c1.size=XL
	fmt.Printf("c1.size=%v\n", c1.size)
	
	// jason is wear NaKe
	c1.wear("jason")
	
	// 第二个例子
	c2 := newCar("BMW", "pink", "2HX", 1999999)
	
	// c2={BMW 1999999 {pink 2HX}}
	fmt.Printf("c2=%v\n", c2)
	
	// c2.name=BMW
	fmt.Printf("c2.name=%v\n", c2.name)
	
	// c2.price=1999999
	fmt.Printf("c2.price=%v\n", c2.price)
	
	// 直接使用c2.color、c2.size进行访问嵌套结构体里的属性
	// c2.color=pink
	fmt.Printf("c2.color=%v\n", c2.color)

	// c2.size=2HX
	fmt.Printf("c2.size=%v\n", c2.size)

	// sam drive a BMW
	c2.drive("sam")
}
```

##### 3.12.3 匿名嵌套结构体字段冲突

> 如果被嵌套的结构体里有多个相同的字段，那么访问就出现匿名嵌套结构体冲突
>
> - 那么就需要按嵌套的结构体一层一层去找

```go
package main

import (
	"fmt"
)

type carBody struct{
	color	string
	size	int
}

type carInside struct{
	color string
	siteNum int
}

type car struct{
	name string
	carBody
	carInside
}

// car的字段比较多，所以返回结构体指针
func newCar(name string, bodyColor string, size int, insideColor string, siteNum int) *car{
	return &car{
		name: name,
		carBody: carBody{
			color: bodyColor,
			size: size,
		},
		carInside: carInside{
			color: insideColor,
			siteNum: siteNum,
		},
	}
}

func main() {
	c1 := newCar("BMW", "red", 199, "black", 4)
	fmt.Printf("c1=%p\n", c1)
	fmt.Printf("c1=%v\n", *c1)
	
	fmt.Printf("c1.color==> %v\n", c1.color)
}
```

> 上面代码的car结构体匿名嵌套了结构体`carBody`和`carInside`，并且结构体`carBody`和`carInside`都有一个相同字段叫`color`
>
> 那么实例化car结构体后赋值给c1，c1直接访问`color`字段就会报错: 
>
> - 报错信息：`ambiguous selector c1.color`表示是模糊的选择器`c1.color`
> - 因为c1里有两个冲突的`color`字段，此时访问就不知道该访问哪个，就会报错

> 如何解决呢？
>
> - 那就和显式嵌套结构体一样，一层一层的写结构体字段调用

```go
package main

import (
	"fmt"
)

type carBody struct{
	color	string
	size	int
}

type carInside struct{
	color string
	siteNum int
}

type car struct{
	name string
	carBody
	carInside
}

// car的字段比较多，所以返回结构体指针
func newCar(name string, bodyColor string, size int, insideColor string, siteNum int) *car{
	return &car{
		name: name,
		carBody: carBody{
			color: bodyColor,
			size: size,
		},
		carInside: carInside{
			color: insideColor,
			siteNum: siteNum,
		},
	}
}

func main() {
	c1 := newCar("BMW", "red", 199, "black", 4)
	// c1.carBody.color==> red
	fmt.Printf("c1.carBody.color==> %v\n", c1.carBody.color)
	
	// c1.carInside.color==> black
	fmt.Printf("c1.carInside.color==> %v\n", c1.carInside.color)
}
```

##### 3.12.4 嵌套结构体是指针类型

> 被嵌套的结构体指定为指针类型
>
> - 当被嵌套的结构体自身定义的字段比较多，还需要被嵌套，可以在嵌套的时候传入指针类型
> - 访问嵌套的指针结构体，也可以直接去访问

```go
package main

import (
	"fmt"
)

type carBody struct{
	color	string
	size	int
	carType string
	carAddr string
}

type car struct{
	name string
	*carBody
}

// car的字段比较多，所以返回结构体指针
func newCar(name string, color string, size int, carType, carAddr string) *car{
	return &car{
		name: name,
		carBody: &carBody{
			color: color,
			size: size,
			carType: carType,
			carAddr: carAddr,
		},
	}
}

func main() {
	c1 := newCar("BMW", "red", 199, "SUV_Car", "Germen")
	
	// c1自身的值：&{BMW 0xc000024080}
	fmt.Printf("c1自身的值：%v\n", c1)
	
	// c1内存地址指向的值：&{BMW 0xc000024080}
	fmt.Printf("c1内存地址指向的值：%v\n", c1)
	
	// c1的类型：*main.car
	fmt.Printf("c1的类型：%T\n", c1)
	
	// c1.color：red
	fmt.Printf("c1.color：%v\n", c1.color)
	
	// c1.carAddr：Germen
	fmt.Printf("c1.carAddr：%v\n", c1.carAddr)
}
```

##### 3.12.5 嵌套结构体注意事项

> 嵌套结构体写构造函数：
>
> - 需要将结构自身的字段和被嵌套的结构体的字段完全写全
>
> 嵌套结构体查找属性：
>
> - 嵌套结构体查找属性时，先从自己内部的属性字典里去找，找不到再去嵌套结构体里找，这样一层一层去找元素
>
> 匿名嵌套结构体使用场景：
>
> - 多适用于只有一个嵌套结构体
>
> 显式嵌套结构体：
>
> - 当有多个嵌套结构体时，建议还是对嵌套的结构体写不同的变量名
> - 并且在访问时一级一级的去写访问属性，如`c1.specs.color`，这样更清晰
>
> 显式嵌套结构体和匿名嵌套结构体该用哪一种？
>
> - 这个看自身习惯，不过个人比较喜欢使用匿名嵌套结构体
> - 这样在定义时不需要对嵌套结构体多写额外得字段名，直接用嵌套的结构体名字作为字段名即可
> - 如果遇到结构体字段冲突，那就老老实实一级一级去写，这样不会出错，但是又和显示嵌套结构体访问字段方式一样了，
> - 那用哪种嵌套结构体就仁者见仁智者见智了

#### 3.13 结构体模拟继承

> `go`本身是没有继承的，但是用结构体可以来模拟继承
>
> 继承：
>
> - 在其他语言中，有一个父类，然后有一个子类，子类可以继承父类的属性和方法
> - 在`go`语言中可以使用结构体嵌套来模拟继承，当一个结构体A嵌套了结构体B，那么这个结构体A就拥有了结构体B的所有属性和方法，也就实现了模拟继承
>
> 如下代码：
>
> - `father`结构体类比为一个父类，`son`结构体类比为一个子类，`father`结构体有个`house`方法
> - `son`结构体中嵌套了`father`结构体，那么就拥有了`father`结构体的所有属性和方法，`son`结构体就可以进行访问`father`结构体的`house`方法和`name`属性
> - 从执行结果里可以看到`s1=main.son{age:19, father:main.father{name:"hupe"}}`，就说明了`s1`结构体里嵌套的`father`结构体，那么就可以访问`father`结构体的所有的属性和方法

```go
package main

import (
	"fmt"
)

// father结构体
type father struct{
	name string
}

// father的构造函数
func newFather(name string) father{
	return father{
		name: name,
	}
}

// father结构体的方法
func (f *father) house() {
	fmt.Printf("father init func, name [%v] have a house\n", f.name)
}

// son结构体
type son struct{
	age int
	father
}

// son结构体的构造函数
func newSon(age int, name string) son {
	return son{
		age: age,
		father: father{
			name: name,
		},
	}
}

// son结构体的方法
func (s *son) goWalk() {
	fmt.Printf("father is %v\n", s.name)
	fmt.Printf("son age is %v\n", s.age)
}

func main() {
	f1 := newFather("opim")
	fmt.Printf("f1=%#v\n", f1)
	
	s1 := newSon(19, "hupe")
	fmt.Printf("s1=%#v\n", s1)
	
	s1.goWalk()
	s1.house()
}


/*	
	执行结果：
	f1=main.father{name:"opim"}
	s1=main.son{age:19, father:main.father{name:"hupe"}}
	father is hupe
	son age is 19
	father init func, name [hupe] have a house
*/
```

#### 3.14 结构体和json

##### 3.14.1 json解释

> 结构体中支持json格式输出
>
> `JSON`简介
>
> - JSON的全称是”JavaScript Object Notation”，意思是JavaScript对象表示法，它是一种基于文本，独立于语言的轻量级数据交换格式。
>
> - JSON语法
>
>   - 数据在名称/值对中
>   - 数据由逗号分隔
>   - 大括号保存对象
>   - 中括号保存数组
>
> - JSON值
>
>   - 数字(整数/浮点数)
>
>   - 字符串(双引号)
>   - [布尔值](https://www.zhihu.com/search?q=布尔值&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A627916260})(true/false)
>
>   - 数组(中括号中)
>
>   - 对象(大括号中)
>
>   - null
>
>   - 实例
>
> - JSON 数据的书写格式
>
>   - 名称/值对组合中的名称写在前面（在双引号中），值对写在后面，中间用冒号隔开
>   - 其中`值`可以是：数字（整数或浮点数）、字符串（在双引号中）、布尔值（true或false）、数组（在方括号中）、对象（在花括号中）、null

##### 3.14.2 序列化和反序列化

> 知乎解释：[序列化和反序列化](https://zhuanlan.zhihu.com/p/40462507)
>
> 百度百科解释：
>
> - 序列化 (Serialization)是将对象的状态信息转换为可以存储或传输的形式的过程
>   - 把对象转化为可传输的字节序列过程称为序列化，比如`json`、`bytes`等形式
>   - 在序列化期间，对象将其当前状态写入到临时或持久性存储区
> - 反序列化
>   - 可以通过从存储区中读取或反序列化对象的状态，重新创建该对象
>   - 把字节序列还原为对象的过程称为反序列化

##### 3.14.3 go序列化

> 序列化：
>
> - 将go语言中的结构体变量 --> json格式的字符串
>
> `go`序列化:
>
> - 使用到了内置包`encoding/json`，需要先引入
>
> - 输出序列化的值：
>   - 需要使用内置函数`string`

```go
// 语法
ret, err := json.Marshal(d1)

/* 
	json.Marshal(需要序列化的对象)
	输出时使用string对ret进行转化成字符串，否则会直接输出会显示为空
	返回两个值，ret是序列化的结果，err是错误信息，没有错误的话都是nil，表示空值，可以用来进行判断序列化是否转化成功
*/
```

> 直接输出序列化的变量，是一个字节类型的

```go
package main

import (
	"encoding/json"
	"fmt"
)

type dog struct{
	// 首字母不大写，没法进行序列化
	name string
	age int
}

func newDog(name string, age int) dog{
	return dog{
		name: name,
		age: age,
	}
}

func main() {
	d1 := newDog("bom", 3)
	fmt.Printf("d1=%v\n", d1)
	
	// 序列化：将go语言中的结构体变量 --> json格式的字符串
	ret, err := json.Marshal(d1)
	
	if err != nil {
		fmt.Printf("json转化失败")
		return
	}
	fmt.Printf("ret=%#v\n", ret)
}
```

![image-20220208180705196](go%E7%AC%94%E8%AE%B0.assets/image-20220208180705196.png)

> 使用string转化输出,但是输出是空的json

```go
package main

import (
	"encoding/json"
	"fmt"
)

type dog struct{
	// 首字母不大写，没法进行序列化
	name string
	age int
}

func newDog(name string, age int) dog{
	return dog{
		name: name,
		age: age,
	}
}

func main() {
	d1 := newDog("bom", 3)
	fmt.Printf("d1=%v\n", d1)
	
	// 序列化：将go语言中的结构体变量 --> json格式的字符串
	ret, err := json.Marshal(d1)
	
	if err != nil {
		fmt.Printf("json转化失败")
		return
	}
	fmt.Printf("ret=%#v\n", string(ret))
}

```

![image-20220208180821232](go%E7%AC%94%E8%AE%B0.assets/image-20220208180821232.png)

> 上面可以看到使用`string`转化序列化的变量以后，输出的空字符串，没有d1里的name和age属性
>
> 这里就是字段的可见性的原因：
>
> - 因为在`go`字段名是小写的，那么其他包导入的时候，是访问不到的，属于隐藏变量
> - 在上面的代码中，定义的`d1`的结构体的`name`和`age`属性都是小写，那么在`json`这个包序列化`d1`的时候，由于`d1`属性名都是小写，所以`json`包访问不到，所以出现了空字符串
> - 所以修改`dog`结构体的`name`和`age`字段名首字母大写，构造函数中也进行对应的字段名首字母大写就可以正确输出`json`字符串了

```go
package main

import (
	"encoding/json"
	"fmt"
)

type dog struct{
	// 首字母不大写，没法进行序列化
	Name string
	Age int
}

func newDog(name string, age int) dog{
	return dog{
		Name: name,
		Age: age,
	}
}

func main() {
	d1 := newDog("bom", 3)
	fmt.Printf("d1=%v\n", d1)
	
	// 序列化：将go语言中的结构体变量 --> json格式的字符串
	// 需要注意的是结构体的字段名首字母必须大写，因为这是需要json包需要访问d1的name和age属性，小写的字段在其他包都是没法访问到的
	ret, err := json.Marshal(d1)
	
	if err != nil {
		fmt.Printf("json转化失败")
		return
	}
	fmt.Printf("ret=%#v\n", string(ret))
}
```

![image-20220208181655186](go%E7%AC%94%E8%AE%B0.assets/image-20220208181655186.png)



> 下图是将上面的结果`"{\"Name\":\"bom\",\"Age\":3}"`放到`json`格式转化的网站进行了转化，可以看到是一个正确的`json`字符串，反斜杠是表示转义符号

![image-20220208181803156](go%E7%AC%94%E8%AE%B0.assets/image-20220208181803156.png)

> 但是有个问题，序列化出来的`json`字段名首字母都是大写，但是传给前端的时候需要都是小写的，就需要使用`tag`，`tag`是在定义结构体的位置添加，tag表示给字段名起了一个别名

```go
// 添加tag
type dog struct{
	// 首字母不大写，没法进行序列化
    // 反斜杠，json表示使用的包，用冒号隔开，后面要写的字段用小写，有多个用空格隔开
    // 可以理解为是给首字母大写的字段名通过tag起了一个别名
	Name string `json:"name"`
	Age int `json:"age"`
}

注意tag和后面的变量名不能有空格
```

```go
package main

import (
	"encoding/json"
	"fmt"
)

type dog struct{
	// 首字母不大写，没法进行序列化
	Name string `json:"name"`
	Age int `json:"age"`
}

func newDog(name string, age int) dog{
	return dog{
		Name: name,
		Age: age,
	}
}

func main() {
	d1 := newDog("bom", 3)
	fmt.Printf("d1=%v\n", d1)
	
	// 序列化：将go语言中的结构体变量 --> json格式的字符串
	// 需要注意的是结构体的字段名首字母必须大写，因为这是需要json包需要访问d1的name和age属性，小写的字段在其他包都是没法访问到的
	ret, err := json.Marshal(d1)
	
	if err != nil {
		fmt.Printf("json转化失败")
		return
	}
	fmt.Printf("ret=%#v\n", string(ret))
}
```

![image-20220208184714283](go%E7%AC%94%E8%AE%B0.assets/image-20220208184714283.png)

##### 3.14.4 go反序列化

> 反序列化：
>
> - 将json格式的字符串 --> go语言中的结构体变量

```go
// 语法
var 变量 对应结构体类型
err := json.Unmarshal([]byte(反序列化字符串)， 变量指针)

/* 
	接收的第一个参数是字节类型的切换，那么可以值接使用[]byte(反序列化字符串)进行强制转化
	第二个参数是定义一个变量用来存储反序列化的值，一般都是需要传入指针，因为go语言的函数传值都是拷贝，如果不传指针，定义的变量传给Unmarshal函数一直都是副本，所以需要传递指针，变量在反序列化以后，值才会接收为反序列化的值
	返回1个值，err是错误信息，没有错误的话都是nil，表示空值，可以用来进行判断反序列化是否成功
*/
```

```go
package main

import (
	"encoding/json"
	"fmt"
)

type dog struct{
	// 首字母不大写，没法进行序列化
	Name string `json:"name"`
	Age int `json:"age"`
}

func newDog(name string, age int) dog{
	return dog{
		Name: name,
		Age: age,
	}
}

func main() {
	// 反序列化
	var d1 dog
	// 反引号表示将字符串的内容会原样输出
	jsonStrData := `{"name":"lpm","age":13}`
	fmt.Printf("%#v\n", jsonStrData)
	
	err := json.Unmarshal([]byte(jsonStrData), &d1)
	fmt.Printf("err=%v\n", err)
	if err != nil {
		fmt.Println("反序列化失败！！！")
	}
}
// "{\"name\":\"lpm\",\"age\":13}"
```

##### 3.14.5 go反序列化空值问题

> 反序列化时，传递的`json`字段定义的名字值一定要和结构体里定义的一致，否则会出现空值的情况
>
> 比如将下方的`jsonStrData`里的"name"字段写成`uname`,那么反序列化出来d1的`Name`字段值就是空值

```go
package main

import (
	"encoding/json"
	"fmt"
)

type dog struct{
	// 首字母不大写，没法进行序列化
	Name string `json:"name"`
	Age int `json:"age"`
}

func newDog(name string, age int) dog{
	return dog{
		Name: name,
		Age: age,
	}
}

func main() {
	// 反序列化
	var d1 dog
	// 反引号表示将字符串的内容会原样输出
	jsonStrData := `{"uname":"lpm","age":13}`
	
	err := json.Unmarshal([]byte(jsonStrData), &d1)
	if err != nil {
		fmt.Println("反序列化失败！！！")
	}
	fmt.Printf("d1=%#v\n", d1) // d1=main.dog{Name:"", Age:13}
}
```

#### 3.15 结构体首字母大写

> 1. 如果定义的结构体首字母大写，那么这个结构体对外部暴露可见，公有的变量，其他模块的`go`文件可以用来导入这个结构体
> 2. 如果一个包里定义的结构体首字母是小写的，那么其他`go`文件是访问不到小写开头的结构体的
> 3. 需要注意的点：
>
> - 并且对首字母大写的结构体有格式要求，就是需要对首字母大写的结构体、方法写注释
> - 注释的规则是 结构体名+空格+注释内容

```go
package main

import (
"fmt"
)

// 下面的格式必须是需要空格隔开
// Person 这是一个人的结构体
type Person struct{
	name string
	age int
}

func main() {
	p1 := newPerson("sam", 19)
	fmt.Printf("p1=%v\n", p1)
	p1.walk()
}
```

![image-20220424150850248](go%E7%AC%94%E8%AE%B0.assets/image-20220424150850248.png)

> 上图中的Person结构体是首字母大写的，表示外部可访问到
>
> 那么写的注释：
>
> `// Person 这是一个人的结构体`就需要符合`//+空格+结构体名+空格+注释`的规则来添加注释

#### 3.16 结构体案例

> 下面是通过一个学生管理系统来复习学习过的结构体、`map`等知识点
>
> 需要注意的是在编辑学生时，当修改完学生姓名/年龄，一定要重新赋值给学生管理系统的map，否则修改会不生效

```go
// main.go
package main

import (
	"fmt"
	"os"
)

func main() {
	// excute select func
	selectEvent()
}

func showMenu(){
	fmt.Print("wellcome to student  manager system:")
	fmt.Println(`
		1. showStu
		2. addStu
		3. delStu
		4. editStu
		5. quit
	`)
}

func selectEvent(){
	smr := newStuMr(100)
	for {
		// lopp show menu
		showMenu()
		
		// input user choice
		var choice int
		fmt.Print("input your choice:")
		fmt.Scan(&choice)
		fmt.Printf("your choice is:%v\n", choice)
		
		switch choice{
		case 1:
			smr.showStu()
		case 2:
			smr.addStu()
		case 3:
			smr.delStu()
		case 4:
			smr.editStu()
		case 5:
			fmt.Println("bye~")
			os.Exit(1)
		default:
			fmt.Println("your choice is wrong, pls input age...")
		}
	}
}
```

```go
// stuMgr.go
package main

import (
	"fmt"
)

// student struct
type student struct{
	name 	string
	age 	int
}

func newStudent(name string, age int) student{
	return student{
		name: name,
		 age: age,
	}
}

func (s *student) alterStu(newName string, newAge int) {
	s.name = newName
	s.age  = newAge
}

// studentManager struct
type stuMr struct{
	studentData map[int]student
}

func newStuMr(stuSize int) stuMr{
	return stuMr{
		studentData: make(map[int]student, stuSize),
	}
}

func (s *stuMr) showStu() {
	if len(s.studentData) == 0 {
		fmt.Println("student data is empty, pls add first!!!")
		return
	}
	fmt.Println("Id\tname\tage")
	for k,v := range s.studentData{
		fmt.Printf("%v\t%v\t%v\n",k, v.name, v.age)
	}
}

// define globle virable

var (
	id, age		int
	name		string
)

func (s *stuMr) addStu() {
	fmt.Print("pls input name:")
	fmt.Scan(&name)
	
	fmt.Print("pls input age:")
	fmt.Scan(&age)
	
	id++
	s.studentData[id] = newStudent(name, age)
}

func (s *stuMr) delStu() {
	if len(s.studentData) == 0 {
		fmt.Println("student data is empty, pls add first!!!")
		return
	}
	fmt.Print("pls input Id:")
	fmt.Scan(&id)
	_, ok := s.studentData[id]
	if !ok {
		fmt.Printf("id[%v] don't exists!!!", id)
		return
	}
	delete(s.studentData, id)
}

func (s *stuMr) editStu() {
	if len(s.studentData) == 0 {
		fmt.Println("student data is empty, pls add first!!!")
		return
	}
	fmt.Print("pls input Id:")
	fmt.Scan(&id)
	qStuData, ok := s.studentData[id]
	if !ok {
		fmt.Printf("id[%v] don't exists!!!\n", id)
		return
	}
	fmt.Printf("query stu data:%+v\n", qStuData)
	fmt.Print("pls input new name:")
	fmt.Scan(&name)
	fmt.Print("pls input new age:")
	fmt.Scan(&age)
	qStuData.alterStu(name, age)
	
	// give new qStuData to student map, ottherwise new data can't be effctive
	s.studentData[id] = qStuData
}
```

## 十、接口和包

### 1、接口

#### 1.1 接口定义

> 接口是一种抽象的类型，一种特殊的类型
>
> 接口是一组`method`的集合，不关心属性，只关心方法
>
> 接口用于`不关心变量类型，只关心调用它的什么方法`

```go
// 接口定义
type 接口名 interface {
    接口方法1(参数1， 参数2...)(返回值1，返回值2...)
    接口方法2(参数1， 参数2...)(返回值1，返回值2...)
}

// 所有定义了接口方法的类型，都必须实现接口方法
// 只要实现了接口方法的变量都是speaker类型
// 接口方法也叫方法签名
```

```go
/*
  @Author: lyzin
    @Date: 2022/02/13 20:19
    @File: basic_study
    @Desc: 
*/
package main

import "fmt"

type dog struct{}
type cat struct{}
type pig struct{}

func (d dog) speak() {
	fmt.Printf("狗在叫\n")
}

func (c cat) speak() {
	fmt.Printf("猫在叫\n")
}

func (p pig) speak() {
	fmt.Printf("猪在叫\n")
}

type speaker interface {
	speak()
}

func sp(s speaker) {
	s.speak()
}

func main() {
	var d1 dog
	var c1 cat
	var p1 pig

	sp(d1)
	sp(c1)
	sp(p1)
}
/*
		狗在叫
    猫在叫
    猪在叫
*/
```

#### 1.2 接口实现

> 一个变量如果实现了接口类型中规定的所有方法，那么这个变量就实现了这个接口，所以可以称为这个接口类型的变量
>
> 接口类型的变量的值是`nil`，类型也是`nil`，这表示空接口
>
> 接口保存的是值的动态类型和动态值本身

```go
/*
  @Author: lyzin
    @Date: 2022/02/13 20:19
    @File: basic_study
    @Desc: 
*/
package main

import "fmt"

type dog struct{}

// 此处表示dog结构体的方法没有实现接口里的speak方法，就会报错
func (d dog) speak() {
	fmt.Printf("狗在叫\n")
}

type speaker interface {
	speak()
}


func sp(s speaker) {
	s.speak()
}

func main() {
	var d1 dog
  
  // d1里面有speak方法，那么d1这个变量变量就实现 specker这个接口类型，d1就是speaker这个接口类型的变量
	sp(d1)

	var s1 speaker
	fmt.Printf("s1=%v\n", s1) // nil
	fmt.Printf("s1=%T\n", s1) // nil
}
```

#### 1.3 接口定义方法未实现

> 如果变量的接口方法未实现，就会报错
>
> `implement`: 执行，实施，生效
>
> 会提示dog类型缺少speak方法

```go
/*
  @Author: lyzin
    @Date: 2022/02/13 20:19
    @File: basic_study
    @Desc: 
*/
package main

type dog struct{}

// 此处表示dog结构体的方法没有实现接口里的speak方法，就会报错
//func (d dog) speak() {
//	fmt.Printf("狗在叫\n")
//}

type speaker interface {
	speak()
}

func sp(s speaker) {
	s.speak()
}

func main() {
	var d1 dog
	sp(d1)
}
```

![image-20220213203044074](go%E7%AC%94%E8%AE%B0.assets/image-20220213203044074.png)

#### 1.4 值接收者实现接口

> 值接收者实现接口，结构体类型和结构体指针类型的变量都可以存储
>
> 从下面代码可以看出，`s1`是`speaker`类型的变量，但是`s1`既可以接收值类型结构体，也可以接收指针类型结构体

```go
/*
  @Author: lyzin
    @Date: 2022/02/13 20:19
    @File: basic_study
    @Desc: 
*/
package main

import "fmt"

type dog struct{
	name 	string
	age 	int
}

// 此处表示dog结构体的方法实现的是值类型
func (d dog) speak() {
	fmt.Printf("狗在叫\n")
}

type speaker interface {
	speak()
}

func sp(s speaker) {
	s.speak()
}

func main() {
	var d1 dog
	var d2 dog
	d1 = dog{name:"tom", age: 19}
	d2 = dog{name:"yom", age: 29}
	var s1 speaker

	// 传给s1的是d2的值，接口可以接收到
	s1 = d1
	fmt.Printf("s1=%v\n", s1) // s1={tom 19}
	fmt.Printf("s1=%T\n", s1) // s1=main.dog

	// 传给s1的是d2的指针，接口可以接收到
	s1 = &d2
	fmt.Printf("s1=%v\n", s1) // s1=&{yom 29}
	fmt.Printf("s1=%T\n", s1) // s1=*main.dog
}
```

#### 1.5 指针接收者实现接口

> 指针接收者实现接口只能存结构体指针

```go
/*
  @Author: lyzin
    @Date: 2022/02/13 20:19
    @File: basic_study
    @Desc: 
*/
package main

import "fmt"

type dog struct{
	name 	string
	age 	int
}

// 此处表示dog结构体的方法实现的是指针类型
func (d *dog) speak() {
	fmt.Printf("狗在叫\n")
}

type speaker interface {
	speak()
}

func sp(s speaker) {
	s.speak()
}

func main() {
	var d1 dog
	var d2 dog
	d1 = dog{name:"tom", age: 19}
	d2 = dog{name:"yom", age: 29}
	var s1 speaker

	// 传给s1的是d1的值，但是结构体方法的接收者是指针类型，所以不可以接收到
	// 报错提示speak方法有指针接收者
	s1 = d1 // 这样会报错，必须给s1赋值指针类型的结构体对象
	fmt.Printf("s1=%v\n", s1) 
	fmt.Printf("s1=%T\n", s1) 

	// 传给s1的是d2的指针，接口可以接收到
	s1 = &d2
	fmt.Printf("s1=%v\n", s1) // s1=&{yom 29}
	fmt.Printf("s1=%T\n", s1) // s1=*main.dog
}
```

> 如果结构体实现接口的方法的接收者是指针类型时，那么传给接口类型的方法的变量也必须是指针类型，否则就会报错

![image-20220213213815411](go%E7%AC%94%E8%AE%B0.assets/image-20220213213815411.png)

#### 1.6 多个接口和接口嵌套

> 同一个结构体可以实现多个接口
>
> 接口还可以进行嵌套

```go
/*
  @Author: lyzin
    @Date: 2022/02/13 20:19
    @File: basic_study
    @Desc: 
*/
package main

import "fmt"

// animal 接口嵌套了dog结构体的speaker、eater接口
type animal interface {
	speaker
	eater
}

// 实现dog的speaker接口
type speaker interface {
	speak()
}

// 实现dog的eater接口
type eater interface {
	eat()
}


// dog结构体
type dog struct{
	name 	string
	age 	int
}

//
func (d *dog) speak() {
	fmt.Printf("狗在叫\n")
}

func (d *dog) eat() {
	fmt.Printf("狗在吃\n")
}

// 定义接口调用的方法
func sp(s speaker) {
	s.speak()
}

func main() {
	var d1 dog
	var d2 dog
	d1 = dog{name:"tom", age: 19}
	d2 = dog{name:"yom", age: 29}
	var s1 speaker

	// 传给s1的是d2的值，但是结构体方法的接收者是指针类型，所以不可以接收到
	// 报错提示speak方法有指针接收者
	// s1 = d1 // 这样会报错，必须给s1赋值指针类型的结构体对象
	s1 = &d1 // 必须给接口传递结构体的指针
	fmt.Printf("s1=%v\n", s1) // s1={tom 19}
	fmt.Printf("s1=%T\n", s1) // s1=main.dog

	// 传给s1的是d2的指针，接口可以接收到
	s1 = &d2
	fmt.Printf("s1=%v\n", s1) // s1=&{yom 29}
	fmt.Printf("s1=%T\n", s1) // s1=*main.dog
}
```

```go
package main

import (
	"fmt"
)

// 定义接口嵌套
type animal interface{
	speaker
	eater
}

// 定义第二层接口实现dog的speak接口
type speaker interface{
	speak()
}

// 定义第二层接口实现dog的eater接口
type eater interface{
	eat()
}

type dog struct{
	name string
	age int
}

func newDog(name string, age int) dog {
	return dog{
		name: name,
		 age: age,
	}
}

func (d *dog) speak() {
	fmt.Printf("%s is speak...\n", d.name)
}


func (d *dog) eat() {
	fmt.Printf("%s is eating...\n", d.name)
}

// 接口方法调用
func dfSpeak(x animal) {
	x.speak()
}

func dfEat(x animal) {
	x.eat()
}

func main() {
	d1 := newDog("sam", 19)
	d2 := newDog("jam", 29)
	fmt.Printf("d1=%v\n", d1)
	fmt.Printf("d2=%v\n", d2)
	
	dfSpeak(&d1)
	dfEat(&d2)
}
```

#### 1.7  空接口

> 空接口是指没有定义任何方法的接口
>
> 所以任何类型都实现了空接口
>
> 那么空接口的变量可以存任何类型的变量，也就是说，只要变量的类型是空接口，那么就可以接收任意类型的变量

##### 1.7.1 空接口变量

> 空接口变量本身的值和类型都是`nil`，所以可以是任意类型

```go
package main

import (
	"fmt"
)

func main() {
	var s1 interface{}
	fmt.Printf("s1=%v\t s1 type=%T\n", s1, s1)
	
	s1 = 19
	fmt.Printf("s1=%v\t s1 type=%T\n", s1, s1)
	
	s1 = "sam"
	fmt.Printf("s1=%v\t s1 type=%T\n", s1, s1)
	
	s1 = true
	fmt.Printf("s1=%v\t s1 type=%T\n", s1, s1)
}
```

![image-20220214143852695](go%E7%AC%94%E8%AE%B0.assets/image-20220214143852695.png)

##### 1.7.2 函数形参/返回值为空接口

> 鉴于空接口变量可以接收任意数据类型的值，那么就可以用来给函数传参
>
> - 因为之前函数的形参变量类型都是固定，只允许传入固定类型的形参，有了空接口，就可以接收任意类型的形参
> - 返回值也是同理，返回值可以返回任意类型的值，当然返回值有空接口的不多
>   - 从下面代码可以看出，返回值是`interface{}`类型，表示可以返回任意类型的返回值

```go
package main

import (
	"fmt"
)

// 形参为空接口类型，表示可以接口任意类型的变量
func showVal(x interface{}) interface{} {
	fmt.Printf("showVal函数内：x:%v\t | x type:%T\n", x, x)
	return x
}


func main() {
	s1 := showVal(19)
	fmt.Printf("main方法：%v\t %T\n", s1, s1)
	
	s2 := showVal("sam")
	fmt.Printf("main方法：%v\t %T\n", s2, s2)
	
	s3 := showVal(true)
	fmt.Printf("main方法：%v\t %T\n", s3, s3)
}
```

![image-20220214145120632](go%E7%AC%94%E8%AE%B0.assets/image-20220214145120632.png)

##### 1.7.3 函数空接口接收可变长参数

> 函数可以接收可变长参数，那么可变长参数既可以是`int`/`string`/`slice`/`map`等类型，那么也可以接收空接口类型
>
> 传进来多个值，都可以被空接口形参接收，并且是`空接口类型的切片`

```go
// 复习下可变长参数函数的格式
// 格式
func 函数名(形参 ...T)

// 形参: 形参名
// ...T: 可变长参数的类型
```

```go
package main

import (
	"fmt"
)

// 形参为空接口类型，表示可以接口任意类型的变量
func showVal(x ...interface{}) {
	fmt.Printf("showVal函数内x的值:%v\n", x)
	fmt.Printf("showVal函数内x的type:%T\n", x)
	// 遍历可以空接口类型的可变长参数
	for _, v := range x {
		fmt.Printf("v=%v\n", v)
	}
}

func main() {
	sf := []string{"huge", "bob"}
	mf := make(map[string]int, 10)
	mf["age1"] = 19
	mf["age2"] = 29
	mf["age3"] = 39
	// 可以看到showVal函数可以接收任意类型的形参
	showVal(19, "sam", true, sf, mf)
}
```

##### 1.7.4 接口类型判断

> 空接口可以接收任意类型的变量，那么可以对传进来的变量类型进行判断

```go
// 接口类型判断
x.(T)

// x表示空接口变量，T表示需要判断的数据类型
// 这个判断接口类型返回两个值，一个是传进来的值本身，一个是错误码(布尔类型)，当传入的值的类型是判断里指定的类型，则返回true，否则返回false
```

```go
package main

import (
	"fmt"
)

// 形参为空接口类型，表示可以接口任意类型的变量
func showVal(x interface{}) {
	v, ok := x.(string)
	fmt.Printf("v=%v\tv type=%T\n", v, v) // v=sam   v type=string
	fmt.Printf("ok=%v\tok type=%T\n", ok, ok) // ok=true ok type=bool
	if ok{
		fmt.Printf("%v\t%T\n", v, v)
	} else{
		fmt.Printf("x[%v] type[%T] is not a string type\n", ok, ok)
	}
	
}

func main() {
	// 可以看到showVal函数可以接收任意类型的形参
	showVal("sam")
	
	// 传入一个不是string类型的变量
	showVal(19)
}
```

![image-20220214151505455](go%E7%AC%94%E8%AE%B0.assets/image-20220214151505455.png)



### 2、包

> Go语言中支持模块化的开发理念，在Go语言中使用`包（package）`来支持代码模块化和代码复用。
>
> - 一个包是由一个或多个Go源码文件（.go结尾的文件）组成，是一种高级的代码复用方案
>
> - Go语言为我们提供了很多内置包，如`fmt`、`os`、`io`等。

#### 2.1 包的组成

> 包类型大致可以分为`自定义包`和`main`两类
>
> - `自定义包`：表示这个包是自定义的包，包含一单独的功能，比如注册，登录等
> - `main`：表示是一个可以执行，可以编译成`可执行文件`的包

#### 2.2 自定义包

> 可以根据自己的需要创建自定义包
>
> - 一个包可以简单理解为一个存放`*.go`文件的文件夹
>   - 该文件夹下面的所有`.go`文件都要在非注释的第一行添加如下声明，声明该文件归属的包

```go
package packagename

/*
其中：
	- package：声明包的关键字
	- packagename：包名，可以不与文件夹的名称一致，不能包含 `-` 符号，最好与其实现的功能相对应
*/
```

##### 2.2.1 包可见性

> 在同一个包内部声明的标识符都位于同一个命名空间下
>
> - 所以当有大于1个`*.go`文件同属于一个包时，这个包里的`*.go`文件可以互相访问里面的函数、变量、方法等，就相当于是在同一个内存地址里面一样，直接引用就可以

> 在`不同的包`内部声明的标识符就属于`不同的命名空间`
>
> - 如果想让一个包中的标识符（如变量、常量、类型、函数等）能被`外部的包`使用，那么标识符必须是对外可见的（public）
> - 在Go语言中是通过`标识符的首字母大/小写来控制标识符`的`对外可见（public）/不可见（private）`的
>   - 在一个包内部只有`首字母大写的标识符`才是`对外可见`的。
>
> - 想要在包的外部使用包内部的标识符就需要添加包名前缀
>   - 例如`fmt.Println("Hi go~")`，就是指调用`fmt`包中的`Println`函数

```go
/*
	定义一个名为demo_test的包，在其中定义了若干标识符。在另外一个包中并不是所有的标识符都能通过demo_test.前缀访问到，因为只有那些首字母是大写的标识符才是对外可见的
*/
package demo_test

import "fmt"

// 包级别标识符的可见性
// num 定义一个全局整型变量
// 首字母小写，对外不可见(只能在当前包内使用)
var il = 100

// Mode 定义一个常量
// 首字母大写，对外可见(可在其它包中使用)
const Mode = 1

// person 定义一个代表人的结构体
// 首字母小写，对外不可见(只能在当前包内使用)
type person struct {
	name string
	Age  int
}

// 首字母大写，对外可见(可在其它包中使用)
type Student struct {
	Name  string // 可在包外访问的方法
	class string // 仅限包内访问的字段
}

// Add 返回两个整数和的函数
// 首字母大写，对外可见(可在其它包中使用)
func Add(x, y int) int {
	return x + y
}

// sayHi 打招呼的函数
// 首字母小写，对外不可见(只能在当前包内使用)
func sayHi() {
	var myName = "七米" // 函数局部变量，只能在当前函数内使用
	fmt.Println(myName)
}
```

##### 2.2.2 自定义包注意事项

> 参考：
>
> [https://studygolang.com/articles/7165](https://studygolang.com/articles/7165)
>
> [http://c.biancheng.net/view/5394.html](http://c.biancheng.net/view/5394.html)

> 注意:
>
> - 一个文件夹下面直接包含的文件只能归属一个包，同一个包的文件不能存在于多个文件夹下
>   - 也就是说一个文件夹只能有一个包，同一个包的文件不能分散与多个文件夹中
> - 包名一般是小写的，使用一个简短且有意义的名称
> - 自定义包名常规都和包含`*.go`文件的文件夹名字一致
>   - 也可以不和文件夹的名字一样，可以自己起一个包名字，然后所有`*.go`文件都声明为该包名
>     - 文件夹名可以和该包名不一致，但`*.go`文件中使用的包名必须要和自定义包名一致
>   - 包名不能包含`-`符号，需要符合标识符定义规则
> - 包一般使用域名作为目录名称，这样能保证包名的唯一性
>   - 比如 GitHub 项目的包一般会放到`GOPATH/src/github.com/userName/projectName `目录下

##### 2.2.3 包禁止循环引用

> `go`语言中禁止包的循环导入
>
> `jim`包和`kop`包互相引用，最后`main`包导入`jim`包、`kop`包后运行提示`import cycle not allowed`

![image-20220215132419145](go%E7%AC%94%E8%AE%B0.assets/image-20220215132419145.png)

#### 2.3 main包

> 包名为`main`的包是应用程序的入口包，这种包编译后会得到一个可执行文件
>
> 而编译不包含`main`包的源代码则不会得到可执行文件

#### 2.4 包的导入

> 要在代码中引用其他包的内容，需要使用`import`关键字导入使用的包
>
> 注意事项：
>
> - `import`导入语句通常放在源码文件开头包声明语句的下面
> - 导入的包名需要使用双引号包裹起来
> - 导入的包名是从`GOPATH/src/ `后开始计算的，使用`/ `进行路径分隔

```go
// 具体语法如下：
import "包的路径"
```

##### 2.4.1 包导入案例讲解

> 导入的包名是从`GOPATH/src/ `后开始计算的
>
> 那么当`day09`里的`import_demo.go`需要导入下图中的`day08`包里有两个`*.go`文件时，在`import_demo.go`中写的导入路径就需要从`src`下的`code.zinly.com`开始

![image-20220214174513405](go%E7%AC%94%E8%AE%B0.assets/image-20220214174513405.png)

> day08文件夹中的`cal_data.go`代码

```go
// day08里的cal_data.go文件
package jim

import "fmt"

func AddVal(x, y int) int {
	return x + y
}


// 首字母小写，表示别的包不可以导入使用
type person struct {
	name 	string
	age 	int
}

// 首字母大写，表示别的包可以导入使用
func NewPerson(name string, age int) person {
	return person {
		name: name,
		 age: age,
	}
}

// 首字母大写，表示别的包可以导入使用
func (p *person) ShowInfo() {
	fmt.Printf("name：%v\t age:%v\n", p.name, p.age)
}
```

> day08文件夹中的`hibi.go`代码

```go
// day08里的hibi.go
package jim

import (
	"fmt"
)

var name string

// 首字母大写，表示别的包可以导入使用
func ShowAge() {
	name := "hibi"
	f.Printf("name=%v\n", name)
}
```

> day09文件夹中的`import_demo.go`代码
>
> 这个导入代码里导入day08里的所有go文件，导入路径需要从src下的目录开始写，jimx是导入路径的别名，建议与导入的包名一致，这样也方便查找
>
> - 导入路径没有别名，那么在下面代码引用时，用已导入的包的包名来引用，也就是导入的代码里的包名来引用所有的方法、函数、变量等
> - 导入路径有别名，那么在下面代码引用时，用声明的包别名来引用所有的方法、函数、变量等

```go
// day09文件夹中的`import_demo.go`文件
package main

import (
    // 导入day08里的所有go文件，需要从src下的目录开始写，jimx是导入的别名，建议与导入的包名一致，这样也方便查找
	 jimx "code.zinly.com/goLearning/day08"  
	"fmt"
)

func main() {
	ret := jimx.AddVal(1, 2)
	fmt.Printf("ret=%v\n", ret)
	
	// 实例化结构体
	p1 := jimx.NewPerson("sam", 12)
	fmt.Printf("p1=%v\n", p1)
	
	// 调用实例化的方法，首字母也必须大写
	p1.ShowInfo()
	
	jimx.ShowAge()
}
```

> 从上面代码可以看出，
>
> - `day09`文件夹导入了`day08`这个包，并且`day08`这个文件夹里所有`*.go`文件声明的包名没有和`day08`这个文件名字`day08`一样，而是叫`jim`，这里也就可以看出`包名`可以自定义
>
> - `day08`里的所有`*.go`文件只有首字母大写的方法、变量等标识符才可以被`day09`里引用
> - `day08`里的所有`*.go`文件的包名都必须一致，否则就会报错，从下图可以看出：
>   - day08文件中当`cal_data.go`和`bal_data_bak.go`声明为`jims`包
>   - day08文件中当`hibi.go`声明为`jim`包
>   - 在`day09`的`import_demo.go`导入后执行，报错提示了在`day08`文件中
>     - `found packages jims (bal_data_bak.go) and jim (hibi.go)`表示发现了2个包在`bal_data_bak.go`和`hibi.go`文件中
>     - 而且在`import_demo.go`即使将调用`Him()`写到很下面，仍然会优先检测`bal_data_bak.go`文件，而不是`cal_data.go`文件，说明导入时，是按目标包的文件名字母的顺序进行导入的

![image-20220214182104927](go%E7%AC%94%E8%AE%B0.assets/image-20220214182104927.png)

#### 2.5 匿名导包

> 如果只希望导入包，而不使用包内部的数据，可以使用匿名导入包
>
> 后面学习数据库时才会用到，表示只会执行包的`init`函数

```go
// 匿名导包，在导入包的路径前面加一个下划线即可
import (
	_  "包的路径"
)
```

#### 2.6 init函数

> `init函数`既没有参数，也没有返回值
>
> 是在程序运行时自动被调用执行，不能再代码中主动调用它
>
> 一个包里只能有一个`init函数`

![image-20220214224358662](go%E7%AC%94%E8%AE%B0.assets/image-20220214224358662.png)

##### 2.6.1 导包的init函数执行顺序

> 从下图可以看出init函数导入包时的顺序

![image-20220214231144093](go%E7%AC%94%E8%AE%B0.assets/image-20220214231144093.png)

![image-20220214232204476](go%E7%AC%94%E8%AE%B0.assets/image-20220214232204476.png)

#### 2.7 包的运行注意事项

> 当一个main包里有多个`*.go`文件时，而且文件之间有互相的依赖引用，当运行时，不能运行单独的文件
>
> - 单独运行一个`*.go`文件，因为引用的函数、变量在内存中并没有，所以会提示`undefined`的错误
> - 所以需要以包的形式运行，也就是引导了哪些文件，`go run `时就跟上所有的`*.go`文件，这样才可以找到对应引用的函数、变量

### 3、go module

> [https://zhuanlan.zhihu.com/p/330962571](https://zhuanlan.zhihu.com/p/330962571)
>
> [https://www.cnblogs.com/wongbingming/p/12941021.html](https://www.cnblogs.com/wongbingming/p/12941021.html)
>
> https://golang.google.cn/doc/tutorial/create-module
>
> https://golang.google.cn/doc/modules/managing-dependencies#naming_module
>
> https://golang.google.cn/doc/tutorial/getting-started
>
> https://golang.google.cn/doc/modules/gomod-ref
>
> https://www.jianshu.com/p/04dd0d386df2
>
> https://www.cnblogs.com/wongbingming/p/12941021.html
>
> https://blog.csdn.net/u011069013/article/details/110114319

#### 3.1 go module历史

> 为什么要有go module?
>
> 

#### 3.2 go module使用

> 







## 十一、文件操作

> 在`go`语言中，可以对文件进行读写操作

### 1、读取文件

#### 1.1 打开关闭文件

> `go`语言中使用`os`模块进行打开文件，获得文件句柄，也叫文件指针

```go
os.Open()
// 用来打开文件，返回两个值，一个是os.File指针，另一个是错误码err
```

```go
fileHandler, err := os.Open("./name.txt")
if err != nil {
		fmt.Printf("打开文件错误:%v\n", err)
		return
}
fmt.Printf("fileHandler=%#v\n", fileHandler)
fmt.Printf("fileHandler=%p\n", fileHandler)
fmt.Printf("fileHandler type=%T\n", fileHandler)

/*
    fileHandler=&{0xc0000a4780}
    fileHandler=0xc0000a2018
    fileHandler type=*os.File
*/
```

```go
// 上面获取到的文件的指针，那么就可以对该指针进行操作了

// 关闭文件
fileHandler.Close()
```

> 关闭文件一般是在`defer`语句来定义

#### 1.2 读取文件内容

##### 1.2.1 较为底层方法 

> 较为底层的方法就是使用上面打开文件获取到的文件指针，调用`Read()`方法，`Read()`传入一个可以一个字节类型的切片，并且指定字节切片长度，就可以来读取文件内容

```go
// 读取文件内容
fileHandler.Read([]byte, 字节长度)
```

> 上面的方法是返回两个值
>
> - 第一个值n是按照Read()函数传入的字节切片长度，开始读取文件，然后返回读取到文件内容的字节数
>   - 如果返回的n小于定义的切片长度，那么表示文件内容全部被读出来
>   - 如果返回的n大于定义的切片长度，那么表示文件内容只被读出来字节长度的文件内容，剩余的没有被读出来，那就需要使用`for`循环不断读取文件内容
>     - 每次循环读取的都是从上一次读取的结尾作为开始进行读取
> - 第二个值就是err
>   - err会有两种情况：
>     - 读取内容错误，结果不等nil
>     - 文件内容都读取完成后，err会有一个`EOF(end of file)`的结束标识符，所以需要进行判断接收，如果是EOF，那就表示文件读取结束
>     - `EOF`需要使用`io`的`io.EOF`来接收

```go
// readFile.go
package main

import (
	"fmt"
	"os" // 读取文件的包
	"io" // 接收EOF结束符
)

func readFileContent(fileName string) {
	// 打开文件
	fileHandler, err := os.Open("./name.txt")
	if err != nil {
		fmt.Printf("打开文件错误:%v\n", err)
		return
	}
	fmt.Printf("fileHandler=%#v\n", fileHandler)
	fmt.Printf("fileHandler=%p\n", fileHandler)
	fmt.Printf("fileHandler type=%T\n", fileHandler)
	// 等待函数执行结束前，再执行文件关闭操作
	defer fileHandler.Close()

	readTimes := 1
	AllTimes := 3
	for {
		fmt.Printf("\n第%v次读取文件内容\n", readTimes)
		// 开始读取文件内容
		var tmp = make([]byte, 128)
		byteNums, err := fileHandler.Read(tmp)

		// 判断文件读取结束
		if err == io.EOF {
			fmt.Println("读取文件结束~")
			return
		}

		// 判断错误是不是nil
		if err != nil {
			fmt.Printf("读取文件内容失败:%v\n", err)
			return
		}

		if readTimes > AllTimes {
			fmt.Printf("读取超过%v次，再见~\n", AllTimes)
			break
		}
		readTimes++
		fmt.Printf("读取到的文件内容字节个数:%v\n", byteNums)
		fmt.Printf("读取到的文件内容:%v\n", string(tmp[:byteNums]))
	}
}

func main() {
	readFileContent("./name.txt")
}
```

> 注意：
>
> - 如果文件在`Open`函数中写的是绝对路径，最好不要在`goland`中直接右键执行该读取文件内容的`go`文件，因为会提示找不到需要读取文件路径
>   - 代码里如果写的是相对路径，那么就可以在终端里是使用`go run`/`go build`运行就可以

![image-20220215234301296](go%E7%AC%94%E8%AE%B0.assets/image-20220215234301296.png)

##### 1.2.2 稍显优雅的方法

> 使用`bufio`读取，`bufio`是在`file`的基础上封装了一层API，支持更多的功能

```go
// 导入bufio

import "bufio"

// 第一步
// 使用bufio.NewReader传入打开文件获得的文件指针
readObj := bufio.NewReader(fileHandler)

// 上面的readObj调用ReadString方法，需要传入字符格式的分隔符，比如：`\n`，' '等
line, err := readObj.ReadString('\n')
// line的值是根据分隔符获得到的每一行
// err是读取的错误码
```

```go
package main

import (
	"fmt"
	"os"
	"bufio"
	"io"
)

func readFileContent(fileName string) {
	// 打开文件
	fileHandler, err := os.Open("./name.txt")
	if err != nil {
		fmt.Printf("打开文件错误:%v\n", err)
		return
	}
	fmt.Printf("fileHandler=%#v\n", fileHandler)
	fmt.Printf("fileHandler=%p\n", fileHandler)
	fmt.Printf("fileHandler type=%T\n", fileHandler)
	// 等待函数执行结束前，再执行文件关闭操作
	defer fileHandler.Close()

	// 实例化bufio对象，并将打开的文件指针传入
	readObj := bufio.NewReader(fileHandler)
	for {
		// ReadSting里传入的是字符，表示以什么分隔开
		readLine, err := readObj.ReadString('\n')
		
    // 将每一行读出来
		fmt.Printf("readline:%v\n", readLine)
		
    // 判断文件读取结束
		if err == io.EOF {
			fmt.Println("读取文件结束~")
			break
		}
		// 判断错误是不是nil
		if err != nil {
			fmt.Printf("读取文件内容失败:%v\n", err)
			break
		}
	
	}
}

func main() {
	readFileContent("./name.txt")
}
```

![image-20220215235504007](go%E7%AC%94%E8%AE%B0.assets/image-20220215235504007.png)

##### 1.2.3 更简洁的方法

> 使用`io/ioutil`的`ReadFile`方法读取完整文件内容，只需要传入文件名既可
>
> 

```go
// 导入io/ioutil
import "io/ioutil"

ioutil.ReadFile(fileName string)
/* 
	返回两个值:
		第一个值的类型：[]uint8，可以用string强制转换成`string`
		第二个值是返回错误码
*/
```

```go
package main

import (
	"fmt"
	"io/ioutil"
)

func readFileContent(fileName string) {
	// 打开读取文件
	fileData, err := ioutil.ReadFile("./name.txt")
	if err != nil {
		fmt.Printf("读取文件错误:%v\n", err)
		return
	}
	fmt.Printf("fileData:%v\n", string(fileData))
}

func main() {
	readFileContent("./name.txt")
}
```

##### 1.2.4 练习汇总

```go
package main

import (
	"fmt"
	"os"
	"io"
	"io/ioutil"
	"bufio"
)

func readFileByLowType(fileName string) {
	// 底层方式
	fileHandler, err := os.Open(fileName)
	if err != nil {
		fmt.Printf("打开文件失败:%v\n", err)
		return
	}
	defer fileHandler.Close()
	
	times := 1
	allTimes := 5
	for {
		fmt.Printf("\n第%v次读取文件内容\n", times)
		var tmp = make([]byte, 128)
		readNums, err := fileHandler.Read(tmp)
		
		fmt.Printf("读取到的文件内容:\n%v\n", string(tmp[:readNums]))
		
		// 判断读到结尾，需要优先进行判断，否则会报错读取文件内容失败
		if err == io.EOF {
			fmt.Printf("文件读完了\n")
			break
		}
		
		// 判断读取文件内容错误码
		if err != nil {
			fmt.Printf("读取文件内容失败:%v\n", err)
			break
		}

		if times > allTimes {
			fmt.Printf("读取文件超过最大%v次数\n", allTimes)
			break
		}
		times++
		
	}
}

func readFileByBufio(fileName string) {
	// 使用bufio读取，不需要控制读取的切片长度
	fileHandler, err := os.Open(fileName)
	if err != nil {
		fmt.Printf("打开文件失败:%v\n", err)
		return
	}
	defer fileHandler.Close()
	
	reader := bufio.NewReader(fileHandler)
	for {
		line, err := reader.ReadString('\n')
		fmt.Printf("读取到的文件内容:%v\n", line)
		// 判断读到结尾，需要优先进行判断，否则会报错读取文件内容失败
		if err == io.EOF {
			fmt.Printf("文件读完了\n")
			break
		}
		
		// 判断读取文件内容错误码
		if err != nil {
			fmt.Printf("读取文件内容失败:%v\n", err)
			break
		}
		
	}
}

func readFileByIOUtil(fileName string) {
	// 使用ioutil读取，直接读取全部内容
	// readData类型：[]uint8
	readData, err := ioutil.ReadFile(fileName)
	if err != nil {
		fmt.Printf("读取文件内容错误:%v\n", err)
		return
	}
	fmt.Printf("读取到的内容:%v\n", string(readData))
}

func main(){
	fileName := "./userinfo.txt"
	// 底层方式读取文件内容
	fmt.Println("\n>>>>>>底层方式读取文件内容<<<<<<")
	readFileByLowType(fileName)
	
	// 以bufio读取
	fmt.Println("\n>>>>>>以bufio读取文件内容<<<<<<")
	readFileByBufio(fileName)
	
	// 以io/ioutil读取
	fmt.Println("\n>>>>>>以io/ioutil读取文件内容<<<<<<")
	readFileByIOUtil(fileName)
}
```

### 2、写入文件

#### 2.1 写入文件模式

> `go`可以使用指定模式打开写入内容到文件中
>
> 需要注意的是flag是可以用位运算的`或(|)`来表示文件没有的话就可以先创建

```go
func OpenFile(name string, flag int, perm FileMode) (*File, err) {
    ...
}
/* 
	name: 要打开的文件名
	flag: 打开文件的模式
	perm: 文件权限，是一个八进制数
		  r(读) ： 04
		  w(写) ： 02
		x(执行) ： 01
*/
```

> flag支持的模式：
>
> - os.O_WRONLY	只写
> - os.O_CREATE    创建文件
> - os.O_RDONLY    只读
> - os.O_RDWR      读写
> - os.O_TRUNC     清空
> - os.O_APPEND    追加内容到文件

> 关于文件权限的解释
>
> 在终端输入:
> `ls -l xxx.xxx （xxx.xxx是文件名）`查看的是`xxx文件`之中的文件权限
>
> 那么就会出现相类似的信息，主要都是这些`-rw-rw-r--`
>
> - 一共有十位数，其中：最前面那个 - 代表的是类型
> - 中间那三个 rw- 代表的是所有者（user）拥有的权限
> - 然后那三个 r-- 代表的是组群（group）拥有的权限
> - 最后那三个 r-- 代表的是其他人（other）拥有的权限
>
> 那么CNAME文件的操作权限就是-rw-r-r-- = 644
>
> - rw为什么是6，因为是连在一起，所以是r=4加上w=2所以是6

![image-20220220210813699](go%E7%AC%94%E8%AE%B0.assets/image-20220220210813699.png)

```go
func writeFile(fileName string) {
	fileHandler, err := os.OpenFile(fileName, os.O_APPEND|os.O_CREATE, 0644)
	if err != nil {
		fmt.Printf("openFile failed: %v\n", err)
		return
	}
	fmt.Printf("fileHandler:%v\n", fileHandler)
}
//  os.O_APPEND|os.O_CREATE这是位运算，表示添加文件时，文件不存在，需要现金向创建，后面的0644是文件操作权限，表示文件时可读可写
```

#### 2.2 write写入内容到文件

> 可以将字节或字符串写入到文件中
>
> 可以写入字节和字符串
>
> - `write`可以写入字节
> - `writestring`可以写入字符串

```go
// 写入文件实例代码
/*
  @Author: lyzin
    @Date: 2022/02/17 22:51
    @File: basic_study
    @Desc: 
*/
package main

import (
	"fmt"
	"os"
)

func writeFile(fileName string, fileContent string) {
	fileHandler, err := os.OpenFile(fileName, os.O_WRONLY|os.O_CREATE|os.O_APPEND, 0644)
	if err != nil {
		fmt.Printf("openFile failed: %v\n", err)
		return
	}
	defer fileHandler.Close()

	// write写入字节
	fileHandler.Write([]byte(fileContent))
	// writeString写入字符串
	fileHandler.WriteString(fileContent)
}

func main() {
	// 写入内容到文件
	fileName := "./xx.txt"
	writeFile(fileName, "我是学习go语言")
}
```

#### 2.3 bufio写入内容到文件

> 需要注意的是，写完一定要使用`Flush函数`将写入缓存的内容保存到文件里

```go
/*
  @Author: lyzin
    @Date: 2022/02/17 22:51
    @File: basic_study
    @Desc: 
*/
package main

import (
	"fmt"
	"os"
	"bufio"
)

func writeFile(fileName string, fileContent string) {
	fileHandler, err := os.OpenFile(fileName, os.O_WRONLY|os.O_CREATE|os.O_APPEND, 0644)
	if err != nil {
		fmt.Printf("openFile failed: %v\n", err)
		return
	}
	defer fileHandler.Close()

	// bufio写入文件
	wr := bufio.NewWriter(fileHandler)
	
  // 写入字节，将文件内容写到缓存里
	writer.Write([]byte(fileContent))
  
	// 这里是将文件内容写到缓存里
	wr.WriteString(fileContent)

	// 写完需要将写入到缓存里的东西存到文件中
	wr.Flush()
}

func main() {
	// 写入内容到文件
	fileName := "./xx.txt"
	writeFile(fileName, "我是学习go语言222")
}
```

#### 2.4 ioutil写入内容到文件

> 需要注意`WriteFile`里写入文件时字节切片类型

```go
/*
  @Author: lyzin
    @Date: 2022/02/17 22:51
    @File: basic_study
    @Desc: 
*/
package main

import (
	"fmt"
	"io/ioutil"
)

func writeFile(fileName string, fileContent string) {
	err := ioutil.WriteFile(fileName, []byte(fileContent), 0644)
	if err != nil {
		fmt.Printf("write file err:%v\n", err)
		return
	}
}

func main() {
	// 写入内容到文件
	fileName := "./xx.txt"
	writeFile(fileName, "我是学习go语言ioutil")
}
```

#### 2.5 插入内容到文件

> 这一部分先待定，目前暂时用不到

## 十二、常用模块

### 1、time模块

> 时间概念解释

> **GMT**：Greenwich Mean Time [[1\]
>
> 格林威治标准时间 ; 英国伦敦格林威治定为0°经线开始的地方，地球每15°经度 被分为一个时区，共分为24个时区，相邻时区相差一小时；例: 中国北京位于东八区，GMT时间比北京时间慢8小时。

> **UTC**: Coordinated Universal Time
>
> 世界协调时间；经严谨计算得到的时间，精确到秒，误差在0.9s以内， 是比GMT更为精确的世界时间

> **DST**: Daylight Saving Time
>
> 夏季节约时间，即夏令时；是为了利用夏天充足的光照而将时间调早一个小时，北美、欧洲的许多国家实行夏令时；

> **CST**:
>
> 四个不同时区的缩写：
>
> 1. Central Standard Time (USA) UT-6:00   美国标准时间
> 2. Central Standard Time (Australia) UT+9:30  澳大利亚标准时间
> 3. China Standard Time UT+8:00     中国标准时间
> 4. Cuba Standard Time UT-4:00     古巴标准时间

#### 1.1 当前时间

> 用来表示时间，可以通过`time.Now()`函数获取本地的时间(东八区)，以及年、月、日等对象信息

```go
/*
  @Author: lyzin
    @Date: 2022/02/17 22:51
    @File: basic_study
    @Desc: 
*/
package main

import (
	"fmt"
	"time"
)

func main() {
	now := time.Now()
	fmt.Printf("now:%v\n", now) // now:2022-02-20 22:00:21.9037896 +0800 CST m=+0.002991401
	year := now.Year()
	fmt.Printf("year:%v\n", year) 
	
	month := now.Month()
	fmt.Printf("month:%v\n", month)
	
	day := now.Day()
	fmt.Printf("day:%v\n", day)
	
	hour := now.Hour()
	fmt.Printf("hour:%v\n", hour)
	
	minute := now.Minute()
	fmt.Printf("minute:%v\n", minute)
	
	second := now.Second()
	fmt.Printf("second:%v\n", second)
}
```

#### 1.2 获取时间戳

> 时间戳是最长用的一个时间格式
>
> 表示从1970年至当前时间的总毫秒数，被称为`unix时间戳`
>
> 使用`now.Unix()`获取当前时间戳

```go
/*
  @Author: lyzin
    @Date: 2022/02/17 22:51
    @File: basic_study
    @Desc: 
*/
package main

import (
	"fmt"
	"time"
)

func main() {
	now := time.Now()
	// 秒时间戳
	timeStamp1 := now.Unix()
	fmt.Printf("timeStamp1:%v\n", timeStamp1)

	// 毫秒时间戳
	timeStamp2 := (now.Unix()) * 1000
	fmt.Printf("timeStamp2:%v\n", timeStamp2)
	
	// 纳秒时间戳
	timeStamp3 := now.UnixNano()
	fmt.Printf("timeStamp3:%v\n", timeStamp3)
}
```

#### 1.3 时间间隔常量

> `time`包可以用来快速获取一个时间的常量
>
> 时间间隔只有时、分、秒，没有天、年、日

![image-20220220221753457](go%E7%AC%94%E8%AE%B0.assets/image-20220220221753457.png)

```go
/*
  @Author: lyzin
    @Date: 2022/02/17 22:51
    @File: basic_study
    @Desc: 
*/
package main

import (
	"fmt"
	"time"
)

func main() {
	// 时间间隔秒数, 1秒
	sec := time.Second
	fmt.Printf("sec:%v\n", sec) // 1s

	// 时间间隔分, 1分
	min := time.Minute
	fmt.Printf("min:%v\n", min) // 1m0s

	// 时间间隔小时, 1小时
	hour := time.Hour
	fmt.Printf("hour:%v\n", hour) // 1h0m0s
}
```

#### 1.4 时间后延Add

> 时间可以往后延续
>
> `now.Add()`函数传参里就是对应的时间数，可以是时分秒

```go
/*
  @Author: lyzin
    @Date: 2022/02/17 22:51
    @File: basic_study
    @Desc: 
*/
package main

import (
	"fmt"
	"time"
)

func main() {
	// 时间间隔小时, 1小时
	hour := time.Hour
	fmt.Printf("hour:%v\n", hour) // 1h0m0s

	// 24小时以后，需要先拿到当前时间，再去当前时间的基础上再添加
	now := time.Now()
	afterTime := now.Add(24 * (time.Hour))
	fmt.Printf("afterTime:%v\n", afterTime)
}
```

#### 1.5 时间格式化

##### 1.5.1 当前时间转换为字符串时间

> `go`语言中使用时间模块的`Format`进行格式化，但是不是常见的`%Y-%m-%d %X`，而是用`20061234`来表示，因为`go`语言诞生于2006年1月2号15点04分
>
> 时间格式化是将时间对象转换为字符串类型时间

```go
// 于常见格式对比
Y   		m		d		H		M		S
2006		1		2		3		4		5

// 15:04:05表示24小时计时法
// 03:04:05表示12小时计时法，可以添加AM/PM用来表示上午或下午
```

```go
/*
  @Author: lyzin
    @Date: 2022/02/17 22:51
    @File: basic_study
    @Desc: 
*/
package main

import (
	"fmt"
	"time"
)

func main() {
	// 当前时间
	now := time.Now()

	// 格式化时间
	str1 := now.Format("2006-01-02 03:04")
	fmt.Printf("str1:%v\n", str1)

	// 15:04:05表示24小时计时法
	// 03:04:05表示12小时计时法，可以添加AM/PM用来表示上午或下午
	str2 := now.Format("2006/01/02 15:04:05")
	fmt.Printf("str2:%v\n", str2)
}
```

##### 1.5.2 字符串时间转换为时间戳(parse/ParseInLocation)

> `time.Parse()` 按照对应的格式解析字符串类型的时间，再转换为时间戳
>
> `Parse`函数：
>
> - 解析一个格式化的时间字符串并返回它代表的时间
> - 如果缺少表示时区的信息，Parse会将时区设置为UTC
>   - 当解析具有时区缩写的时间字符串时，如果该时区缩写具有已定义的时间偏移量，会使用该偏移量。如果时区缩写是"UTC"，会将该时间视为UTC时间，不考虑Location

```go
/*
  @Author: lyzin
    @Date: 2022/02/17 22:51
    @File: basic_study
    @Desc: 
*/
package main

import (
	"fmt"
	"time"
)

func main() {
	// timeObj 是返回了字符串类型的时间格式
	timeObj, err := time.Parse("2006-01-02", "2010-10-10")
	if err != nil {
		fmt.Printf("parse time failed:%v\n", err)
	}
	fmt.Printf("timeObj:%v\n", timeObj) // 2010-10-10 00:00:00 +0000 UTC
	fmt.Printf("timeObj:%v\n", timeObj.Unix()) // 1286668800
}
```

> `time.ParseInLocation()`和`time.Parse()`的区别
>
> - 第一，当缺少时区信息时，Parse将时间解释为UTC时间，而ParseInLocation将返回值的Location设置为loc，即作为本地的时区
> - 第二，当时间字符串提供了时区偏移量信息时，Parse会尝试去匹配本地时区，而ParseInLocation会去匹配loc

```go
// ParseInLocation源码
func ParseInLocation(layout, value string, loc *Location) (Time, error)

/* 
	layout: 布局;安排，用来指定时间的格式
	 value: 需要转换的时间字符串
		 loc: 指定时区
*/
```

> 下面代码可以看出来:
>
> - `Parse`函数转换出来的时区是`+0000 UTC`时间，不是东八区
> - `time.LoadLocation`先加载时区，再将获取的时区值传递给`ParseInLocation`函数，这样转换出来的就是东八区时间

```go
package main

import (
	"fmt"
	"time"
)

func main() {
	nowTime := time.Now()
	fmt.Printf("nowTime:%v\n\n", nowTime)
	
	// 手动指定一个时间，计算差值
	specTime := "2019-12-22 12:12:12"
	specTimeFmt, _ := time.Parse("2006-01-02 15:04:05", specTime)
	
	// 可以看到specTimeFmt:2022-02-22 13:12:12 +0000 UTC， 默认不是东八区时间
	fmt.Printf("specTimeFmt:%v\n", specTimeFmt)
	
	// 先加载时区，东八区
	loc, _ := time.LoadLocation("Asia/ShangHai")
	
	// 再将时区传递给ParseInLoaction函数，这样转换出来的时间格式时区也是东八区
	specTimeFmtNew, _ := time.ParseInLocation("2006-01-02 15:04:05", specTime, loc)
	fmt.Printf("\nspecTimeFmtNew:%v\n", specTimeFmtNew)
}
```

##### 1.5.3 时间戳转换为字符串时间

> 使用`time.Unix(时间戳, 0)`转为字符串可读的时间格式
>
> - `0`表示一个标志位
> - `time.Unix()`函数返回的对象继续可以调用`Format`函数进行时间格式化

```go
/*
  @Author: lyzin
    @Date: 2022/02/17 22:51
    @File: basic_study
    @Desc: 
*/
package main

import (
	"fmt"
	"time"
)

func main() {
	// 当前时间
	now := time.Now()

	// 时间戳
	timeStamp1 := now.Unix()
	fmt.Printf("timeStamp1:%v\n", timeStamp1)

	// 时间戳转换为字符串时间
	cu := time.Unix(timeStamp1, 0)
	fmt.Printf("cu:%v\n", cu) // 2022-02-20 22:50:47 +0800 CST

	// cu对象继续调用Format方法进行格式化时间
	fcu := cu.Format("2006/01/02 15:04:05")
	fmt.Printf("fcu:%v\n", fcu) // 2022/02/20 22:50:47
}
```

#### 1.6 time.Sleep

> 下面是`Sleep`的源码

```go
// Sleep源码
// Sleep pauses the current goroutine for at least the duration d.
// A negative or zero duration causes Sleep to return immediately.
func Sleep(d Duration)

// Duration源码
// A Duration represents the elapsed time between two instants
// as an int64 nanosecond count. The representation limits the
// largest representable duration to approximately 290 years.
type Duration int64

const (
	minDuration Duration = -1 << 63
	maxDuration Duration = 1<<63 - 1
)
```

> 从源码可以看出来，Sleep函数需要传入的形参类型是`Duration`，所以不能将一个`int`类型的变量传给它，需要进行转换
>
> 直接在`Sleep()`函数里只写数字，表示单位是`纳秒`

```go
/*
  @Author: lyzin
    @Date: 2022/02/17 22:51
    @File: basic_study
    @Desc: 
*/
package main

import (
	"fmt"
	"time"
)

func main() {
	// 时间间隔
	n := 5
	// 不能直接给Sleep里传入time.Sleep(n)，需要先进行类型转换
	// 下面是休息了5s
	fmt.Printf("5s前开始了:%v\n", time.Now())
	time.Sleep(time.Duration(n) * time.Second)
	fmt.Printf("5s后结束了:%v\n", time.Now())

	fmt.Printf("3s前开始了:%v\n", time.Now())
	time.Sleep(3 * time.Second)
	fmt.Printf("3s后结束了:%v\n", time.Now())
}

```

![image-20220220230924765](go%E7%AC%94%E8%AE%B0.assets/image-20220220230924765.png)

#### 1.7 时间差Sub

> 利用`Sub`函数可以快速计算出两个时间的差值
>
> 需要注意的是，`Sub`时，开始时间、结束时间的时区一定要一致

```go
时间差值 := 结束时间.Sub(开始时间)
```

```go
	nowTime := time.Now()
	fmt.Printf("nowTime:%v\n", nowTime)
	
	// 今天和两天后的时间差
	dt := afterTime.Sub(nowTime)
	fmt.Printf("dt:%v\n", dt)
```

### 2、path模块

> https://studygolang.com/pkgdoc
>
> path实现了对斜杠分隔的路径的实用操作函数。

### 3、os模块

> os包提供了操作系统函数的不依赖平台的接口。设计为Unix风格的，虽然错误处理是go风格的；失败的调用会返回错误值而非错误码。
>
> 通常错误值里包含更多信息:
>
> - 例如，如果某个使用一个文件名的调用（如Open、Stat）失败了，打印错误时会包含该文件名，错误类型将为*PathError，其内部可以解包获得更多信息。
> - os包的接口规定为在所有操作系统中都是一致的。非公用的属性可以从操作系统特定的[syscall](http://godoc.org/syscall)包获取。

### 4、数据类型转换

> Go语言中可以对基础数据类型与字符串之间进行相互转换

#### 4.1 string方法

> string是go的内置方法，不需要引包，直接调用即可
>
> string方法不能将数字转换为string
>
> - 下面代码里因为string会拿着传进来的数字根据utf-8编码去找97对应的符号了，所以是a

```go
package main

import (
	"fmt"
)

func main() {
	i := int32(97)

	// string方法不能将数字转换为string，因为string会拿着传进来的数字根据utf-8编码去找97对应的符号了，所以是a
	ret := string(i)
	fmt.Printf("ret=%v\n", ret) // "a"

	
}
```

#### 4.2 fmt.Sprintf方法

> fmt.Sprintf转换数字为string

```go
package main

import (
	"fmt"
)

func main() {
	i := int32(97)
	// fmt.Sprintf转换数字为string
	ret1 := fmt.Sprintf("%d", i)
	fmt.Printf("ret1 = %#v\n", ret1) // "97"
}
```

#### 4.3 strconv方法

> strconv包实现了基本数据类型和其(其是指基本数据类型)字符串之间的相互转换

##### 4.3.1 ParseInt字符串转数字

> 使用`ParseInt`方法进行转换，返回的值的类型都是`int64`
>
> - 需要注意的是，`ParseInt`方法里的`bitSize`如果指定为了32位，返回结果是int64，那么可以用int32再把结果从int64强制转换为int32，这样结果精度就不会丢
> - 当bitSize为0时，表示是int类型

```go
// ParseInt interprets a string s in the given base (0, 2 to 36) and
// bit size (0 to 64) and returns the corresponding value i.
// ParseInt在给定的base（0，2到36）和 bit 大小（0到64）中解释一个字符串s，并返回相应的值i。
// 位数（0-64），并返回相应的值i。
// The string may begin with a leading sign: "+" or "-".
// 字符串可以以一个前导符号开始。"+"或"-"。
// If the base argument is 0, the true base is implied by the string's
// prefix following the sign (if present): 2 for "0b", 8 for "0" or "0o",
// 16 for "0x", and 10 otherwise. Also, for argument base 0 only,
// underscore characters are permitted as defined by the Go syntax for
// integer literals.
// 如果基数参数为0，则真正的基数是由字符串的
// 符号后面的前缀（如果存在）：2代表 "0b"，8代表 "0 "或 "0o"。
// 16代表 "0x"，否则就是10。另外，仅对参数base 0而言。
// 允许使用下划线字符，这是由Go的语法定义的
// 整数字元。
// The bitSize argument specifies the integer type
// that the result must fit into. Bit sizes 0, 8, 16, 32, and 64
// correspond to int, int8, int16, int32, and int64.
// If bitSize is below 0 or above 64, an error is returned.
// 比特尺寸参数指定了结果必须符合的整数类型。
// 结果必须符合的整数类型。比特大小为0、8、16、32和64
// 对应于int、int8、int16、int32和int64。
// 如果bitSize低于0或高于64，将返回一个错误。
// The errors that ParseInt returns have concrete type *NumError
// and include err.Num = s. If s is empty or contains invalid
// digits, err.Err = ErrSyntax and the returned value is 0;
// if the value corresponding to s cannot be represented by a
// signed integer of the given size, err.Err = ErrRange and the
// returned value is the maximum magnitude integer of the
// appropriate bitSize and sign.
// ParseInt返回的错误有具体类型*NumError
// 如果s是空的或者包含无效的数字，err.Er就会返回错误。
// err.Err = ErrSyntax，返回值为0。
// 如果对应于s的值不能由给定的有符号整数表示
// 如果s对应的值不能由给定大小的有符号整数表示，err.Err = ErrRange，返回值为0。
// err.Err = ErrRange，并且返回值是最大量级的整数。
// 适当的bitSize和符号。
func ParseInt(s string, base int, bitSize int) (i int64, err error) {
	const fnParseInt = "ParseInt"

	if s == "" {
		return 0, syntaxError(fnParseInt, s)
	}

	// Pick off leading sign.
	s0 := s
	neg := false
	if s[0] == '+' {
		s = s[1:]
	} else if s[0] == '-' {
		neg = true
		s = s[1:]
	}

	// Convert unsigned and check range.
	var un uint64
	un, err = ParseUint(s, base, bitSize)
	if err != nil && err.(*NumError).Err != ErrRange {
		err.(*NumError).Func = fnParseInt
		err.(*NumError).Num = s0
		return 0, err
	}

	if bitSize == 0 {
		bitSize = IntSize
	}

	cutoff := uint64(1 << uint(bitSize-1))
	if !neg && un >= cutoff {
		return int64(cutoff - 1), rangeError(fnParseInt, s0)
	}
	if neg && un > cutoff {
		return -int64(cutoff), rangeError(fnParseInt, s0)
	}
	n := int64(un)
	if neg {
		n = -n
	}
	return n, nil
}

```

```go
package main

import (
	"fmt"
	"strconv"
)

// strconv
func main() {
	// 从字符串中解析对应的数字数据，字符串不能有非数字的字符
	str := "100"
    
    // str是需要转换的字符串
    // 10表示转换成10进制
    // 64表示结果必须符合的整数类型，也就是10进制的64位
	ret, err := strconv.ParseInt(str, 10, 64)
	if err != nil {
		fmt.Printf("转换失败:%v\n", err)
		return
	}
	fmt.Printf("ret=%v ret type=%T\n", ret, ret)
}

/* 
	执行结果
	ret=100 ret type=int64
*/
```

> 注意字符串里面不能有非数字的字符，否则会报错
>

![image-20220331213432391](go%E7%AC%94%E8%AE%B0.assets/image-20220331213432391.png)

##### 4.3.2 Atoi字符串转数字

> strconv包里有个`Atoi`方法，专门用来将字符串转换为数字
>
> - `A`表示字符串
>     - 因为Go语言是从C语言发展出来，C语言中没有字符串，只有字符，A是字符的数组，所以A用来表示字符串
> - `i`表示int整型

```go
package main

import (
	"fmt"
	"strconv"
)

// strconv
func main() {
	// 从字符串中解析对应的数字数据，字符串不能有非数字的字符
	str := "100"
	ret, err := strconv.Atoi(str)
	if err != nil {
		fmt.Printf("转换失败:%v\n", err)
		return
	}
	fmt.Printf("ret=%v ret_type=%T\n", ret, ret)
}
```

![image-20220331215400222](go%E7%AC%94%E8%AE%B0.assets/image-20220331215400222.png)



##### 4.3.3 ItoA数字转字符串

> 将数字转换为字符串，只有一个返回值，没有err返回

```go
package main

import (
	"fmt"
	"strconv"
)

// strconv
func main() {
	// 从字符串中解析对应的数字数据，字符串不能有非数字的字符
	s := 100
	ret := strconv.Itoa(s)
	fmt.Printf("ret=%v ret_type=%T\n", ret, ret)
}
```

![image-20220331215554288](go%E7%AC%94%E8%AE%B0.assets/image-20220331215554288.png)

##### 4.3.4 ParseBool字符串布尔值转成布尔值

> `ParseBool`将字符串的布尔值转为真正的布尔值

```go
package main

import (
	"fmt"
	"strconv"
)

// strconv
func main() {
	// 从字符串中解析对应的数字数据，字符串不能有非数字的字符
	s := "true"
	ret, _ := strconv.ParseBool(s)
	fmt.Printf("ret=%v ret_type=%T\n", ret, ret)
}
```

![image-20220331215741171](go%E7%AC%94%E8%AE%B0.assets/image-20220331215741171.png)

##### 4.3.5 ParseFloat字符串浮点型转为浮点型

> `ParseFloat`需要传入`bitSize`

```go
package main

import (
	"fmt"
	"strconv"
)

// strconv
func main() {
	// 从字符串中解析对应的数字数据，字符串不能有非数字的字符
	s := "3.1415"
	ret, _ := strconv.ParseFloat(s, 64)
	fmt.Printf("ret=%v ret_type=%T\n", ret, ret)
}
```

![image-20220331220000832](go%E7%AC%94%E8%AE%B0.assets/image-20220331220000832.png)

### 5、rand模块

> rand模块可以用来生成随机数，是`math`包里的`rand`方法
>
> 注意：
>
> - 生成随机数时，需要有一个种子，否则每次生成的随机数都是一样的

```go
// rand源码
// Intn returns, as an int, a non-negative pseudo-random number in the half-open interval [0,n)
// from the default Source.
// It panics if n <= 0.
func Intn(n int) int { return globalRand.Intn(n) }

// Intn用来生成一个整数的随机数，从代码注释来看是属于：左包含右不包含
```

#### 5.1 生成随机整数

```go
package main

import (
	"fmt"
	"math/rand"
	"time"
)

func getRandNum() int {
	// 种子为了每次生成的随机数不一样，否则会出现每次运行得到的随机数都是一样的
	rand.Seed(time.Now().UnixNano())
	randNum := rand.Intn(19)
	return randNum
}

func getRandEleBySlice(a []int) int {
	if len(a) == 0 {
		panic("input slice is empty")
	}
	
	// 获取随机数
	// 种子为了每次生成的随机数不一样，否则会出现每次运行得到的随机数都是一样的
	rand.Seed(time.Now().UnixNano())
	randEle := rand.Intn(len(a))
	return a[randEle]
}

func main() {
	randNum := getRandNum()
	fmt.Printf("randNum: %v\n", randNum)
	
	a := []int{1,2,3,4}
	randEle := getRandEleBySlice(a)
	fmt.Printf("a=%v\n", randEle)
}
```

#### 5.2 猜数字案例

```go
package main

import (
	"fmt"
	"math/rand"
	"os"
	"time"
)

func getRandNum() int {
	// 种子为了每次生成的随机数不一样，否则会出现每次运行得到的随机数都是一样的
	rand.Seed(time.Now().UnixNano())
	randNum := rand.Intn(10)
	return randNum
}

func guessNumGame() {
	// 生成一个随机数
	guessNum := getRandNum()
	ops := 3
	fmt.Printf("请猜一个0-10的数字，只有%v次机会~\n", ops)
	for i := 1; i <= ops; i++ {
		fmt.Printf(">>>第%d次猜数字<<<\n", i)
	
		var inputNum int
		fmt.Print("请猜一个数字:")
		fmt.Scan(&inputNum)
		
		if inputNum > 10 {
			fmt.Println("输入的数字不在0-10之间")
		} else if inputNum > guessNum {
			fmt.Println("猜大了")
		} else if inputNum < guessNum {
			fmt.Println("猜小了")
		} else {
			fmt.Println("猜对了，随机数是:", guessNum)
			os.Exit(1)
		}
		if i >= ops {
			fmt.Printf("%v次机会已经用完~\n", ops)
			os.Exit(1)
		}
	}
}

func main() {
	// 猜数字
	guessNumGame()
}
```

### 6、go doc

> https://www.kancloud.cn/cattong/go_command_tutorial/261351
>
> 常用来查看当前go文件的文档
>
> godoc可以快速查看对应模块的文档

## 十二、反射

> **程序编译**：
>
> - 程序在编译时，变量的值会被转换为内存地址，变量名不会被编译器写入到可执行部分。
>
> **反射**：
>
> - 是指在程序运行期对程序本身进行访问和修改的能力。
>
> **反射的作用**：
>
> - 在运行程序时，程序无法获取自身的信息。
> - 支持反射的语言可以在程序编译期将变量的反射信息，如字段名称、类型信息、结构体信息等整合到可执行文件中，并给程序提供接口访问反射信息，这样就可以在程序运行期获取类型的反射信息，并且有能力修改它们
>
> `GO`语言中使用`reflect`包来进行访问反射信息
>
> - reflect包使用`reflect.TypeOf`获取对象的类型
> - reflect包使用`reflect.ValueOf`获取对象的值

### 1、反射获取对象类型

> Go语言中，使用`reflect.TypeOf()`函数可以获得任意值的类型对象
>
> 所以可以看到用来获取任意对象的类型

```go
package main

import (
	"fmt"
	"reflect"
)

func reflectType(x interface{}){
	v := reflect.TypeOf(x)
	fmt.Printf("%v type:%v\n",x, v)
}

func main() {
	var a = 34
	reflectType(a)

	var b = "sam"
	reflectType(b)

	var c = true
	reflectType(c)
}
```

![image-20220328223413135](go%E7%AC%94%E8%AE%B0.assets/image-20220328223413135.png)

#### 1.1 类型和种类

> 反射类型其实把类型划分为两种：
>
> - 一种是类型Type
>     - 是指用type关键字创建的自定义类型
> - 一种是种类Kind
>     - 是指底层类型，比如指针，结构体等，表示一大类的类型

```go
package main

import (
	"fmt"
	"reflect"
)

func reflectType(x interface{}){
	v := reflect.TypeOf(x)
	fmt.Printf("type:%v <==> kind:%v\n", v.Name(), v.Kind())
}

func main() {
	var a = 34
	reflectType(a)

	var b = "sam"
	reflectType(b)

	var c = true
	reflectType(c)

	d1 := make([]int, 10, 10)
	d1 = []int{1,2,3,4}
	reflectType(d1)

	type e struct{
		name string
	}
	e1 := e{
		name: "sam",
	}
	reflectType(e1)
}
```

> 从下面的运行结果看出， 结构体的类型是e类型，种类是struct结构体
>
> Go语言的反射中像数组、切片、Map、指针等类型的变量，它们的`.Name()`都是返回`空`。

![image-20220328224924305](go%E7%AC%94%E8%AE%B0.assets/image-20220328224924305.png)

### 2、反射获取值

> `reflect.ValueOf()`返回的是`reflect.Value`类型，其中包含了原始值的值信息。`reflect.Value`与原始值之间可以互相转换。

```go
package main

import (
	"fmt"
	"reflect"
)

func reflectType(x interface{}){
	v := reflect.ValueOf(x)
	fmt.Printf("value:%+v <==> kind:%v\n", v, v.Kind())
}

func main() {
	var a = 34
	reflectType(a)

	var b = "sam"
	reflectType(b)

	var c = true
	reflectType(c)

	d1 := make([]int, 10, 10)
	d1 = []int{1,2,3,4}
	reflectType(d1)

	type e struct{
		name string
	}
	e1 := e{
		name: "sam",
	}
	reflectType(e1)
}
```

![image-20220328225337645](go%E7%AC%94%E8%AE%B0.assets/image-20220328225337645.png)

### 3、结构体反射

> 任意值通过`reflect.TypeOf()`获得反射对象信息后，如果它的类型是结构体，可以通过反射值对象（`reflect.Type`）的两个方法来获取结构体信息
>
> - `NumField()`方法：返回结构体成员字段数量
>     - 所以可以用来统计一个结构体里有多少个字段
> - `Field()`方法：根据索引，返回索引对应的结构体字段的信息
>     - 可以获取一个结构体的一个字段的具体详细信息，比如Name，tag， index等

```go
# Field() 方法源代码， 根据索引，返回索引对应的结构体字段的信息，返回值是StructField类型
// Field returns the i'th struct field.
func (t *structType) Field(i int) (f StructField) {
	if i < 0 || i >= len(t.fields) {
		panic("reflect: Field index out of bounds")
	}
	p := &t.fields[i]
	f.Type = toType(p.typ)
	f.Name = p.name.name()
	f.Anonymous = p.embedded()
	if !p.name.isExported() {
		f.PkgPath = t.pkgPath.name()
	}
	if tag := p.name.tag(); tag != "" {
		f.Tag = StructTag(tag)
	}
	f.Offset = p.offset()

	// NOTE(rsc): This is the only allocation in the interface
	// presented by a reflect.Type. It would be nice to avoid,
	// at least in the common cases, but we need to make sure
	// that misbehaving clients of reflect cannot affect other
	// uses of reflect. One possibility is CL 5371098, but we
	// postponed that ugliness until there is a demonstrated
	// need for the performance. This is issue 2320.
	f.Index = []int{i}
	return
}

// StructField是一个结构体，可以看到这个结构体里的源代码的字段
// A StructField describes a single field in a struct.
type StructField struct {
	// Name is the field name.
	Name string

	// PkgPath is the package path that qualifies a lower case (unexported)
	// field name. It is empty for upper case (exported) field names.
	// See https://golang.org/ref/spec#Uniqueness_of_identifiers
	PkgPath string

	Type      Type      // field type 字段类型
	Tag       StructTag // field tag string 字段标签
	Offset    uintptr   // offset within struct, in bytes 字段在结构体中的字节偏移量
	Index     []int     // index sequence for Type.FieldByIndex 用于Type.FieldByIndex时的索引切片
	Anonymous bool      // is an embedded field 是否匿名字段
}
```

```go
// NumField() 是接口方法
// NumField returns a struct type's field count.
// It panics if the type's Kind is not Struct.
NumField() int
```

#### 3.1 结构体反射示例

> for循环遍历结构体所有字段信息，返回结构体成员字段数量
>
> - for循环会把所有字段的信息获取到
>
> - 当然也可以根据字段名，单独获取字段信息

```go
package main

import (
	"fmt"
	"reflect"
)
type person struct{
	Name string `liu:"name"`
	Age int `liu:"name"`
}

func main() {
	p1 := person{
		Name: "sam",
		Age: 19,
	}
	// 先生成一个reflect的Type类型，才可以调用Field和NumField方法
	t := reflect.TypeOf(p1)
	// t type:person 	 t.kind:struct
	fmt.Printf("t type:%v \t t.kind:%v\n\n", t.Name(), t.Kind())

	// for循环遍历结构体所有字段信息，返回结构体成员字段数量
	for i := 0; i < t.NumField(); i++{
		// Field方法传入索引，返回索引对应的结构体字段的信息，比如Name， Type， Tag等
		field := t.Field(i)
		fmt.Printf("field:%v\n", field)

		// 字段的name就是结构体定义的首字母字段名
		fmt.Printf("name:%v\n", field.Name)

		// 字段的Type就是结构体定义的字段的类型
		fmt.Printf("type:%v\n", field.Type)
		
		// 这里的Tag是我们自己在结构体里定义的liu，使用Get通过tag名获取真正的tag的值
		fmt.Printf("tag:%v\n\n", field.Tag.Get("liu"))
	}
}
```

![image-20220328232318252](go%E7%AC%94%E8%AE%B0.assets/image-20220328232318252.png)

> 通过字段名获取指定结构体字段信息，可以根据字段名，单独获取字段信息，更灵活一些
>
> 使用到了反射值对象（`reflect.Type`）的`FieldByName`方法

```go
// FieldByName源码也是接口方法，需要统一实现，传入了字段名，然后返回了结构体字段类型和布尔类型，结构体字段类型就和上面的for循环一样，可以获取结构字段的详细信息了，比如name，type，tag等
// FieldByName returns the struct field with the given name
// and a boolean indicating if the field was found.
FieldByName(name string) (StructField, bool)
```

```go
package main

import (
	"fmt"
	"reflect"
)
type person struct{
	Name string `liu:"name"`
	Age int `liu:"name"`
}


func main() {
	p1 := person{
		Name: "sam",
		Age: 19,
	}
	// 先生成一个reflect的Type类型，才可以调用Field和NumField方法
	t := reflect.TypeOf(p1)
	// t type:person 	 t.kind:struct
	fmt.Printf("t type:%v \t t.kind:%v\n\n", t.Name(), t.Kind())

	// 根据字段名，单独获取字段信息, 更灵活
	field, ok := t.FieldByName("Name")
	fmt.Printf("fieldObj:%v  ok:%v\n", field, ok)
	if ok {
		// 字段的name就是结构体定义的首字母字段名
		fmt.Printf("name:%v\n", field.Name)

		// 字段的Type就是结构体定义的字段的类型
		fmt.Printf("type:%v\n", field.Type)

		// 这里的Tag是我们自己在结构体里定义的liu，使用Get通过tag名获取真正的tag的值
		fmt.Printf("tag:%v\n\n", field.Tag.Get("liu"))
	}
}
```

## 十三、并发编程(非常重要)

> `go`天生支持并发，所以并发编程很重要，需要好好理解

### 1、并发和并行

> 相关参考资料：
>
> [https://laike9m.com/blog/huan-zai-yi-huo-bing-fa-he-bing-xing,61/](https://laike9m.com/blog/huan-zai-yi-huo-bing-fa-he-bing-xing,61/)
>
> [https://zhuanlan.zhihu.com/p/145587728](https://zhuanlan.zhihu.com/p/145587728)

> - 并发(Concurrency)
>   - 并发是同时发生
>     - 并行指物理上同时执行
>     - 并发的字面意思指的是线程同时开始执行这个事件，后续的执行是串行，还是并行，不确定，依赖于底层的硬件条件和操作系统的调度
>   - 并发的“发”
>     - 这里的发是指，如果有多个线程，都会同一时间先启动，但是线程里内容先不执行，会根据操作系统调度去交替执行
> - 并行(Parallelism)
>   - 并行就是同时执行
>     - 并行是指线程同时执行这个过程
>     - 并发指能够让多个任务在逻辑上交织执行的程序设计
> - 注意：
>   - 并发和并行都必须是多线程的
>   - 如果这些线程可以被同时执行(执行线程的步骤)，这叫并行
>   - 如果这些线程可以同时启动，但没有同时执行(执行线程的步骤)，这叫并发

![preview](go%E7%AC%94%E8%AE%B0.assets/v2-674f0d37fca4fac1bd2df28a2b78e633_r.jpg)

> 上图是Erlang之父画的并发、并行的简单理解图
>
> - 并发
>   - 两个队列**`交替`**使用一个咖啡机
> - 并行
>   - 两个队列**`同时`**使用两个咖啡机
> - 注意
>   - 一个队列对应一个任务(线程)，队列的每个人对应任务的步骤
>   - 并发要处理的任务必须是可分步骤、任务数量大于等于2的
>   - 并行要处理的任务必须是多个处理器(也就是图中的多个咖啡机)

### 2、进程、线程、协程

> 进程（process）：程序在操作系统中的一次执行过程，系统进行资源分配和调度的一个独立单位。
>
> 线程（thread）：操作系统基于进程开启的轻量级进程，是操作系统调度执行的最小单位。
>
> 协程（coroutine）：非操作系统提供而是由用户自行创建和控制的用户态‘线程’，比线程更轻量级。

### 3、goroutine

> Go语言中的并发程序主要是通过基于CSP（communicating sequential processes）的goroutine和channel来实现，当然也支持使用传统的多线程共享内存的并发方式。

#### 3.1 goroutine介绍

> Goroutine是Go语言支持并发的核心
>
> - 在go语言中可以**`同时`**创建N个goroutine，非常的简单方便
> - Goroutine介绍
>   - 一个goroutine会以很小的生命周期开始，一般只有2KB
>   - 和操作系统调度线程不同，操作系统是由系统内核调度的，而goroutine是由go在运行时(runtime)调度的
>   - go在运行时，会进行操作系统资源分配，会把m个goroutine合理地分配给n个操作系统线程，实现m:n的调度机制
>   - 开发人员不需要为go在代码层面维护一个线程池
>- Goroutine的特点
>   - Goroutine 是Go程序中最基本的并发执行单元
>   - 每一个程序都至少包含一个goroutine，也就是main函数的（main goroutine），当go程序创建时，它会默认创建
>   - go语言不需要自己单独写进程、线程、协程，只需要利用goroutine就可以实现并发
>   - 当需要多个任务并发执行的时候，把任务包装成一个函数，然后开启goroutine去执行，就实现了并发
> - 

#### 3.2 Go关键字开启gouroutine

> Go语言中使用goroutine非常简单，只需要在函数或方法调用前加上`go`关键字就可以创建一个goroutine
>
> 从而让该函数或方法（结构体里的定义的函数就叫方法）在新创建的goroutine中执行，而不是在`main goroutine`中执行

```go
# go 关键字创建goroutine
package main

import (
	"fmt"
	"time"
)

func addData(x int) {
	fmt.Printf("x = %v\n", x)
}

// main程序启动以后，会创建一个主goroutine去执行
func main(){
	x := 33
	// go关键字单独开启一个goroutine去执行addData函数
	go addData(x)
	fmt.Printf("this is main func")
}
```

> 执行以后会发现，并没有将addData函数里的Printf内容输出
>
> 为什么没有呢？
>
> - go addData(x)表示开启了一个goroutine，但是此时只是刚开启，就好比是刚刚把通道打开了，但是里面的内容还没进去执行
> - 此时代码继续往下走，执行`fmt.Printf("this is main func")`表示main函数结束了，由main函数启动的goroutine就结束了，此时整个函数就执行完毕了，所以就来不及执行`addData`里的printf内容
>
> 可以用`time.Sleep(time.Second)`这样等待`go addData()`启动并执行完毕，再执行main函数里`printf`语句，这样就可以看到`addData`函数里的输出了

```go
package main

import (
	"fmt"
	"time"
)

func addData(x int) {
	fmt.Printf("x = %v\n", x)
}

func main(){
	x := 33
	// go关键字单独开启一个goroutine去执行addData函数
	go addData(x)
  
  // 使用sleep强制等待新开的goroutine执行完毕，再执行下面的代码
	time.Sleep(time.Second)
	fmt.Printf("this is main func")
}
```

![image-20220403220757049](go%E7%AC%94%E8%AE%B0.assets/image-20220403220757049.png)

##### 3.2.1 for启动goroutine(闭包)

> 上面的都是开启一个goroutine去执行代码，但是我们可以使用for循环开启很多个goroutine

```go
package main

import (
	"fmt"
	"time"
)

func main(){
	for i := 0; i<10; i++{
		// go关键字单独开启一个goroutine去执行匿名函数
		go func() {
			fmt.Println(i)
		}()
	}
	time.Sleep(time.Second)
	fmt.Printf("this is main func")
}
```

![image-20220403221849085](go%E7%AC%94%E8%AE%B0.assets/image-20220403221849085.png)

> 从执行结果来看，并不是我们预期的想要的输出1到10，而是输出了`8 10`这些数字
>
> 为什么会这样呢？
>
> - 从for循环里的`go`关键字后面的匿名函数来看，里面打印了for循环里的`i`变量，对于一个函数内部的变量从函数外部拿，这就是`闭包`
> - 由于for循环很快，所以开启10个goroutine的时候，for循环已经执行完了，那么最后传递给匿名函数里的`i`可能是for循环的最后一个10，或者是中间的某一个，所以就出现了上图的结果
>   - 这里也反映出了启动goroutine是需要一定时间的，因为从for循环来看，先启动了10个goroutine，才开始执行goroutine里面匿名函数里的打印`i`功能，而且输出到终端也需要时间，那么就表示了goroutine是都先启动，再执行里面任务，此时的时间差for循环已经执行结束了，最后的i是10，所以就会出现了上面的结果
>   - 如果goroutine能里面启动，立马执行，就不会有这样的问题
>   - 并不是启动一个就输出展示一个

##### 3.2.2 for启动goroutine(传参)

> 从3.2.1里可以看出，`for`循环启动多个goroutine时，采用闭包传参，会出现多个`goroutine`接收到的参数值都是一样，这样就不符合我们的需求，所以需要给传参
>
> 从下面代码可以看出，走传参形式给goroutine，那么循环一个就给一个值到goroutine中，这样每次循环的值都会被传到启动的goroutine中，这样就不会有问题

```go

package main

import (
	"fmt"
	"time"
)

func main() {
	for i := 0; i < 10; i++ {
		go func(i int) {
			fmt.Printf("i=%v\n", i)
		}(i)
	}
	fmt.Println("main run done!")
	time.Sleep((time.Second) * 2)
}
```

![image-20220427112458128](go%E7%AC%94%E8%AE%B0.assets/image-20220427112458128.png)



> 但是仔细观察上面的代码，使用了`time.Sleep`来等待for循环启动的goroutine执行完，十分的不可控，也不优雅
>

#### 3.3 sync.WaitGroup

> 使用`sync.WaitGroup`来实现goroutine的同步：
>
> - sync.WaitGroup是用来创建等待组
>
> - 从源码可以看到WaitGroup不能被拷贝，因为里面是计数器，如果拷贝了，那计数器的值就不一致了，因为WaitGroup是结构体，结构体是值类型，值类型不像指针类型，指针类型可以保持值一致

```go
// A WaitGroup waits for a collection of goroutines to finish.
// The main goroutine calls Add to set the number of
// goroutines to wait for. Then each of the goroutines
// runs and calls Done when finished. At the same time,
// Wait can be used to block until all goroutines have finished.
//
// A WaitGroup must not be copied after first use.
type WaitGroup struct {
	noCopy noCopy

	// 64-bit value: high 32 bits are counter, low 32 bits are waiter count.
	// 64-bit atomic operations require 64-bit alignment, but 32-bit
	// compilers do not ensure it. So we allocate 12 bytes and then use
	// the aligned 8 bytes in them as state, and the other 4 as storage
	// for the sema.
	state1 [3]uint32
}
```

> 涉及到的sync.WaitGroup三个方法，Add()、Wait()、Done()

> - wg.Add()
>   - 要启动多少个goroutine，就添加多少个计数器，可以一次性加好，也可以在循环里每次挨个加1

```go
// Add adds delta, which may be negative, to the WaitGroup counter.
// If the counter becomes zero, all goroutines blocked on Wait are released.
// If the counter goes negative, Add panics.
//
// Note that calls with a positive delta that occur when the counter is zero
// must happen before a Wait. Calls with a negative delta, or calls with a
// positive delta that start when the counter is greater than zero, may happen
// at any time.
// Typically this means the calls to Add should execute before the statement
// creating the goroutine or other event to be waited for.
// If a WaitGroup is reused to wait for several independent sets of events,
// new Add calls must happen after all previous Wait calls have returned.
// See the WaitGroup example.
func (wg *WaitGroup) Add(delta int) {
	statep, semap := wg.state()
	if race.Enabled {
		_ = *statep // trigger nil deref early
		if delta < 0 {
			// Synchronize decrements with Wait.
			race.ReleaseMerge(unsafe.Pointer(wg))
		}
		race.Disable()
		defer race.Enable()
	}
	state := atomic.AddUint64(statep, uint64(delta)<<32)
	v := int32(state >> 32)
	w := uint32(state)
	if race.Enabled && delta > 0 && v == int32(delta) {
		// The first increment must be synchronized with Wait.
		// Need to model this as a read, because there can be
		// several concurrent wg.counter transitions from 0.
		race.Read(unsafe.Pointer(semap))
	}
	if v < 0 {
		panic("sync: negative WaitGroup counter")
	}
	if w != 0 && delta > 0 && v == int32(delta) {
		panic("sync: WaitGroup misuse: Add called concurrently with Wait")
	}
	if v > 0 || w == 0 {
		return
	}
	// This goroutine has set counter to 0 when waiters > 0.
	// Now there can't be concurrent mutations of state:
	// - Adds must not happen concurrently with Wait,
	// - Wait does not increment waiters if it sees counter == 0.
	// Still do a cheap sanity check to detect WaitGroup misuse.
	if *statep != state {
		panic("sync: WaitGroup misuse: Add called concurrently with Wait")
	}
	// Reset waiters count to 0.
	*statep = 0
	for ; w != 0; w-- {
		runtime_Semrelease(semap, false, 0)
	}
}
```

> - wg.Wait()
>   - 等待计数器减为0，否则会一直等待

```go
// Wait blocks until the WaitGroup counter is zero.
func (wg *WaitGroup) Wait() {
	statep, semap := wg.state()
	if race.Enabled {
		_ = *statep // trigger nil deref early
		race.Disable()
	}
	for {
		state := atomic.LoadUint64(statep)
		v := int32(state >> 32)
		w := uint32(state)
		if v == 0 {
			// Counter is 0, no need to wait.
			if race.Enabled {
				race.Enable()
				race.Acquire(unsafe.Pointer(wg))
			}
			return
		}
		// Increment waiters count.
		if atomic.CompareAndSwapUint64(statep, state, state+1) {
			if race.Enabled && w == 0 {
				// Wait must be synchronized with the first Add.
				// Need to model this is as a write to race with the read in Add.
				// As a consequence, can do the write only for the first waiter,
				// otherwise concurrent Waits will race with each other.
				race.Write(unsafe.Pointer(semap))
			}
			runtime_Semacquire(semap)
			if *statep != 0 {
				panic("sync: WaitGroup is reused before previous Wait has returned")
			}
			if race.Enabled {
				race.Enable()
				race.Acquire(unsafe.Pointer(wg))
			}
			return
		}
	}
}

```

> - wg.Done()
>   - 完成一个goroutine，等待组的计数器减一

```go
// wg.Done 
// Done decrements the WaitGroup counter by one.
func (wg *WaitGroup) Done() {
	wg.Add(-1)
}
```

> 添加了sync后，启动多个goroutine

```go
package main

import (
	"fmt"
	"math/rand"
	"sync"
	"time"
)

var wg sync.WaitGroup

func f(i int) {
	// f函数直接结束前，给等待组的计数器-1
	defer wg.Done()
	// 随机等待n秒
	time.Sleep(time.Second * time.Duration(rand.Intn(1)))
	fmt.Println(i)
}

func main() {
	for i := 0; i < 10; i++ {
		// 开启goroutine前，先给等待组的计数器+1
		wg.Add(1)
		go f(i)
	}

	// 等待wg的计数器值减为0
	wg.Wait()
	fmt.Println("main run done!")
}
```

![image-20220427120247340](go%E7%AC%94%E8%AE%B0.assets/image-20220427120247340.png)

> 会发现每次打印的数字的顺序都不一致
>
> 这是因为10个`goroutine`是并发执行的，而`goroutine`的调度是随机的。

#### 3.4 goroutine结束时机

> goroutine什么时候结束？
>
> - 当goroutine对应的函数结束了，那么启动的goroutine就结束了
> - 在main函数中，当main函数结束了，那么由main函数里启动的goroutine也会结束

#### 3.5 goroutine调度(GMP模型)

> 这块是理论知识，需要多多理解
>
> 参考资料：[https://www.cnblogs.com/sunsky303/p/9705727.html](https://www.cnblogs.com/sunsky303/p/9705727.html)

> `GPM`是Go语言运行时（runtime）层面的实现，是go语言自己实现的一套调度系统。区别于操作系统调度OS线程。
>
> - `G`很好理解，就是个goroutine的，里面除了存放本goroutine信息外 还有与所在P的绑定等信息。
> - `P`管理着一组goroutine队列，P里面会存储当前goroutine运行的上下文环境（函数指针，堆栈地址及地址边界），P会对自己管理的goroutine队列做一些调度（比如把占用CPU时间较长的goroutine暂停、运行后续的goroutine等等）当自己的队列消费完了就去全局队列里取，如果全局队列里也消费完了会去其他P的队列里抢任务。
> - `M（machine）`是Go运行时（runtime）对操作系统内核线程的虚拟， M与内核线程一般是一一映射的关系， 一个groutine最终是要放到M上执行的；
>
> P与M一般也是一一对应的。他们关系是： P管理着一组G挂载在M上运行。当一个G长久阻塞在一个M上时，runtime会新建一个M，阻塞G所在的P会把其他的G 挂载在新建的M上。当旧的G阻塞完成或者认为其已经死掉时 回收旧的M。
>
> P的个数是通过`runtime.GOMAXPROCS`设定（最大256），Go1.5版本之后默认为物理线程数。 在并发量大的时候会增加一些P和M，但不会太多，切换太频繁的话得不偿失。
>
> 单从线程调度讲，Go语言相比起其他语言的优势在于OS线程是由OS内核来调度的，`goroutine`则是由Go运行时（runtime）自己的调度器调度的，这个调度器使用一个称为m:n调度的技术（复用/调度m个goroutine到n个OS线程）。 其一大特点是goroutine的调度是在用户态下完成的， 不涉及内核态与用户态之间的频繁切换，包括内存的分配与释放，都是在用户态维护着一块大的内存池， 不直接调用系统的malloc函数（除非内存池需要改变），成本比调度OS线程低很多。 另一方面充分利用了多核的硬件资源，近似的把若干goroutine均分在物理线程上， 再加上本身goroutine的超轻量，以上种种保证了go调度方面的性能。

#### 3.6 GOMAXPROCS

> 1. Go运行时的调度器使用`GOMAXPROCS`参数来确定需要使用多少个OS线程来同时执行Go代码。
>     - 默认值是机器上的CPU核心数
>         - cpu核心数指的是CPU内核数量,表示一个CPU由多少个核心组成
>         - 例如在一个8核心的机器上，调度器会把Go代码同时调度到8个OS线程上（GOMAXPROCS是m:n调度中的n）
> 2. Go语言中可以通过`runtime.GOMAXPROCS()`函数设置当前程序并发时占用的CPU逻辑核心数。
>     - Go1.5版本之前，默认使用的是单核心执行
>     - Go1.5版本之后，默认使用全部的CPU逻辑核心数
>
> https://blog.csdn.net/zhengyshan/article/details/80641770?spm=1001.2101.3001.6650.1&utm_medium=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-1.pc_relevant_paycolumn_v3&depth_1-utm_source=distribute.pc_relevant.none-task-blog-2%7Edefault%7ECTRLIST%7ERate-1.pc_relevant_paycolumn_v3&utm_relevant_index=2

```go
// 两个任务只有一个逻辑核心，此时是做完一个任务再做另一个任务
package main

import (
	"fmt"
	"runtime"
	"time"
)

func a() {
	for i := 1; i < 10; i++ {
		fmt.Println("A:", i)
	}
}

func b() {
	for i := 1; i < 10; i++ {
		fmt.Println("B:", i)
	}
}

func main() {
	runtime.GOMAXPROCS(1)
	go a()
	go b()
	time.Sleep(time.Second)
}
```

```go
// 
package main

import (
	"fmt"
	"runtime"
	"time"
)

func a() {
	for i := 1; i < 10; i++ {
		fmt.Println("A:", i)
	}
}

func b() {
	for i := 1; i < 10; i++ {
		fmt.Println("B:", i)
	}
}

func main() {
	runtime.GOMAXPROCS(2)
	go a()
	go b()
	time.Sleep(time.Second)
}
```

### 4、channel

#### 4.1 channel介绍

> 为什么需要设计channel？
>
> - 单纯地将函数并发执行是没有意义的，函数与函数间需要交换数据才能体现并发执行函数的意义。
> - 虽然可以使用共享内存进行数据交换，但是共享内存在不同的`goroutine`中容易发生竞态问题。
> - 为了保证数据交换的正确性，必须使用互斥量对内存进行加锁，这种做法势必造成性能问题。
>
> go语言的channel：
>
> - Go语言的并发模型是`CSP（Communicating Sequential Processes）`，提倡`通过通信共享内存`而不是`通过共享内存而实现通信`
> - 推荐使用通过通信共享内存：
>     - 通过通信共享内存，把数据发送给其他人需要使用的人，比如一个管道，这样就不会有问题
> - 通过共享内存而实现通信
>     - 使用共享内存来实现数据交换，这个时候就会出现有人读，有人写，就出现了数据竞态问题，这个时候数据交换正常，就要考虑给共享内存里的数据进行加锁，但是这样会有性能损耗，而且会把并行变为串行
> - 如果说`goroutine`是Go程序并发的执行体，`channel`就是它们之间的连接。
> - `channel`是可以让一个`goroutine`发送特定值到另一个`goroutine`的通信机制，这样就实现了通过通信共享内存变量
>
> - Go 语言中的通道（channel）是一种特殊的类型。
>     - 通道像一个传送带或者队列，总是遵循先入先出（First In First Out）的规则，保证收发数据的顺序。
>     - 每一个通道都是一个具体类型的导管，也就是声明channel的时候需要为其指定元素类型，这一点和切片很像

#### 4.2 channel声明

```go
var 变量 chan 元素类型

// 下面是例子
var ch1 chan int // 声明一个传递整型的通道
var ch1 chan bool // 声明一个传递布尔值的通道
var ch1 chan []int // 声明一个传递int切片的通道

// 可以把channel理解为一个管道
```

#### 4.3 channel定义使用

> `channel`是引用类型，需要初始化才可以使用，也就是开辟空间
>
> 从下面可以看出：
>
> - channel不初始化，他的值就是nil(表示没有开辟内存空间)
> - channel的类型是：chan int

```go
package main

import (
	"fmt"
)

func main() {
	var c1 chan int
	
	// 定义的c1:<nil>
	fmt.Printf("定义的c1:%v\n", c1)
	
	// 定义的c1类型:chan int
	fmt.Printf("定义的c1类型:%T\n", c1)

}
```

#### 4.4 channel初始化

> channel使用make进行初始化，可以看到初始化以后，c1这个管道就有内存地址
>
> 所有channel必须初始化才可以使用

```go
package main

import (
	"fmt"
)

func main() {
	var c1 chan int
	
	// 定义的c1:<nil>
	fmt.Printf("定义的c1:%v\n", c1)
	
	// 定义的c1类型:chan int
	fmt.Printf("定义的c1类型:%T\n", c1)
	
	c1 = make(chan int)
	
	// 初始化的c1:0xc00008c060
	fmt.Printf("初始化的c1:%v\n", c1)
	
	// 初始化的c1类型:chan int
	fmt.Printf("初始化的c1类型:%T\n", c1)
}
```

#### 4.5 channel发送值

```go
// 语法
var c1 chan int

// 发送一个值给c1这个管道
c1 <- 1
```

#### 4.6 channel接收值(取值)

```go
// 语法
var c1 chan int

// 发送一个值给c1这个管道
c1 <- 1

// 从管道c1里获取值，并用ret变量接收，如果不想接收，可使用匿名变量`_`接收
ret := <- c1
```

#### 4.7 channel初始化指定缓冲区

> channel初始化的时候可以不指定缓冲区大小，也可以指定
>
> 区别：
>
> - 无缓冲区，必须有人收，才可以发
> - 有缓冲区，表示可以预存多少个值，当缓冲区存满了，就存不进去了，如果需要存新的值，就需要先从管道拿值，才可以存进行新值

##### 4.7.1 无缓冲死锁

> 无缓冲区可以理解为是一个同步的过程，比如打电话给某人，发起打电话，就是给管道发送值，但是没有缓冲区，就表示没有人接，就会一值卡在那里等待，除非有人接了，下面的步骤才可以正常进行
>
> 也表示代码在此处阻塞了

```go
package main

import (
	"fmt"
)

func main() {
	var c1 chan int
	
	c1 = make(chan int)
	
	c1 <- 2  // 这里就会卡主，夯住了
	fmt.Printf("存了值的c1:%v\n", c1)
	ret := <- c1
	fmt.Printf("取了值的c1:%v\n", c1)
	fmt.Printf("取出ret:%v\n", ret)
	
}
```

![image-20220501214315620](go%E7%AC%94%E8%AE%B0.assets/image-20220501214315620.png)



> 从上面的报错可以看出来：
>
> - 所有的goroutine都休眠了，死锁了

##### 4.7.2 无缓冲区死锁解决

> 无缓冲区没人接受管道的值，就会出现死锁，死锁以后，如何解决？
>
> - 可以在后台启动一个goroutine，来接收给channel发送的值
>     - 当main函数里的goroutine启动以后，就一直在等待管道里发一个值进来，只要管道发送一个值进行以后，就立马接收

```go
package main

import (
	"fmt"
)

func main() {
	var c1 chan int
	
	c1 = make(chan int)
	
	// 启动一个匿名函数接收管道发送的值，这个goroutine是后台启动的，接收管道的值
	go func(){
		ret := <- c1
		fmt.Printf("取出ret:%v\n", ret)
	}()
	
	c1 <- 2
	fmt.Printf("存了值的c1:%v\n", c1)
}
```

![image-20220501214754826](go%E7%AC%94%E8%AE%B0.assets/image-20220501214754826.png)

##### 4.7.3 有缓冲区的通道

> 通道里放的值应该小一点，如果存string等大存量的值，可以放指针

```go
package main

import (
	"fmt"
)

func main() {
	var c1 chan int
	c1 = make(chan int, 2)
	c1 <- 1
	c1 <- 2
	fmt.Printf("c1:%vs\n", c1)
	
	// 取值
	ret := <- c1
	fmt.Printf("ret:%v\n", ret)
}
```

![image-20220501215536702](go%E7%AC%94%E8%AE%B0.assets/image-20220501215536702.png)

##### 4.7.4 有缓冲区发送值超过缓冲区

> 当初始化管道时，指定了缓冲区大小，然后给管道里存放值，当超过设置的缓冲区大小时，就存不进去了，就会报错
>
> 因为存满以后，管道就满了，如果没人从管道里取值，就会出现存不进去，代码就卡主的情况

```go
package main

import (
	"fmt"
)

func main() {
	var c1 chan int
	c1 = make(chan int, 1)
  
  // 发送第一个值，管道缓冲区占满了
	c1 <- 1
  
  // 发送第二值时，缓冲区满了，发送值进不去了，就会死锁
	c1 <- 2
	fmt.Printf("c1:%vs\n", c1)
	
	// 取值
	ret := <- c1
	fmt.Printf("ret:%v\n", ret)
}
```

![image-20220501215732031](go%E7%AC%94%E8%AE%B0.assets/image-20220501215732031.png)

#### 4.8 channel关闭

```go
// channel关闭，使用内置的close函数关闭通道
var c1 chan int

// 关闭通道
close(c1)
```

```go
package main

import (
	"fmt"
)

func main() {
	var c1 chan int
	
	c1 = make(chan int, 2)
	
	// 塞第一个值
	c1 <- 1
	
	// 塞第二个值
	c1 <- 2
	
	// 关闭通道
	close(c1)
	
	// 取第一个值
	<- c1
	
	// 取第二个值
	<- c1
	
	// 再取值
	ret, ok := <- c1
	
	// ret:0
	fmt.Printf("ret:%v\n", ret)
	
	// ok:false
	fmt.Printf("ok:%v\n", ok)
}
```

##### 4.8.1 channel关闭注意事项

> - 从通道取值时，可以拿到值和一个布尔值，如果布尔值为true表示值存在，如果布尔值为false，表示值不存在
> - 取值时通道关闭：
>     - 当通道缓冲区没有取完时，可以正常取值
>     - 当通道的缓冲区取完时，再从通道获取值，得到的值是通道定义时类型的零值，且返回的布尔值是false，表示值不存在
> - 取值时通道不关闭
>     - 当通道的缓冲区取完时，再从通道获取值，此时会报错，提示死锁
>     - 可以理解为通道内的值都被取完了，此时还想获取值，就拿不到，代码就阻塞了

![image-20220502002356328](go%E7%AC%94%E8%AE%B0.assets/image-20220502002356328.png)

#### 4.9 chhannel练习题

> // 练习题
>
> 步骤1：启动一个goroutine生成100个数发给c1
>
> 步骤2：启动一个goroutine，从c1中取值，计算其平方放到c2中
>
> 步骤3：在main函数中取值，打印出来

```go
package main

import (
	"fmt"
	"sync"
)

// 定义等待组
var wg sync.WaitGroup

// 步骤1：生成100个数发给c1
func getChData(c1 chan int){
	defer wg.Done()
	for i := 1; i <= 100; i++{
		// 给c1发送值
		c1 <- i
	}
	// 需要关闭c1通道
	close(c1)
}

// 步骤2：从c1中取值，计算其平方放到c2中
func recvChData(c1, c2 chan int){
	defer wg.Done()
	for {
		v, ok := <- c1
		if !ok {
			break
		}
		c2 <- v * v
	}
	
	// 需要关闭c2通道
	close(c2)
}

func main() {
	// 定义和初始化c1
	var c1 chan int
	c1 = make(chan int, 100)
	
	// 定义和初始化c2
	var c2 chan int
	c2 = make(chan int, 100)
	
	// 给第一个goroutine设置等待组计数器+1
	wg.Add(1)
	go getChData(c1)
	
	// 给第二个goroutine设置等待组计数器+1
	wg.Add(1)
	go recvChData(c1, c2)
	
	// 步骤3：在main函数中取值，打印出来
	for ret := range c2{
		fmt.Printf("c2中的ret: %v\n", ret)
	}
	
	// 等待所有计数器减为0
	wg.Wait()
}
```

#### 4.10 单向通道

> 当一个通道只允许发送值，或者只允许接收值时，就可以使用单向通道
>
> 比如通道作为函数的传参，只允许做一件事
>
> 单向通道快速理解为：”前接后发“
>
> 符号`<-`在chan前，表示只能接收值，也就是只能从通道里取值
>
> 符号`<-`在chan后，表示只能发送值，也就是只能给通道发送值
>
> 注意：
>
> - 单向通道不是在通道初始化(make函数)的时候定义
> - 而是在通道定义(使用var关键字)的时候使用

##### 4.10.1 只允许通道发送值

```go
// 只允许通道发送值，表示不能接收值，只能发送
func f1(c1 chan<- int) {}
```

```go
package main

import (
	"fmt"
)


func main() {
	// 定义和初始化c1，只允许发送值给c1
	var c1 chan<- int
	c1 = make(chan int, 100)
	
	// 给c1发送值
	c1 <- 1
	
  // 从c1取值，就会报错，提示从一个只读通道接收值
	ret := <- c1
	fmt.Printf("ret:%v\n", ret)
}
```

![image-20220502003436158](go%E7%AC%94%E8%AE%B0.assets/image-20220502003436158.png)

##### 4.10.2 只允许通道接收值

```go
// 只允许通道接收值，表示只能接收，不能发送值
func f1(c2 <-chan int) {}
```

```go
package main

import (
	"fmt"
)


func main() {
	// 定义和初始化c1，只允许通道接收值c1
	var c1 <-chan int
	c1 = make(chan int, 100)
	
	// 给c1发送值，但是c1是一个只接收的通道，所以到这里会报错
	c1 <- 1
	
	ret := <- c1
	fmt.Printf("ret:%v\n", ret)
}
```

![image-20220502003746091](go%E7%AC%94%E8%AE%B0.assets/image-20220502003746091.png)

#### 4.11 channel使用报错汇总

> https://www.jianshu.com/p/b886c62e7eb8?utm_campaign=maleskine&utm_content=note&utm_medium=seo_notes&utm_source=recommendation
>
> https://www.jianshu.com/p/cfcc33df4fdb

##### 4.11.1 channel存值非指定类型(报错类型)

> 当给channel存的值不是定义channel时的类型，就会报错

```go
package main

import (
	"fmt"
)

func main() {
	var c1 chan int
	c1 = make(chan int, 1)
  
  // channel本来是int类型，但是发送了一个string，就会报错
	c1 <- "sam"
	fmt.Printf("c1:%vs\n", c1)
	
	// 取值
	ret := <- c1
	fmt.Printf("ret:%v\n", ret)
}
```

![image-20220501220020185](go%E7%AC%94%E8%AE%B0.assets/image-20220501220020185.png)

##### 4.11.2 channel关闭后不能再关闭

```go
channel关闭后不能再关闭，会引发panic
```

```go
package main

func main() {
	// 定义和初始化c1，只允许通道接收值c1
	var c1 chan int
	c1 = make(chan int, 100)
	
	// 给c1发送值
	c1 <- 1
	
	// 第一次关闭
	close(c1)
	
	// c1关闭后再关闭c1，会报错
	close(c1)
}
```

![image-20220502004944710](go%E7%AC%94%E8%AE%B0.assets/image-20220502004944710.png)

#### 4.12 channel异常汇总

> 下表是channel的异常汇总

| channel    | nil   | 非空                                                       | 为空                                                         | 满载                                                       | 没满                                                       |
| ---------- | ----- | ---------------------------------------------------------- | ------------------------------------------------------------ | ---------------------------------------------------------- | ---------------------------------------------------------- |
| 接收值动作 | 阻塞  | 接收值正常                                                 | 阻塞                                                         | 接收值正常                                                 | 接收值正常                                                 |
| 发送值动作 | 阻塞  | 发送值正常                                                 | 发送值正常                                                   | 阻塞                                                       | 发送值正常                                                 |
| 关闭通道   | panic | 关闭成功以后，读完缓冲区的数据，再读取值就是通道类型的零值 | 关闭成功以后，此时缓冲区的数据为空，再读取值就是通道类型的零值 | 关闭成功以后，读完缓冲区的数据，再读取值就是通道类型的零值 | 关闭成功以后，读完缓冲区的数据，再读取值就是通道类型的零值 |

#### 4.13 work_pool

> 工作池用来巩固通道的理解

```go
package main

import (
	"fmt"
	"time"
)

func worker(id int, jobs <-chan int, result chan<- int) {
	for j := range jobs{
		fmt.Printf("workerId: %d, start job jobVal:%d\n", id, j)
		time.Sleep(time.Second)
		fmt.Printf("workerId: %d, end job jobval:%d\n", id, j)
		result <- j * 2
	}
}

func main() {
	jobs := make(chan int, 100)
	results := make(chan int, 100)
	
	// 启动3个goroutine执行任务
	for w := 1; w <= 3; w++{
		go worker(w, jobs, results)
	}
	
	// 启动5个任务，表示给jobs通道里塞了5个值
	for j := 1; j <= 5; j++{
		jobs <- j
	}
	
	// 关闭jobs通道
	close(jobs)
	
	// 输出结果
	for a := 1; a <= 5; a++{
		<- results
		// fmt.Printf("res=%v\n", res)
	}
}
```

#### 4.14 select使用

> `select`可以同时响应多个通道的操作，select的使用类似由于switch语句：
>
> - select语句会有一些case分支和default分支
>
>
> - 每个case会对应一个通道的操作过程，比如接收或发送
>
>
> - select会一直等待，当case语句执行完毕，就会执行case语句里的代码
> - select语句能提高代码可读性，如果多个case同时满足，select会随机选择一个，对于没有case的select{}会一直等待中
> - select可以在外面套个循环，表示循环取值

```go
// select语法
select {
	case <-ch1:
		...
	case data := <-ch2:
		...
	default:
		...
}
```
```go
package main

import (
	"fmt"
)

func main() {
	ch1 := make(chan int, 1)
	for i := 0; i < 10; i++{
		select {
		case x := <- ch1:
			fmt.Printf("x=%v\n", x)
		case ch1 <- i:
		default:
			fmt.Printf("default operate")
		}
	}
}
```

![image-20220502142538484](go%E7%AC%94%E8%AE%B0.assets/image-20220502142538484.png)

