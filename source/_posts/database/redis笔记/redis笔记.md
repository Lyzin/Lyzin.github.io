---
title: Redis笔记
date: 2021-05-16 19:31:21
tags: Redis
cover: /posts_cover_img/database/redis_logo.png
categories: Redis笔记
---



## 一、搭建Redis环境

> 前言：使用Docker 来搭建Redis环境
>
> 镜像官网：[https://hub.docker.com/_/redis](https://hub.docker.com/_/redis)

### 1. 创建redis容器

> 使用redis-cli客户端连接方式创建redis容器
>

```bash	
 # 创建redis容器
 docker run -idt --name redisly -p 6379:6379 redis
 
 # 命令参数解释
 -idt: i表示可以进行交互，t表示开启一个tty终端，d表示在后台运行容器
 --name: 表示自定义容器名，进入容器时可以使用该名字进入
 --rm: 表示创建redis容器时候，如果存在redis 、redis-cli先删除再创建
 -p: 表示将容器内端口映射到宿主机的端口
```

 1.2 创建redis容器，无密码

![image-20210608132942146](redis%E7%AC%94%E8%AE%B0/image-20210608132942146.png)

### 2. 连接redis

#### 2.1 redis-cli工具

> `redis`服务器可以通过`redis-cli`工具进行连接

```shell
// redis-cli --help 帮助文档
redis-cli 6.0.1

Usage: redis-cli [OPTIONS] [cmd [arg [arg ...]]]
  -h <hostname>      Server hostname (default: 127.0.0.1).
  -p <port>          Server port (default: 6379).
  -s <socket>        Server socket (overrides hostname and port).
  -a <password>      Password to use when connecting to the server.
                     You can also use the REDISCLI_AUTH environment
                     variable to pass this password more safely
                     (if both are used, this argument takes predecence).
  --user <username>  Used to send ACL style 'AUTH username pass'. Needs -a.
  --pass <password>  Alias of -a for consistency with the new --user option.
  --askpass          Force user to input password with mask from STDIN.
                     If this argument is used, '-a' and REDISCLI_AUTH
                     environment variable will be ignored.
  -u <uri>           Server URI.
  -r <repeat>        Execute specified command N times.
  -i <interval>      When -r is used, waits <interval> seconds per command.
                     It is possible to specify sub-second times like -i 0.1.
  -n <db>            Database number.
  -3                 Start session in RESP3 protocol mode.
  -x                 Read last argument from STDIN.
  -d <delimiter>     Multi-bulk delimiter in for raw formatting (default: \n).
  -c                 Enable cluster mode (follow -ASK and -MOVED redirections).
  --raw              Use raw formatting for replies (default when STDOUT is
                     not a tty).
  --no-raw           Force formatted output even when STDOUT is not a tty.
  --csv              Output in CSV format.
  --stat             Print rolling stats about server: mem, clients, ...
  --latency          Enter a special mode continuously sampling latency.
                     If you use this mode in an interactive session it runs
                     forever displaying real-time stats. Otherwise if --raw or
                     --csv is specified, or if you redirect the output to a non
                     TTY, it samples the latency for 1 second (you can use
                     -i to change the interval), then produces a single output
                     and exits.
  --latency-history  Like --latency but tracking latency changes over time.
                     Default time interval is 15 sec. Change it using -i.
  --latency-dist     Shows latency as a spectrum, requires xterm 256 colors.
                     Default time interval is 1 sec. Change it using -i.
  --lru-test <keys>  Simulate a cache workload with an 80-20 distribution.
  --replica          Simulate a replica showing commands received from the master.
  --rdb <filename>   Transfer an RDB dump from remote server to local file.
  --pipe             Transfer raw Redis protocol from stdin to server.
  --pipe-timeout <n> In --pipe mode, abort with error if after sending all data.
                     no reply is received within <n> seconds.
                     Default timeout: 30. Use 0 to wait forever.
  --bigkeys          Sample Redis keys looking for keys with many elements (complexity).
  --memkeys          Sample Redis keys looking for keys consuming a lot of memory.
  --memkeys-samples <n> Sample Redis keys looking for keys consuming a lot of memory.
                     And define number of key elements to sample
  --hotkeys          Sample Redis keys looking for hot keys.
                     only works when maxmemory-policy is *lfu.
  --scan             List all keys using the SCAN command.
  --pattern <pat>    Useful with --scan to specify a SCAN pattern.
  --intrinsic-latency <sec> Run a test to measure intrinsic system latency.
                     The test will run for the specified amount of seconds.
  --eval <file>      Send an EVAL command using the Lua script at <file>.
  --ldb              Used with --eval enable the Redis Lua debugger.
  --ldb-sync-mode    Like --ldb but uses the synchronous Lua debugger, in
                     this mode the server is blocked and script changes are
                     not rolled back from the server memory.
  --cluster <command> [args...] [opts...]
                     Cluster Manager command and arguments (see below).
  --verbose          Verbose mode.
  --no-auth-warning  Don't show warning message when using password on command
                     line interface.
  --help             Output this help and exit.
  --version          Output version and exit.

Cluster Manager Commands:
  Use --cluster help to list all available cluster manager commands.

Examples:
  cat /etc/passwd | redis-cli -x set mypasswd
  redis-cli get mypasswd
  redis-cli -r 100 lpush mylist x
  redis-cli -r 100 -i 1 info | grep used_memory_human:
  redis-cli --eval myscript.lua key1 key2 , arg1 arg2 arg3
  redis-cli --scan --pattern '*:12345*'

  (Note: when using --eval the comma separates KEYS[] from ARGV[] items)

When no command is given, redis-cli starts in interactive mode.
Type "help" in interactive mode for information on available commands
and settings.
```

#### 2.2 连接redis

```shell
# 连接命令，这个命令行工具是单独下载安装的
redis-cli -h 127.0.0.1
```



![image-20210608133051787](redis%E7%AC%94%E8%AE%B0/image-20210608133051787.png)

#### 2.3 python代码连接redis

```python
import redis

conn_dict = {
    'host':'127.0.0.1',
    'port': 6379
}

r = redis.Redis(**conn_dict)

# 获取所有数据，返回值是一个List，每个元素都是bytes类型
all_data = r.keys('*')

# 结果是: [b'name']
print(all_data) 

# get方法是返回结果是bytes类型数据，需要解码
data = r.get('name').decode('utf-8')

# 结果是: alex
print(data)
```

## 二、Redis数据类型

### 1、Redis介绍

> 

### 2、redis持久化

> 

### 3、Redis的数据类型

#### 3.1 string

> 