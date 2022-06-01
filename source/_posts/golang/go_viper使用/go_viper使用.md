---
title: Golang Viper使用
date: 2022-05-24 21:30:31
updated: 2022-05-24 21:30:31
tags:
- Viper
- Golang
cover: /posts_cover_img/golang/go_viper.png
categories: Golang Viper使用
---

## 一、viper介绍与安装

### 1、什么是viper？

> 地址：https://github.com/spf13/viper

> Viper是一个完整的Go应用程序(包括Twelve-Factor App)的配置解决方案，它被设计为在应用程序中工作，并能处理所有类型的配置需求和格式。它支持:
>
> - 设置默认值
> - 读取JSON、TOML、YAML、HCL、envfile和Java properties格式的配置文件
> - 实时监控和重读配置文件（可选)
> - 从环境变量中读取
> - 从远程配置系统（etcd或Consul）中读取、监控配置变化
> - 从命令行参数读取
> - 从缓冲区读取
> - 显式配置值
> - Viper可以被认为是一个注册表，满足你所有的应用配置需求。

### 2、viper的特点

> 为什么选择Viper？
>
> - 在构建一个现代化的应用程序时，你不想担心配置文件的格式；你想专注于构建一个出色的软件。Viper就是来帮助你的。
>
> - Viper为你做以下工作。
>
>     1. 查找、加载和解除JSON、TOML、YAML、HCL、INI、envfile或Java属性格式的配置文件。
>
>     2. 提供一种机制，为你的不同配置选项设置默认值。
>
>     3. 提供一种机制，为通过命令行标志指定的选项设置覆盖值。
>
>     4. 提供一个别名系统，在不破坏现有代码的情况下轻松重命名参数。
>
>     5. 使得用户提供的命令行或配置文件与默认值相同时，可以很容易地分辨出来。
>
>     6. Viper使用以下优先顺序。每一项都优先于它下面的项目。
>
>         - 显式调用Set设置值
>
>         - 命令行参数(flag)
>
>         - 环境变量
>
>         - 配置文件
>
>         - key/value存储
>
>         - 默认值
>
> - 重要提示：Viper配置的键(key)是不区分大小写的。目前正在讨论如何使之成为可选项。

### 3、viper安装

> 注意: Viper使用Go Modules来管理依赖

```bash
# 安装
go get github.com/spf13/viper
```

## 二、viper使用

### 1、viper初始化配置

> viper使用的时候，需要先进行初始化配置

#### 1.1 设置默认值

> ”一个好的配置系统应该支持默认值。键不需要默认值，但如果没有通过配置文件、环境变量、远程配置或命令行标志（flag）设置键，则默认值非常有用。“这句话来自官网翻译
>
> 从`SetDefault`方法注释可以看出来：
>
> - SetDefault对于一个键来说是不分大小写的
> - 默认值只在用户没有通过flag、config或ENV提供值时使用
>
> 具体的使用场景后面再说，目前来说先给配置上

```go
// SetDefault源码
// SetDefault sets the default value for this key.
// SetDefault is case-insensitive for a key.
// Default only used when no value is provided by the user via flag, config or ENV.
func SetDefault(key string, value interface{}) { v.SetDefault(key, value) }
```

```go
package main

import (
	"fmt"
	"github.com/fsnotify/fsnotify"
	"github.com/spf13/viper"
)

func main() {
    // 设置默认值
	viper.SetDefault("conf", ".")
}
```

#### 1.2 配置初始化方式一

##### 1.2.1 SetConfigName

> 配置文件名称:
>
> - 如果配置文件全名叫“xxx.yaml”:
>     - `SetConfigName`方法可以只写`xxx`(配置文件名，不写后缀)，然后需要继续调用`SetConfigType`方法写上`xxx`配置文件的后缀`yaml`，这样才算将配置文件传入正确
> - 如果配置文件的名称中没有扩展名，更要配置`SetConfigType`方法中配置`配置文件格式`，告诉`viper`以哪种配置文件格式来解析配置文件

```go
// SetConfigName sets name for the config file.
// Does not include extension.
func SetConfigName(in string) { v.SetConfigName(in) }
```

```go
// 配置文件叫config.yaml
// 需要调用SetConfigType传入配置文件的类型
viper.SetConfigName("config")	
viper.SetConfigType("yaml")
```

##### 1.2.2 SetConfigType

> 设置配置文件的格式
>
> - 如果配置文件的名称中有扩展名(如“config.yaml”)，一定需要配置此项
> - 如果配置文件的名称中没有扩展名(如“config”)，一定需要配置此项

```go
// SetConfigType sets the type of the configuration returned by the
// remote source, e.g. "json".
func SetConfigType(in string) { v.SetConfigType(in) }
```

```go
// 配置文件叫config.yaml
// 需要调用SetConfigType传入配置文件的类型
viper.SetConfigName("config")	
viper.SetConfigType("yaml")
```

##### 1.2.3 AddConfigPath

> AddConfigPath用来添加配置文件路径的，告诉`viper`从哪里开始找配置文件
>
> - AddConfigPath用来添加路径，使的viper可以从传入的路径来搜索配置文件
> - AddConfigPath方法可以被调用多次，添加多个搜索路径
>
> 注意：
>
> - 如果配置文件和配置初始化的代码文件`在同一个路径`下，可以写成相对路径
>     - 比如文件夹a，文件夹a里面有config.yaml、readConf.go
>     - 那么AddConfigPath里写成`./a`
> - 如果配置文件和配置初始化的代码文件`不在同一个路径`下，可以写成相对路径比如：
>     - 文件夹a，文件夹a里面有config.yaml
>     - 文件夹b，文件夹b里面有readConf.go
>     - 文件夹a和文件夹b处于同级目录
>     - 那么readConf.go里的AddConfigPath里写成`./a`

```go
// AddConfigPath adds a path for Viper to search for the config file in.
// Can be called multiple times to define multiple search paths.
func AddConfigPath(in string) { v.AddConfigPath(in) }
```

```go
viper.AddConfigPath("./viper_demo/")
viper.AddConfigPath(".")
```

> 至此配置初始化完成

#### 1.3 配置初始化方式二

##### 1.3.1 SetConfigFile

> SetConfigFile需要明确地定义了配置文件的路径、名称和扩展名。
>
> 当指定了以后，viper将使用指定的配置文件，而不检查任何的配置路径。
>
> 也就是说这种配置方式相当于一步到位配置好了配置文件初始化

```go
// SetConfigFile explicitly defines the path, name and extension of the config file.
// Viper will use this and not check any of the config paths.
func SetConfigFile(in string) { v.SetConfigFile(in) }
```

```go
viper.SetConfigFile("./viper_demo/db_conf.yaml")
```

#### 1.4 查找与读取配置文件

> 上面介绍了两种配置初始化方式，个人觉得配置初始化方式一更加灵活一些，也推荐使用
>
> 配置初始化好了以后，就可以读取配置了

##### 1.4.1 ReadInConfig

> ReadInConfig会查找并从磁盘里加载配置文件，包括`key/value`通过定义的路径查找
>
> 读取成功以后，就可以获取配置文件内容了

```go
// ReadInConfig will discover and load the configuration file from disk
// and key/value stores, searching in one of the defined paths.
func ReadInConfig() error { return v.ReadInConfig() }
```

```go
// 读取配置文件的部分代码
err := viper.ReadInConfig()
if err != nil {
	fmt.Printf("读取conf配置文件失败:%v\n", err)
	return	
}
```

##### 1.4.2 读取不到配置处理

> 可以对配置文件在读取不到时，作进一步的更详细的错误处理
>
> - 可以处理没有找到的文件的错误
> - 如果文件找了，那可以是viper解析的错误
>
> 这样处理会读取配置文件会更具体

```go
// 读取配置
err := viper.ReadInConfig()
if err != nil {
	_, ok := err.(viper.ConfigFileNotFoundError)
	if ok {
		fmt.Printf("读取配置文件时未找到:%v\n",err)
		return
	} else{
		fmt.Printf("读取配置文件已找到，读取内容时错误:%v\n", err)
		return
	}
}
fmt.Println("读取配置文件成功")
```

##### 1.4.3 读取正确示例

> 下面是读取正确的

![image-20220525231840025](go_viper%E4%BD%BF%E7%94%A8/image-20220525231840025.png)

##### 1.4.4 配置文件找不到示例

> 下面是当配置文件找不到时的错误提示
>
> 可以看到报错提示是`db_conf`在后面的路径没有找到

![image-20220525232108075](go_viper%E4%BD%BF%E7%94%A8/image-20220525232108075.png)

##### 1.4.5 配置文件找到但内容格式错误

> 当配置文件路径正确，但是配置文件里面的内容格式出错时
>
> 就会提示内容有报错

![image-20220525232333300](go_viper%E4%BD%BF%E7%94%A8/image-20220525232333300.png)

#### 1.5 初始化与读取配置完整示例

```go
package main

import (
	"fmt"
	"github.com/spf13/viper"
)

func main(){
	// 设置默认值
	viper.SetDefault("conf", ".")
	
	// 下面是读取配置文件
	// 配置文件名称，无扩展名
	viper.SetConfigName("db_conf")
	
	// 需要配置此项，指定配置文件类型
	viper.SetConfigType("yaml")
	
	// 查找配置文件所在路径，可以加很多个
	viper.AddConfigPath("./conf/")
	
	// 读取配置
	err := viper.ReadInConfig()
	if err != nil {
		_, ok := err.(viper.ConfigFileNotFoundError)
		if ok {
			fmt.Printf("读取配置文件时未找到:%v\n",err)
			return
		} else{
			fmt.Printf("读取配置文件已找到，读取内容时错误:%v\n", err)
			return
		}
	}
	fmt.Println("读取配置文件成功")
}
```

### 2、viper获取配置文件里的值

#### 2.1 获取值支持的方法

> Viper提供了下面这些方法根据值类型获取值，具体内部实现可以去看源码
>
> 需要注意：
>
> - Get方法获取到map类型的值时，没法使用中括号里面填写key来获取对应value，会提示空接口类型不支持索引的报错

```go
Get(key string) : interface{}
GetBool(key string) : bool
GetFloat64(key string) : float64
GetInt(key string) : int
GetIntSlice(key string) : []int
GetString(key string) : string
GetStringMap(key string) : map[string]interface{}
GetStringMapString(key string) : map[string]string
GetStringSlice(key string) : []string
GetTime(key string) : time.Time
GetDuration(key string) : time.Duration
IsSet(key string) : bool
AllSettings() : map[string]interface{}
```

#### 2.2 IsSet方法校验key存在

> 需要注意的是：每一个Get方法在找不到值的时候都会返回零值(nil)，有些场景为了能够保证能够读取正确的值，从而避免不必要的问题出现，那么就提供了IsSet方法，用来校验给定的键(key)是否存在
>
> 上面的这些Get方法都适用

```go
// IsSet方法
// IsSet checks to see if the key has been set in any of the data locations.
// IsSet is case-insensitive for a key.
func IsSet(key string) bool { return v.IsSet(key) }
```

> 从IsSet方法的代码注释可以看出来：
>
> - IsSet检查键是否在任何数据位置被设置过
>     - key存在，返回True
>     - key不存在，返回False
> - IsSet对于一个键是不分大小写的

#### 2.3 常用获取值的方法

##### 2.3.1 Get方法

> Get方法用来根据传入的key获取配置文件里的值
>
> - Get可以检索任何给定使用的键的值
>     - 返回的是一个空接口类型的值
>     - 如果是map类型，则不能使用map的中括号里放key找值
> - `对于一个键，Get是不区分大小写的`
> - Get的行为是返回与第一个
> - 设置的地方相关的值。Viper将按照以下顺序进行检查。
>     - override, flag, env, config file, key/value store, default
>     - 获取返回一个接口。对于一个特定的值，请使用Get 方法中的一种。
>
> - 当找不到值的时候，会返回一个零值
>     - 所以为了检查给定的键是否存在，viper提供了IsSet方法

```go
// Get方法
// Get can retrieve any value given the key to use.
// Get is case-insensitive for a key.
// Get has the behavior of returning the value associated with the first
// place from where it is set. Viper will check in the following order:
// override, flag, env, config file, key/value store, default
//
// Get returns an interface. For a specific value use one of the Get____ methods.
func Get(key string) interface{} { return v.Get(key) }
```

```go
// 部分代码
// 通过IsSet先判断get的key是否存在
keyExist := viper.IsSet("ports")
if keyExist {
	port := viper.Get("port")
	fmt.Printf("获取到port:%v\n", port)
} else {
	fmt.Println("获取port key不存在")
}
	
// key存在
host := viper.Get("host")
fmt.Printf("获取到host:%v  Type:%T\n", host, host)
	
// key name存在, 但是输入错误的key为names
name := viper.Get("names")
fmt.Printf("获取到name:%v  Type:%T\n", name, name)
```

> 配置文件里的内容

![image-20220526004036761](go_viper%E4%BD%BF%E7%94%A8/image-20220526004036761.png)

> 执行结果分析
>
> - 使用IsSet()先进行key是否判断：
>     - 当输入的`key`为`ports`时，在配置文件中是没有这个key的，所以`keyExist`是`false`，所以走到了else分支
> - 不使用IsSet()先进行key是否判断
>     - 当输入的`key`为`host`时，在配置文件中是`有`这个key的，所以能打印出他的值为`127.0.0.1`
>     - 当输入的`key`为`names`时，在配置文件中是`没有`这个key的，所以打印出来是`nil`，表示空值

![image-20220526004100996](go_viper%E4%BD%BF%E7%94%A8/image-20220526004100996.png)

##### 2.3.2 GetString方法

> GetString以字符串形式返回与键相关的值。

```go
// GetString returns the value associated with the key as a string.
func GetString(key string) string { return v.GetString(key) }
```

```go
package main

import (
	"fmt"
	"github.com/fsnotify/fsnotify"
	"github.com/spf13/viper"
)

func initViperCnf () {
	// 设置默认值
	viper.SetDefault("conf", ".")
	
	// 下面是读取配置文件
	// 配置文件名称，无扩展名
	viper.SetConfigName("db_conf")
	
	// 需要配置此项，指定配置文件类型
	viper.SetConfigType("yaml")
	
	// 查找配置文件所在路径，可以加很多个
	viper.AddConfigPath("./conf/")
	
	// 读取配置
	err := viper.ReadInConfig()
	if err != nil {
		_, ok := err.(viper.ConfigFileNotFoundError)
		if ok {
			fmt.Printf("读取配置文件时未找到:%v\n",err)
			return
		} else{
			fmt.Printf("读取配置文件已找到，读取内容时错误:%v\n", err)
			return
		}
	}
	fmt.Println("读取配置文件成功")
	
	// 配置文件热加载
	viper.WatchConfig()
	viper.OnConfigChange(func(e fsnotify.Event) {
		// 配置文件内容变更以后会回调该函数
		fmt.Printf("监测到配置文件内容发生 %s 动作，文件位置:%s\n", e.Op, e.Name)
	})
}

func checkKeyExists(key string) bool {
	keyExists := viper.IsSet(key)
	if keyExists {
		return true
	} else{
		return false
	}
}

func main(){
	// 初始化Viper配置
	initViperCnf()
	
	// key name存在
	nameKey := checkKeyExists("name")
	if nameKey {
		name := viper.GetString("name")
		fmt.Printf("获取到name:%#v  Type:%T\n", name, name)
	} else {
		fmt.Printf("获取到name不存在:%#v", nameKey)
	}
	
	// 输入错误的key为names key names不存在
	namesKey := checkKeyExists("names")
	if namesKey {
		names := viper.GetString("names")
		fmt.Printf("获取到names:%#v  Type:%T\n", names, names)
	} else {
		fmt.Printf("获取到names不存在:%#v", namesKey)
	}
}
```

![image-20220530083131838](go_viper%E4%BD%BF%E7%94%A8/image-20220530083131838.png)



> 从上面的代码分析：
>
> - 定义了一个checkKeyExists是否存在的方法来校验key是否存在
> - 输入了存在的key->`name`，viper是可以正确拿到值
> - 输入了存在的key->`names，viper不可以正确拿到值，但是返回了零值

### 3、写入配置文件

> 这块暂时没用到，后面再补充

### 4、配置文件热加载

> Viper支持在程序运行时实时读取配置文件的功能，这也就是热加载，不需要重新启动服务，而是在服务运行时，自动重新加载最新的配置内容
>
> - viper可以实时的去读取配置文件的更新，而且不会错误任何内容
> - viper实现热加载的两个方法
>     - WatchConfig()
>     - nConfigChange() : 这个方法可选，这个方法提供了一个回调函数，可以在每次配置文件内容有修改时，通知我们
> - 一定要确保`watchConfig`前面的代码添加了所有的配置文件路径

```go
// 添加配置文件热加载代码
package main

import (
	"fmt"
	"github.com/fsnotify/fsnotify"
	"github.com/spf13/viper"
	"time"
)

func main(){
	// 设置默认值
	viper.SetDefault("conf", ".")
	
	// 下面是读取配置文件
	// 配置文件名称，无扩展名
	viper.SetConfigName("db_conf")
	
	// 需要配置此项，指定配置文件类型
	viper.SetConfigType("yaml")
	
	// 查找配置文件所在路径，可以加很多个
	viper.AddConfigPath("./conf/")
	
	// 读取配置
	err := viper.ReadInConfig()
	if err != nil {
		_, ok := err.(viper.ConfigFileNotFoundError)
		if ok {
			fmt.Printf("读取配置文件时未找到:%v\n",err)
			return
		} else{
			fmt.Printf("读取配置文件已找到，读取内容时错误:%v\n", err)
			return
		}
	}
	fmt.Println("读取配置文件成功")
	
	// 配置文件热加载
	viper.WatchConfig()
	viper.OnConfigChange(func(e fsnotify.Event) {
		// 配置文件内容变更以后会回调该函数
		fmt.Printf("监测到配置文件内容发生 %s 动作，文件位置:%s\n", e.Op, e.Name)
	})
	
	// 使用死循环，模拟程序一直在长期运行，然后修改配置文件
	for {
		nowTime := time.Now()
		fmt.Printf("程序运行中:%v\n", nowTime)
		// 间隔3s
		time.Sleep(3 * time.Second)
	}
}
```

> 启动程序后，修改配置文件内容后，会提示有修改配置文件内容提示，并且重新加载最新的内容

![image-20220526001137129](go_viper%E4%BD%BF%E7%94%A8/image-20220526001137129.png)

### 5、覆盖设置

### 6、注册和使用别名

### 7、使用环境变量

> viper完全支持环境变量，有五种方法可以和ENV配合使用
>
> - `AutomaticEnv()`
> - `BindEnv(string...) : error`
> - `SetEnvPrefix(string)`
> - `SetEnvKeyReplacer(string...) *strings.Replacer`
> - `AllowEmptyEnv(bool)`

