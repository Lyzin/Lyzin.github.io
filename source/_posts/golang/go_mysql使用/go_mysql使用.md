---
title: Go Mysql笔记
date: 2021-05-16 19:31:21
updated: 2022-05-23 23:17:48
tags: 
- MySQL
- Go
cover: /posts_cover_img/golang/go_mysql.png
categories: Go Mysql笔记
---

## 一、Mysql环境搭建

### 1、mysql镜像地址

> 推荐使用docker搭建mysql环境，非常方便用来学习mysql
>
> [mysql的docker镜像地址](https://registry.hub.docker.com/_/mysql)

### 2、创建mysql容器

#### 2.1 拉取mysql镜像

```bash
docker pull mysql
```

#### 2.2 创建mysql容器

> 下面内容来自dockerhub里mysql的使用介绍

```bash
#Configuration without a cnf file
#Many configuration options can be passed as flags to mysqld. This will give you the flexibility to customize the container without needing a cnf file. For example, if you want to change the default encoding and collation for all tables to use UTF-8 (utf8mb4) just run the following:

$ docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci

# If you would like to see a complete list of available options, just run:
$ docker run -it --rm mysql:tag --verbose --help

------------------->翻译如下<--------------------------
#没有cnf文件的配置
#许多配置选项可以作为标志传递给mysqld。这将使你能够灵活地定制容器而不需要cnf文件。例如，如果你想改变所有表的默认编码和排序为使用UTF-8(utf8mb4)，只需运行以下内容。
$ docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=my-secret-pw -d mysql:tag --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci

# 如果你想看到可用选项的完整列表，只需运行。
$ docker run -it --rm mysql:tag --verbose --help
```

> 创建mysql容器

```bash
$ docker run -itd --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=123456 mysql --character-set-server=utf8mb4 --collation-server=utf8mb4_unicode_ci

# --name mysql 创建的容器名叫mysql
# -e MYSQL_ROOT_PASSWORD=123456   MYSQL_ROOT_PASSWORD指定了将为MySQL根超级用户账户设置的密码，可以看到是123456
# --character-set-server=utf8mb4  设置mysql字符编码为utf8mb4，表示可以支持中文和表情
# --collation-server=utf8mb4_unicode_ci 在字符集内用于比较或排序字符的一套规则，即校验规则
```

![image-20220324152525798](go_mysql%E4%BD%BF%E7%94%A8/image-20220324152525798.png)

#### 2.3 连接数据库

> 这里使用了`mycli`这个包来连接数据库测试
>
> `mycli`包时python写的一个具有代码提示的mysql使用工具

![image-20220324152502070](go_mysql%E4%BD%BF%E7%94%A8/image-20220324152502070.png)

> 可以看到连接数据库成功，可以成功登录到mysql里面了

## 二、go连接mysql

### 1、go连接mysql用到的包

#### 1.1 database/sql

> go语言中的`database/sql`包提供了保证SQL或类SQL数据库的泛用接口，并不提供具体的数据库驱动，使用`database/sql`包时必须注入一个数据库驱动
>
> - 也就是说`database/sql`里面定义了SQL的需要实现的方法

#### 1.2 mysql数据库驱动

```go
// 下载mysql驱动
go get -u github.com/go-sql-driver/mysql

// -u：表示所有的依赖都是下载最新的
// github地址：https://github.com/go-sql-driver/mysql
```

### 2、使用mysql驱动

#### 2.1 Open方法

> go语言中没有数据库驱动，所以需要外部导入一个数据库驱动来注入
>
> 使用`database/sql`的Open()方法
>
> 下面内容来自Open方法注释翻译
>
> - 打开一个由其数据库驱动名称和一个特定的数据源名称指定的数据库。
> - 驱动程序特定的数据源名称，通常至少包括一个数据库名称和连接信息。
> - 大多数用户会通过一个特定驱动程序的连接来打开一个数据库辅助函数来打开数据库，该函数返回一个*DB。
>     - Go标准库中没有包含数据库驱动没有包括在Go标准库中。参见 https://golang.org/s/sqldrivers 以了解第三方驱动程序的列表。
>     - Open可以只验证它的参数，而不创建一个与数据库的连接与数据库的连接。为了验证数据源的名称是否有效，可以调用Ping。
> - 返回的DB对于多个goroutine的并发使用是安全的并维护它自己的空闲连接池。
>     - 因此，Open函数应该只被调用一次。很少有必要关闭一个数据库。

```go
// open方法打开指定驱动的数据库
// Open opens a database specified by its database driver name and a
// driver-specific data source name, usually consisting of at least a
// database name and connection information.
//
// Most users will open a database via a driver-specific connection
// helper function that returns a *DB. No database drivers are included
// in the Go standard library. See https://golang.org/s/sqldrivers for
// a list of third-party drivers.
//
// Open may just validate its arguments without creating a connection
// to the database. To verify that the data source name is valid, call
// Ping.
//
// The returned DB is safe for concurrent use by multiple goroutines
// and maintains its own pool of idle connections. Thus, the Open
// function should be called just once. It is rarely necessary to
// close a DB.
func Open(driverName, dataSourceName string) (*DB, error) {
	driversMu.RLock()
	driveri, ok := drivers[driverName]
	driversMu.RUnlock()
	if !ok {
		return nil, fmt.Errorf("sql: unknown driver %q (forgotten import?)", driverName)
	}

	if driverCtx, ok := driveri.(driver.DriverContext); ok {
		connector, err := driverCtx.OpenConnector(dataSourceName)
		if err != nil {
			return nil, err
		}
		return OpenDB(connector), nil
	}

	return OpenDB(dsnConnector{dsn: dataSourceName, driver: driveri}), nil
}
```

> Open方法
>
> - 打开一个driverName指定的数据库
>
> - DataSourceName指定数据源，一般包括数据库文件名和连接信息

#### 2.2 DB结构体

> 一般都是通过数据库特定的链接帮助函数打开数据库，返回一个`*DB`(DB结构体指针)
>
> 下面内容来自DB结构体的翻译
>
> - DB是一个数据库句柄，代表一个由0个或更多的底层连接。它可以安全地被多个goroutines同时使用。
>     - 0或多个底层连接，这里是指有一个连接池，当要连接数据库时从连接池里拿一个sql连接对象来用，用完了再放回去
>     - 连接池的优势：
>         - 当需要频繁的操作sql数据时，会提前将sql数据库连接提前创建好并放到链接池里
>         - 而不是每次需要操作sql时，再去创建连接，节省时间和提高效率
>         - 当使用完以后，再将链接放回到链接池
>         - 并且连接池是可以被多个`goroutine`同时使用
> - sql包自动创建和释放连接；它也维护一个空闲的连接池。
>     - 如果数据库有有每个连接状态的概念，这种状态可以被可靠地观察到在一个事务（Tx）或连接（Conn）中可靠地观察到这种状态。
>     - 一旦DB.Begin被调用，返回的返回的Tx被绑定到一个单一的连接。
>     - 一旦提交或称为 "回滚"，该事务的连接被返回到DB的闲置连接池。
>     - 池的大小 可以用SetMaxIdleConns来控制。

```go
// 下面是DB结构体的实现
// DB is a database handle representing a pool of zero or more
// underlying connections. It's safe for concurrent use by multiple
// goroutines.
//
// The sql package creates and frees connections automatically; it
// also maintains a free pool of idle connections. If the database has
// a concept of per-connection state, such state can be reliably observed
// within a transaction (Tx) or connection (Conn). Once DB.Begin is called, the
// returned Tx is bound to a single connection. Once Commit or
// Rollback is called on the transaction, that transaction's
// connection is returned to DB's idle connection pool. The pool size
// can be controlled with SetMaxIdleConns.
type DB struct {
	// Atomic access only. At top of struct to prevent mis-alignment
	// on 32-bit platforms. Of type time.Duration.
	waitDuration int64 // Total time waited for new connections.

	connector driver.Connector
	// numClosed is an atomic counter which represents a total number of
	// closed connections. Stmt.openStmt checks it before cleaning closed
	// connections in Stmt.css.
	numClosed uint64

	mu           sync.Mutex // protects following fields
	freeConn     []*driverConn
	connRequests map[uint64]chan connRequest
	nextRequest  uint64 // Next key to use in connRequests.
	numOpen      int    // number of opened and pending open connections
	// Used to signal the need for new connections
	// a goroutine running connectionOpener() reads on this chan and
	// maybeOpenNewConnections sends on the chan (one send per needed connection)
	// It is closed during db.Close(). The close tells the connectionOpener
	// goroutine to exit.
	openerCh          chan struct{}
	closed            bool
	dep               map[finalCloser]depSet
	lastPut           map[*driverConn]string // stacktrace of last conn's put; debug only
	maxIdleCount      int                    // zero means defaultMaxIdleConns; negative means 0
	maxOpen           int                    // <= 0 means unlimited
	maxLifetime       time.Duration          // maximum amount of time a connection may be reused
	maxIdleTime       time.Duration          // maximum amount of time a connection may be idle before being closed
	cleanerCh         chan struct{}
	waitCount         int64 // Total number of connections waited for.
	maxIdleClosed     int64 // Total number of connections closed due to idle count.
	maxIdleTimeClosed int64 // Total number of connections closed due to idle time.
	maxLifetimeClosed int64 // Total number of connections closed due to max connection lifetime limit.

	stop func() // stop cancels the connection opener.
}
```

### 3、mysql连接

#### 3.1 Open数据库

> 使用Open方法打开数据库:
>
> - dataSourceName格式：`“用户名:密码@tcp(host:port)/数据库名称”`
> - Open方法不会校验用户名和密码正确，只会校验dsn格式是否正确
>     - 当dataSourceName格式不正确的时候，会报错

```go
package main

import (
	"database/sql"
	"fmt"
	_ "github.com/go-sql-driver/mysql"
)

func main() {
	// 连接数据库， Open方法不会校验用户名和密码正确，只会校验dsn格式是否正确
	dsn := "root:root@tcp(127.0.0.1:3306)/prc_ly"
	db, err := sql.Open("mysql", dsn)
	if err != nil {
		fmt.Printf("打开数据库失败:%v", err)
		return
	}
	fmt.Printf("数据库的打开成功:%#+v\n", db)
	fmt.Printf("数据库db类型:%T\n", db)
}
```

```go
// 上面代码返回的DB数据
// 数据库的打开成功:
&sql.DB{
    waitDuration:0, 
    connector:(*mysql.connector)(0xc00012a018), 
    numClosed:0x0, 
    mu:sync.Mutex{state:0, sema:0x0}nn:[]*sql.driverConn(nil), 
    connRequests:map[uint64]chan sql.connRequest{}, 
    nextRequest:0x0, 
    numOpen:0, 
    openerCh:(chan struct {})(0xc0001020c0), 
    closed:false, 
    dep:map[sql.finalCloser]sql.depSet(nil), 
    lastPut:map[*sql.driverConn]string{}, 
    maxIdleCount:0, 
    maxOpen:0, 
    maxLifetime:0, 
    maxIdleTime:0, 
    cleanerCh:(chan struct {})(nil), 
    waitCount:0, 
    maxIdleClosed:0, 
    maxIdleTimeClosed:0, 
    maxLifetimeClosed:0, 
    stop:(func())(0x107d760)
}
// 数据库db类型: *sql.DB
```

##### 3.1.1 Open数据库正确

```go
package main

import (
	"database/sql"
	"fmt"
	_ "github.com/go-sql-driver/mysql"
)

func main() {
	// 连接数据库， Open方法不会校验用户名和密码正确，只会校验dsn格式是否正确
	
	// dsn格式正确
	dsn := "root:root@tcp(127.0.0.1:3306)/prc_ly"
	_, err := sql.Open("mysql", dsn)
	if err != nil {
		fmt.Printf("校验数据库参数失败:%v\n", err)
		return
	}
	fmt.Printf("校验数据库成功\n")
}
```

![image-20220516104406809](go_mysql%E4%BD%BF%E7%94%A8/image-20220516104406809.png)

##### 3.1.2 Open数据库失败

```go
package main

import (
	"database/sql"
	"fmt"
	_ "github.com/go-sql-driver/mysql"
)

func main() {
	// 连接数据库， Open方法不会校验用户名和密码正确，只会校验dsn格式是否正确
	
	// dsn格式不正确
	dsn := "root:root@tcp(127.0.0.1:3306)————prc_ly"
	_, err := sql.Open("mysql", dsn)
	if err != nil {
		fmt.Printf("校验数据库参数失败:%v\n", err)
		return
	}
	fmt.Printf("校验数据库成功\n")
}
```

![image-20220516104457767](go_mysql%E4%BD%BF%E7%94%A8/image-20220516104457767.png)

#### 3.2 Ping数据库

> 通过Ping方法来真正连接数据库，校验是否连接正确

##### 3.2.1 Ping数据库正确

```go
package main

import (
	"database/sql"
	"fmt"
	_ "github.com/go-sql-driver/mysql"
)

func main() {
	// 连接数据库， Open方法不会校验用户名和密码正确，只会校验dsn格式是否正确
	
	// dsn格式正确，密码不正确
	dsn := "root:123456@tcp(127.0.0.1:3306)/prc_ly"
	db, err := sql.Open("mysql", dsn)
	if err != nil {
		fmt.Printf("校验数据库参数失败:%v\n", err)
		return
	}
	
	// 校验数据库打开是否成功
	err = db.Ping()
	if err != nil {
		fmt.Printf("打开数据库失败:%v\n", err)
		return
	}
	fmt.Printf("打开数据库成功\n")
}
```

![image-20220516105118247](go_mysql%E4%BD%BF%E7%94%A8/image-20220516105118247.png)

##### 3.2.2 Ping数据库失败

> 比如将dsn里的数据库密码写错

```go
package main

import (
	"database/sql"
	"fmt"
	_ "github.com/go-sql-driver/mysql"
)

func main() {
	// 连接数据库， Open方法不会校验用户名和密码正确，只会校验dsn格式是否正确
	
	// dsn格式正确，密码不正确
	dsn := "root:root@tcp(127.0.0.1:3306)/prc_ly"
	db, err := sql.Open("mysql", dsn)
	if err != nil {
		fmt.Printf("校验数据库参数失败:%v\n", err)
		return
	}
	
	// 校验数据库打开是否成功
	err = db.Ping()
	if err != nil {
		fmt.Printf("打开数据库失败:%v\n", err)
		return
	}
	fmt.Printf("打开数据库成功\n")
}
```

![image-20220516104653089](go_mysql%E4%BD%BF%E7%94%A8/image-20220516104653089.png)

#### 3.3 驱动注入原理简单介绍

```go
// 使用mysql驱动
package main

import (
	"database/sql"
	"fmt"
	_ "github.com/go-sql-driver/mysql"
)
```

```go
// 因为是以匿名导入"github.com/go-sql-driver/mysql"包，所以只会导入这个包的Init方法
// 路径：/Users/xxx/Desktop/Code/go_study/pkg/mod/github.com/go-sql-driver/mysql@v1.6.0/driver.go

// Package mysql provides a MySQL driver for Go's database/sql package.
//
// The driver should be used via the database/sql package:
//
//  import "database/sql"
//  import _ "github.com/go-sql-driver/mysql"
//
//  db, err := sql.Open("mysql", "user:password@/dbname")
//
// See https://github.com/go-sql-driver/mysql#usage for details
package mysql

import (
	"context"
	"database/sql"
	"database/sql/driver"
	"net"
	"sync"
)

func init() {
	sql.Register("mysql", &MySQLDriver{})
}
```

> 其实可以看到是导入了go原生的`database/sql`这个包，然后init方法里进行了注册
>
> - 所以在我们写代码的时候，只需要匿名导入`"github.com/go-sql-driver/mysql"`这个包，会自动执行init方法，帮我们调用`database/sql`包里的`Register`方法来完成mysql的注入
>
> - Register注册并命名一个数据库，可以在Open函数中使用该命名启用该驱动
> - 如果 Register注册同一名称两次，或者driver参数为nil，会导致panic。

## 三、go增删改查数据库

### 1、定义全局db连接池

> 在第二章我们了解到，使用Open方法打开mysql数据库:
>
> 得到的db是`database/sql`包里定义的`DB`结构体对象，并且DB是一个连接池，所以我们可以将其定义为全局的变量，供其他地方使用
>
> - 另外再initDB方法里，因为db这个变量已经定义为全局变量了，就不需要再重新声明并定义了
>     - 在db, err = sql.Open("mysql", dsn)这块代码，如果仍写成`:=`，就会将db这个变量声明未局部变量，那边全局db仍然是一个空指针，这块需要注意
>     - 另外为什么err也可以直接用`=`号接收，因为在返回值里定义了

```go
// 定义db为全局的连接池
package main

import (
	"database/sql"
	"fmt"
	_ "github.com/go-sql-driver/mysql"
)

// 定义全局db连接池
var db *sql.DB

// 初始化数据库
func initDB() (err error){
	// 连接数据库， Open方法不会校验用户名和密码正确，只会校验dsn格式是否正确
	dsn := "root:123456@tcp(127.0.0.1:3306)/prc_ly"
	db, err = sql.Open("mysql", dsn)
	if err != nil {
		return
	}
	
	// 校验数据库打开是否成功
	err = db.Ping()
	if err != nil {
		return
	}	
}
```

### 2、查询数据

> 查询数据用到了两个方法，queryRow和Scan

#### 2.1 查询单条记录

##### 2.1.1 QueryRow方法

> QueryRow()
>
> - 表示是从一个连接池里拿出来一个连接去数据库查询单条记录
> - 注释翻译：
>     - QueryRow执行一个查询，预计最多返回一条记录。
>     - QueryRow总是返回一个非零的值。
>     - 错误被推迟到Row的Scan方法被调用。
>     - 如果查询没有选择任何行，*Row的扫描将返回ErrNoRows。否则，*Row's Scan会扫描第一条被选择的行，并丢弃其余的。
>     - QueryRow内部使用context.Background。要指定context，请使用QueryRowContext.Background。

```go
// QueryRow
// QueryRow executes a query that is expected to return at most one row.
// QueryRow always returns a non-nil value. Errors are deferred until
// Row's Scan method is called.
// If the query selects no rows, the *Row's Scan will return ErrNoRows.
// Otherwise, the *Row's Scan scans the first selected row and discards
// the rest.
//
// QueryRow uses context.Background internally; to specify the context, use
// QueryRowContext.
func (db *DB) QueryRow(query string, args ...interface{}) *Row {
	return db.QueryRowContext(context.Background(), query, args...)
}
```

##### 2.1.2 Scan方法

> Scan()
>
> - 从queryRow方法拿到的Row对象，然后传进一个结构体来接收查询到结果，对结构体进行重新赋值，所以需要传入结构体指针
> - 注释翻译
>     - 扫描将匹配的行中的列复制到目的地的值中。
>     - 指向的值。详情请参见Rows.Scan的文档。
>     - 如果有多条记录符合查询要求。扫描使用第一条记录，并丢弃其余的记录。
>     - 如果没有任何行符合 查询，Scan会返回ErrNoRows。

```go
// Scan copies the columns from the matched row into the values
// pointed at by dest. See the documentation on Rows.Scan for details.
// If more than one row matches the query,
// Scan uses the first row and discards the rest. If no row matches
// the query, Scan returns ErrNoRows.
func (r *Row) Scan(dest ...interface{}) error {
	if r.err != nil {
		return r.err
	}

	// TODO(bradfitz): for now we need to defensively clone all
	// []byte that the driver returned (not permitting
	// *RawBytes in Rows.Scan), since we're about to close
	// the Rows in our defer, when we return from this function.
	// the contract with the driver.Next(...) interface is that it
	// can return slices into read-only temporary memory that's
	// only valid until the next Scan/Close. But the TODO is that
	// for a lot of drivers, this copy will be unnecessary. We
	// should provide an optional interface for drivers to
	// implement to say, "don't worry, the []bytes that I return
	// from Next will not be modified again." (for instance, if
	// they were obtained from the network anyway) But for now we
	// don't care.
	defer r.rows.Close()
	for _, dp := range dest {
		if _, ok := dp.(*RawBytes); ok {
			return errors.New("sql: RawBytes isn't allowed on Row.Scan")
		}
	}

	if !r.rows.Next() {
		if err := r.rows.Err(); err != nil {
			return err
		}
		return ErrNoRows
	}
	err := r.rows.Scan(dest...)
	if err != nil {
		return err
	}
	// Make sure the query can be processed to completion with no errors.
	return r.rows.Close()
}
```

##### 2.1.3 单条记录查询示例

> 下面是单条记录查询的示例，需要先定一个数据库对应表的结构体，来传入给Scan方法进行接收QueryRow对象获得的值
>
> 注意：
>
> - 需要传入的是结构体指针，因为go语言中函数传值一般都是值拷贝，我们不希望值拷贝，如果是值拷贝，拿到的结果就不会重新赋值给声明的结构体
>- 所以对声明的结构体重新赋值，必须穿入指针，保证是传入的同一个
> - 并且select语句里如果是用的`*`（表示表的所有字段）查询，那么Scan里的接收的结构体字段必须要和表里的字段值、个数一致，否则会提示”“
>
> 查询时，传递给QueryRow的sqlStr时，可以在sqlStr里使用`?`来表示占位符，用来动态传递值
>
> 必须对RowQuery查询到的结果调用Scan方法，因为Scan方法里定义了自动释放数据库连接的方法

```go
package main

import (
	"database/sql"
	"fmt"
	_ "github.com/go-sql-driver/mysql"
)

// 定义全局db连接池
var db *sql.DB

// 定义user结构体，结构体字段必须要和查询数据库表的字段定义一致
type user struct{
	id int
	name string
	age int
	hobby string
}

// 初始化数据库
func initDB() (err error){
	// 连接数据库， Open方法不会校验用户名和密码正确，只会校验dsn格式是否正确
	dsn := "root:123456@tcp(127.0.0.1:3306)/prc_ly"
	db, err = sql.Open("mysql", dsn)
	if err != nil {
		return
	}
	
	// 校验数据库打开是否成功
	err = db.Ping()
	if err != nil {
		return
	}
	return
}

// 查询单条记录
func queryData(id int) {
	sqlStr := "select * from user where id=?;"
	// 从db连接池里拿出来一个连接去查询记录
	rowObj := db.QueryRow(sqlStr, id)
	
	// 定义接收的结构体对象
	var u1 user
	
	// 拿到结果
	// 必须调用Scan方法，Scan会自动归还db的连接，传入user结构体的指针
	rowObj.Scan(&u1.id, &u1.name, &u1.age, &u1.hobby)
	fmt.Printf("u1:%+#v\n", u1)
}

func main() {
	err := initDB()
	if err != nil {
		fmt.Printf("initDB err:%v\n", err)
		return
	}
	
	queryData(1)
}
```

![image-20220516145006179](go_mysql%E4%BD%BF%E7%94%A8/image-20220516145006179.png)

#### 2.2、最大连接数

> 因为`DB`这个结构体自己维护了一个数据库连接池，那么这个连接池可以设置数据库连接池大小

##### 2.2.1 SetMaxOpenConns方法

> 用来设置数据库连接池最大连接数
>
> 注释翻译:
>
> - SetMaxOpenConns设置到数据库的最大mysql的连接数。
> - 如果MaxIdleConns大于0，而新的MaxOpenConns小于MaxIdleConns，那么MaxIdleConns将被减少以符合新的MaxOpenConns限制。
> - 如果n<=0，那么对开放连接的数量没有限制。默认是0（无限）。

```go
// 数据库连接数
// SetMaxOpenConns sets the maximum number of open connections to the database.
//
// If MaxIdleConns is greater than 0 and the new MaxOpenConns is less than
// MaxIdleConns, then MaxIdleConns will be reduced to match the new
// MaxOpenConns limit.
//
// If n <= 0, then there is no limit on the number of open connections.
// The default is 0 (unlimited).
func (db *DB) SetMaxOpenConns(n int) {...}
```

> 如果设置了SetMaxOpenConns的最大数，比如10
>
> - 当连接池的db连接被使用完了，程序就会夯住，
> - 因为没有连接池里没有闲置的db连接了，此时会一直等待有闲置的db来使用，但是池子里已经没有可用的db连接了，那么程序就卡住了

```go
package main

import (
	"database/sql"
	"fmt"
	_ "github.com/go-sql-driver/mysql"
)

// 定义全局db连接池
var db *sql.DB

// 定义user结构体
type user struct{
	id int
	name string
	age int
	hobby string
}

// 初始化数据库
func initDB() (err error){
	// 连接数据库， Open方法不会校验用户名和密码正确，只会校验dsn格式是否正确
	dsn := "root:123456@tcp(127.0.0.1:3306)/prc_ly"
	db, err = sql.Open("mysql", dsn)
	if err != nil {
		return
	}
	
	// 校验数据库打开是否成功
	err = db.Ping()
	if err != nil {
		return
	}
	
	// 设置db最大连接池的连接个数

	db.SetMaxOpenConns(10)
	return
}

// 查询单条记录
func queryData(id int) {
	sqlStr := "select * from user where id=?;"
	// 从db连接池里拿出来一个连接去查询记录
	for i := 0; i < 11; i++{
		fmt.Printf("开始第%v次查询\n", i)
		db.QueryRow(sqlStr, id)
	}
	
	
	// 定义接收的结构体对象
	var u1 user
	
	// 拿到结果
	// 必须调用Scan方法，Scan会自动归还db的连接
	// rowObj.Scan(&u1.id, &u1.name, &u1.age, &u1.hobby)
	fmt.Printf("u1:%+#v\n", u1)
}

func main() {
	err := initDB()
	if err != nil {
		fmt.Printf("initDB err:%v\n", err)
		return
	}
	
	queryData(1)
}
```

![image-20220516171940580](go_mysql%E4%BD%BF%E7%94%A8/image-20220516171940580.png)

##### 3.2.2  SetMaxIdleConns

> 连接池中的最大闲置连接数，如果n大于最大开启连接数，那新的最大闲置连接数会减少到匹配最大开启连接数的显示
>
> 如果n<=0，不会保留闲置连接数

```go
func (db *DB) SetMaxIdleConns(n int) {}
```

#### 2.3、查询多条记录

> 多行查询(db.Query())执行查询后，会返回多行结果（Rows），一般用于执行select命令
>
> 参数args表示query中的占位符
>
> 注意：
>
> - Query方法返回的是`Rows对象类型`，和查询单条记录的QueryRow方法返回的`Row对象类型`不一样
> - Query方法需要手动的进行归还拿到的那个数据库连接，所以需要再查询方法里添加`defer rows.Close()`

```go
// query 源码
// Query executes a query that returns rows, typically a SELECT.
// The args are for any placeholder parameters in the query.
//
// Query uses context.Background internally; to specify the context, use
// QueryContext.
func (db *DB) Query(query string, args ...interface{}) (*Rows, error) {
	return db.QueryContext(context.Background(), query, args...)
}
```

```go
func queryMultiData(n int) {
	// 1、sql语句 ?是占位符
	sqlStr := "select id, name, age from user where id > ?"
	// 2、执行查询
	rowsObj, err := db.Query(sqlStr, n)
	
	if err!= nil {
		fmt.Printf("%s查询多行数据错误:%v\n", sqlStr, err)
		return
	}
	
	// 3、关闭rows
	defer rowsObj.Close()
	
	// 4、定义返回结果的user结构体对象
	var userMore user
	
	// 5、循环取值
	for rowsObj.Next() {
		rowsObj.Scan(&userMore.id, &userMore.name, &userMore.age)
		fmt.Printf("userMore:%+#v\n", userMore)
		fmt.Printf("userMore.name:%v\n", userMore.name)
	}
}
```

### 3、插入数据

> 插入、更新和删除都是用的`Exec`方法
>
> Exec方法：
>
> - 执行一次命令（增、删、改、查），返回的Result是对已执行的Sql命令的综合，Result是一个接口
> - 参数args表示执行sql语句中（也就是Exec方法里query参数）中的占位参数

```go
// Exec方法源码
// Exec executes a query without returning any rows.
// The args are for any placeholder parameters in the query.
//
// Exec uses context.Background internally; to specify the context, use
// ExecContext.
func (db *DB) Exec(query string, args ...interface{}) (Result, error) {
	return db.ExecContext(context.Background(), query, args...)
}
```

```go
// Exec方法返回结果的Result是一个接口类型
// A Result summarizes an executed SQL command.
type Result interface {
	// LastInsertId returns the integer generated by the database
	// in response to a command. Typically this will be from an
	// "auto increment" column when inserting a new row. Not all
	// databases support this feature, and the syntax of such
	// statements varies.
	LastInsertId() (int64, error)

	// RowsAffected returns the number of rows affected by an
	// update, insert, or delete. Not every database or database
	// driver may support this.
	RowsAffected() (int64, error)
}
```

#### 3.1 插入数据实例

> 插入数据的时候，调用db的`Exec`方法，返回的Result是一个接口类型，这个接口类型有两个方法
>
> - LastInsertId()
>     - 如果id是自增的，可以拿到插入数据后，插入数据的主键id
> - RowsAffected()
>     - 插入数据时还可以拿到操作影响的行数

> 从原生数据库中插入数据时，当插入数据成功，会返回两个消息
>
> - Query OK
> - 1 row affected(0.00 sec)
>     - RowsAffected()方法返回的结果就是影响行数的这个数字`1`

![image-20220522230340452](go_mysql%E4%BD%BF%E7%94%A8/image-20220522230340452.png)

```go
// 插入数据
func insertDBData(name string, age int, hobby string) {
	// 1.插入数据的sql
	insertSql := "insert into user(name, age, hobby) value(?,?,?)"
	
	// 2.执行插入数据
	ret, err := db.Exec(insertSql, name, age, hobby)
	if err != nil {
		fmt.Printf("%s插入数据错误:%v\n", insertSql, err)
		return
	}
	// 3.如果是插入数据的操作，能拿到插入数据的id
	id, err := ret.LastInsertId()
	
	// 4. 插入数据还可以拿到操作影响的行数
	rowsAffect, err := ret.RowsAffected()
	if err != nil {
		fmt.Printf("获取id失败:%v\n", err)
		return
	}
	fmt.Printf("获取到的Id: %v\n", id)
	fmt.Printf("操作影响的行数: %v\n", rowsAffect)
}
```

![image-20220522230559355](go_mysql%E4%BD%BF%E7%94%A8/image-20220522230559355.png)

### 4、更新数据

> update操作也是用`Exec`方法，代码和插入操作一致，下面是源码
>
> 注意：
>
> - 更新操作可以调用LastInsertId()方法，但是返回的是0，所以调用了也没意义
> - 更新操作可以调用RowsAffected()方法，仍能看到影响的行数

```go
// 更新数据
func updateDBData(age, id int64) {
	// 1.更新数据的sql
	updateSql := "update user set age = ? where id = ?"
	
	// 2.执行更新数据
	ret, err := db.Exec(updateSql, age, id)
	if err != nil {
		fmt.Printf("%s更新数据错误:%v\n", updateSql, err)
		return
	}
	// 3.如果是更新数据的操作，是不能更新的数据的id
	updateId, err := ret.LastInsertId()
	
	// 4. 更新数据可以拿到操作影响的行数
	rowsAffect, errAffect := ret.RowsAffected()
	if errAffect != nil {
		fmt.Printf("更新数据失败:%v\n", err)
		return
	}
	fmt.Printf("更新数据获取到的Id: %v\n", updateId)
	fmt.Printf("更新数据操作影响的行数: %v\n", rowsAffect)
}
```

![image-20220522231716463](go_mysql%E4%BD%BF%E7%94%A8/image-20220522231716463.png)

### 5、删除数据

> Delete操作也是用`Exec`方法，代码和插入操作一致，下面是源码
>
> 注意：
>
> - 删除操作可以调用LastInsertId()方法，但是返回的是0，所以调用了也没意义
> - 删除操作可以调用RowsAffected()方法，仍能看到影响的行数

```go
// 删除数据
func deleteDBData(id int) {
	// 1.删除数据的sql
	deleteSql := "delete from user where id = ?"
	
	// 2.执行删除数据
	ret, err := db.Exec(deleteSql, id)
	if err != nil {
		fmt.Printf("%s删除数据错误:%v\n", deleteSql, err)
		return
	}
	// 3.如果是删除数据的操作，不能拿到删除数据的id
	deleteId, err := ret.LastInsertId()
	
	// 4. 删除数据可以拿到操作影响的行数
	rowsAffect, errDelete := ret.RowsAffected()
	
	if errDelete != nil {
		fmt.Printf("删除数据失败:%v\n", errDelete)
		return
	}
	fmt.Printf("删除数据获取到的Id: %v\n", deleteId)
	fmt.Printf("删除数据操作影响的行数: %v\n", rowsAffect)
}
```

![image-20220522232456037](go_mysql%E4%BD%BF%E7%94%A8/image-20220522232456037.png)

### 6、Mysql语句预处理

#### 6.1 预处理的定义

> 预处理的定义可以从普通SQL执行和预处理执行的区别来理解
>
> 普通SQL执行过程
>
> - 1.客户端对SQL语句进行占位符替换得到完整的SQL语句
> - 2.客户端发送完整SQL语句给Mysql服务端
> - 3.MYSQL服务端执行完整的SQL语句并将结果返回到客户端
>
> 预处理过程
>
> - 1.把SQL语句分为两部分，命令部分和数据部分
> - 2.客户端`先`把命令部分发给MYSQL服务器，Mysql服务器进行SQL预处理
> - 3.`然后`客户端再把数据发给MYSQL服务器，MYSQL服务器对SQL语句进行占位符替换
> - 4.MYSQL服务端执行完整的SQL语句并将结果返回到客户端

#### 6.2 预处理的优点

> 1.预处理SQL后，可以优化MYSQL服务端`重复执行SQL`的方法，提高服务器性能，提前让MYSQL服务器编译，一次编译多次执行，节省编译的成本
>
> 2.避免SQL注入问题

#### 6.3 GO处理MYSQL预处理

> go语言中使用`Prepare`方法进行SQL语句预处理
>
> Prepare方法返回的是`stmt`结构体的指针

```go
// Prepare 源码
// Prepare creates a prepared statement for later queries or executions.
// Multiple queries or executions may be run concurrently from the
// returned statement.
// The caller must call the statement's Close method
// when the statement is no longer needed.
//
// Prepare uses context.Background internally; to specify the context, use
// PrepareContext.
func (db *DB) Prepare(query string) (*Stmt, error) {
	return db.PrepareContext(context.Background(), query)
}
```

```go
// stmt结构体
// Stmt is a prepared statement.
// A Stmt is safe for concurrent use by multiple goroutines.
//
// If a Stmt is prepared on a Tx or Conn, it will be bound to a single
// underlying connection forever. If the Tx or Conn closes, the Stmt will
// become unusable and all operations will return an error.
// If a Stmt is prepared on a DB, it will remain usable for the lifetime of the
// DB. When the Stmt needs to execute on a new underlying connection, it will
// prepare itself on the new connection automatically.
type Stmt struct {
	// Immutable:
	db        *DB    // where we came from
	query     string // that created the Stmt
	stickyErr error  // if non-nil, this error is returned for all operations

	closemu sync.RWMutex // held exclusively during close, for read otherwise.

	// If Stmt is prepared on a Tx or Conn then cg is present and will
	// only ever grab a connection from cg.
	// If cg is nil then the Stmt must grab an arbitrary connection
	// from db and determine if it must prepare the stmt again by
	// inspecting css.
	cg   stmtConnGrabber
	cgds *driverStmt

	// parentStmt is set when a transaction-specific statement
	// is requested from an identical statement prepared on the same
	// conn. parentStmt is used to track the dependency of this statement
	// on its originating ("parent") statement so that parentStmt may
	// be closed by the user without them having to know whether or not
	// any transactions are still using it.
	parentStmt *Stmt

	mu     sync.Mutex // protects the rest of the fields
	closed bool

	// css is a list of underlying driver statement interfaces
	// that are valid on particular connections. This is only
	// used if cg == nil and one is found that has idle
	// connections. If cg != nil, cgds is always used.
	css []connStmt

	// lastNumClosed is copied from db.numClosed when Stmt is created
	// without tx and closed connections in css are removed.
	lastNumClosed uint64
}
```

##### 6.3.1 预处理stmt返回的实例结果

> stmt是一个结构体

```go
// 预处理SQL
func prepareSQLAction(id int) {
	// 1.需要重复执行的语句
	sqlStr := "select name, age from user where id = ?"
	
	// 2. 预处理sql
	stmt, _ := db.Prepare(sqlStr)
	fmt.Printf("预处理的stmt:%+#v\n", stmt)
	
	// 3. 关闭预处理
	defer stmt.Close()
}
```

```go
// stmt返回值
&sql.Stmt{
    db:(*sql.DB)(0xc000103040), 
    query:"select name, age from user where id = ?", 
    stickyErr:error(nil), 
    closemu:sync.RWMutex{
        w:sync.Mutex{
            state:0, 
            sema:0x0
        }, 
    	writerSem:0x0, 
    	readerSem:0x0, 
    	readerCount:0, 
    	eaderWait:0
    }, 
    cg:sql.stmtConnGrabber(nil), 
    cgds:(*sql.driverStmt)(0xc0000260c0), 
    parentStmt:(*sql.Stmt)(nil), 
    mu:sync.Mutex{
        state:0, 
        sema:0x0
    }, 
    closed:false, 
    css:[]sql.connStmt{
        sql.connStmt{
            dc:(*sql.driverConn)(0xc00011e090), 
            ds:(*sql.driverStmt)(0xc0000260c0)
        }             
    }, 
    lastNumClosed:0x0
}
```

##### 6.3.2 预处理进行查询操作实例

> 预处理可以进行增、删、改、查进行操作
>
> 注意：
>
> - 查操作
>     - 调用的是`stmt.QueryRow`或`stmt.Query`方法，然后拿到`Row`对象，再调用`Row`对象的`Scan`获取结果
>         - 当sql语句里的查询字段没有写的时候，那么返回的结果肯定是该类型的零值
>             - 比如下面的id、hobby没有查询，所以返回的是零值
>         - Scan方法里放的参数顺序必须和Sql语句里查询字段对应起来，否则也是该该类型的零值
>             - 比如下面给Scan方法里传入name、age参数时，先后顺序不能乱，否则得到的也是对应类型的零值
> - 增、删、改操作
>     - 调用的是`stmt.Exec`方法，然后得到`Result`接口类型，再调用`Result`接口类型里的方法

> 下面演示的是预处理进行查询操作，增、删、改操作一样，不做过多赘述

```go
// 预处理SQL
func prepareSQLAction(ids []int) {
	// 1. 需要重复执行的语句
	sqlStr := "select name, age from user where id = ?"
	
	// 2. 预处理sql
	stmt, err := db.Prepare(sqlStr)
	if err != nil {
		fmt.Printf("预处理的stmt错误：%v\n", err)
		return
	}
	
	// 3. 关闭预处理
	defer stmt.Close()
	
	// 4. 拿到stmt就去执行重复操作
	var uObj user
	for _, id := range ids {
		fmt.Printf("查询的Id:%v\n", id)
		rowObj := stmt.QueryRow(id)
		rowObj.Scan(&uObj.name, &uObj.age)
		fmt.Printf("uObj:%+#v\n", uObj)
		fmt.Printf("uObj.name:%v\n", uObj.name)
		fmt.Printf("uObj.age:%v\n\n", uObj.age)
	}
	fmt.Printf("\033[1;32m预处理所有数据完成\033[0m")
}
```

![image-20220523001643890](go_mysql%E4%BD%BF%E7%94%A8/image-20220523001643890.png)

### 7、Mysql事务

#### 7.1 事务定义

> - 事务是一个最小的不可再分的工作单元
>
> - 通常事务对应一个完整的业务
>     - 比如银行转账，就是一个最小的工作单元
>     - 同时这个业务需要执行多次增删改等语句共同完成
> - Mysql中使用了`Innodb`引擎的数据库或表才支持事务
> - 事务处理用来维护数据库的完整性，保证成批的SQL语句要么全部执行，要么全部不执行

#### 7.2 事务的ACID

> 通常事务必须满足四个条件(ACID)
>
> - 原子性(Atomicity)，也叫不可分割性
>     - 一个事务(transaction)中所有的操作，要么都全部完成，要么全部不完成，不会结束在中间某个环节
>     - 实物在执行过程中发生错误，会被回滚(Rollback)到事务开始的状态，就像是这和个事务从来没有被执行过
> - 一致性(Consistency)
>     - 在事务开始之前和事务结束结束以后，数据库的完整性没有被破坏
>     - 表示写入的数据必须完全符合所有的预设规则，包含数据的精确度、串联型，以及后续数据库可以自发性的完成预定的工作
> - 隔离性(Isolation)，也叫独立性
>     - 数据库允许多个并发事务同时对其数据进行读写和修改的能力
>     - 隔离性可以防止多个事务并发执行时，由于交叉执行而导致数据的不一致
>     - 事务隔离分为不同级别，包括
>         - 读未提交（Read uncommitted）
>         - 读提交（read committed）
>         - 可重复读（repeatable read）
>         - 串行化（serializable）
> - 持久性(Durability)
>     - 事务处理结束后，对数据的修改就是永久的，即使系统故障也不会丢失

#### 7.3 go中事务方法

> go语言中有三个方法可以来实现mysql中的事务操作

##### 7.3.1 开始事务

> 开启事务是database/sql这个包里的Begin方法

```go
// Begin starts a transaction. The default isolation level is dependent on
// the driver.
//
// Begin uses context.Background internally; to specify the context, use
// BeginTx.
func (db *DB) Begin() (*Tx, error) {
	return db.BeginTx(context.Background(), nil)
}
```

##### 7.3.2 提交事务

> 提交事务是开启事务后，返回的Tx结构体里的方法

```go
// Commit commits the transaction.
func (tx *Tx) Commit() error {
	// Check context first to avoid transaction leak.
	// If put it behind tx.done CompareAndSwap statement, we can't ensure
	// the consistency between tx.done and the real COMMIT operation.
	select {
	default:
	case <-tx.ctx.Done():
		if atomic.LoadInt32(&tx.done) == 1 {
			return ErrTxDone
		}
		return tx.ctx.Err()
	}
	if !atomic.CompareAndSwapInt32(&tx.done, 0, 1) {
		return ErrTxDone
	}

	// Cancel the Tx to release any active R-closemu locks.
	// This is safe to do because tx.done has already transitioned
	// from 0 to 1. Hold the W-closemu lock prior to rollback
	// to ensure no other connection has an active query.
	tx.cancel()
	tx.closemu.Lock()
	tx.closemu.Unlock()

	var err error
	withLock(tx.dc, func() {
		err = tx.txi.Commit()
	})
	if err != driver.ErrBadConn {
		tx.closePrepared()
	}
	tx.close(err)
	return err
}

```

##### 7.3.3 回滚事务

> 提交事务是开启事务后，返回的Tx结构体里的方法

```go
// Rollback aborts the transaction.
func (tx *Tx) Rollback() error {
	return tx.rollback(false)
}
```

#### 7.4 事务操作实例

##### 7.4.1 开启事务前表数据

![image-20220523095756292](go_mysql%E4%BD%BF%E7%94%A8/image-20220523095756292.png)

##### 7.4.2 事务操作成功

> 下面代码里
>
> - 事务开启
> - 然后执行2个sql语句
>     - sqlstr1，将age更新为3
>     - sqlstr2，将age更新为4
> - 如果sql1str1和sqlstr2都执行成功，那么事务就执行成功，本次事务就会提交
>     - 也就是说要么sql都执行成功，就进行事务提交
>     - 要么sql只要有一处执行失败，就进行事务回滚
> - 如果sql1str1和sqlstr2其中一个执行失败，那么就会直接进行回滚，函数return，本次执行结束

```go
package main

import (
	"database/sql"
	"fmt"
	_ "github.com/go-sql-driver/mysql"
)

// 定义全局db，表示数据库连接池
var db *sql.DB

// 初始化数据库
func initDB() (err error) {
	// dsn: data source name
	dsn := "root:123456@tcp(127.0.0.1:3306)/prc_ly"
	// 打开数据库
	db, err = sql.Open("mysql", dsn)
	if err != nil {
		fmt.Printf("open mysql err:%v\n", err)
		return
	}
	
	// ping mysql
	err = db.Ping()
	if err != nil{
		fmt.Printf("conn mysql err:%v\n", err)
		return
	}
	fmt.Println("数据库初始化成功")
	return
}

// 定义数据库字段结构体
type user struct{
	id int
	name string
	age int
	hobby string
}

// 事务操作
func transactionDBData(){
	// 开启事务
	fmt.Println("开始开启事务")
	tx, err := db.Begin()
	if err != nil {
		fmt.Printf("开始事务失败:%v\n", err)
	}
	
	// 提交多个sql操作
	sqlStr1 := "update user set age = 3 where id = 1"
	sqlStr2 := "update user set age = 4 where id = 2"
	
	// 执行sqlstr1
	_, err = tx.Exec(sqlStr1)
	if err != nil {
		// 执行sql有错误，事务要回滚，并且直接函数返回
		tx.Rollback()
		fmt.Printf("执行sqlstr1错误需要回滚:%v\n", err)
		return
	}
	// 执行sqlstr1
	_, err = tx.Exec(sqlStr2)
	if err != nil {
		// 执行sql有错误，事务要回滚，并且直接函数返回
		tx.Rollback()
		fmt.Printf("执行sqlstr1错误需要回滚:%v\n", err)
		return
	}
	
	// 上面没问题就开始提交事务
	err = tx.Commit()
	if err != nil{
		tx.Rollback()
		fmt.Printf("提交事务出错需要回滚:%v\n", err)
		return
	}
	fmt.Printf("事务执行成功")
}

func main() {
	err := initDB()
	if err != nil {
		fmt.Printf("数据库初始化失败:%v\n", err)
	}
	
	// 事务执行
	transactionDBData()
}
```

![image-20220523095904385](go_mysql%E4%BD%BF%E7%94%A8/image-20220523095904385.png)

##### 7.4.3 事务成功后表数据

> 可以看到事务实行成功以后，id=1和id=2的age都进行了更新

![image-20220523095943669](go_mysql%E4%BD%BF%E7%94%A8/image-20220523095943669.png)

##### 7.4.4 事务操作失败

> 事务操作失败：只要事务中有一个sql执行失败、或者提交事务失败，那么本次事务就会回滚，有增删改操作的sql数据就不会修改
>
> - 模拟事务执行失败，此时`user`表的数据里只有id等于1和2的数据，所以可以模拟更新age字段时，将`age`字段写错，比如写成`ages`
> - 将id=1和id=2的`age`故意写错为`ages`(正确字段是age)更新为2
>     - 此时的id=1数据，age字段原本的值是3（上面7.4.2小节事务操作成功后修改的数据）
>     - 此时的id=2数据，age字段原本的值是4（上面7.4.2小节事务操作成功后修改的数据）

```go
// 关键修改的代码，将age字段写错，比如写成ages
sqlStr1 := "update user set ages = 2 where id = 1"
sqlStr2 := "update user set ages = 2 where id = 2"
```

![image-20220523101004206](go_mysql%E4%BD%BF%E7%94%A8/image-20220523101004206.png)

> 从执行结果看到执行事务失败后，进行了事务回滚，再次查看表的数据，id=1和id=2的这两条数据里的age字段的值没有被修改为2，仍是3和4

![image-20220523101057390](go_mysql%E4%BD%BF%E7%94%A8/image-20220523101057390.png)

### 8、SQL中的占位符

> sql中的占位符是原生数据库本来的语法，和`golang`语言没有关系

| 数据库     | 占位符       |
| ---------- | ------------ |
| MySQL      | ?            |
| PostgreSql | $1、$2、$3等 |
| SQLite     | ?和$1        |

## 四、sqlx

> sqlx是一个库，它在go的标准数据库/sql库上提供了一系列的扩展。sqlx版本的sql.DB、sql.TX、sql.Stmt等都没有动用底层接口，因此它们的接口是标准接口的超集。这使得用sqlx整合现有的数据库/sql的代码库变得相对容易。
>
> Sqlx主要的附加概念是：
>
> - 将行转入结构（支持嵌入式结构）、映射和切片中
> - 支持命名的参数，包括准备好的语句
> - 获取和选择以快速从查询到结构/切片
> - 除了godoc API文档外，还有一些用户文档，解释了如何与sqlx一起使用数据库/sql。

> sql会遇到的坑
>
> https://zhuanlan.zhihu.com/p/98161107

### 1、sqlx安装

> sqlx是个第三方库，能简化数据库操作，提交效率
>
> sqlx替换了原生的`database/sql`这个包

```bash
# sqlx安装
go get github.com/jmoiron/sqlx
```

### 2、sqlx连接数据库

> sqlx.Connect()直接连数据库，并且将原来`database/sql`的open和ping方法二者结合为一
>
> 注意：
>
> - 定义全局变量db时，是定义的`*sqlx.DB`
> - 也可使用MustConnect来校验连接，连接失败就会panic
>     - MustConnect底层调用的就是Connect方法

```go
// sqlx.Connect代码源码
// Connect to a database and verify with a ping.
func Connect(driverName, dataSourceName string) (*DB, error) {
	db, err := Open(driverName, dataSourceName)
	if err != nil {
		return nil, err
	}
	err = db.Ping()
	if err != nil {
		db.Close()
		return nil, err
	}
	return db, nil
}
```

```go
// MustConnect方法源码
// MustConnect connects to a database and panics on error.
func MustConnect(driverName, dataSourceName string) *DB {
	db, err := Connect(driverName, dataSourceName)
	if err != nil {
		panic(err)
	}
	return db
}
```

```go
package main

import (
	"fmt"
	_ "github.com/go-sql-driver/mysql"
	// 这个包替换了database/sql这个包
	"github.com/jmoiron/sqlx"
)

// 定义sqlx.DB全局变量，表示一个连接池
var db *sqlx.DB

func initDB() (err error){
	dsn := "root:123456@tcp(127.0.0.1:3306)/prc_ly"
	db, err = sqlx.Connect("mysql", dsn)
	if err != nil {
		fmt.Printf("数据库连接失败:%v\n", err)
		return
	}
	fmt.Println("数据库连接成功")
	return
}

func main(){
	err := initDB()
	if err != nil {
		fmt.Printf("初始化数据失败:%v\n", err)
		return
	}
}
```

![image-20220523103145835](go_mysql%E4%BD%BF%E7%94%A8/image-20220523103145835.png)

### 3、sqlx操作数据库

#### 3.1 查询

##### 3.1.1 单条记录查询

> 使用的`Get`方法，其实可以看到需要传入的参数里
>
> - dest: 是一个空接口类型，可以是一个结构体指针，来接收查询到的值
> - query: 是一个字符串，表示是执行sql的字符串
>     - 可以用`?`进行占位符
> - args: 表示是参数
>     - 可以用来传递`?`占位符的值
> - 注意：
>     - 在定义接收查询结果的结构体里，字段名需要写成首字母大写
>     - 因为Get方法里的`Get`用到了反射，那么为了在别的包能找到定义接收结果的结构体，结构体字段的首字母都要大写

```go
// Get方法源码
// Get using this DB.
// Any placeholder parameters are replaced with supplied args.
// An error is returned if the result set is empty.
func (db *DB) Get(dest interface{}, query string, args ...interface{}) error {
	return Get(db, dest, query, args...)
}
```

```go
package main

import (
	"fmt"
	_ "github.com/go-sql-driver/mysql"
	// 这个包替换了database/sql这个包
	"github.com/jmoiron/sqlx"
)

// 定义sqlx.DB全局变量，表示一个连接池
var db *sqlx.DB

// 初始化数据库
func initDB() (err error){
	dsn := "root:123456@tcp(127.0.0.1:3306)/prc_ly"
	db, err = sqlx.Connect("mysql", dsn)
	if err != nil {
		fmt.Printf("数据库连接失败:%v\n", err)
		return
	}
	fmt.Println("数据库连接成功")
	return
}

type user struct{
	Name string
	Age int
}


// 单条查询数据
func queryRowData(id int) {
	sqlStr := "select name, age from user where id = ?"
	var uObj user
	err := db.Get(&uObj, sqlStr, id)
	if err != nil {
		fmt.Printf("查询数据失败：%v\n", err)
		return
	}
	fmt.Printf("uObj:%+#v\n", uObj)
}

func main(){
	err := initDB()
	if err != nil {
		fmt.Printf("初始化数据失败:%v\n", err)
		return
	}
	
	// 查询数据
	queryRowData(1)
}
```

![image-20220523221603385](go_mysql%E4%BD%BF%E7%94%A8/image-20220523221603385.png)

##### 3.1.2 多条记录查询

> 查询多条使用`Select`方法

```go
// select方法
// Select using this DB.
// Any placeholder parameters are replaced with supplied args.
func (db *DB) Select(dest interface{}, query string, args ...interface{}) error {
	return Select(db, dest, query, args...)
}
```

```go
// 查询多条记录
func queryMultiRowData(id int) {
	sqlStr := "select name, age from user where id > ?"
	
	// 初始化切片
	uObj := make([]user, 0, 10)
	
	err := db.Select(&uObj, sqlStr, id)
	if err != nil {
		fmt.Printf("查询多条数据失败：%v\n", err)
		return
	}
	fmt.Printf("uObj:%+v\n", uObj)
}
```

![image-20220523222434551](go_mysql%E4%BD%BF%E7%94%A8/image-20220523222434551.png)

#### 3.2 增删改数据

> sqlx里的增删改数据操作和原生的`database/sql`里的方法一致，都是用`Exec`方法，就不做赘述

#### 3.3 事务支持

> `sqlx`中提供了：
>
> - `db.Beginx()`：开启事务
>
> - `tx.Exec()`：事务执行sql语句
> - `tx.Rollback()`: 事务进行回滚
> - `tx.Commit()`:  提交事务
>
> 因为sqlx里的事务操作也和原生的`database/sql`里的事务操作类似，所以就不做重复记录了

### 4、sqlx常见问题

#### 4.1 missing destination name xx in xxx

问题背景

> - 当sql语句中是select *
> - 当使用的是sqlx.Select函数查询所有记录
> - 当Select函数传入的结构体没有使用`db`tag来标记字段

问题原因

> 1、当定义的结构体没有添加`db`这个tag时，
>
> - 追踪sqlx的调用链你会找到`scanAny`函数，而此函数会有一个对比操作，下面这段代码会对比你查询的数据库字段和映射的结构体字段,如果结构体中不存在这个字段就会报 "missing destination name"
>
> 参考：
>
> [https://zhuanlan.zhihu.com/p/98161107](https://zhuanlan.zhihu.com/p/98161107)
>
> [https://stackoverflow.com/questions/44985354/sqlx-missing-destination-name-for-struct-tag-through-pointer](https://stackoverflow.com/questions/44985354/sqlx-missing-destination-name-for-struct-tag-through-pointer)
>
> [https://stackoverflow.com/questions/53655515/sqlx-missing-destination-name-when-using-table-name-in-the-struct-tag](https://stackoverflow.com/questions/53655515/sqlx-missing-destination-name-when-using-table-name-in-the-struct-tag)

```text
// v.Type() 为你传入的struct的反射类型
// columns 为你查询的数据库列
fields := m.TraversalsByName(v.Type(), columns)
// if we are not unsafe and are missing fields, return an error
if f, err := missingFields(fields); err != nil && !r.unsafe {
    return fmt.Errorf("missing destination name %s in %T", columns[f], dest)
}
```

> 2、当定义的结构体添加了`db`这个tag时
>
> - 需要检查是否漏掉了`db`tag的两个引号导致的问题
> - `db`tag中的字段吗是否和数据库中的字段名对应
>
> 参考：
>
> - [https://blog.csdn.net/qq_44336275/article/details/113830594](https://blog.csdn.net/qq_44336275/article/details/113830594)

问题解决

> - 给Select函数传入的结构体使用`db`tag来标记数据库字段
> - 并且`db`tag中的写入的字段名和数据库表中字段名一致

## 五、SQL注入理解

### 1、SQL注入示例

> SQL注入就是在查询数据库时，尝试性的在数据查询后面拼接上`or 1=1 #`这样的语句，就会把所有数据都查出来
>
> - `#`表示后面的语句都注释掉
>
> 如何避免SQL注入
>
> - 不要自己拼接SQL语句
> - 让SQL语句在SQL服务器进行预编译

```go
package main

import (
	"fmt"
	_ "github.com/go-sql-driver/mysql"
	// 这个包替换了database/sql这个包
	"github.com/jmoiron/sqlx"
)

// 定义sqlx.DB全局变量，表示一个连接池
var db *sqlx.DB

// 初始化数据库
func initDB() (err error){
	dsn := "root:123456@tcp(127.0.0.1:3306)/prc_ly"
	db, err = sqlx.Connect("mysql", dsn)
	if err != nil {
		fmt.Printf("数据库连接失败:%v\n", err)
		return
	}
	fmt.Println("数据库连接成功")
	return
}

type user struct{
	Name string
	Age int
}


// Sql注入查询记录
func sqlInjectDBData(name string) {
	// 手动拼接sql
	sqlStr := fmt.Sprintf("select name, age from user where name = '%v'", name)
	
	fmt.Printf("手动拼接的sql：%v\n", sqlStr)
	
	// 初始化切片
	uObj := make([]user, 0, 10)
	
	err := db.Select(&uObj, sqlStr)
	if err != nil {
		fmt.Printf("查询多条数据失败：%v\n", err)
		return
	}
	fmt.Printf("uObj:%+v\n", uObj)
}

func main(){
	err := initDB()
	if err != nil {
		fmt.Printf("初始化数据失败:%v\n", err)
		return
	}
	
	// 正确查询
	sqlInjectDBData("sam")
	
	// Sql注入查询实例
	sqlInjectDBData("sam' or 1=1 #")
}
```

![image-20220523225248038](go_mysql%E4%BD%BF%E7%94%A8/image-20220523225248038.png)

### 2、注入分析

```go
// 在编写查询代码时，在代码里进行手动拼接sql
sqlStr := fmt.Sprintf("select name, age from user where name = '%v'", name)

// 在执行时，写了如下代码
sqlInjectDBData("sam' or 1=1 #")

// 那么上面写的语句在sqlStr里就会变成
select name, age from user where name = 'sam' or 1=1 #' "

// 这样去查询数据库,当有sam这个值时，查询出了sam的记录，并且1=1，表示永远为真，会把所有数据都查出来，这样就是SQL注入了
```
