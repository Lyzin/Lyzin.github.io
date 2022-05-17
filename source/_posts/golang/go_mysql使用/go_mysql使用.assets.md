---
title: Golang Mysql笔记
date: 2021-05-16 19:31:21
tags: 
- Mysql
- Golang
cover: /posts_cover_img/golang/go_mysql.png
categories: Golang Mysql笔记
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

![image-20220324152525798](go_mysql%E4%BD%BF%E7%94%A8.assets/image-20220324152525798.png)

#### 2.3 连接数据库

> 这里使用了`mycli`这个包来连接数据库测试
>
> `mycli`包时python写的一个具有代码提示的mysql使用工具

![image-20220324152502070](go_mysql%E4%BD%BF%E7%94%A8.assets/image-20220324152502070.png)

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

![image-20220516104406809](go_mysql%E4%BD%BF%E7%94%A8.assets/image-20220516104406809.png)

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

![image-20220516104457767](go_mysql%E4%BD%BF%E7%94%A8.assets/image-20220516104457767.png)

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

![image-20220516105118247](go_mysql%E4%BD%BF%E7%94%A8.assets/image-20220516105118247.png)

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

![image-20220516104653089](go_mysql%E4%BD%BF%E7%94%A8.assets/image-20220516104653089.png)

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

### 2、查询单条数据

> 查询数据用到了两个方法，queryRow和Scan

#### 2.1 QueryRow方法

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

#### 2.2 Scan方法

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

#### 2.3 查询实例

> 下面是单条记录查询的demo
>
> 需要先定一个数据库对应表的结构体，来传入给Scan方法进行接收QueryRow对象获得的值
>
> 注意：
>
> - 需要传入的是结构体指针，因为go语言中函数传值一般都是值拷贝，我们不希望值拷贝，如果是值拷贝，拿到的结果就不会重新赋值给声明的结构体
>
> - 所以对声明的结构体重新赋值，必须穿入指针，保证是传入的同一个
>
> 查询时，传递给QueryRow的sqlStr时，可以在sqlStr里使用`?`来表示占位符，用来动态传递值
>
> 必须对RowQuery查询到的结果调用Scan方法，因为Scan方法里定义了自动释放数据库链接的方法

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

![image-20220516145006179](go_mysql%E4%BD%BF%E7%94%A8.assets/image-20220516145006179.png)

### 3、最大连接数

> 因为`DB`这个结构体自己维护了一个数据库连接池，那么这个连接池可以设置数据库链接大小

#### 3.1 SetMaxOpenConns方法

> 用来设置数据库连接池最大连接数
>
> 注释翻译:
>
> - SetMaxOpenConns设置到数据库的最大开放连接数。
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

#### 3.2 SetMaxOpenConns方法使用

> 如果设置了SetMaxOpenConns的最大数，比如10
>
> 当连接池的db连接被使用完了，程序就会夯住，因为没有连接池里没有闲置的db连接了，此时会一直等待有闲置的db来使用，但是池子里已经没有可用的db连接了，那么程序就卡住了

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

![image-20220516171940580](go_mysql%E4%BD%BF%E7%94%A8.assets/image-20220516171940580.png)

