---
title: Django笔记
date: 2022-05-16 19:31:21
tags: 
- Python
- Django
cover: /posts_cover_img/python/django.png
categories: Django笔记
---

## 一、Web框架介绍

### 1、web框架的底层理解

```python
# 网络协议
HTTP协议    数据传输明文协议
HTTPS协议   数据传输密文协议
websock协议 数据传输密文协议

# HTTP四大特性
1. 基于请求、响应
2. 基于TCP/IP作用于应用层之上的协议
3. 无状态
4. 短/无链接

# HTTP数据格式
请求首行
请求头
请求行

# 响应状态码
1XX
2XX
3XX
4XX
5XX
```

#### 1.1 实现一个Http的服务端

```python
import socket

server = socket.socket()
server.bind(("127.0.0.1", 8000))

# 池子
server.listen(5)

while True:
    conn, addr = server.accept()

    # 接收客户端的请求数据,客户端可以是浏览器，请求相关的所有信息
    data = conn.recv(1024)
    print(f"recv data:{data}")
    print("data type is:",type(data))
    conn.send(b"HTTP/1.1 200 OK\r\n\r\nhello web")
    conn.close()
```

- 浏览器打开`http://127.0.0.1:8080`

> 终端内有两条请求记录，目前只关心`GET /` 这一条，`/favicon.ico`暂时不关心

![image-20211025193840271](django%E7%AC%94%E8%AE%B0.assets/image-20211025193840271.png)

```python
 print(f"recv data:{data}")
 print("data type is:",type(data))  # <class 'bytes'>
# 上面两行代码返回的data结果
 """
    b'GET / HTTP/1.1\r\n
    Host: 127.0.0.1:8001\r\n
    Connection: keep-alive\r\n
    Upgrade-Insecure-Requests: 1\r\n
    User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36\r\n
    Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9\r\n
    Sec-Fetch-Site: none\r\n
    Sec-Fetch-Mode: navigate\r\n
    Sec-Fetch-User: ?1\r\n
    Sec-Fetch-Dest: document\r\n
    Accept-Encoding: gzip, deflate, br\r\n
    Accept-Language: zh-CN,zh;q=0.9\r\n
    Cookie: csrftoken=SwCZzdzHFXp8uGWHUqjfrIycQ1P4X6MMo0OG1EhPLPzfMYV1yeSaxmaOEq8GqbXe\r\n\r\n'
    """
```

### 2、wsgiref模块

> Django底层用的是`wsgiref`模块来请求和响应数据
>
> `wsgiref`模块也叫web服务网关接口
>
> 1. 请求来的时候解析`HTTP`格式的数据，封装成大字典
> 2. 响应走的时候给数据打包成符合`HTTP`格式的数据返回给浏览器

### 3、Django安装

> `Django`的版本问题
>
> - `Django1.x`和`Django2.x`的差距不大
> - 所以先学习`Django1.x`的即可，后续有需要可以往`Django2.x`过渡
> - 面试时可以说先用的1.8，慢慢过渡到了1.11版本
> - 因为Django1.11.11最好适合的Python3版本是`3.4~3.6`之间的版本，3.7以及后面的版本和Django的`1.11.11`版本有兼容问题
>   - [pip清华地址:https://mirrors.tuna.tsinghua.edu.cn/help/pypi/](https://mirrors.tuna.tsinghua.edu.cn/help/pypi/)

```bash
pip install django==1.11.11

// 查看django版本
(venv) D:\>django-admin version
1.11.11
```

## 二、Django基本操作

> 下面基本都在命令行操作

### 1、创建项目

> `blog`是项目名
>
> 使用`django-admin`可以快速创建一个`Django`项目

```bash
// 创建Django项目的命令
django-admin startproject blog
```

> 创建完以后可以看到项目目录的结构
>
> - 项目根目录有两个东西：
>   - 一个是项目管理文件: `manage.py`
>   - 另一个是目录:`blog`
>
> - `blog`目录中：
>
>   - `setting.py`：项目配置文件
>
>   - `urls.py` ：项目路由文件
>
>   - `wsgi.py` ：项目启动服务文件

### 2、创建应用

> - 一个`app`就是一个功能独立的模块
> - 一个项目可以有多个`app`：比如下面的`home`是就是应用名
>
> - 由于`django 1.11`版本和`python3.7`版本不兼容, 2.0版本以后的Django修复了这个问题，所以使用下面命令创建app就需要注意下python3和Django的版本
>

```bash
# 切换到创建的项目根目录
python manage.py startapp home
```

![image-20211215235855339](django%E7%AC%94%E8%AE%B0.assets/image-20211215235855339.png)

#### 2.1 应用的目录结构

![image-20211216000052168](django%E7%AC%94%E8%AE%B0.assets/image-20211216000052168.png)

#### 2.2 注册应用

> 创建出来的应用一定要先去配置文件中注册，在`setting.py`文件中

```python
# 注册创建的App
# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    # 'bolg.home',  // 全写
    'home' # 简写，只写应用名
]
```

### 3、项目目录结构介绍

```bash
- blog目录
		- blog目录中：
			 -- setting.py 配置文件
			 -- urls.py  路由与视图函数对应关系（路由层）
			 -- wsgi.py  wsgiref模块（不考虑）
		- manage.py  项目入口文件
		- db.sqlite3 自带数据库，很小，仅仅用来做测试
		- home目录
			 -- admin.py 后台管理
			 -- apps.py 注册使用
			 -- migrations 数据库迁移日志文件
			 -- models.py 数据库模型类，用于ORM
			 -- views.py 视图函数文件
			 -- test.py 测试文件
```

### 4、启动Django项目

```bash
python manage.py runserver
```

![image-20211216000435878](django%E7%AC%94%E8%AE%B0.assets/image-20211216000435878.png)

> 打开浏览器，输入上面的地址打开后可以看到下面页面，就表示启动`Django`成功
>
> 并且可以看到下面的英文提示：
>
> - 第一句(Your're seeing...):表示能看到这个消息，是`Django`项目的`setting.py`文件中的`DEBUG=True`
> - 第二句(you haven't...):表示还没有配置路由`URLS`

![image-20211216000754066](django%E7%AC%94%E8%AE%B0.assets/image-20211216000754066.png)

### 5、`templates`目录

> `templates`目录用来存放前段`HTML`页面的
>
> - 命令行创建`没有templates`文件目录
>
> - pycharm创建是`templates`文件目录的

### 6、Django三组件

#### 6.1 HttpResponse

> 从`HttpResponse`源码可以看：
>
> - 是一个`Http`响应，并且返回的是字符串内容
> - 这个内容可以被读、追加或者替换
>
> 视图函数中的`request`参数是一个对象，用来获取请求的所有数据

```python
# HttpResponse部分源码
class HttpResponse(HttpResponseBase):
    """
    An HTTP response class with a string as content.

    This content that can be read, appended to or replaced.
    """

    streaming = False

    def __init__(self, content=b'', *args, **kwargs):
        super(HttpResponse, self).__init__(*args, **kwargs)
        # Content is a bytestring. See the `content` property methods.
        self.content = content
```

```python
# 写在urls.py文件
from home import views

urlpatterns = [
    # url(r'^admin/', admin.site.urls),
    url("^home/", views.home)
]
-------------------------------------------------------------------
# 写在应用的views.py中
from django.shortcuts import render,HttpResponse

# Create your views here.
def home(request):
    ret = HttpResponse("Hi, Django")
    print(ret) # <HttpResponse status_code=200, "text/html; charset=utf-8">
    print(ret.status_code) # 200
    print(type(ret)) # <class 'django.http.response.HttpResponse'>
    return ret
```

#### 6.2 render

> 给浏览器返回渲染的`html`文件，将`html`文件变成字节形式返回给浏览器

##### 2.1 创建`html`文件

> 需要先在`templates`创建对应的`html`文件
>
> `{{ ret }}`是django自带的模板语法，表示接收变量的值

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
    {{ ret }}
</body>
</html>
```

##### 2.2 编写路由

```python
# 在settings.py文件中添加index_html的路由
from django.conf.urls import url
from django.contrib import admin
from day01 import views

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^index/', views.index),
    url(r'^index_html/', views.index_html),
]
```

##### 2.3 编写视图函数

```python
# 应用中使用,写在views.py中
def index_html(request):
    """
    :param request: 请求相关的所有的数据
    :return: HttpResponse对象值
    """
    ret = 'html page data'
    return render(request, 'index.html', locals())
```

##### 2.4 请求页面

> 访问`http://127.0.0.1:8000/index_html/`即可看到下面的页面

![image-20210903143834317](django%E7%AC%94%E8%AE%B0.assets/image-20210903143834317.png)

#### 3. redirect

> 表示在视图函数中跳转到别的页面，也叫重定向

```python
# 应用中使用,写在views.py中
def index_redirect(request):
    """
    :param request: 请求相关的所有的数据
    :return: HttpResponse对象值
    """
    redirect_url = '/index/'
    return redirect(redirect_url)
```

> 访问`http://127.0.0.1:8000/index_html/`就会最终跳转至`/index/`页面

![image-20210903144432203](django%E7%AC%94%E8%AE%B0.assets/image-20210903144432203.png)

### 7、静态文件配置

> `html`文件都放在`templates`文件下
>
> 将静态文件放在`static`文件夹里
>
> - 前端写好的文件都可以叫静态文件，比如`js`/`css`/`图片`/`前端框架`
>
> `django`需要自己创建`static`文件夹
>
> - 在`static`中可以放`js`/`css`/`plugins`等文件夹，做好区分



#### 1.1 静态文件绝对路径

> `谨记：`
>
> - `在浏览器输入url时，能看到对应的资源，是因为服务端开启了对应资源的接口`
> - `如果访问不到，那就是服务端没有开启对应资源的接口`

> 未开启对应资源的接口，而是只在Django目录下创建了`/static/css/home.css`目录和文件，然后直接在`html`里直接引用，就会报错，因为服务端根本没有将这个资源的入口开启，直接访问会404找不到

```html
# index文件里直接写css文件
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>home</title>
    <link rel="stylesheet" href="../static/css/home.css">
</head>
<body>
    <p>这是主页</p>
</body>
</html>
```

![image-20211227234555244](django%E7%AC%94%E8%AE%B0.assets/image-20211227234555244.png)

> 上述在浏览器打开`http://127.0.0.1:8000/home/`就会出现home.css文件404的情况

![image-20211227235030984](django%E7%AC%94%E8%AE%B0.assets/image-20211227235030984.png)

#### 1.2 服务端开启静态资源入口

> 因为上面的报错，所以需要服务端开启访问静态资源的入口，才可以使得前端可以访问到资源
>
> `STATICFILES_DIRS`表示:
>
> - 开放了静态文件路径，将`Django`目录下创建的`static`文件夹加入到了`静态资源列表`,前端页面就可以访问到了
> - 是一个列表，表示可以放多个静态资源目录
>   - 多个时，先从第一个找，找不到继续往下找，直到找到就会返回对应的资源
>
> `STATIC_URL = '/static/'`:
>
> - 表示前端访问静态资源时，需要带的一个令牌，拿着这个令牌，再去`STATICFILES_DIRS`里的文件夹中去找对应的资源文件
> - 前端写静态资源的路径时，写的`static`就是`STATIC_URL`后面的`/static/`就是令牌
> - 那么这个令牌就可以自定义了，只需要改了这里，前端页面去拿静态资源时的令牌就要变成修改的了，比如将`/static/`改为`/abc/`，那么前端页面里写静态资源路径时的第一个单词就要写成`/abc/`

```python
# 在setting.py文件下添加该行代码，表示服务端开启了访问静态资源的入口
# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.11/howto/static-files/

# 这个是访问的令牌
STATIC_URL = '/static/'

# 此处为新加代码
STATICFILES_DIRS = [
    os.path.join(BASE_DIR, "static"),
]
```

![image-20211227234806719](django%E7%AC%94%E8%AE%B0.assets/image-20211227234806719.png)

> 再次访问`http://127.0.0.1:8000/home/`就会出现正常样式

![image-20211227235127800](django%E7%AC%94%E8%AE%B0.assets/image-20211227235127800.png)



#### 1.3 灵活取令牌值

> ​	但是当前端页面很多时，并且我们都是用相对路径去写静态资源的路径，并且路径第一个单词是`令牌`，这个时候需要修改令牌时，就会需要修改很多文件，那么怎么灵活处理呢？就用到了`静态文件动态解析`
>

![image-20220106150623144](django%E7%AC%94%E8%AE%B0.assets/image-20220106150623144.png)

![image-20211228000549317](django%E7%AC%94%E8%AE%B0.assets/image-20211228000549317.png)

![image-20211228000832612](django%E7%AC%94%E8%AE%B0.assets/image-20211228000832612.png)



### 8、request对象方法

#### 1.1 关闭`csrf`中间件

> 在前阶段学习时，可以先注释`csrf`中间件，否则做一些`form`表单提交时会报错
>
> 后面再来探讨这个问题

![image-20211228001140316](django%E7%AC%94%E8%AE%B0.assets/image-20211228001140316.png)

#### 1.2 request对象

> 在视图函数中都会有`request`形参，需要重点来学习下这个`request`，`request`是一个对象，里面有很多可以供我们使用的方法

```python
# 还是用之前的home函数
from django.shortcuts import render,HttpResponse

# Create your views here.

def home(request):
    print(request) # <WSGIRequest: GET '/home/'>
    print(type(request)) #<class 'django.core.handlers.wsgi.WSGIRequest'>
    print(dir(request)) 
    return render(request, "index.html")
```

```python
dir(request) # 可以看到有很多的方法

# ['COOKIES', 'FILES', 'GET', 'META', 'POST', '__class__', '__delattr__', '__dict__', '__dir__', '__doc__', '__eq__', '__format__', '__ge__', '__getattribute__', '__gt__', '__hash__', '__init__', '__init_subclass__', '__iter__', '__le__', '__lt__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_encoding', '_get_post', '_get_raw_host', '_get_scheme', '_initialize_handlers', '_load_post_and_files', '_mark_post_parse_error', '_messages', '_post_parse_error', '_read_started', '_set_post', '_stream', '_upload_handlers', 'body', 'build_absolute_uri', 'close', 'content_params', 'content_type', 'encoding', 'environ', 'get_full_path', 'get_host', 'get_port', 'get_raw_uri', 'get_signed_cookie', 'is_ajax', 'is_secure', 'method', 'parse_file_upload', 'path', 'path_info', 'read', 'readline', 'readlines', 'resolver_match', 'scheme', 'session', 'upload_handlers', 'user', 'xreadlines']
```

##### 1.2.1 request.method

> 用来获取请求这个url的请求方法

> 如果是以`get`方法请求的这个视图函数，那么`request.method`返回值就是`大写的GET`字符串
>
> 如果是以`post`方法请求的这个视图函数，那么`request.method`返回值就是`大写的POST`字符串
>
> 举例：这样就可以用来做请求方法拆分，可以使用`if`先判断请求方法是什么：
>
> - 如果请求方法是`GET`，可以先返回一个页面
> - 如果请求方法是`POST`，返回单独的`POST`请求处理，在`POST`里就可以获取前端传入的请求数据

```python
from django.shortcuts import render,HttpResponse

# Create your views here.

def home(request):
    if request.method == "POST":
        return HttpResponse("POST data")
    return render(request, "index.html")
```

##### 1.2.2 request.POST

> 用来获取用户提交的`post`请求数据，不包含文件

> 前端页面

```html
# 创建一个form表单
<body>
    <p>这是主页</p>
    <form action="/home/" method="post">
        用户名: <input type="text" name="uname">
        密码: <input type="text" name="pwd">
        爱好:
            <input type="checkbox" name="hobby" value="足球">足球
            <input type="checkbox" name="hobby" value="排球">排球
            <input type="checkbox" name="hobby" value="桌球">桌球
        <input type="submit">
    </form>
</body>
</html>
```

![image-20211228003707768](django%E7%AC%94%E8%AE%B0.assets/image-20211228003707768.png)

> 后端`views.py`代码，从中可以看出：
>
> - `request.POST`是一个查询字典，类型是`<class 'django.http.request.QueryDict'>`
> - `request.POST`的`get方法`只会获取最后一个值，并且类型是`str`
> - `request.POST`的`getlist方法`会获取所有值，并且类型是`list`

```python
def home(request):
    if request.method == "POST":
        # <QueryDict: {'uname': ['ko'], 'pwd': ['123'], 'hobby': ['足球', '排球']}>
        print("request.POST:", request.POST)
        # <class 'django.http.request.QueryDict'>
        print("request.POST type:", type(request.POST))

        # get方法只会获取最后一个值
        uname = request.POST.get("uname")
        # uname = > ko
        print("uname=>", uname)
        # <class 'str'>
        print("uname type:", type(uname))

        # get方法只会获取最后一个值
        hob = request.POST.get("hobby")

        # 桌球
        print("hob=>", hob) # 桌球
        
        # <class 'str'>
        print("hob type=>", type(hob)) # 桌球

        hob_list= request.POST.getlist("hobby")
        # ['排球', '桌球']
        print("hob_list=>", hob_list)

        # <class 'list'>
        print("hob_list type=>", type(hob_list))
        return HttpResponse("POST data")
    return render(request, "index.html")
```

##### 1.2.3 request.GET

> `request.GET`和`request.POST`的所有请求方法都一样，`request.GET`和`request.POST`
>
> `request.GET`常用于获取url后面携带的参数
>
> 同样`request.GET`也支持用`get`/`getlist`获取`url`后面带的值

```python
# 请求的url：http://127.0.0.1:8000/home/?user=ko&age=19
# ?user=ko&age=19 是拼接的参数，在url里可以看到

def home(request):
    # < QueryDict: {'user': ['ko'], 'age': ['19']} >
    print(request.GET)
    
    # <class 'django.http.request.QueryDict'>
    print(type(request.GET))
    
    # 19
    print(request.GET.get("age"))

    # <class 'str'>
    print(type(request.GET.get("age")))
    return render(request, "index.html")
```

### 9、Pycharm操作Django技巧

#### 9.1 快速创建Django应用

![image-20211216001638808](django%E7%AC%94%E8%AE%B0.assets/image-20211216001638808.png)

#### 9.2 修改Django端口

![image-20211216001717991](django%E7%AC%94%E8%AE%B0.assets/image-20211216001717991.png)

![image-20211216001748598](django%E7%AC%94%E8%AE%B0.assets/image-20211216001748598.png)

#### 9.3 浏览器访问页面不走缓存

> 谷歌浏览器打开F12，找到设置，勾选下面的选项即可

![image-20211227235948716](django%E7%AC%94%E8%AE%B0.assets/image-20211227235948716.png)



## 三、ORM数据库

### 1、Pycharm连接数据库

> 使用`docker`可以快速创建`mysql`等数据库，用来快速搭建想要的环境

#### 1.1 mac下连接docker的mysql

> 步骤：
>
> - 创建一个`mysql`容器，拉取`mysql:5.7`镜像
> - 再去创建容器
> - 注意
>   - 创建完的数据库默认用户是root，密码使用`-e MYSQL_ROOT_PASSWORD=123456`设置为123456
>   - 创建完以后需要登录容器内部，给root用户开启远程访问权限，否则在容器外部会出现访问数据库失败的情况

```bash
# 拉取mysql容器，选择5.7版本的tag，不写5.7则会拉取8版本，8版本对我们来说太新了
docker pull mysql:5.7

# 启动容器
docker run -dit --name mysql -p 3306:3306  -e MYSQL_ROOT_PASSWORD=123456 mysql:5.7
#  表示设置数据库用户root的密码为123456

# 登录容器，赋予root远程登录权限
docker exec -it mysql /bin/bash

# 登录mysql容器后，配置远程访问权限
>> grant all privileges on *.* to root@"%" identified by "123456";
>> flush privileges ;

# 上面配置完成退出数据库，就可以在容器外部连接mysql了
mysql -uroot -h127.0.0.1 -p123456
```

> 在上述配置好以后，就可以在`pycharm`中打开`mysql`连接界面，进行连接数据库了，下面用截图表示

![image-20220104075847993](django%E7%AC%94%E8%AE%B0.assets/image-20220104075847993.png)

![image-20220104075948885](django%E7%AC%94%E8%AE%B0.assets/image-20220104075948885.png)

> 需要先下载对应数据库的驱动，上图配置界面会提示下载，点击下载即可
>
> 主机：数据库的地址，因为是本地连接，所以是127.0.0.1
>
> 端口：3306不变
>
> 用户、密码：数据库的用户和密码
>
> 数据库：提前创建好的数据名，需要提前在数据库中创建才可以进行连接
>
> 上面连接信息填写完以后，点击`测试连接`即可快速验证数据库是否连接成功，若未成功，需要检查下配置是否正确

#### 1.2 windows下连接docker的mysql

> `windows`下也可以用`docker`的`mysql`，一般可以在`linux`虚拟机里安装docker，在启动mysql容器
>
> 所以拉取`mysql`镜像,修改`mysql`的`root`权限、在`pycharm`中配置等步骤都和上面的`mac`配置一样
>
> 唯一区别在于：
>
> - windows下的`pycharm`想连接虚拟机里的docker的`mysql`容器，需要使用`pycharm`的`ssh隧道`功能先连接上虚拟机，再去连接虚拟机里的数据库
> - 下图展示了如何配置

![image-20220104080802817](django%E7%AC%94%E8%AE%B0.assets/image-20220104080802817.png)

![image-20220104080909084](django%E7%AC%94%E8%AE%B0.assets/image-20220104080909084.png)

> 虚拟机连接上后，再配置数据库连接

![image-20220104081033712](django%E7%AC%94%E8%AE%B0.assets/image-20220104081033712.png)

> 到这里数据库连接配置完成，可以在`pycharm`进行`django`的数据库连接了

### 2、Django连接Mysql

> `Django`连接数据库时，需要先创建好数据库
>
> `Django`自带了一个小型数据库`sqlite3`，这个数据库比较小，我们可以不用他，换成`mysql`
>
> `Django`如何连接`mysql`
>
> [官方地址: https://docs.djangoproject.com/en/1.11/ref/settings/#databases](https://docs.djangoproject.com/en/1.11/ref/settings/#databases)
>
> 注意一定要在`settings.py`文件中注册`APP`，否则会出现数据库迁移失败的情况

> `Django`连接mysql需要在`settings.py`中指定连接数据的名字、用户名、密码、端口
>
> `Django`连接数据库一定要先创建数据库，再去`settings.py`里去连接

```python
# settings.py文件，大概78行
# Database
# https://docs.djangoproject.com/en/1.11/ref/settings/#databases

# 这是默认的sqlite3连接，可以注释掉，连接mysql
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    }
}

# 连接mysql
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'mydatabase',   
        'USER': 'mydatabaseuser',
        'PASSWORD': 'mypassword',
        'HOST': '127.0.0.1',
        'PORT': '5432',
	}
}
```

![image-20211228010019204](django%E7%AC%94%E8%AE%B0.assets/image-20211228010019204.png)

### 3、ORM介绍和使用

> `ORM`：对象关系映射
>
> 主要是用来将mysql语句通过面向对象去执行
>
> 主要是在`Django`的`app`的`models.py`文件中写创建表语句，以面向对象的形式

#### 3.1 编写建表语句

> 需要在`app`的`models.py`文件中写面向对象代码
>
> 下面是创建了一个User表语句代码

```python
from django.db import models

# Create your models here.

class User(models.Model):
    # 等价于：id int primary_key auto_inscrement
    id = models.AutoField(primary_key=True)
    
    # 等价于：name varchar(32)
    name = models.CharField(max_length=32)
    
    # 等价于 age int
    age = models.IntegerField()
```

#### 3.2 数据库迁移命令

> 第一条命令，主要用来生成数据库建表语句记录，下面的命令只是生成记录，还没有真正在数据库中执行创建表

```bash
python manage.py makemigrations
```

> 执行后会在对应`app`的`migrations`文件夹下生成一个类似`0001_initial.py`的文件，主要记录了建表语句

![image-20220105234018673](django%E7%AC%94%E8%AE%B0.assets/image-20220105234018673.png)



> 第二条命令，将操作真正同步到数据库中
>

```python
python manage.py makemigrations
```



























=======
## 一、Web框架

### 1、web框架的底层理解

```python
# 网络协议
HTTP协议    数据传输明文协议
HTTPS协议   数据传输密文协议
websock协议 数据传输密文协议

# HTTP四大特性
1. 基于请求、响应
2. 基于TCP/IP作用于应用层之上的协议
3. 无状态
4. 短/无链接

# HTTP数据格式
请求首行
请求头
请求行

# 响应状态码
1XX
2XX
3XX
4XX
5XX
```

#### 1.1 实现一个Http的服务端

```python
import socket

server = socket.socket()
server.bind(("127.0.0.1", 8000))

# 池子
server.listen(5)

while True:
    conn, addr = server.accept()

    # 接收客户端的请求数据,客户端可以是浏览器，请求相关的所有信息
    data = conn.recv(1024)
    print(f"recv data:{data}")
    print("data type is:",type(data))
    conn.send(b"HTTP/1.1 200 OK\r\n\r\nhello web")
    conn.close()
```

- 浏览器打开`http://127.0.0.1:8080`

> 终端内有两条请求记录，目前只关心`GET /` 这一条，`/favicon.ico`暂时不关心

![image-20211025193840271](django%E7%AC%94%E8%AE%B0.assets/image-20211025193840271.png)

```python
 print(f"recv data:{data}")
 print("data type is:",type(data))  # <class 'bytes'>
# 上面两行代码返回的data结果
 """
    b'GET / HTTP/1.1\r\n
    Host: 127.0.0.1:8001\r\n
    Connection: keep-alive\r\n
    Upgrade-Insecure-Requests: 1\r\n
    User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.111 Safari/537.36\r\n
    Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/avif,image/webp,image/apng,*/*;q=0.8,application/signed-exchange;v=b3;q=0.9\r\n
    Sec-Fetch-Site: none\r\n
    Sec-Fetch-Mode: navigate\r\n
    Sec-Fetch-User: ?1\r\n
    Sec-Fetch-Dest: document\r\n
    Accept-Encoding: gzip, deflate, br\r\n
    Accept-Language: zh-CN,zh;q=0.9\r\n
    Cookie: csrftoken=SwCZzdzHFXp8uGWHUqjfrIycQ1P4X6MMo0OG1EhPLPzfMYV1yeSaxmaOEq8GqbXe\r\n\r\n'
    """
```

### 2、wsgiref模块

> Django底层用的是`wsgiref`模块来请求和响应数据
>
> `wsgiref`模块也叫web服务网关接口
>
> 1. 请求来的时候解析`HTTP`格式的数据，封装成大字典
> 2. 响应走的时候给数据打包成符合`HTTP`格式的数据返回给浏览器

### 3、Django安装

> `Django`的版本问题
>
> - `Django1.x`和`Django2.x`的差距不大
> - 所以先学习`Django1.x`的即可，后续有需要可以往`Django2.x`过渡
> - 面试时可以说先用的1.8，慢慢过渡到了1.11版本
> - 因为Django1.11.11最好适合的Python3版本是`3.4~3.6`之间的版本，3.7以及后面的版本和Django的`1.11.11`版本有兼容问题
>   - [pip清华地址:https://mirrors.tuna.tsinghua.edu.cn/help/pypi/](https://mirrors.tuna.tsinghua.edu.cn/help/pypi/)

```bash
pip install django==1.11.11

// 查看django版本
(venv) D:\>django-admin version
1.11.11
```

## 二、Django基本操作

> 下面基本都在命令行操作

### 1、创建项目

> `blog`是项目名
>
> 使用`django-admin`可以快速创建一个`Django`项目

```bash
// 创建Django项目的命令
django-admin startproject blog
```

> 创建完以后可以看到项目目录的结构
>
> - 项目根目录有两个东西：
>   - 一个是项目管理文件: `manage.py`
>   - 另一个是目录:`blog`
>
> - `blog`目录中：
>
>   - `setting.py`：项目配置文件
>
>   - `urls.py` ：项目路由文件
>
>   - `wsgi.py` ：项目启动服务文件

### 2、创建应用

> - 一个`app`就是一个功能独立的模块
> - 一个项目可以有多个`app`：比如下面的`home`是就是应用名
>
> - 由于`django 1.11`版本和`python3.7`版本不兼容, 2.0版本以后的Django修复了这个问题，所以使用下面命令创建app就需要注意下python3和Django的版本
>

```bash
# 切换到创建的项目根目录
python manage.py startapp home
```

![image-20211215235855339](django%E7%AC%94%E8%AE%B0.assets/image-20211215235855339.png)

#### 2.1 应用的目录结构

![image-20211216000052168](django%E7%AC%94%E8%AE%B0.assets/image-20211216000052168.png)

#### 2.2 注册应用

> 创建出来的应用一定要先去配置文件中注册，在`setting.py`文件中

```python
# 注册创建的App
# Application definition

INSTALLED_APPS = [
    'django.contrib.admin',
    'django.contrib.auth',
    'django.contrib.contenttypes',
    'django.contrib.sessions',
    'django.contrib.messages',
    'django.contrib.staticfiles',
    # 'bolg.home',  // 全写
    'home' # 简写，只写应用名
]
```

### 3、项目目录结构介绍

```bash
- blog目录
		- blog目录中：
			 -- setting.py 配置文件
			 -- urls.py  路由与视图函数对应关系（路由层）
			 -- wsgi.py  wsgiref模块（不考虑）
		- manage.py  项目入口文件
		- db.sqlite3 自带数据库，很小，仅仅用来做测试
		- home目录
			 -- admin.py 后台管理
			 -- apps.py 注册使用
			 -- migrations 数据库迁移日志文件
			 -- models.py 数据库模型类，用于ORM
			 -- views.py 视图函数文件
			 -- test.py 测试文件
```

### 4、启动Django项目

```bash
python manage.py runserver
```

![image-20211216000435878](django%E7%AC%94%E8%AE%B0.assets/image-20211216000435878.png)

> 打开浏览器，输入上面的地址打开后可以看到下面页面，就表示启动`Django`成功
>
> 并且可以看到下面的英文提示：
>
> - 第一句(Your're seeing...):表示能看到这个消息，是`Django`项目的`setting.py`文件中的`DEBUG=True`
> - 第二句(you haven't...):表示还没有配置路由`URLS`

![image-20211216000754066](django%E7%AC%94%E8%AE%B0.assets/image-20211216000754066.png)

### 5、`templates`目录

> `templates`目录用来存放前段`HTML`页面的
>
> - 命令行创建`没有templates`文件目录
>
> - pycharm创建是`templates`文件目录的

### 6、Django三组件

#### 6.1 HttpResponse

> 从`HttpResponse`源码可以看：
>
> - 是一个`Http`响应，并且返回的是字符串内容
> - 这个内容可以被读、追加或者替换
>
> 视图函数中的`request`参数是一个对象，用来获取请求的所有数据

```python
# HttpResponse部分源码
class HttpResponse(HttpResponseBase):
    """
    An HTTP response class with a string as content.

    This content that can be read, appended to or replaced.
    """

    streaming = False

    def __init__(self, content=b'', *args, **kwargs):
        super(HttpResponse, self).__init__(*args, **kwargs)
        # Content is a bytestring. See the `content` property methods.
        self.content = content
```

```python
# 写在urls.py文件
from home import views

urlpatterns = [
    # url(r'^admin/', admin.site.urls),
    url("^home/", views.home)
]
-------------------------------------------------------------------
# 写在应用的views.py中
from django.shortcuts import render,HttpResponse

# Create your views here.
def home(request):
    ret = HttpResponse("Hi, Django")
    print(ret) # <HttpResponse status_code=200, "text/html; charset=utf-8">
    print(ret.status_code) # 200
    print(type(ret)) # <class 'django.http.response.HttpResponse'>
    return ret
```

#### 6.2 render

> 给浏览器返回渲染的`html`文件，将`html`文件变成字节形式返回给浏览器

##### 2.1 创建`html`文件

> 需要先在`templates`创建对应的`html`文件
>
> `{{ ret }}`是django自带的模板语法，表示接收变量的值

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Title</title>
</head>
<body>
    {{ ret }}
</body>
</html>
```

##### 2.2 编写路由

```python
# 在settings.py文件中添加index_html的路由
from django.conf.urls import url
from django.contrib import admin
from day01 import views

urlpatterns = [
    url(r'^admin/', admin.site.urls),
    url(r'^index/', views.index),
    url(r'^index_html/', views.index_html),
]
```

##### 2.3 编写视图函数

```python
# 应用中使用,写在views.py中
def index_html(request):
    """
    :param request: 请求相关的所有的数据
    :return: HttpResponse对象值
    """
    ret = 'html page data'
    return render(request, 'index.html', locals())
```

##### 2.4 请求页面

> 访问`http://127.0.0.1:8000/index_html/`即可看到下面的页面

![image-20210903143834317](django%E7%AC%94%E8%AE%B0.assets/image-20210903143834317.png)

#### 3. redirect

> 表示在视图函数中跳转到别的页面，也叫重定向

```python
# 应用中使用,写在views.py中
def index_redirect(request):
    """
    :param request: 请求相关的所有的数据
    :return: HttpResponse对象值
    """
    redirect_url = '/index/'
    return redirect(redirect_url)
```

> 访问`http://127.0.0.1:8000/index_html/`就会最终跳转至`/index/`页面

![image-20210903144432203](django%E7%AC%94%E8%AE%B0.assets/image-20210903144432203.png)

### 7、静态文件配置

> `html`文件都放在`templates`文件下
>
> 将静态文件放在`static`文件夹里
>
> - 前端写好的文件都可以叫静态文件，比如`js`/`css`/`图片`/`前端框架`
>
> `django`需要自己创建`static`文件夹
>
> - 在`static`中可以放`js`/`css`/`plugins`等文件夹，做好区分



#### 1.1 静态文件绝对路径

> `谨记：`
>
> - `在浏览器输入url时，能看到对应的资源，是因为服务端开启了对应资源的接口`
> - `如果访问不到，那就是服务端没有开启对应资源的接口`

> 未开启对应资源的接口，而是只在Django目录下创建了`/static/css/home.css`目录和文件，然后直接在`html`里直接引用，就会报错，因为服务端根本没有将这个资源的入口开启，直接访问会404找不到

```html
# index文件里直接写css文件
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>home</title>
    <link rel="stylesheet" href="../static/css/home.css">
</head>
<body>
    <p>这是主页</p>
</body>
</html>
```

![image-20211227234555244](django%E7%AC%94%E8%AE%B0.assets/image-20211227234555244.png)

> 上述在浏览器打开`http://127.0.0.1:8000/home/`就会出现home.css文件404的情况

![image-20211227235030984](django%E7%AC%94%E8%AE%B0.assets/image-20211227235030984.png)

#### 1.2 服务端开启静态资源入口

> 因为上面的报错，所以需要服务端开启访问静态资源的入口，才可以使得前端可以访问到资源
>
> `STATICFILES_DIRS`表示:
>
> - 开放了静态文件路径，将`Django`目录下创建的`static`文件夹加入到了`静态资源列表`,前端页面就可以访问到了
> - 是一个列表，表示可以放多个静态资源目录
>   - 多个时，先从第一个找，找不到继续往下找，直到找到就会返回对应的资源
>
> `STATIC_URL = '/static/'`:
>
> - 表示前端访问静态资源时，需要带的一个令牌，拿着这个令牌，再去`STATICFILES_DIRS`里的文件夹中去找对应的资源文件
> - 前端写静态资源的路径时，写的`static`就是`STATIC_URL`后面的`/static/`就是令牌
> - 那么这个令牌就可以自定义了，只需要改了这里，前端页面去拿静态资源时的令牌就要变成修改的了，比如将`/static/`改为`/abc/`，那么前端页面里写静态资源路径时的第一个单词就要写成`/abc/`

```python
# 在setting.py文件下添加该行代码，表示服务端开启了访问静态资源的入口
# Static files (CSS, JavaScript, Images)
# https://docs.djangoproject.com/en/1.11/howto/static-files/

# 这个是访问的令牌
STATIC_URL = '/static/'

# 此处为新加代码
STATICFILES_DIRS = [
    os.path.join(BASE_DIR, "static"),
]
```

![image-20211227234806719](django%E7%AC%94%E8%AE%B0.assets/image-20211227234806719.png)

> 再次访问`http://127.0.0.1:8000/home/`就会出现正常样式

![image-20211227235127800](django%E7%AC%94%E8%AE%B0.assets/image-20211227235127800.png)



#### 1.3 灵活取令牌值

> ​	但是当前端页面很多时，并且我们都是用相对路径去写静态资源的路径，并且路径第一个单词是`令牌`，这个时候需要修改令牌时，就会需要修改很多文件，那么怎么灵活处理呢？就用到了`静态文件动态解析`
>

![image-20220106150623144](django%E7%AC%94%E8%AE%B0.assets/image-20220106150623144.png)

![image-20211228000549317](django%E7%AC%94%E8%AE%B0.assets/image-20211228000549317.png)

![image-20211228000832612](django%E7%AC%94%E8%AE%B0.assets/image-20211228000832612.png)



### 8、request对象方法

#### 1.1 关闭`csrf`中间件

> 在前阶段学习时，可以先注释`csrf`中间件，否则做一些`form`表单提交时会报错
>
> 后面再来探讨这个问题

![image-20211228001140316](django%E7%AC%94%E8%AE%B0.assets/image-20211228001140316.png)

#### 1.2 request对象

> 在视图函数中都会有`request`形参，需要重点来学习下这个`request`，`request`是一个对象，里面有很多可以供我们使用的方法

```python
# 还是用之前的home函数
from django.shortcuts import render,HttpResponse

# Create your views here.

def home(request):
    print(request) # <WSGIRequest: GET '/home/'>
    print(type(request)) #<class 'django.core.handlers.wsgi.WSGIRequest'>
    print(dir(request)) 
    return render(request, "index.html")
```

```python
dir(request) # 可以看到有很多的方法

# ['COOKIES', 'FILES', 'GET', 'META', 'POST', '__class__', '__delattr__', '__dict__', '__dir__', '__doc__', '__eq__', '__format__', '__ge__', '__getattribute__', '__gt__', '__hash__', '__init__', '__init_subclass__', '__iter__', '__le__', '__lt__', '__module__', '__ne__', '__new__', '__reduce__', '__reduce_ex__', '__repr__', '__setattr__', '__sizeof__', '__str__', '__subclasshook__', '__weakref__', '_encoding', '_get_post', '_get_raw_host', '_get_scheme', '_initialize_handlers', '_load_post_and_files', '_mark_post_parse_error', '_messages', '_post_parse_error', '_read_started', '_set_post', '_stream', '_upload_handlers', 'body', 'build_absolute_uri', 'close', 'content_params', 'content_type', 'encoding', 'environ', 'get_full_path', 'get_host', 'get_port', 'get_raw_uri', 'get_signed_cookie', 'is_ajax', 'is_secure', 'method', 'parse_file_upload', 'path', 'path_info', 'read', 'readline', 'readlines', 'resolver_match', 'scheme', 'session', 'upload_handlers', 'user', 'xreadlines']
```

##### 1.2.1 request.method

> 用来获取请求这个url的请求方法

> 如果是以`get`方法请求的这个视图函数，那么`request.method`返回值就是`大写的GET`字符串
>
> 如果是以`post`方法请求的这个视图函数，那么`request.method`返回值就是`大写的POST`字符串
>
> 举例：这样就可以用来做请求方法拆分，可以使用`if`先判断请求方法是什么：
>
> - 如果请求方法是`GET`，可以先返回一个页面
> - 如果请求方法是`POST`，返回单独的`POST`请求处理，在`POST`里就可以获取前端传入的请求数据

```python
from django.shortcuts import render,HttpResponse

# Create your views here.

def home(request):
    if request.method == "POST":
        return HttpResponse("POST data")
    return render(request, "index.html")
```

##### 1.2.2 request.POST

> 用来获取用户提交的`post`请求数据，不包含文件

> 前端页面

```html
# 创建一个form表单
<body>
    <p>这是主页</p>
    <form action="/home/" method="post">
        用户名: <input type="text" name="uname">
        密码: <input type="text" name="pwd">
        爱好:
            <input type="checkbox" name="hobby" value="足球">足球
            <input type="checkbox" name="hobby" value="排球">排球
            <input type="checkbox" name="hobby" value="桌球">桌球
        <input type="submit">
    </form>
</body>
</html>
```

![image-20211228003707768](django%E7%AC%94%E8%AE%B0.assets/image-20211228003707768.png)

> 后端`views.py`代码，从中可以看出：
>
> - `request.POST`是一个查询字典，类型是`<class 'django.http.request.QueryDict'>`
> - `request.POST`的`get方法`只会获取最后一个值，并且类型是`str`
> - `request.POST`的`getlist方法`会获取所有值，并且类型是`list`

```python
def home(request):
    if request.method == "POST":
        # <QueryDict: {'uname': ['ko'], 'pwd': ['123'], 'hobby': ['足球', '排球']}>
        print("request.POST:", request.POST)
        # <class 'django.http.request.QueryDict'>
        print("request.POST type:", type(request.POST))

        # get方法只会获取最后一个值
        uname = request.POST.get("uname")
        # uname = > ko
        print("uname=>", uname)
        # <class 'str'>
        print("uname type:", type(uname))

        # get方法只会获取最后一个值
        hob = request.POST.get("hobby")

        # 桌球
        print("hob=>", hob) # 桌球
        
        # <class 'str'>
        print("hob type=>", type(hob)) # 桌球

        hob_list= request.POST.getlist("hobby")
        # ['排球', '桌球']
        print("hob_list=>", hob_list)

        # <class 'list'>
        print("hob_list type=>", type(hob_list))
        return HttpResponse("POST data")
    return render(request, "index.html")
```

##### 1.2.3 request.GET

> `request.GET`和`request.POST`的所有请求方法都一样，`request.GET`和`request.POST`
>
> `request.GET`常用于获取url后面携带的参数
>
> 同样`request.GET`也支持用`get`/`getlist`获取`url`后面带的值

```python
# 请求的url：http://127.0.0.1:8000/home/?user=ko&age=19
# ?user=ko&age=19 是拼接的参数，在url里可以看到

def home(request):
    # < QueryDict: {'user': ['ko'], 'age': ['19']} >
    print(request.GET)
    
    # <class 'django.http.request.QueryDict'>
    print(type(request.GET))
    
    # 19
    print(request.GET.get("age"))

    # <class 'str'>
    print(type(request.GET.get("age")))
    return render(request, "index.html")
```

### 9、Pycharm操作Django技巧

#### 9.1 快速创建Django应用

![image-20211216001638808](django%E7%AC%94%E8%AE%B0.assets/image-20211216001638808.png)

#### 9.2 修改Django端口

![image-20211216001717991](django%E7%AC%94%E8%AE%B0.assets/image-20211216001717991.png)

![image-20211216001748598](django%E7%AC%94%E8%AE%B0.assets/image-20211216001748598.png)

#### 9.3 浏览器访问页面不走缓存

> 谷歌浏览器打开F12，找到设置，勾选下面的选项即可

![image-20211227235948716](django%E7%AC%94%E8%AE%B0.assets/image-20211227235948716.png)



## 三、ORM数据库

### 1、Pycharm连接数据库

> 使用`docker`可以快速创建`mysql`等数据库，用来快速搭建想要的环境

#### 1.1 mac下连接docker的mysql

> 步骤：
>
> - 创建一个`mysql`容器，拉取`mysql:5.7`镜像
> - 再去创建容器
> - 注意
>   - 创建完的数据库默认用户是root，密码使用`-e MYSQL_ROOT_PASSWORD=123456`设置为123456
>   - 创建完以后需要登录容器内部，给root用户开启远程访问权限，否则在容器外部会出现访问数据库失败的情况

```bash
# 拉取mysql容器，选择5.7版本的tag，不写5.7则会拉取8版本，8版本对我们来说太新了
docker pull mysql:5.7

# 启动容器
docker run -dit --name mysql -p 3306:3306  -e MYSQL_ROOT_PASSWORD=123456 mysql:5.7
#  表示设置数据库用户root的密码为123456

# 登录容器，赋予root远程登录权限
docker exec -it mysql /bin/bash

# 登录mysql容器后，配置远程访问权限
>> grant all privileges on *.* to root@"%" identified by "123456";
>> flush privileges ;

# 上面配置完成退出数据库，就可以在容器外部连接mysql了
mysql -uroot -h127.0.0.1 -p123456
```

> 在上述配置好以后，就可以在`pycharm`中打开`mysql`连接界面，进行连接数据库了，下面用截图表示

![image-20220104075847993](django%E7%AC%94%E8%AE%B0.assets/image-20220104075847993.png)

![image-20220104075948885](django%E7%AC%94%E8%AE%B0.assets/image-20220104075948885.png)

> 需要先下载对应数据库的驱动，上图配置界面会提示下载，点击下载即可
>
> 主机：数据库的地址，因为是本地连接，所以是127.0.0.1
>
> 端口：3306不变
>
> 用户、密码：数据库的用户和密码
>
> 数据库：提前创建好的数据名，需要提前在数据库中创建才可以进行连接
>
> 上面连接信息填写完以后，点击`测试连接`即可快速验证数据库是否连接成功，若未成功，需要检查下配置是否正确

#### 1.2 windows下连接docker的mysql

> `windows`下也可以用`docker`的`mysql`，一般可以在`linux`虚拟机里安装docker，在启动mysql容器
>
> 所以拉取`mysql`镜像,修改`mysql`的`root`权限、在`pycharm`中配置等步骤都和上面的`mac`配置一样
>
> 唯一区别在于：
>
> - windows下的`pycharm`想连接虚拟机里的docker的`mysql`容器，需要使用`pycharm`的`ssh隧道`功能先连接上虚拟机，再去连接虚拟机里的数据库
> - 下图展示了如何配置

![image-20220104080802817](django%E7%AC%94%E8%AE%B0.assets/image-20220104080802817.png)

![image-20220104080909084](django%E7%AC%94%E8%AE%B0.assets/image-20220104080909084.png)

> 虚拟机连接上后，再配置数据库连接

![image-20220104081033712](django%E7%AC%94%E8%AE%B0.assets/image-20220104081033712.png)

> 到这里数据库连接配置完成，可以在`pycharm`进行`django`的数据库连接了

### 2、Django连接Mysql

> `Django`连接数据库时，需要先创建好数据库
>
> `Django`自带了一个小型数据库`sqlite3`，这个数据库比较小，我们可以不用他，换成`mysql`
>
> `Django`如何连接`mysql`
>
> [官方地址: https://docs.djangoproject.com/en/1.11/ref/settings/#databases](https://docs.djangoproject.com/en/1.11/ref/settings/#databases)
>
> 注意一定要在`settings.py`文件中注册`APP`，否则会出现数据库迁移失败的情况

> `Django`连接mysql需要在`settings.py`中指定连接数据的名字、用户名、密码、端口
>
> `Django`连接数据库一定要先创建数据库，再去`settings.py`里去连接

```python
# settings.py文件，大概78行
# Database
# https://docs.djangoproject.com/en/1.11/ref/settings/#databases

# 这是默认的sqlite3连接，可以注释掉，连接mysql
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.sqlite3',
        'NAME': os.path.join(BASE_DIR, 'db.sqlite3'),
    }
}

# 连接mysql
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql',
        'NAME': 'mydatabase',   
        'USER': 'mydatabaseuser',
        'PASSWORD': 'mypassword',
        'HOST': '127.0.0.1',
        'PORT': '5432',
	}
}
```

![image-20211228010019204](django%E7%AC%94%E8%AE%B0.assets/image-20211228010019204.png)

### 3、ORM介绍和使用

> `ORM`：对象关系映射
>
> 主要是用来将mysql语句通过面向对象去执行
>
> 主要是在`Django`的`app`的`models.py`文件中写创建表语句，以面向对象的形式

#### 3.1 编写建表语句

> 需要在`app`的`models.py`文件中写面向对象代码
>
> 下面是创建了一个User表语句代码

```python
from django.db import models

# Create your models here.

class User(models.Model):
    # 等价于：id int primary_key auto_inscrement
    id = models.AutoField(primary_key=True)
    
    # 等价于：name varchar(32)
    name = models.CharField(max_length=32)
    
    # 等价于 age int
    age = models.IntegerField()
```

#### 3.2 数据库迁移命令

> 第一条命令，主要用来生成数据库建表语句记录，下面的命令只是生成记录，还没有真正在数据库中执行创建表

```bash
python manage.py makemigrations
```

> 执行后会在对应`app`的`migrations`文件夹下生成一个类似`0001_initial.py`的文件，主要记录了建表语句

![image-20220105234018673](django%E7%AC%94%E8%AE%B0.assets/image-20220105234018673.png)



> 第二条命令，将操作真正同步到数据库中
>

```python
python manage.py migrate
```



