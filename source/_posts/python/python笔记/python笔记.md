---
title: Python基础编程
date: 2022-05-16 19:31:21
tags: Python
cover: /posts_cover_img/python/python_logo.jpeg
categories: Python基础编程
---

> 高质量代码：不是越少越好，而是让刚入门的小白也能看懂的才是优质代码

## 一、基本数据类型

### 1、变量

```python
name = "sam"
```

> 变量定义的过程：
>
> - 在内存中开辟一片内存空间，将`name`这个变量的值`name`存到开辟的内存空间中，将name绑定到`sam`这个值上，所以`name`就是`sam`这个值的引用标签
> - 变量等号左侧是变量名，变量右侧等号是具体的值才算产生新值，开辟新的内存空间来存值
> - x=10在内存中的理解
>   - 栈区：存放的是变量名和内存地址的对应关系，简单理解为变量名存了内存地址
>   - 堆区：存放的是变量名

#### 1.1 变量的三大特性

> - id
>   - 反映的是变量值的内存地址，是根据变量值计算出来的一串数字，也可以理解为内存地址id
> - type
>   - 变量的类型，比如:整型、浮点型、字符串等等
> - 值
>   - 就是变量值

#### 1.2 is和== 

> - is
>   - 比较的是左右两个值身份id是否相同
> - ==
>   - 比较左右两个值是否相同，是表面上的值，也就是可以看到的值
> - python解释器在启动时会在内存中加载一个`小整数池`，在这个整数池内定义的所有变量的id都一样，小整数池范围是:`-5~256`，这样提高了访问速度，没必要每次赋值都在内存开辟内存空间，这是python自己的优化
> - 在`pycharm`中会出现`-5~256`这个范围外的id也会一样，这是因为`pycharm`自己做的优化，会将更大范围的整数池加载到内存，这也是`pycharm`占用大量内存的原因之一
> - 那到底应该以python解释器的范围为准还是以`pycharm`为准呢？肯定是以python解释器为准，因为最终运行python代码肯定是用python解释器来运行的，`pycharm`只是开发工具，将python代码部署到服务器上肯定也是python解释器来运行的
> - 另外python解释器也有`小字符串池`概念，也就是在小字符串池的字符串id一样

#### 1.3 常量

> - python没有常量的概念
>
> - 约定成俗的是`变量名全大写`就是常量

### 2、`str`字符串

> 字符串的拼接，使用+号，但是这种形式效率比较低，不推荐使用
>

```python
name = "sam"
sex = "male"
info = name + sex
print(info)
```

### 3、`bool`布尔值

> - 只有两个值，常用于条件判断
>   - true：真
>   - false：假

### 4、list列表

```python
user_list = ["sam", "jam", "tom"]
print(f"user_list:{user_list}")
```

### 5、tuple元组

```python
user_tuple = ("sam", "jam", "tom")
print(f"user_tuple:{user_tuple}")
```

### 6、字典

```python
user_dict = {
  "name": "sam",
  "age": 19,
  "hobby": ["feet", "beet"]
}
print(f"user_dict:{user_dict}")
```

### 7、垃圾回收机制

> https://zhuanlan.zhihu.com/p/108683483

> - 概念
>   - 垃圾回收机制(GC)是python自带的内存管理机制，用来回收不可用的变量值所占用的内存空间
>
> - 为什么要有垃圾回收
>   - 程序运行过程中会申请大量的内存空间，而对于一些无用的内存空间如果不及时清理的话会导致内存使用殆尽（内存溢出），导致程序崩溃，因此管理内存是一件重要且繁杂的事情，而python解释器自带的垃圾回收机制把程序员从繁杂的内存管理中解放出来。
>
> - 原理
>   -  Python的GC模块主要运用了“引用计数”（reference counting）来跟踪和回收垃圾。在引用计数的基础上，还可以通过“标记-清除”（mark and sweep）解决容器对象可能产生的循环引用的问题，并且通过“分代回收”（generation collection）以空间换取时间的方式来进一步提高垃圾回收的效率。
> - 三个特性：
>   - 引用计数
>   - 标记清除
>   - 分代回收

#### 7.1 引用计数

> - 直接引用
>   - 指的是从栈区出发直接引用到的内存地址。
>
> -  间接引用
>   - 指的是从栈区出发引用到堆区后，再通过进一步引用才能到达的内存地址。

```python
# 列表本身被变量名l2直接引用，包含的元素被列表间接引用
l2 = [20, 30]  

# 值10被变量名x直接引用
x = 10  

# 列表本身被变量名l1直接引用，包含的元素被列表间接引用
l1 = [x, l2]  
```

#### 7.2 标记清除

> 是为了解决循环引用的缺陷，内存泄露（内存一直被占用无法释放）
>
> - 标记
>   - 通俗地讲就是：
>     栈区相当于“根”，凡是从根出发可以访达（直接或间接引用）的，都称之为“有根之人”，有根之人当活，无根之人当死。
>   - 具体地：标记的过程其实就是，遍历所有的GC Roots对象(栈区中的所有内容或者线程都可以作为GC Roots对象），然后将所有GC Roots的对象可以直接或间接访问到的对象标记为存活的对象，其余的均为非存活对象，应该被清除。
> - 清除
>   - 将遍历堆中所有的对象，将没有标记的对象全部清除掉。

#### 7.3  分代回收

> - 主要是为了提高循环引用清除的效率问题
>
> - 分代
>   - 在历经多次扫描的情况下，都没有被回收的变量，gc机制就会认为，该变量是常用变量，gc对其扫描的频率会降低，具体实现原理如下：
>   - 分代指的是根据存活时间来为变量划分不同等级（也就是不同的代）
>   - 新定义的变量，放到新生代这个等级中，假设每隔1分钟扫描新生代一次，`如果发现变量依然被引用`，那么该对象的权重（权重本质就是个整数）加一，当变量的权重大于某个设定得值（假设为3），会将它移动到更高一级的青春代，青春代的gc扫描的频率低于新生代（扫描时间间隔更长），假设5分钟扫描青春代一次，这样每次gc需要扫描的变量的总个数就变少了，节省了扫描的总时间，接下来，青春代中的对象，也会以同样的方式被移动到老年代中。也就是等级（代）越高，被垃圾回收机制扫描的频率越低
> - 回收
>   - 回收依然是使用引用计数作为回收的依据
>   - 垃圾回收机制是在清理垃圾&释放内存的大背景下，允许分代回收以极小部分垃圾不会被及时释放为代价，以此换取引用计数整体扫描频率的降低，从而提升其性能，这是一种以空间换时间的解决方案目录

### 8、编解码

> https://www.cnblogs.com/jin-xin/articles/10577131.html#_label14

> - unicode转换为bytes称为编码,也就是encode
> - bytes转化为unicode称为解码,也就是decode
> - 数据在内存中是以unicode编码形式存在，但是当数据用于网络传输或者存储到硬盘，必须以非unicode编码存储（utf-8,gbk等格式，这些格式的编码方式是bytes(字节类型)），数据不止字符串、代码等等都是数据
> - 用文件编辑器（word，wps,等）编辑文件的时候，从文件将你的数据（此时你的数据是非Unicode（可能是UTF-8，也可能是gbk，这个编码取决于你的编辑器设置））字符被转换为Unicode字符读到内存里，进行相应的编辑，编辑完成后，保存的时候再把Unicode转换为非Unicode（UTF-8，GBK 等）保存到文件。

#### 8.1 str类型

> - 内部编码：unicode
> - 内容示例
>   - 英文： 'sam'
>   -  中文： '中国'
> - 组成单位: 字符
> - 弊端
>   - Unicode编码的数据不可以存储到磁盘中，也不能进行网络传输

#### 8.2 bytes类型

> - 内部编码：可指定编码（除Unicode之外），比如UTF-8，GBK 等都是bytes字节类型编码
> - 内容示例
>   - 英文：b'alex'
>   - 中文：b'\xe4\xb8\xad\xe5\x9b\xbd'
> - 组成单位：字节
> - bytes（特殊的字符类型，内部编码： 非unicode，比如：utf-8，gbk）：常用来存储到磁盘或者进行网络传输

#### 8.3 编码转换

> - bytes类型也称作字节文本，他的主要用途就是网络的数据传输，与数据存储。那么有人问，bytes类型既然与str差不多，而且操作方法也很相似，就是在字符串前面加个b不就行了，python为什么还要这两个数据类型呢？我只用bytes不行么？
>   - str类型的数据想要存储到文件或者传输出去，那么直接是不可以的，需要将str数据转化成bytes数据就可以了

> - encode：
>   - 编码，将 str 转化成 bytes类型
>   - 即unicode ---编码---> 非unicode（utf-8、gbk等）
>   - 然后进行存储到磁盘或者进行网络传输

```python
# encode称作编码:将 str 转化成 bytes类型
s1 = '中国'
b1 = s1.encode('utf-8')  # 转化成utf-8的bytes类型
print(s1)  # 中国
print(b1)  # b'\xe4\xb8\xad\xe5\x9b\xbd'

s1 = '中国'
b1 = s1.encode('gbk')  # 转化成gbk的bytes类型
print(s1)  # 中国
print(b1)  # b'\xd6\xd0\xb9\xfa'
```

> - decode：
>   - 解码，将bytes转化成str类型
>   - 即非unicode（utf-8、gbk等） ---解码---> unicode

```python
# 这是utf-8编码bytes类型的中国,一个中文占了3个字节
b1 =  b'\xe4\xb8\xad\xe5\x9b\xbd' 

# 这是gbk编码bytes类型的中国，一个中文占了2个字节
b2 =  b'\xd6\xd0\xb9\xfa'   
```

> - 不同编码方式的bytes如何相互转化
>   - 不同编码方式之间不能直接相互转化，比如gbk->utf-8，但是可以间接的进行转化，使用unicode作为中间编码
> - 如何将gbk转化为utf-8编码的bytes呢？
>   - 方法：可以借助unicode编码
>   - 过程：gbk(bytes类型)-->解码-->unicode--编码-->utf-8(bytes类型)
>   - unicode转换为bytes称为编码,也就是encode
>   - bytes转化为unicode称为解码,也就是decode
>   - 需要遵循的一点，原始字节数据的编码格式是什么，编解码的格式就必须是什么格式

```python
# 这是gbk编码bytes类型的"中国"，一个中文占了2个字节
b1 = b'\xd6\xd0\xb9\xfa'
print(b1,type(b1))


# 将b1(bytes)--解码(decode)-->unicode
s = b1.decode("gbk")
print(s,type(s)) # s=中国，type(s)=<class 'str'>

# 将b1(unicode)--编码(encode)-->utf-8(bytes)
b2 = s.encode("utf-8")
print(b2,type(b2)) # b2=b'\xe4\xb8\xad\xe5\x9b\xbd' ,type(b2)=<class 'bytes'>
```

### 9、运算符

#### 9.1 算数运算符

```python
# 增量赋值
age += 1 # age = age + 1

# 交叉赋值
x,y = y,x

# 链式赋值
x,y,z = 10,11,13

# 解压赋值
x,y,*_,z = [1,2,3,4,5,6]
# x = 1
# y = 2
# z = 6
# *_代表3,4,5这三个值
```

#### 9.2 逻辑运算符

> `not`  `and`  `or`
>
> 优先级: not > and > or

#### 9.3 成员运算符和身份运算符

> - 成员运算符
>
>   - in 
>
>     - 判断元素是否存在于列表
>
>     - ```python
>       111 in  [1,2,3,4,111]
>       ```
>
>     - 判断元素是否存在于字典，但是只能判断key，不能判断value
>
>     - ```python
>       "name" in {"name":"sam",age:18}
>       ```
>
>   - not in
>
>     - 判断元素不存在于列表
>
> - 身份运算符
>
>   - is  判断两个值的内存地址是否相同

## 二、流程控制

### 1、if-else判断

```python
age = 19
if age > 20:
  print("age 大于 20")
else:
  print("age 小于 20")
```

### 2、if-elif-else判断

```python
age = 19
if age > 20:
  print("age 大于 20")
elif age == 19:
  print("age 等于 20")
else:
  print("age 小于 20")
```

### 3、for循环

```python
l = [i for i in range(10)]
print(l)
```

![image-20230217133254541](python笔记/image-20230217133254541.png)

### 4、while循环

```python
nums = 3
while nums > 0:
    print(f"num ==> {nums}")
    nums -= 1
```

![image-20230217133430162](python笔记/image-20230217133430162.png)

## 三、函数

### 1、为什么要用函数

1.1、先来看这样一个例子：自己实现Python内置的len方法

> len() 是python内置的方法，用来计算列表、元组、字符串的元素个数

```python
s1 = "ilovepython"
count1 = 0
for i in s1:
    count1 += 1
print(count1) # count1=11

s2 = [1,2,3,4,5]
count2 = 0
for i in s2:
    count2 += 1
print(count2) # count2=5
```

1.2、使用for循环遍历字符串、列表、元组，然后使用一个count变量来递增统计循环的次数，循环结束也就拿到了字符串、列表、元素的元素个数，但只要计算一个字符串长度就要写一个for循环，代码被大量重复使用，我们肯定不希望这样来写代码，所以引入了函数概念

1.3、函数：以功能(完成一件事)为目的，比如登录、注册、len等等，一个函数就是一个功能，随调随用，减少了代码的重复性，增强了代码的可读性

1.4、将上述自己实现len方法写成函数

```python
def len_ly(seqeue):
    count = 0
    for i in seqeue:
        count += 1
    return count

s = "ilovepython"
s3 = [1,2,3,4,5]
print(len_ly(s)) # 11
print(len_ly(s3)) # 5
```

1.5、名字叫len_ly的这个函数就实现随调随用



### 2、函数的结构与调用

2.1、函数的格式

```python
def test():
    '''
    结构：
        def：关键字，定义函数，以冒号结束
        test：函数名，与变量设置相同，具有描述性，
        print("test func")：函数体，必须以4个空格缩进，函数中尽量不要出现print
    '''
    print("test func")
```

2.2、函数什么时候执行？

> 函数名：指向的是函数的内存地址
>
> 当遇到  函数名+() ，函数才会被执行!!!，并且是从上到下依次执行函数里的所有内容



### 3、return函数的返回值

3.1、return的作用

> 1. return 用来将函数的值返回，在函数中遇到return会直接结束函数运行
> 2. return将数据返回给函数的执行者，执行者:函数名+() 表示运行函数
> 3. return单个元素时，以单个元素返回给函数的执行者
> 4. return多个元素时，是以元组形式返回给函数的执行者

3.2、代码示例

```python
def test():
    a = 3
    b = 4
    c = a + b
    return c
res = test()
print(f'res={res}') # 7
```

3.3、return的其他注意点

> 1. 函数里不写return，默认函数返回值就是None
> 2. 函数里写了return，但是后面不跟任何元素，返回的是None，其实return作用就是终止函数



### 4、形参、关键字参数、默认参数

4.1、函数的形参、实参

> 形参：函数定义时接收的参数形式
>
> 实参：函数执行传的参数

4.2、位置参数

> 从左至右，一 一对应来传参

```python
def test(name,age,sex):
    print("name=",name)
    print("age=",age)
    print("sex=",sex)

test("xm",18,"boy")
# name= xm
# age= 18
# sex= man
```

4.3、关键字参数

> 以键值对的方式传参，传参的顺序可以打乱，但是必须参数名必须一 一对应

```python
def test(name,age,sex):
    print("name=",name)
    print("age=",age)
    print("sex=",sex)

test(name="xl",age=28,sex="girl")
# #name= xl
# age= 28
# sex= girl
```

4.4、默认参数

> 给函数定义的形参设置一个值，作为默认值，有默认参数的函数在函数执行时可以不需要对默认参数进行传参，当然给默认参数传了参，会将默认参数的值覆盖掉

```python
def test(name,age,sex="man"):
    print("name=",name)
    print("age=",age)
    print("sex=",sex)

test("xm",18)
# name= xm
# age= 18
# sex= man

test("xl",28,sex="girl")
# #name= xl
# age= 28
# sex= girl

```

4.6、混合传参

```python
def test(name,age,sex):
    print("name=",name)
    print("age=",age)
    print("sex=",sex)

test(name="xm",18,sex="boy")
```

4.7、混合传参的注意点

> 对于混合传参(关键字参数和位置参数一起传参)，关键字参数一定要在位置参数的后面，则会报错

### 5、万能参数:*args和**kwargs

5.1、可以接收所有的实参，就是万能参数，也叫可变参数，比如: *args,**kwargs

5.2、*的魔法使用

> 函数定义时： 代表聚合
>
> 合数调用时：代表打散

5.3、*args：表示可以接收任意个数的位置参数，接收的参数之间以逗号隔开

> 1. args 约定成俗的叫法，换成其他名字也没有问题，只不过用的多了都叫这个名字
> 2. 一个星号(*)表示聚合，将所有的位置参数聚合成一个元组，赋值给了args
> 3. 传入一个列表进去会被当成元组的一个元素

```python
def test(*args):
    print("args=",args)
    print("args type:",type(args))

test(1,2,3)
# args= (1, 2, 3)
# args type: <class 'tuple'>

test([1,2,3]) 
# 传入一个列表进去会被当成元组的一个元素
# args= ([1, 2, 3],)
# args type: <class 'tuple'>
```

5.4、**kwargs：

> 1. kwargs 约定成俗的叫法，换成其他名字也没有问题，只不过用的多了都叫这个名字
> 2. 两个星号(**)表示聚合，将所有的关键字参数聚合成一个字典，赋值给了kwargs

```python
def test(**kwargs):
    print("kwargs=",kwargs)
    print("kwargs type:",type(kwargs))

test(sex="boy",name="liming")
# kwargs= {'sex': 'boy', 'name': 'liming'}
# kwargs type: <class 'dict'>
```

5.5、正向传参：*args和**kwargs混合使用，位置参数和关键字参数一 一传入到test函数就是

```python
def test(*args,**kwargs):
    print("args=",args)
    print("args type:",type(args))
    print("kwargs=",kwargs)
    print("kwargs type:",type(kwargs))

test(1,2,3,sex="boy",name="liming")
# args= (1, 2, 3)
# args type: <class 'tuple'>
# kwargs= {'sex': 'boy', 'name': 'liming'}
# kwargs type: <class 'dict'>
```

5.6、逆向传参：在程序已有列表、元祖、字典等对象的前提下，把他们的元素拆开传给函数，逆向参数收集需要在传入的列表、元组参数之前添加一个星号 ，在字典参数之前添加两个星号，不管是一颗星还是两颗星都表示打散传入的参数所有元素，

```python
def test1(*args):
    print("args=",args)
    print("args type:",type(args))
    print()

a = [4,5,6]
test1(*a)
# args= (4, 5, 6)
# args type: <class 'tuple'>

test1(*[1,2,3])
# args= (1, 2, 3)
# args type: <class 'tuple'>


def test2(**kwargs):
    print("kwargs=",kwargs)
    print("kwargs type:",type(kwargs))
    print()
    
b={"name":"lixiao","age":18}
test2(**b)
# kwargs= {'name': 'lixiao', 'age': 18}
# kwargs type: <class 'dict'>
    
test2(**{"name":"lixiao","age":18})
# kwargs= {'name': 'lixiao', 'age': 18}
# kwargs type: <class 'dict'>
```



### 6、函数的名称空间、作用域

> [名称空间解释](https://www.cnblogs.com/jin-xin/articles/10839389.html)

6.1、全局名称空间：

 		在python解释器开始执行之后, 就会在内存中开辟一个空间, 每当遇到一个变量的时候, 就把变量名和值之间的关系记录下来, 但是当遇到函数定义的时候, 解释器只是把函数名读入内存, 表示这个函数存在了, 至于函数内部的变量和逻辑, 解释器是不关心的. 也就是说一开始的时候函数只是加载进来, 仅此而已, 只有当函数被调用和访问的时候, 解释器才会根据函数内部声明的变量来进行开辟变量的内部空间. 随着函数执行完毕, 这些函数内部变量占用的空间也会随着函数执行完毕而被清空.
 	
 		我们首先回忆一下Python代码运行的时候遇到函数是怎么做的，从Python解释器开始执行之后，就在内存中开辟里一个空间，每当遇到一个变量的时候，就把变量名和值之间对应的关系记录下来，但是当遇到函数定义的时候，解释器只是象征性的将函数名读如内存，表示知道这个函数存在了，至于函数内部的变量和逻辑，解释器根本不关心。
 	
 		等执行到函数调用的时候，Python解释器会再开辟一块内存来储存这个函数里面的内容，这个时候，才关注函数里面有哪些变量，而函数中的变量回储存在新开辟出来的内存中，函数中的变量只能在函数内部使用，并且会随着函数执行完毕，这块内存中的所有内容也会被清空。

​		我们给这个‘存放名字与值的关系’的空间起了一个名字-------命名空间。

​		代码在运行伊始，创建的存储“变量名与值的关系”的空间叫做全局命名空间；

​		在函数的运行中开辟的临时的空间叫做局部命名空间也叫做临时名称空间。

​		现在我们知道了，py文件中，存放变量与值的关系的一个空间叫做全局名称空间，而当执行一个函数时，内存中会临时开辟一个空间，临时存放函数中的变量与值的关系，这个叫做临时名称空间，或者局部名称空间。

 	其实python还有一个空间叫做内置名称空间：内置名称空间存放的就是一些内置函数等拿来即用的特殊的变量：input，print，list等等，所以，我们通过画图捋一下：

![img](python%E7%AC%94%E8%AE%B0/1dbdb473-e660-4707-abc5-b3f4d0f80340-2885684.jpg)

那么这就是python中经常提到的三个空间。

6.2、总结:

> 1. 全局命名空间--> 我们直接在py文件中, 函数外声明的变量都属于全局命名空间
>
> 2. 局部命名空间--> 在函数中声明的变量会放在局部命名空间
>
> 3. 内置命名空间--> 存放python解释器为我们提供的名字, list, tuple, str, int这些都是内置命名空间

6.3、加载顺序：

 		所谓的加载顺序，就是这三个空间加载到内存的先后顺序，也就是这个三个空间在内存中创建的先后顺序，你想想他们能是同时创建么？肯定不是的，那么谁先谁后呢？我们捋顺一下：在启动python解释器之后，即使没有创建任何的变量或者函数，还是会有一些函数直接可以用的比如abs(-1),max(1,3)等等，在启动Python解释器的时候，就已经导入到内存当中供我们使用，所以肯定是先加载内置名称空间，然后就开始从文件的最上面向下一行一行执行，此时如果遇到了初始化变量，就会创建全局名称空间，将这些对应关系存放进去，然后遇到了函数执行时，在内存中临时开辟一个空间，加载函数中的一些变量等等。所以这三个空间的加载顺序为：内置命名空间(程序运行伊始加载)->全局命名空间(程序运行中：从上到下加载)->局部命名空间(程序运行中：调用时才加载。

6.4、取值顺序：

 		取值顺序就是引用一个变量，先从哪一个空间开始引用。这个有一个关键点：从哪个空间开始引用这个变量。我们分别举例说明：

```python
# 如果你在全局名称空间引用一个变量，先从全局名称空间引用，全局名# 称空间如果没有，才会向内置名称空间引用。
input = 666
print(input) # 666
# 如果你在局部名称空间引用一个变量，先从局部名称空间引用，
# 局部名称空间如果没有，才会向全局名称空间引用，全局名称空间在没有，就会向内置名称空间引用。
input = 666
print(input) # 666
input = 666
def func():
    input = 111
    print(input) # 111
func()
```

6.5、所以空间的取值顺序与加载顺序是相反的，取值顺序满足的就近原则，从小范围到大范围一层一层的逐步引用。

![img](python%E7%AC%94%E8%AE%B0/bef1149c-e624-4e26-883d-c335b426f6ed-2885684.jpg)

6.6、三个空间

6.7、作用域

- 作用域代码

```python
count = 12

def test():
    count = 13
    print(count)
test() # 13 
print(count)  #12 
```

> test函数内部的count属于局部作用域变量，虽然和test函数外部的全局作用域变量重名，但是因为所处的作用域不同，互相不影响，因为这两个是在不同的内存地址空间里

```python
# 经典作用域错误
count = 1

def test():
    count += 1
    print(count)
test()
```

- 上述代码运行会报错

- 解释如下

  > 局部作用域（比如函数内部）不能改变全局作用域的变量，但是可以引用，也就是在局部作用域里仅仅可以把全局作用域拿过来使用一下，但是不能改变全局作用域的变量
  >
  > 结论：当python解释器读取到局部作用域时，发现了你对一个变量进行修改的操作，解释器就会认为你再局部作用域已经定义过这个局部变量了，解释器就会从局部去找局部变量，但是没有找到（因为修改的是全局作用域变量），所以报错了

- 先看一个简单例子

- 从上面可以看出，b是a的基础上+1，那么b和a的内存地址不一样，就表示a和b是两个变量，映射到函数中也是一样，如下

  ```python
  # 外层的num是全局变量
  num = 10
  print(f"外层num:{id(num)}")
  
  
  def test():
      # 内层的num是在原来的基础上做了+1操作，那么就是一个新的值，指向新的内存地址，需要使用global声明num为全局变量，
      # 如果不声明，那就会在执行test函数时，找不到num这个局部变量，直接抛出异常
      global num
      num += 1
      print(f"内层num:{id(num)}")
  
  test()
  print()
  
  
  #　外层alist和内层alist指向的是同一个内存地址空间，所以不需要使用global
  alist = [1,2,3]
  print(f"外层alist:{id(alist)}")
  
  def test1():
      alist.append(4)
      print(f"内层alist:{id(alist)}")
  
      # 但是内层alist是在alist基础上增加了一些值，那么alist就会指向新的内存地址，是一个新的列表
      alist_1 = alist + ["a","b"]
      print(f"内层alist_1:{id(alist_1)}")
  
  test1()
  ```

- 总结：
  - 在函数中，对于全局变量进行修改时，是否需要global进行说明，是要看是否对全局变量的执行指向进行了修改，也就是修改全局变量后是否指向了的内存地址（新值）
  - 如果没有产生新值，那么就可以不用global声明，比如可变数据类型
  - 如果修改了执行，即全局变量指向了一个新地址，那么必须用global来声明

### 7、高阶函数

7.1、函数嵌套也就是高阶函数

### 8、globals() 和 locals()

8.1、globals() 和 locals()的使用，这两个属于内置函数

> globals() :返回的是字典: 字典里面的键值对是全局作用域的所有内容
>
> locals():返回的是字典: 字典里面的键值对是当前作用域的所有内容

```python
def test():
    name = "tom"
    age=73
    print(globals())  # 返回的是字典: 字典里面的键值对是全局作用域的所有内容
    print(locals())  # 返回的是字典: 字典里面的键值对是当前作用域的所有内容，也就是test函数这个作用域

print(globals()) # 返回的是字典: 字典里面的键值对是全局作用域的所有内容
print(locals())  # 返回的是字典: 字典里面的键值对是当前作用域的所有内容，也就是全局作用域
test()
```

### 9、global关键字作用

9.1、在局部作用域声明一个全局变量

```python
def func():
    global name  # 将局部作用域的name变量声明为全局作用域变量
    name = "tom"

print(name) # 因为还没运行func函数，所以name变量还没有从局部作用域变为全局作用域变量，所以会报name is not defined错误
print(globals()) # 全局作用域内容中没有 name 字段
func()  # 遇到函数名+括号才算运行函数，此时函数里的global name才会生效变为全局作用域变量
print(name) # 此时访问name已经变成了全局作用域变量了
print(globals()) # 全局作用域内容中有了 name 字段
```

9.2、修改一个全局变量

```python
count = 1

def func():
    global count
    count += 1

print(count) # func函数还没运行，所以count还是1
func()  # func函数运行，count由局部作用域变量声明为了全局作用域变量，并且做了count = count + 1 计算，所以全局作用域变量count=2
print(count) # 此时count已经变为2
```

### 10、nonlocal关键字(使用较少)

10.1、不能操作全局变量，运行会报错

```python
count = 1

def func():
    nonlocal count
    count += 1

func() 
```

10.2、局部作用域：内部函数对外层函数的局部变量进行修改

```python
def func():
    count = 1
    def inner():
        nonlocal count
        count += 1
    print(count) # func函数局部作用域里的count变量仍是1没变
    inner() # inner函数开始执行，并且inner函数使用nonlocal关键字，即inner函数对外层函数的局部变量count进行修改进行了+1
    print(count) # 此时inner函数外层函数的count变量已经变成了2

func() # 结果1和2
```

### 11、默认参数、作用域的陷阱

11.1、默认参数的陷阱

```python
# 如果默认参数指向的是可变数据类型，比如列表，那么无论调用多少次这个默认参数，都是同一个
def func(a,alist=[]):
    alist.append(a)
    return alist

print(func(10)) # [10]，只传了一个10进去，那么10就会传入默认参数这个空列表中
print(func(20,[])) #[20],因为这个传参后面新传了一个空列表进去，那么20就会存到新的空列表中
print(func(30))  #[10,30] 第三次调用，还是走默认参数的列表，但是因为第一次调用的时候已经将10传进去了，那么就会再把30传进去 

# 上面这三个函数是执行一个打印出一个结果
```

```python
# 如果默认参数指向的是可变数据类型，比如列表，那么无论调用多少次这个默认参数，都是同一个

def func(a,alist=[]):
    alist.append(a)
    return alist

ret1 = func(10) 
ret2 = func(20,[])
ret3 = func(30)
# 这里是上面三个函数都执行完了再打印，那么ret1的值在ret3执行完以后也变得和ret3一样了，因为ret1和ret3共用同一个列表
print(ret1) # [10,30]
print(ret2) #[20],
print(ret3)  #[10,30] 
```

11.2、作用域的陷阱，同6里面的作用域

```python
count = 1

def func():
    print(count)
    count = 3
func()
```

- 执行结果

>  `local variable 'count' referenced before assignment`
>
> 这句话的意思: 局部变量在赋值前被引用
>
> `referenced `：引用
>
> `assignment`： 赋值

- 所以在函数中，如果定义了一个变量，但在定义这个变量之前就对其进行了引用，那么解释器在引用时去找这个变量没有找到就会报错，属于语法问题


### 12、函数名应用

12.1、函数名可以多次赋值引用

> 函数名：就是一个变量，指向的是函数的内存地址
>
> 当遇到  函数名+() ，函数才会被执行!!!，并且是从上到下依次执行函数里的所有内容

```python
def func():
    print("in func")

print(func) #  func就是个变量，那么func这个变量的值指向的是函数的内存地址
print(type(func)) # 函数类型
func() # 所以这里也可以理解为是函数的内存+()来运行函数，函数名就是个变量，可以取任意名字

print("*"*10,"函数名重命名","*"*10)
f = func
f1 = f
f2 = f1
f2()
```

```python
def func():
    print("in func")

def func1():
    print("in func1")

func1 = func # 这里将func函数名重新指向了func1

func1()  # 这里执行func1执行的就是func函数
```

12.2、函数名可以作为容器数据类型的元素

```python
def func():
    print("in func")

def func1():
    print("in func1")

def func2():
    print("in func2")

ll = [func,func1,func2]

for i in ll:
    i()
# 执行结果
in func
in func1
in func2
```

12.3、函数名可以作为函数的参数

```python
def func():
    print("in func")

def func1(x):  # x = func
    x()   # 这里执行的就是func()，
    print("in func1") 

func1(func)  # 将func函数名作为参数传给func1函数，先输出 in func，再输出 in func1
```

12.4、函数名作为函数的返回值

```python
def func():
    print("in func")

def func1(x):  # x = func
    print("in func1")
    return x

ret = func1(func) # ret的值就是func1函数传进去的func这个形参
ret() # ret()执行的就是func()

```

### 13、函数闭包

13.1 什么是闭包

> https://www.cnblogs.com/jin-xin/articles/10863032.html

> - 闭包定义
>   - 闭包函数只能存在嵌套函数
>   - 内层函数对外层函数的非全局变量的引用(使用)，就会形成闭包
>   - 被引用的非全局变量也叫自由变量，这个自由变量会和内层函数产生一个绑定关系
>   - 自由变量持续在内存中存在，不会消失，可以持续调用
> - 闭包的作用
>   - 保存局部信息不被销毁，保证数据的安全性。
> - 闭包的应用
>   - 可以保存一些非全局变量但是不易被销毁、改变的数据。
>   - 装饰器
> - 如何判断一个嵌套函数是不是闭包
>   - 闭包是嵌套在函数中的函数
>   - 闭包必须是内层函数对外层函数的变量（非全局变量）的引用。

> 1. 上面被红色方框框起来的区域就是闭包，被蓝色圈起来的那个变量应该是make_averager()函数的局部变量，它应该是随着make_averager()函数的执行结束之后而消失。
> 2. 但是他没有，是因为此区域形成了闭包，series变量就变成了一个叫自由变量的东西，averager函数的作用域会延伸到包含自由变量series的绑定。
> 3. 也就是说，每次我调用avg对应的averager函数 时，都可以引用到这个自由变量series，这个就是闭包。

```python
# 例一：是闭包
def wrapper1():
    a = 1
    def inner():
        print(a)
    return inner
ret1 = wrapper1()

# 例二：不是闭包，因为a1是全局变量
a1 = 2
def wrapper2():
    def inner():
        print(a1)
    return inner
ret2 = wrapper2()

# 例三：是闭包
# 因为a，b是作为参数传进wrapper3函数中，那么a,b就是wrapper3函数里的局部变量
def wrapper3(a,b):
    def inner():
        print(a)
        print(b)
    return inner
a2 = 2
b = 3
ret3 = wrapper3(a2,b)
```

13.2 如何判断一个函数是不是闭包

> 使用`func.__code__.co_freevars`来判断，有返回值就是闭包，没有就不是

```python
# 例二：不是闭包，因为a1是全局变量
a1 = 2
def wrapper2():
    def inner():
        print(a1)
    return inner
ret2 = wrapper2()
print(ret2.__code__.co_freevars) # ()

```

### 14、格式化输出

14.1 %s、format格式化输出

```python
name = "Tom"
age = 18
msg1 = 'My name is %s, %s years old' %(name,age)
msg2 = 'My name is {0}, {1} years old'.format(name,age)

print(msg1)
print(msg2)

# 输出
My name is Tom, 18 years old
My name is Tom, 18 years old
```

14.2 f-string 格式化输出

> Python3.6以后支持的语法，效率更高
>
> 注意  ！， ：{  } ; 这些不能出现f-string的{}中
>
> 优点:
>
> 1、结构更简化
>
> 2、结合表达式、函数进行使用
>
> 3、比%s、format效率更高

2.1、基本用法，格式化输出

> 在需要格式化的前面加一个f/F，大小写都支持

```python
name = "tom"
age = 10
msg = f'my name is {name} , I\'m {age} years old'
print(msg)
```

2.2、支持多种格式

```python
# 支持表达式
dict = {'name':'Tom','age':18}
msg = f'My name is {dict["name"]}, {dict["age"]} years old'
print(msg)

# 支持计算
count = 7
print(f'count平方是: {count**2}')

# 支持字符串操作
name = "sam"
print(f'Name is: {name.upper()}')

# 结合函数写
def add(a,b):
    return a + b
print(f'3 + 4 = {add(3,4)}')
```

### 15、函数的类型提示

> 类型提示 Type hinting（最低Python版本3.5）

```python
# 形参后面加 冒号和类型,代表提示形参的提示信息
# ->int 表示函数返回值，
# 上面两种提示信息传任何内容都可以

def register(name:str,age:int,hobbies:tuple)->int:
    print(name)
    print(age)
    print(hobbies)

# 查看提示信息的所有内容
print(register.__annotations__) #{'name': <class 'str'>, 'age': <class 'int'>, 'hobbies': <class 'tuple'>, 'return': <class 'int'>}
```

## 四、Python内置语法使用

> https://www.cnblogs.com/jin-xin/articles/10854130.html

### 1、三元运算符

> 1.简单的if...else语句
>
> 2.下图中的if条件为真输出die，if条件为假执行else，输出live

### 2、迭代器

1.1 可迭代对象

> 字面意思：Python中一切皆对象，一个实实在在存在的值，对象
>
> 可迭代：更新迭代，重复循环的过程，每次更新迭代都有新内容，可以进行循环更新的一个值
>
> 专业角度：内部含有一个`__iter__`方法的对象，可迭代对象
>
> 目前已有的可迭代对象：str/list/dict/set/range
>
> 优点：
>
> ​	1.存储的数据能直接展示，比较直观
>
> ​	2.拥有的方法比较多，操作方便
>
> 缺点：
>
> ​	1.占用内存
>
> ​	2.不能直接通过for循环，不能通过索引、key取值



1.2 判断是否为可迭代对象

> 获取对象的所有方法，以字符串形式表现，使用dir(obj)，返回值为一个列表
>
> 所有只要判断对象的所有方法里有`__iter__`方法，那就是可迭代对象

```python
s1 = "python"

print("__iter__" in dir(s1)) # true，那s1就是一个可迭代对象
```



1.3 迭代器

> 字面意思：更新迭代，器：工具，可迭代更新的工具
>
> 专业角度：内部含有`__iter__`方法并含有`__next__`方法的对象就是迭代器
>
> 

1.3.1 可以判断是否为迭代器：含有`__iter__`和`__next__`在不在dir(obj)

```python
file = "article.log"

with open(file,encoding="utf-8") as f:
    print(("__iter__" in dir(f)) and "__next__" in dir(f))
    
# output
true
```

1.3.2 可迭代对象可以转换为迭代器

```python
s = "echo"

# 可迭代器对象转换为迭代器，原来的对象仍没有变化
# 两种方法：
#   1、iter(s)
#   2、s.__iter__()
obj = iter(s)

# 迭代器返回值:<str_iterator object at 0x00000000021283C8>，表示字符串迭代器对象
print(obj)

# 获取迭代器的值，当取值超过迭代器所有值以后，就抛出StopIteration报错
# obj这个迭代器只有"e c h o"四个元素，第五个next(obj)就会抛出StopIteration
print(next(obj)) # 一个next即使运行N次，永远只会输出一个值，
print(next(obj))
print(next(obj))
print(next(obj))
print(next(obj))
```

1.3.3 迭代器优点

> 1、节省内存：迭代器在内存中相当于只占一个数据的空间：因为每次取值都上一条数据会在内存释放（消失），加载当前的此条数据。
>
> 2、惰性机制：next一次，取一个值，绝不过多取值。​
>
> 3、有一个迭代器模式可以很好的解释上面这两条：迭代是数据处理的基石。扫描内存中放不下的数据集时，我们要找到一种惰性获取数据项的方式，即按需一次获取一个数据项。这就是迭代器模式。
>
> ​    

1.3.4 迭代器的缺点：

> 1、不能直观的查看里面的数据。
>
> 2、速度慢
>
> 3、取值时不走回头路，只能一直向下取值。

1.4 迭代器与可迭代对象的对比

> 可迭代对象
>
> ​	是一个操作昂发比较多，比较直观、存储数据相对少（几百万个对象，8G内存可以承受）的一个数据集合
>
> ​	当侧重于数据可以灵活处理，并且内存空间足够，可以将数据集设置为可迭代对象
>
> ​	是一个非常节省内存，可记录取值位置，可以直接通过循环+next方法取值，但是不直观，操作方法比较单一的数据集合
>
> 迭代器：
>
> ​	当数据量非常大，足以撑爆内存或者为了节省内存时，将数据集设置为迭代器最好了

1.5 for循环原理

> for循环原理：先将可迭代对象转换为迭代器，再调用迭代器的next方法进行取值

1.5.1 使用while模拟for循环

```python
ll = [2,3,45,11,221,34]
obj = ll.__iter__()

while 1:
    try:
        print(next(obj))
    except StopIteration:
        break
```

### 3、生成器

3.1 生成器

> 1. 生成器本质就是迭代器
> 2. 唯一区别：
>    - 生成器是我们自己用python代码构建的数据结构
>    - 迭代器是提供的，或者转化而来的

3.2 获取生成器的三种方式

> 1. 生成器幻术
> 2. 生成器表达式
> 3. python内部提供的一些

3.3 生成器函数获取生成器

```python
# 生成器函数
def func():
    print(111)
    print(222)
    yield 3 # 当运行生成器函数，只有一个next函数来取值时，只会执行到这里，下面的代码不会执行
    a = 3
    b = 4
    c = a + b
    print(c)
    yield 7 # 当有两个next函数来取值时，会执行到这里

ret = func()

# ret是一个生成器对象：<generator object func at 0x000000000BB648E0>
print(ret)

# 生成器通过next来取值，一个next对应一个yield
# 当next取值超过yield的范围，也会报Stopiteration错误，和迭代器一样
print(next(ret))

# yield from seq 
# 表示将这个可迭代对象中每一个元素变成了迭代器结果返回
def test():
    alist = [1,2,3,4,5]

    # 将alist这个列表变成了迭代器
    yield from alist

ret = test()
print(next(ret))
print(next(ret))
print(next(ret))
print(next(ret))
```

> - return：
>  - 函数中只存在一个return结束函数，并给函数的执行者返回值
> 
>- yield：
>   - 只要函数中有yield，那就是生成器函数，而不是函数
>
> - 生成器函数中可以存在多个yield，一个yield对应一个next，yield不会结束函数

### 4、推导式

4.1 列表推导式：多层嵌套循环

```python
# 取出所有人名有一个l的并大写

l1 = [["sam","tom","july"],["john","lily","wisely"]]

# 老办法
l2 = []

for ele in l1:
    for name in ele:
        if name.count("l") == 1:
            l2.append(name)
print(f"l2={l2}")

# 一行代码,循环嵌套
l3 = [name for ele in l1 for name in ele if name.count("l") == 1]
print(f"l3={l3}")
```

4.2 生成器推导式

> - 与列表推导式的写法完全一致，也有筛选模式，循环模式，多层循环
> - 唯一区别就是 [] 换成 ()

```python
obj = ( i for i in range(11))
print(obj,type(obj)) # <generator object <genexpr> at 0x0000000002856E60> <class 'generator'>

print(next(obj)) # 0
print(next(obj)) # 1
print(next(obj)) # 2
```

4.3 总结

> - 列表推导式：
>
>   - 缺点：
>
>     - 构建比较复杂且有规律的列表，不能太沉迷使用该办法
>     - 超过三层才能构建成功的，不要使用推导式
>     - 查找错误不方便，debug代码时
>- 优点
>   
>  - 一行代码构建，简单
> - 列表推导式和生成器的区别
>
>   - 写法：列表推导式[]，生成器语法 ()
>   - 列表是iterable，可迭代对象 
>   - 生成器的本质是迭代器(iterator)

```python
# 一行代码构建[2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'O']
ll = [i for i in range(2,11)] + list("JQKO")
print(ll)
```

### 5、装饰器

> 装饰器等于高阶函数+闭包
>

### 6、模块导入import

6.1 模块

https://zhuanlan.zhihu.com/p/109127048

> 在Python中，一个py文件就是一个模块，文件名为xxx.py模块名则是xxx,

6.2 导入模块发生了什么

> 首次导入模块会发生3件事
>
> - 执行导入的文件（xx.py）
>
> - 产生xx.py的名称空间，将xx.py运行过程中产生的名字都堆到foo的名称空间
>
> - 在当前文件中产生的又一个名字xx，该名字指向2中产生的名称空间
>
> 需要强调一点是，第一次导入模块已经将其加载到内存空间了，之后的重复导入会直接引用内存中已存在的模块，不会重复执行文件，通过import sys，打印sys.modules的值可以看到内存中已经加载的模块名。

6.3 导入模块后引用

> 强调1：
>
> - 方式：模块名.名字
> - 是指名道姓问某个模块要名字对应的值，不会与当前名称空间中的名字发生冲突，即使是重名的
>
> 强调2：
>
> - 无论是查看或修改，都是以调入的模块为基准，与调用位置无关，也就是说在一个文件里调用另外一个模块，无论对文件中定义或修改与调用模块同名的变量，不会对调用模块产生影响

6.4 起别名

```python
import  time as t
```

6.5 模块命名风格

> python3自定义模块的命名都是以纯消息+下划线风格

```python
import socketserver
```

6.6  模块导入和代码测试

> 1、一个Python文件有两种用途，
>
> - 一种被当主程序/脚本执行，
>
> - 另一种被当模块导入，
>
> 2、为了区别同一个文件的不同用途，每个py文件都内置了`__name__`变量
>
> - 该变量在py文件被当做脚本执行时赋值为`“__main__”`
> - 在py文件被当做模块导入时赋值为模块名

```python
def test():
    print("hahaha")

if __name__ == '__main__':
    test()
```

6.7 from...import... 导入模块

> from...import...与import语句基本一致，唯一不同的是：使用import foo导入模块后，引用模块中的名字都需要加上foo.作为前缀，而使用from foo import x,get,change, foo则可以在当前执行文件中直接引用模块foo中的名字，如下
>
> from xx import yy : yy必须是xx模块（xx.py文件）里的方法、变量、类等内容，import yy的yy是指向xx模块里叫yy这个方法的内存地址

```python
from foo import x,get,change #将模块foo中的x和get导入到当前名称空间
a=x #直接使用模块foo中的x赋值给a
get() #直接执行foo中的get函数
change() #即便是当前有重名的x，修改的仍然是源文件中的x
```

> 无需加前缀的好处是使得我们的代码更加简洁，坏处则是容易与当前名称空间中的名字冲突，如果当前名称空间存在相同的名字，则后定义的名字会覆盖之前定义的名字。

> 另外from语句支持`from foo import *`语法，*代表将foo中所有的名字都导入到当前位置

```python
from foo import * #把foo中所有的名字都导入到当前执行文件的名称空间中，在当前位置直接可以使用这些名字

a=x
get()
change()
obj=Foo()
```

> 如果我们需要引用模块中的名字过多的话，可以采用上述的导入形式来达到节省代码量的效果，但是需要强调的一点是：只能在模块最顶层使用*的方式导入，在函数内则非法，并且*的方式会带来一种副作用，即我们无法搞清楚究竟从源文件中导入了哪些名字到当前位置，这极有可能与当前位置的名字产生冲突。模块的编写者可以在自己的文件中定义`__all__`变量用来控制*代表的意思

```python
#foo.py
__all__=['x','get'] #该列表中所有的元素必须是字符串类型，每个元素对应foo.py中的一个名字
x=1
def get():
    print(x)
def change():
    global x
    x=0
class Foo:
    def func(self):
       print('from the func')
```

> 这样我们在另外一个文件中使用*导入时，就只能导入`__all__`定义的名字了

```python
from foo import * #此时的*只代表x和get

x #可用
get() #可用
change() #不可用
Foo() #不可用
```

6.8 模块跨目录导入

> 模块查找优先级
>
> 1. 先从内存中找，内容中会预先加载Python的内置模块
> 2. 如果内存中没有，就按照sys.path中存放的文件顺序依次查找所需要的导入的模块

```python
import sys
# 值为一个列表，存放了一系列的文件夹
# 其中第一个文件夹是当前执行文件所在的文件夹
# 在pycharm中会看到项目的目录也会加到这个列表中，这是pycharm做的优化，真正Python解释器运行时不会有这个目录
print(sys.path)
```

> 查看加载到内存中的模块

```python
print(sys.modules)
```

> sys.path中的第一个路径通常为空，代表执行文件所在的路径，所以在被导入模块与执行文件在同一目录下时肯定是可以正常导入的，而针对被导入的模块与执行文件在不同路径下的情况，为了确保模块对应的源文件仍可以被找到，需要将源文件foo.py所在的路径添加到sys.path中，假设foo.py所在的路径为/pythoner/projects/

```python
import sys
# 找foo.py就把foo.py的文件夹添加到环境变量中
sys.path.append(r'/pythoner/projects/') #也可以使用sys.path.insert(……)，不过不推荐使用insert

import foo #无论foo.py在何处,我们都可以导入它了
```

6.9 编写规范模块

> 在编写py文件时，需要时刻提醒自己，该文件既是给自己用的，也有可能会被其他人使用，因而代码的可读性与易维护性显得十分重要，为此我们在编写一个模块时最好按照统一的规范去编写，如下

```python
#!/usr/bin/env python #通常只在类unix环境有效,作用是可以使用脚本名来执行，而无需直接调用解释器。

"The module is used to..." #模块的文档描述

import sys #导入模块

x=1 #定义全局变量,如果非必须,则最好使用局部变量,这样可以提高代码的易维护性,并且可以节省内存提高性能

class Foo: #定义类,并写好类的注释
    'Class Foo is used to...'
    pass

def test(): #定义函数,并写好函数的注释
    'Function test is used to…'
    pass

if __name__ == '__main__': #主程序
    test() #在被当做脚本执行时,执行此处的代码
```

### 7、模块和包

#### 7.1 模块

> 模块就是一系列功能的集合体
>
> - 模块的作用：可以直接使用别人封装好的模块，提高开发效率
>
> - 模块的三大类
>
>     - 内置模块
>
>     - 第三方模块
>
>     - 自定义的模块
>         - 一个python文件本身就是一个模块，文件名叫x.py，模块名叫m

##### 7.1.1 模块导入

```python
# 语法
import 模块名
```

> 需要注意：
>
> - import第一次导入时，会执行导入的文件中所有的代码
>
> - 之后再重复导入，会直接引用第一次导入的名称空间，不会再次导入

> 从下图代码结果可以看出，import一个模块，其实就是在执行模块里的代码

![image-20221106003856637](python笔记/image-20221106003856637.png)

> 模块强调：
>
> 模块名.名字：表示指名道姓的访问某一个模块的对应变量的值
>
> 无论查看还是修改的都是模块本身，和调用位置无关

##### 7.1.2 导入模块规范

> 先导入内置模块
>
> 其次导入第三方模块
>
> 最后导入自定义的模块

> 模块的起名python3中是纯小写+下划线的风格

##### 7.1.3 模块导入起别名

> 可以给导入的模块起个别名，使用`as`关键字来起别名

```python
import xxx as xl
```



## 五、常用模块

### 1、OS模块

> 和操作系统相关的操作封装在这个模块

1.1. 和文件操作相关

> 可以操作文件的重命名，删除等

```python
import os

 # 这个文件不存在，临时写的一个不存在的文件名
file = "aaa" 

# 当文件不存在，执行会报错，FileNotFoundError: [WinError 2] 系统找不到指定的文件。: 'aaa'
os.remove(file)

# 当文件不存在，执行会报错，FileNotFoundError: [WinError 2] 系统找不到指定的文件。: 'aaa' -> 'bb.txt'
os.rename(file,"bb.txt")


import shutil
# 删除目录，目录可以是非空的
shutil.rmtree(file)
```

1.2. 和路径相关的操作

> 和路径相关的操作，封装在一个子模块里：`os.path `

1.2.1 `os.path.dirname`：获取当前文件所在的目录

> 不判断路径是否存在，即使路径不存在，返回值为空

```python
import os

file = "aaa"

s = os.path.dirname(file)
print("s=",s)
print("s len:",len(s))
```

1.2.2 `os.path.basename`：获取当前路径的文件名

> 不判断路径是否存在，即使路径不存在，也会返回文件名

1.2.3  `os.path.split`

> 把路径中的路径名和文件名切分开，结果是元祖

```python
import os

file = "./test/asfsd"

s = os.path.split(file)
print("s=",s) # s= ('./test', 'asfsd')
print("s len:",len(s)) # 2
```

1.2.4 `os.path.join`：拼接路径

```python
import os
file = ".\\test\\asfsd"

s = os.path.join(file,"index.txt")
print("s=",s)
print("s len:",len(s))

# output
s= .\test\asfsd\index.txt
s len: 22
```

1.2.5 `os.path.abspath`

> 1.如果是/开头，默认是在当前盘符下
>
> 2.如果不以/开头，默认是当前所在路径

```python
import os

s1 = os.path.abspath(r"/a/b/c")
print("s1=",s1)
# s1= D:\a\b\c

s2 = os.path.abspath(r"a/b/c")
print("s2=",s2) 
# 因为当前py文件所在目录就是D:\Flask\AutoCrossFire
# s2= D:\Flask\AutoCrossFire\a\b\c
```

1.2.6 `os.path.exists`

> 判断文件是否存在，如果不存在，则返回值为False，否则为True

```python
import os

file = "index.html"

if os.path.exists(file):
    print(f"{file} exists")
else:
    print(f"{file} not exists")

# output
index.html not exists
```



### 2、SYS模块

> 和Python解释器相关的操作

2.1 ` sys.argv`

> 获取命令行方式运行的脚本后面的参数
>
> sys.argv 返回值是一个列表

```python
import sys

print(sys.argv) # ['home.py', '123', '456']
print(type(sys.argv)) # <class 'list'>

# 脚本名
print(sys.argv[0]) # home.py

# 第一个参数
print(sys.argv[1])  # 123

# 第二个参数
print(sys.argv[2]) # 456

```

2.2 `sys.path`

> 系统寻找模块的路径，可通过PYTHONPATH来初始化

2.3 `sys.module`

> 系统加载的模块

### 3、logging模块

> https://www.cnblogs.com/Eva-j/articles/7228075.html#_label14

> ```python
> # 日志作用:
> #   1.用来记录用户行为 - 数据分析
> #   2.用来记录用户行为 - 操作审计
> #   3.排查代码错误
> ```

3.1 logging简单配置

> 1. 默认情况下Python的logging模块将日志打印到了标准输出中，且只显示了大于等于WARNING级别的日志，默认的日志级别设置为WARNING
> 2. 日志级别等级CRITICAL > ERROR > WARNING > INFO > DEBUG
> 3. 默认的日志格式为日志级别：Logger名称：用户输出消息，比如：`WARNING:root:warning msg`

```python
import logging

logging.debug("debug msg") # 调试
logging.info("info msg")  # 信息
logging.warning("warning msg") # 警告
logging.error("error msg") # 错误
logging.critical("critical msg") # 批判性的
```

3.2 logging自定义配置等级、格式

```python
import logging

logging.basicConfig(
    # 标准业务log格式: WARNING: 2020-05-22 17:56:37 [D:/Flask/MyOffice/tests_code/loggerstudy/logstudy01.py:31] a=33
    format= '%(levelname)s: %(asctime)s [%(pathname)s:%(lineno)d] %(message)s',
    datefmt= '%Y-%m-%d %H:%M:%S',
)

def test():
    a = 33
    logging.warning(f"a={a}")
    return a
test()
```

3.3 输出日志到文件和屏幕

```python
import logging

# 文件操作符，写入日志到文件，
# 这里需要注意写了几个fileHandler，就会输出到几个文件中
fh1 = logging.FileHandler("tmp1.log", encoding="utf-8")
fh2 = logging.FileHandler("tmp2.log", encoding="utf-8")

# 流处理输出到屏幕
sh = logging.StreamHandler()

logging.basicConfig(
    # 标准业务log格式: WARNING: 2020-05-22 17:56:37 [D:/Flask/MyOffice/tests_code/loggerstudy/logstudy01.py:31] a=33
    format='%(levelname)s: %(asctime)s [%(pathname)s:%(lineno)d] %(message)s',
    datefmt='%Y-%m-%d %H:%M:%S',

    # 设置logging等级
    level=logging.DEBUG,

    # 填写上面的handler
    handlers=[fh1,fh2,sh],
)

def test():
    a = 89
    logging.debug(str(a))
    return a
test()

```

3.4 日志切分

```python
import logging,time
from logging import handlers

sh = logging.StreamHandler()

# 按照文件大小进行切割，最多保留5个文件，超过5个会删掉第一个，重新生成一个新的，可以通过日期生成时间观察第一个是否被删掉
# 总是保持生成五个日志文件
rh = handlers.RotatingFileHandler('myapp.log', maxBytes=1024,backupCount=5)

# 按时间切割，when="s",表示按秒切，interval=5表示5s切一个，持续切割
fh = handlers.TimedRotatingFileHandler(filename='x2.log', when='s', interval=5, encoding='utf-8')

logging.basicConfig(
    # 标准业务log格式: WARNING: 2020-05-22 17:56:37 [D:/Flask/MyOffice/tests_code/loggerstudy/logstudy01.py:31] a=33
    format='%(levelname)s: %(asctime)s [%(pathname)s:%(lineno)d] %(message)s',
    datefmt='%Y-%m-%d %H:%M:%S',

    # 设置logging等级
    level=logging.DEBUG,

    # 填写上面的handler
    handlers=[rh,fh,sh],
)

for i in range(1,100000):
    time.sleep(1)
    logging.error('KeyboardInterrupt error %s'%str(i))
```

### 4、内置函数

4.1  abs

> 返回负数的绝对值

```python
print(abs(-1))
```

4.2 all

> 所有值都为true，才是true

```python
print( all([]) )  #true
print( all([1,"aa","1"]) ) #true
```

4.3 any

> 只要循环出来的值有一个为真，那结果就是true

```python
print( any([1,None,"1"]) ) #true
```

4.4 callable

> 表示传入的值是否可以被调用，可以调用返回true，否则为false

```python
def func():
	pass

print( callable(func) )
```

4.5 dir

> 查看对象有哪些属性

```python
print( dir(list) )
```

4.6 `divmod`

> - 接收两个参数，第一个是除数，第二个是被除数
> - 结果是元组，第一个值是商，第二个是余数

```python
a = divmod(10,3)
print(a)

print(type(a))
```

4.7 enumerate

> 返回序列的索引和值，索引在值的前面

```python
a = ["aa","bb","cc"]

for index,ele in enumerate(a):
    print(f"index={index}")
    print(f"ele={ele}")
    print()
```

4.8 eval

> 执行字符串的表达式

```python
res = eval('{"a":1}')
print(res,type(res))
```

4.9 isinstance

> - 做类型判断，前一个参数是不是第二格参数的所指的类型
> - 返回值是true或false

```python
class Foo:
    pass

obj = Foo()
print(isinstance(obj,Foo))
```

### 5、time模块

> 时间模块，比较常用

##### 5.1 `time.time()`

> 用于获取当前时间戳，从1970年到现在的秒数，如果要取的时间戳是毫秒级别，需要乘以1000

```python
import time

# 1、时间戳: 从1970年到现在的秒数
t1 = time.time()
print("t1=", t1) # 2021-12-22 22:37:10
```

##### 5.2 `time.localtime()`

> 用于获取结构化时间，常用来单独取时间的某一部分，比如年、月、日等

> 看`time.localtime()`的实现源码：
>
> - 其实就解释了它可以接收`时间戳`(秒数，不是毫秒数)，然后转化为结构化时间
> - 当然它的默认值是None，不传秒数就是取`当前时间戳`转化为结构化时间

```python
def localtime(seconds=None): # real signature unknown; restored from __doc__
    """
    localtime([seconds]) -> (tm_year,tm_mon,tm_mday,tm_hour,tm_min,
                              tm_sec,tm_wday,tm_yday,tm_isdst)
    
    Convert seconds since the Epoch to a time tuple expressing local time.
    When 'seconds' is not passed in, convert the current time instead.
    """
    pass
```

> 转化的例子

```python
import time

# 结构花时间
# 用于单独获取时间的某一部分
# t4: time.struct_time(tm_year=2021, tm_mon=12, tm_mday=22, tm_hour=22, tm_min=38, tm_sec=55, tm_wday=2, tm_yday=356, tm_isdst=0)
t4 = time.localtime()

print("t4=", t4)
print("t4 year=", t4.tm_year) # 2021
print("t4 mon=", t4.tm_mon) # 12
print("t4 mday=", t4.tm_mday) # 22

# 传入一个时间戳，1640183901
# t5: time.struct_time(tm_year=2021, tm_mon=12, tm_mday=20, tm_hour=22, tm_min=21, tm_sec=41, tm_wday=0, tm_yday=354, tm_isdst=0)
t5 = time.localtime(1640010101)
print("t5==>", t5)
```

##### 5.3 `time.strftime()`

> 字符串格式显示的时间，常用对外展示比较可阅读的时间，比如：`2021-12-20 22:21:41`

> 查看源码可以看出：
>
> - 主要用来将一个时间元祖(也就是结构化时间)，根据一定的格式进行转化
> - 当时间元祖没有传入时，取当前时间的`time.localtime()`作为替代
> - 所以可以使用将结构化时间传入给该函数

```python
def strftime(format, p_tuple=None): # real signature unknown; restored from __doc__
    """
    strftime(format[, tuple]) -> string
    
    Convert a time tuple to a string according to a format specification.
    See the library reference manual for formatting codes. When the time tuple
    is not present, current time as returned by localtime() is used.
    
    Commonly used format codes:
    
    %Y  Year with century as a decimal number.
    %m  Month as a decimal number [01,12].
    %d  Day of the month as a decimal number [01,31].
    %H  Hour (24-hour clock) as a decimal number [00,23].
    %M  Minute as a decimal number [00,59].
    %S  Second as a decimal number [00,61].
    %z  Time zone offset from UTC.
    %a  Locale's abbreviated weekday name.
    %A  Locale's full weekday name.
    %b  Locale's abbreviated month name.
    %B  Locale's full month name.
    %c  Locale's appropriate date and time representation.
    %I  Hour (12-hour clock) as a decimal number [01,12].
    %p  Locale's equivalent of either AM or PM.
    
    Other codes may be available on your platform.  See documentation for
    the C library strftime function.
    """
    return ""
```

> 转化的例子

```python
import time

t2 = time.strftime("%Y-%m-%d %X")
t3 = time.strftime("%Y-%m-%d %H:%M:%S")
print("t2=", t2)  # 2021-12-22 22:37:10
print("t3=", t3) # 2021-12-22 22:37:10

# 需要传入一个结构化时间，那么可以对时间戳先转化为结构化时间，在给strftime()传入
# t5是一个结构化时间，指定一个时间戳戳: 1640010101
# t5: time.struct_time(tm_year=2021, tm_mon=12, tm_mday=20, tm_hour=22, tm_min=21, tm_sec=41, tm_wday=0, tm_yday=354, tm_isdst=0)
t5 = time.localtime(1640010101)
print("t5==>", t5)
t6 = time.strftime("%Y-%m-%d %X", t5)
print("t6==>", t6) # 2021-12-20 22:21:41
```

##### 5.4 `time.strptime()`

> 主要用来将字符串时间转换为格式化时间

> 来看源码:
>
> - 看源码注释解释：根据传入的时间格式，将一个字符串时间转化成一个结构化时间
> - 而且它的返回值就是一个`结构化时间`

```python
def strptime(string, format): # real signature unknown; restored from __doc__
    """
    strptime(string, format) -> struct_time
    
    Parse a string to a time tuple according to a format specification.
    See the library reference manual for formatting codes (same as
    strftime()).
    
    Commonly used format codes:
    
    %Y  Year with century as a decimal number.
    %m  Month as a decimal number [01,12].
    %d  Day of the month as a decimal number [01,31].
    %H  Hour (24-hour clock) as a decimal number [00,23].
    %M  Minute as a decimal number [00,59].
    %S  Second as a decimal number [00,61].
    %z  Time zone offset from UTC.
    %a  Locale's abbreviated weekday name.
    %A  Locale's full weekday name.
    %b  Locale's abbreviated month name.
    %B  Locale's full month name.
    %c  Locale's appropriate date and time representation.
    %I  Hour (12-hour clock) as a decimal number [01,12].
    %p  Locale's equivalent of either AM or PM.
    
    Other codes may be available on your platform.  See documentation for
    the C library strftime function.
    """
    return struct_time
```

```python
import time

# 将一个字符串时间转化为结构化时间
# t1 = time.struct_time(tm_year=2021, tm_mon=11, tm_mday=22, tm_hour=23, tm_min=27, tm_sec=55, tm_wday=0, tm_yday=326, tm_isdst=-1)
t_str = "2021-11-22 23:27:55"
t1 = time.strptime(t_str, "%Y-%m-%d %X")
print("t1===>", t1)
```

##### 5.5 `time.mktime()`

> 主要是用来将结构化时间转换为时间戳

> 来看源码：
>
> - 源码注释说：将一个本地的`结构化时间`转化成`秒数`
> - 返回的是一个浮点数，需要返回整数时，就需要`int()`进行转换

```python
def mktime(p_tuple): # real signature unknown; restored from __doc__
    """
    mktime(tuple) -> floating point number
    
    Convert a time tuple in local time to seconds since the Epoch.
    Note that mktime(gmtime(0)) will not generally return zero for most
    time zones; instead the returned value will either be equal to that
    of the timezone or altzone attributes on the time module.
    """
    return 0.0
```

```python
import time

# t7是结构化时间
# t7: time.struct_time(tm_year=2021, tm_mon=12, tm_mday=22, tm_hour=23, tm_min=28, tm_sec=28, tm_wday=2, tm_yday=356, tm_isdst=0)
t7 = time.localtime()
print("t7===>", t7)
t8 = int(time.mktime(t7)) * 1000
print("t8===>", t8) # 1640186908000
```

##### 5.5 时间戳转换为字符串时间

> 下图是转化的图

![image-20211222232146570](python%E7%AC%94%E8%AE%B0/image-20211222232146570.png)

> 转化的代码

```python
import time

# 将t1时间戳转化为字符串时间
t1 = 1637594296
print("t1时间戳:", t1)

# 转化为结构化时间
t1 = time.localtime(t1)

# 转化为字符串时间
t1 = time.strftime("%Y-%m-%d %X", t1)

print("t1字符串时间:", t1)

# t1时间戳: 1637594296
# t1字符串时间: 2021-11-22 23:18:16
```

##### 5.6 字符串时间转化为时间戳

> 下图是转化的图

![image-20211222234739800](python%E7%AC%94%E8%AE%B0/image-20211222234739800.png)

> 下面是转化的代码

```python
import time

# 将t1字符串时间转化为时间戳
t1 = "2021-11-22 23:27:55"
print("t1字符串:", t1)

# 先转化为结构化时间
t1 = time.strptime(t1, "%Y-%m-%d %X")

# 再将结构化时间转化为时间戳
t1 = int(time.mktime(t1))
print("t1时间戳:", t1)

# 执行结果:
# t1字符串: 2021-11-22 23:27:55
# t1时间戳: 1637594875
```

### 6、datetime模块

> `datetime`也是一个时间模块，不同于`time`模块，可以用来对时间进行加减

##### 6.1 当前时间

```python
# 当前时间
now_time = datetime.datetime.now()

# now_time: 2021-12-22 23:55:17.339830
print("now_time:", now_time)

# now_time type: <class 'datetime.datetime'>
print("now_time type:", type(now_time))
```

##### 6.2 时间加减

> `datetime`可以对时间进行加减，使用`datetime.timedelta()`

> 先看源码
>
> - 可以看到这个时间加减类，接收`days`/`seconds`/`weeks`/`hours`等格式，传入的值是一个float类型
> - `float = ...` 这三个点在python中表示是`<class ellipsis>`，用来占位的，和pass一样

```python
class timedelta(SupportsAbs[timedelta]):
    min: ClassVar[timedelta]
    max: ClassVar[timedelta]
    resolution: ClassVar[timedelta]
    def __init__(
        self,
        days: float = ...,
        seconds: float = ...,
        microseconds: float = ...,
        milliseconds: float = ...,
        minutes: float = ...,
        hours: float = ...,
        weeks: float = ...,
        *,
        fold: int = ...,
    ) -> None: ...
    @property
    def days(self) -> int: ...
    @property
    def seconds(self) -> int: ...
    @property
    def microseconds(self) -> int: ...
    def total_seconds(self) -> float: ...
```

```python
import datetime

# 当前时间
now_time = datetime.datetime.now()

# now_time: 2021-12-22 23:55:17.339830
print("now_time:", now_time) # 2021-12-23 00:09:04.046012

# now_time type: <class 'datetime.datetime'>
print("now_time type:", type(now_time)) # <class 'datetime.datetime'>

# 天数加减
three_day_later = now_time + datetime.timedelta(days=3)
print("三天后:", three_day_later) # 2021-12-26 00:09:04.046012

three_day_early = now_time + datetime.timedelta(days=-3)
print("三天前:", three_day_early) # 2021-12-20 00:09:04.046012
```

##### 6.3 时间戳转化为datetime类型的字符串时间

> 一步到位将时间戳转化为字符串格式的时间，此时的字符串格式时间类型是`<class 'datetime.datetime'>`，可以使用`datetime.timedelta()`进行时间的加减
>
> - 其实`time`模块也可以做到，但是需要两步
>   - 第一步需要先转化为结构化时间
>   - 第二步需要指定输出字符串的格式

```python
import datetime

# 结束时间+7天
# 对时间戳进行加减N天

# 当前时间戳
t1 = time.time()
t2 = datetime.datetime.fromtimestamp(t1) + datetime.timedelta(days=7)

# 2021-12-30 00:47:04.755311
print(t2) 

# <class 'datetime.datetime'>
print(type(t2))

# 再将加了N天的时间转化为时间戳
t3 = t2.timetuple()
t3_stamp = int(time.mktime(t3)) * 1000
print(t3_stamp) # 1640796424000
```

##### 6.4 datetime类型的字符串时间转化为时间戳

> 将类型是`<class 'datetime.datetime'>`的字符串时间转换为时间戳，比如我对某个时间进行了加减，然后需要转换为时间戳存起来
>
> 注意:
>
> - `datetime.datetime.now()`返回的时间类型是`<class 'datetime.datetime'>`
> - 可以通过`timetuple()`将时间类型为`<class 'datetime.datetime'>`转换为结构化时间
> - 最后再使用`time.mktime()`转化为时间戳

```python
import datetime

three_day_early = datetime.datetime.now() + datetime.timedelta(days=-3)
print("三天前:", three_day_early) # 2021-12-20 00:33:05.384049
print("三天前格式:", type(three_day_early)) # <class 'datetime.datetime'>

# timetuple() 返回的是结构化时间
struct_three_day_early = three_day_early.timetuple()

t1 = int(time.mktime(struct_three_day_early)) * 1000
print(t1) # 1639931585000
```

##### 6.5 datetime和time模块复习

```python
import datetime, time

def time_switch_to_stamp():
    # 时间戳转换为字符串时间戳
    s = 1640796424000 // 100

    # 转为结构体
    s_struct = time.localtime(s)

    # 转为字符串时间
    s_str_time = time.strftime("%Y-%m-%d %X")
    print(s_str_time)

    # 字符串格式转化为时间戳
    s_str_time_new = "2021-12-25 10:00:00"

    # 先转化为结构化时间
    s_struct_new = time.strptime(s_str_time_new, "%Y-%m-%d %X")

    # 再转化为时间戳
    s_time_new_stamp = int(time.mktime(s_struct_new))
    print(s_time_new_stamp)


def datetime_switch_to_stamp():
    """
    这个里面既包含了将时间戳转换为字符串时间，也包含了将字符串时间转换为时间戳
    :return:
    """
    # 在存在的一个时间戳上+N天，并且再将最后的N天转换为时间戳
    s = 1640796424000 // 1000

    three_day_later = datetime.datetime.fromtimestamp(s) + datetime.timedelta(days=3)

    # 三天后的时间转化为时间戳
    # step1: 三天后的时间转化为结构化时间
    new_struct_time = three_day_later.timetuple()

    # step2: 再将结构化时间转换为是时间戳
    new_time_stamp = int(time.mktime(new_struct_time))

    print(new_time_stamp)
```

## 六、正则表达式

### 1、正则表达式

> 定义：一套规则，匹配字符串
>
> 功能：检测一个输入的字符串是否合法，从一个大文件中找到所有符合规则的内容
>
> 推荐一个正则好用的网站:
>
> http://tool.chinaz.com/regex/

### 2、元字符

> 
>

## 七、进程和线程

### 1、进程

> 进行中的程序就是一个进程
>
> 1.占用资源
>
> 2.pid: 能唯一标识一个进程
>
> 3.计算机中最小的资源分配单位

### 2、并发、并行

2.1 并发

> 1. 多个程序轮流在一个单核cpu上执行
> 2. 宏观上：多个程序在同时执行
> 3. 微观上：多个程序轮流在一个cpu上执行，本质还是串行
> 4. 本质：每个任务都是交替执行，但由于CPU执行速度太快，所以我们感觉是所有任务都在同时执行

2.2 并行

> 1. 多个程序同时执行，并且同时在多核cpu上执行
> 2. 真正的并行执行多任务也只能在多核cpu上实现，但是由于任务数量远远多于cpu核心数量，所以操作系统也会自动把很多任务轮流调度到每个核上去执行

### 3、同步、异步、阻塞、非阻塞

3.1 同步

> 在做A事的时候发起B事件，必须等待B事件完成后才能继续做A事

3.2 异步

> 在做A事的时候发起B事件，不需要等待B事件完成后才能继续做A事

3.3 阻塞

> 如果CPU不工作了，input accept  recv  recvfrom sleep connect

3.4 非阻塞

> CPU正常在工作

### 4、线程

> 线程是进程中的一个单位，不能脱离进程存在
>
> 线程是计算机中能被CPU调度的最小单位
>
> python的thread模块比较底层，python的threading模块对thread做了一些包装，方便使用

### 5、threading多线程

```python
import threading
import time


def sing(name):
    print(f"{name} sing start time:{time.strftime('%Y-%m-%d %X')}")
    time.sleep(1)
    print(f"{name} sing end time:{time.strftime('%Y-%m-%d %X')}")


def walk(name):
    print(f"{name} walk start time:{time.strftime('%Y-%m-%d %X')}")
    time.sleep(2)
    print(f"{name} walk end time:{time.strftime('%Y-%m-%d %X')}")


sing_th = threading.Thread(target=sing, args=("bob",))
walk_th = threading.Thread(target=walk, args=("sam",))

ths = [sing_th, walk_th]

for th in ths:
    th.start()

for th in ths:
    th.join()

print("done!!!")
```

### 6、线程池

> 线程池比较适合做多个目标做同一件事

```python
import time
from concurrent.futures import ThreadPoolExecutor


def sing(name):
    print(f"{name} sing start time:{time.strftime('%Y-%m-%d %X')}")
    time.sleep(1)
    print(f"{name} sing end time:{time.strftime('%Y-%m-%d %X')}")


# 开启线程池，最多1次有10个线程被执行
pool = ThreadPoolExecutor(10)

users = ["sam", "bob", "tom"]

# 并发执行
for name in users:
    pool.submit(sing, name=name)

# 等待子线程执行完成
pool.shutdown(True)

print("done!")
```

![image-20230217135229336](python笔记/image-20230217135229336.png)

## 八、面向对象

### 1、类定义

#### 1.1 类的实例化

> - 实例化：
>   - 调用类的过程称为实例化
> - 实例化发生了三件事
>   - 1.先产生了一个空对象
>   - 2.`python`会自动调用类的`__init__`方法将空对象已经调用类时括号内传入的参数一同传给`__init__`方法
>   - 3.返回初始化完成的对象
> - `__init__`总结
>   - 1.会在调用类时自动触发执行，用来为对象初始化自己的独有的数据
>   - 2.因为`__init__`是自动触发执行的，而且`__init__`里存放的是为对象初始化属性的功能，就可以存放任何其他代码，想要在类调用时就立刻执行的代码都可以放到该方法中
>   - 3.`__init__`方法必须返回None

```python
# 定义类
class A:

    # 变量定义
    tag = "Tim"

    def __init__(self,name_v,age_v):  # self 就是obj_a这个空对象
        self.name_k = name_v   # obj_a.name = name -> obj_a这个对象字典中{name_k:name_v}
        self.age_k = age_v     # obj_a.age_k = age_v -> obj_a这个对象字典中{name_k:name_v,age_k:age_v}

    def drive(self):
        print(f"the car cost:{self.name_k}")



obj_a = A("sam",19) # A.__init__(空对象，"sam",19)，然后将创建好的类返回给obj_a这个对象
print(obj_a.__dict__) #{'name_k': 'sam', 'age_k': 19}
```

#### 1.2 类的属性查找

```python

# 定义类
class A:

    tag = "Tim"

    def __init__(self,name_v,age_v):
        self.name_k = name_v
        self.age_k = age_v

    def drive(self):
        print(f"the car cost:{self.name_k}")

obj_a = A("sam",19)

# 类中存放的是对象共有的数据与功能
# 类可以访问:
# 1.类的数据属性
print(A.tag) # Tim,就是tag的值


# 2.类的函数属性
print(A.drive) # <function A.drive at 0x00000000028B9B70>

# 类的数据属性和函数属性就是为对象服务的，对象在调用时，会先从自己的属性字典中去找，如果没有找到就会去类的属性字典去找
```

#### 1.3 对象使用类方法就是绑定方法

> 对象调用类中方法，调用哪个方法，就会和这个方法形成绑定关系，并且将自己当做第一个形参传入给方法，然后类方法对这个对象进行各种操作

### 2、类的三大属性

> [https://www.cnblogs.com/peng104/p/9550305.html](https://www.cnblogs.com/peng104/p/9550305.html)
>
> - 封装
> - 继承
> - 多态

### 3、封装

> https://zhuanlan.zhihu.com/p/109310247

> 封装是面向对象三大特性最核心的一个特性
>
> 封装就是将数据属性和方法属性整合到容器中，容器就是类，对象

#### 3.1 私有变量、私有方法

> 在属性名前加`__`(两个下划线)前缀，就会实现对外隐藏属性效果
>
> Python的Class机制采用双下划线开头的方式将属性隐藏起来（设置成私有的），但其实这仅仅只是一种变形操作，类中所有双下滑线开头的属性都会在类定义阶段、检测语法时自动变成“_类名__属性名”的形式
>
> 在类外部无法直接访问双下滑线开头的属性，但知道了类名和属性名就可以拼出名字：`_类名__属性`，然后就可以访问了，如`Foo._A__N`，所以说这种操作并没有严格意义上地限制外部访问，仅仅只是一种语法意义上的变形。

```python
class Foo:
    __N=0 # 变形为_Foo__N

    def __init__(self): # 定义函数时，会检测函数语法，所以__开头的属性也会变形
        self.__x=10 # 变形为self._Foo__x

    def __f1(self): # 变形为_Foo__f1
        print('__f1 run')

    def f2(self):  # 定义函数时，会检测函数语法，所以__开头的属性也会变形
        self.__f1() #变形为self._Foo__f1()

print(Foo.__N) # 报错AttributeError:类Foo没有属性__N

obj = Foo()
print(obbj.__x) # 报错AttributeError:对象obj没有属性__x
```

#### 3.2 property

> property:
>
> - 为此Python专门提供了一个装饰器property，可以将类中的函数“伪装成”对象的数据属性，对象在访问该特殊属性时会触发功能的执行，然后将返回值作为本次访问的结果

```python
>>> class People:
...     def __init__(self,name,weight,height):
...         self.name=name
...         self.weight=weight
...         self.height=height
...     @property
...     def bmi(self):
...         return self.weight / (self.height**2)
...
>>> obj=People('lili',75,1.85)
>>> obj.bmi #触发方法bmi的执行，将obj自动传给self，执行后返回值作为本次引用的结果
21.913805697589478
```

> 使用property有效地保证了属性访问的一致性。另外property还提供设置和删除属性的功能

```python
# 定义类
class A:

    # 变量定义
    tag = "Tim"

    def __init__(self,name):  # self 就是obj_a这个空对象
        self.__name = name  # obj_a.name = name -> obj_a这个对象字典中{name_k:name_v}

    @property
    def name(self):   # obj.name
        return self.__name

    @name.setter
    def name(self,new_value): # obj.name = "hall"
        if type(new_value) is not str:
            print(f"{new_value} must be string")

        self.__name = new_value

    @name.deleter
    def name(self):  # del obj.name
        print(f"{self.__name} cant not be delete")

a = A("hawold")

print(a.name)

a.name = "hall"

del a.name
```

### 4、类的继承

> 继承：
>
> - 是一种创建新类的方式，新建的类可以被称为子类或派生类，父类被称为基类或超类
> - python支持多继承
> - 用来解决类与类之间代码冗余问题

#### 4.1 继承的骨架

```python
class Parent1:
    pass

class Parent2:
    pass

class Sub1(Parent1):  # 单继承
    pass

class Sub2(Parent1,Parent2): # 多继承
    pass


# 查看继承的父类
print(Sub1.__bases__) # (<class '__main__.Parent1'>,)
print(Sub2.__bases__) # (<class '__main__.Parent1'>, <class '__main__.Parent2'>)
```

> - Python2中有经典类和新式类区分
>   - 经典类：没有继承object类的子类，以及该子类的子类子类
>   - 新式类：继承了object类的子类，以及该子类的子类子类
>
> - Python3中没有新式类和经典类区分，默认继承object类，所以Python3就是新式类

#### 4.2 继承的属性查找

> - 可以将多个子类中重复的部分抽离出来，形成一个父类让子类去继承
> - 当子类的init方法初始化时参数比父类多，可以使用:`父类名.__init__(self,name,age,sex)`这种形式

```python
class MyPeople:
    school = 'harry'

    def __init__(self,name,age,sex):
        self.name = name
        self.age = age
        self.sex = sex

class Student(MyPeople):
    def choose_course(self):
        print(f"{self.name} 正在选课")


class Teacher(MyPeople):
    def __init__(self,name,age,sex,salary,level):
        # 指名道姓去调用父类的__init__方法
        MyPeople.__init__(self,name,age,sex)
        self.level = level
        self.salary = salary

    def score(self):
        print(f"{self.name}老师正在给学生上课")

stu_obj = Student("lili",18,"male")
stu_obj.choose_course()

teacher_obj = Teacher("sam",29,"female",4000,5)
teacher_obj.score()
```

#### 4.3 单继承的属性查找

```python
# 单继承的属性查找
class Foo:
    def f1(self):
        print("Foo.f1")

    def f2(self):
        print("Foo.f2")
        self.f1() # b.f1(),所以会先去b这个对象自己属性字典中找

class Bar(Foo):
    def f1(self):
        print("Bar.f1")

# b = Bar()
# b.f2()

# 如果要访问Foo的f1方法
# 方法一: Foo.f1(self)
class Foo:
    def f1(self):
        print("Foo.f1")

    def f2(self):
        print("Foo.f2")
        Foo.f1(self) # Foo.f1(self) 访问Foo类中f1方法

class Bar(Foo):
    def f1(self):
        print("Bar.f1")



# 方法二: 隐藏属性
class Foo:
    def __f1(self): # 变形: _Foo__f1()
        print("Foo.f1")

    def f2(self):
        print("Foo.f2")
        self.__f1() # self._Foo__f1(),因为b3这个子类的属性字典没有_Foo__f1这个属性，就会去父类中找

class Bar(Foo):
    def __f1(self): # self._Bar__f1()
        print("Bar.f1")

b3 = Bar()
b3.f2()
```

#### 4.4 继承原理

> - python到底是如何实现继承的呢？ 对于你定义的每一个类，Python都会计算出一个方法解析顺序(MRO)列表，该MRO列表就是一个简单的所有基类的线性顺序列表
>
> - python会在MRO列表上从左到右开始查找基类,直到找到第一个匹配这个属性的类为止。 而这个MRO列表的构造是通过一个C3线性化算法来实现的。我们不去深究这个算法的数学原理,它实际上就是合并所有父类的MRO列表并遵循如下三条准则:
>
> ```python
> 1.子类会先于父类被检查
> 2.多个父类会根据它们在列表中的顺序被检查
> 3.如果对下一个类存在两个合法的选择,选择第一个父类
> ```

#### 4.5 多继承

>  一个子类可以同时继承多个父类，这样的设计常被人诟病，一来它有可能导致可恶的菱形问题，二来在人的世界观里继承应该是个”is-a”关系。 比如轿车类之所以可以继承交通工具类，是因为基于人的世界观，我们可以说：轿车是一个(“is-a”)交通工具，而在人的世界观里，一个物品不可能是多种不同的东西，因此多重继承在人的世界观里是说不通的，它仅仅只是代码层面的逻辑。不过有没有这种情况，一个类的确是需要继承多个类呢？
>
>  答案是有，我们还是拿交通工具来举例子:
>
>  民航飞机、直升飞机、轿车都是一个（is-a）交通工具，前两者都有一个功能是飞行fly，但是轿车没有，所以如下所示我们把飞行功能放到交通工具这个父类中是不合理的

```python
class Vehicle:  # 交通工具
    def fly(self):
        '''
        飞行功能相应的代码        
        '''
        print("I am flying")


class CivilAircraft(Vehicle):  # 民航飞机
    pass


class Helicopter(Vehicle):  # 直升飞机
    pass


class Car(Vehicle):  # 汽车并不会飞，但按照上述继承关系，汽车也能飞了
    pass
```

>  但是如果民航飞机和直升机都各自写自己的飞行fly方法，又违背了代码尽可能重用的原则（如果以后飞行工具越来越多，那会重复代码将会越来越多）。
>
>  怎么办？？？为了尽可能地重用代码，那就只好在定义出一个飞行器的类，然后让民航飞机和直升飞机同时继承交通工具以及飞行器两个父类，这样就出现了多重继承。这时又违背了继承必须是”is-a”关系

> Python语言可没有接口功能，但Python提供了Mixins机制，简单来说Mixins机制指的是子类混合(mixin)不同类的功能，而这些类采用统一的命名规范（例如Mixin后缀），以此标识这些类只是用来混合功能的，并不是用来标识子类的从属"is-a"关系的，所以Mixins机制本质仍是多继承，但同样遵守”is-a”关系，如下

```python
class Vehicle:  # 交通工具
    pass


class FlyableMixin:
    def fly(self):
        '''
        飞行功能相应的代码        
        '''
        print("I am flying")


class CivilAircraft(FlyableMixin, Vehicle):  # 民航飞机
    pass


class Helicopter(FlyableMixin, Vehicle):  # 直升飞机
    pass


class Car(Vehicle):  # 汽车
    pass

# ps: 采用某种规范（如命名规范）来解决具体的问题是python惯用的套路
```

> 可以看到，上面的CivilAircraft、Helicopter类实现了多继承，不过它继承的第一个类我们起名为FlyableMixin，而不是Flyable，这个并不影响功能，但是会告诉后来读代码的人，这个类是一个Mixin类，表示混入(mix-in)，这种命名方式就是用来明确地告诉别人（python语言惯用的手法），这个类是作为功能添加到子类中，而不是作为父类，它的作用同Java中的接口。所以从含义上理解，CivilAircraft、Helicopter类都只是一个Vehicle，而不是一个飞行器。
>
> 使用Mixin类实现多重继承要非常小心
>
> - 首先它必须表示某一种功能，而不是某个物品，python 对于mixin类的命名方式一般以 Mixin, able, ible 为后缀
> - 其次它必须责任单一，如果有多个功能，那就写多个Mixin类，一个类可以继承多个Mixin，为了保证遵循继承的“is-a”原则，只能继承一个标识其归属含义的父类
> - 然后，它不依赖于子类的实现
> - 最后，子类即便没有继承这个Mixin类，也照样可以工作，就是缺少了某个功能。（比如飞机照样可以载客，就是不能飞了）

#### 4.6 子类派生的新方法中重用父类方法

> 子类可以派生出自己新的属性，在进行属性查找时，子类中的属性名会优先于父类被查找，例如每个老师还有职称这一属性，我们就需要在Teacher类中定义该类自己的`__init__`覆盖父类的

```python
>>> class People:
...     school='清华大学'
...     
...     def __init__(self,name,sex,age):
...         self.name=name
...         self.sex=sex
...         self.age=age
... 
>>> class Teacher(People):
...     def __init__(self,name,sex,age,title): # 派生
...         self.name=name
...         self.sex=sex
...         self.age=age
...         self.title=title
...     def teach(self):
...         print('%s is teaching' %self.name)
... 
>>> obj=Teacher('lili','female',28,'高级讲师') #只会找自己类中的__init__，并不会自动调用父类的
>>> obj.name,obj.sex,obj.age,obj.title
('lili', 'female', 28, '高级讲师')
```

> 很明显子类Teacher中`__init__`内的前三行又是在写重复代码，若想在子类派生出的方法内重用父类的功能，有两种实现方式
>
> 方法一：“指名道姓”地调用某一个类的函数

```python
>>> class Teacher(People):
...     def __init__(self,name,sex,age,title):
...         People.__init__(self,name,age,sex) #调用的是函数,因而需要传入self
...         self.title=title
...     def teach(self):
...         print('%s is teaching' %self.name)
...
```

> 方法二：super()
>
> 调用super()会得到一个特殊的对象，该对象专门用来引用父类的属性，且严格按照MRO规定的顺序向后查找

```python
>>> class Teacher(People):
...     def __init__(self,name,sex,age,title):
...         super().__init__(name,age,sex) #调用的是绑定方法，自动传入self
...         self.title=title
...     def teach(self):
...         print('%s is teaching' %self.name)
...
```

> 提示：在Python2中super的使用需要完整地写成super(自己的类名,self) ,而在python3中可以简写为super()。
>
> 这两种方式的区别是：方式一是跟继承没有关系的，而方式二的super()是依赖于继承的，并且即使没有直接继承关系，super()仍然会按照MRO继续往后查找

```python
>>> #A没有继承B
... class A:
...     def test(self):
...         super().test()
... 
>>> class B:
...     def test(self):
...         print('from B')
... 
>>> class C(A,B):
...     pass
... 
>>> C.mro() # 在代码层面A并不是B的子类，但从MRO列表来看，属性查找时，就是按照顺序C->A->B->object，B就相当于A的“父类”
[<class '__main__.C'>, <class '__main__.A'>, <class '__main__.B'>,<class ‘object'>]
>>> obj=C()
>>> obj.test() # 属性查找的发起者是类C的对象obj，所以中途发生的属性查找都是参照C.mro()
from B
```

> obj.test()首先找到A下的test方法，执行super().test()会基于MRO列表(以C.mro()为准)当前所处的位置继续往后查找()，然后在B中找到了test方法并执行。
>
> 关于在子类中重用父类功能的这两种方式，使用任何一种都可以，但是在最新的代码中还是推荐使用super()



#### 4.7、继承的知识扩展

##### 4.7.1 子类继承语法

> 语法：class  子类名(父类名):pass
>
> 子类可以使用父类中的： 方法  静态变量

```python
# 子类可以使用父类中的： 方法  静态变量
class Animal:
    def __init__(self,name):
        self.name = name

    def eat(self):
        print(f"{self.name} is eating")

    def drink(self):
        print(f"{self.name} is drinking")

    def sleep(self):
        print(f"{self.name} is sleeping")


class Cat(Animal):
    def climb_tree(self):
        print(f"{self.name} is climbing")

s = Cat("xxmo")
s.eat()

# 先开辟空间，空间里有一个类指针－＞指向Cat
# 调用init，对象在自己的空间中找init没找到，到Cat类中找init也没找到
# 找父类Animal中的init
```

##### 4.7.2 子类方法中调用父类方法

> 子类的对象，如果去调用方法，永远先调用自己的方法
>
> 1.如果自己有该方法，则用自己的，语法： self.子类方法
>
> 2.如果自己没有，则使用父类的，语法：self.父类方法
>
> 3.如果子类方法和父类方法重名，也就是自己有该方法，父类也有该方法，此时子类方法还想调用父类的方法，则直接在子类方法中调用父类的方法，调用方式： 父类名.方法名(self)

```python
class Animal:
    def __init__(self,name):
        self.name = name

    def eat(self):
        print(f"{self.name} is eating")

    def drink(self):
        print(f"{self.name} is drinking")

    def sleep(self):
        print(f"{self.name} is sleeping")


class Cat(Animal):
    def eat(self):
        print("子类的eat方法")
        Animal.eat(self)  # 因为子类和父类都有eating方法，仍想调用父类的eating就使用： 父类名.父类方法(self) 

    def climb_tree(self):
        print(f"{self.name} is climbing")
        self.drink() # 因为子类没有drink方法，但是父类有drink方法，所以直接调用父类的drink方法

s = Cat("xxmo")
s.eat() 
```

```python
# 特殊例子
class Foo:
    def __init__(self):
        self.func() # 在每一个self调用func时，不看这句话在哪执行，只看self是谁

    def func(self):
        print("in Foo")

class Son(Foo):
    def func(self):
        print("in Son")

Son()
```

##### 4.7.3 重写父类的`__init__`构造方法

```python
class Animal:
    def __init__(self,name):
        self.name = name

    def eat(self):
        print(f"{self.name} is eating")

    def drink(self):
        print(f"{self.name} is drinking")

    def sleep(self):
        print(f"{self.name} is sleeping")


class Cat(Animal):
    def __init__(self,name,age,color):
        Animal.__init__(self,name) # 调用父类的初始化，完成一些通用属性的初始化
        self.age = age  # 属于子类(派生类)的数据属性
        self.color = color

    def walk(self):
        msg = f"My cat name is {self.name},{self.age} years old,It\'s {self.color}"
        print(msg)

s = Cat("kim",18,"red")
s.walk()
```

### 5、绑定方法

> 绑定方法特殊之处在于将调用者当做第一个参数自动传入
>
> 1. 绑定给对象的方法：
>    1. 调用者是对象，自动传入的是类
> 2. 绑定给类的方法：
>    1. 调用者是类，自动传入的是类

```python
mysql_conf = {
    "ip":"1.1.1.1",
    "port":3306
}


class Mysql:
    def __init__(self,ip,port):
        self.ip = ip
        self.port = port

    def func(self):
        print(f"{self.ip}:{self.port}")

    @classmethod  # 将下面的函数装饰成绑定类的方法
    def from_conf(xxx):
        print(xxx) # 代表传入的类本身
        return xxx(mysql_conf["ip"],mysql_conf["port"])

b1 = Mysql.from_conf()
print(b1.__dict__)
```

### 6、反射

#### 6.1 反射基础

> https://zhuanlan.zhihu.com/p/109336120

> python是动态语言，而反射(reflection)机制被视为动态语言的关键。
>
> 反射机制指的是在程序的运行状态中
>
> - 对于任意一个类，都可以知道这个类的所有属性和方法；
>
> - 对于任意一个对象，都能够调用他的任意方法和属性。
>
> - 这种动态获取程序信息以及动态调用对象的功能称为反射机制。

#### 6.2 反射实现

> 在python中实现反射非常简单，在程序运行过程中，如果我们获取一个不知道存有何种属性的对象，若想操作其内部属性，可以先通过内置函数`dir(obj)`来获取任意一个类或者对象的属性列表，列表中全为字符串格式

> 1、先通过`dir()` 查出某一个对象下有哪些属性可以来用

```python
class People:
    def __init__(self,name,age,gender):
        self.name=name
        self.age=age
        self.gender=gender
 
obj=People('egon',18,'male')
dir(obj) # 列表中查看到的属性全为字符串
[......,'age', 'gender', 'name']
```

> 2、可以通过字符串反射到真正的属性上，得到属性值

```python
# dir(obj)[-2] ： 取的是属性列表的倒数第二个属性，即：gender
# print(obj.__dict__) # {'name': 'sam', 'age': 18, 'gender': 'male'}

# 所以: obj.__dict__[dir(obj)[-2]] 就是 obj.__dict__["gender"]=> male
print(obj.__dict__[dir(obj)[-2]]) # male
```

#### 6.3 反射内置方法

> - 通过字符串来操作对象的属性了，这就涉及反射的内置函数
>   - hasattr
>   - getattr
>   - setattr
>   - delattr
> - Python中一切皆对象，类和对象都可以被这四个函数操作，用法一样

##### 6.3.1 hasattr

> 

##### 6.3.2 getattr

> getattr用来判断对象是否有属性，没有的话给一个默认值

```python
class A:
    def get(self):
        return "use get method"

    def post(self):
        return "use get method"


def method_not_allow(method_str):
    return f"【{method_str}】 method not allow"

if __name__ == '__main__':
    obj = A()
    method_str = "data"
    res = getattr(obj, method_str, method_not_allow(method_str))
    print(res)
    print(res())
```

##### 6.3.3 setattr

> 

##### 6.3.4 delattr

> 

### 7、with上下文

> with上下文可以在没有进行关闭操作时，自动去进行关闭收尾操作

```python
import time


class OpenFile:
    def __init__(self, name):
        self.name = name
        self.timer = time.strftime('%Y-%m-%d %X')

    def __enter__(self):
        # print('出现with语句,对象的__enter__被触发,有返回值则赋值给as声明的变量')
        print(f'{self.timer} 开始读取内容')
        time.sleep(2)
        print(f'{self.timer} 读取内容完毕')

    def __exit__(self, exc_type, exc_val, exc_tb):
        # print('with中代码块执行完毕时执行我啊')
        print(f'{self.timer} 自动关闭文件打开的文件句柄')


if __name__ == '__main__':
    with OpenFile('a.txt') as f:
        print('>>>执行代码块<<<')

    print("done!!!")
```

![image-20230217135129406](python笔记/image-20230217135129406.png)

