---
title: VUE笔记
date: 2022-07-08 11:39:30
updated: 2022-07-08 11:39:30
tags: VUE
cover: /posts_cover_img/web_dev/vue_logo.png
categories: VUE笔记
---

## 一、vue介绍

### 1、vue介绍

> 官网：https://cn.vuejs.org/
>
> 是一套用来构建用户界面的前端框架
>
> - 构建用户界面
>     - 用vue给html中填充数据，非常方便
> - 框架
>     - 是一套现成的解决方案，用来让程序员遵守欧框架规范编写页面功能
> - 学习重点
>     - Vue的用法、指令、组件（对UI结构的复用）、路由、vue

### 2、vue的特性

#### 2.1 数据驱动视图

> 在使用了vue的页面里，vue会`主动`监听数据的`变化`，然后`自动`重新渲染页面结构
>
> 这样带来的优点：
>
> - 当页面数据发生变化时，页面会自动重新渲染
>
> 注意：
>
> - <font color="blue">数据驱动视图是单向的数据绑定</font>

![image-20220711235557934](vue%E7%AC%94%E8%AE%B0/image-20220711235557934.png)



#### 2.2 双向数据绑定

> 双向数据绑定可以服务开发人员在`不操作DOM`的前提下，`自动`把想要的数据`同步`到数据源中
>
> 比如：填写表单时，自动会把页面上输入的内容同步到数据源中
>
> 双向数据绑定的好处：
>
> - 如果没有vue，从页面获取数据，需要操作dom，如果需要把数据渲染到页面上，也要操作dom，如果这样的操作很多了，就会很不方便
> - 有了vue，就可以实现不操作dom，就能做到数据的同步，无论是获取数据，还是渲染数据
>     - 当js数据有变化时，会自动渲染到页面上
>     - 页面上表单上拿到的数据有变化是，会被vue自动获取到，并更新到js中

![image-20220712000158734](vue%E7%AC%94%E8%AE%B0/image-20220712000158734.png)

### 3、了解vue底层原理

#### 3.1 MVVM

> 1、MVVM是vue实现数据驱动视图和双向数据绑定的核心原理
>
> 2、MVVM是Model-View-ViewModel的缩写，即模型-视图-视图模型
>
> 3、MVVM三个特性
>
> - Model：表示当前页面渲染时所依赖的数据源，后端传递的数据
> - View：表示当前页面所渲染的DOM结构，代表UI组件，负责将数据模型转化成UI展现出来
> - ViewModel：表示vue实例，是一个同步View和Model的对象，MVVM模式的核心，是连接Model和View的桥梁

![MVVM](vue%E7%AC%94%E8%AE%B0/mvvm_core.png)

#### 3.2 ViewModel

> ViewModel是MVVM的核心，ViewModel把当前页面的数据源(Model)和页面结构(View)连接在一起
>
> 1. 当数据源有变化时，会被ViewModel监听到，ViewModel会根据最新的数据源`自动更新`页面的结构
> 2. 当表单元素的值有变化时，同时也会被ViewModel监听到，ViewModel会把变化后的最新的数据`自动同步`到Model数据源中

## 二、vue基础语法

### 1、第一个vue代码

> 需要三个步骤：
>
> 1. 导入vue.js的脚本文件（表示是在导入vue库）
> 2. 在页面中声明一个要被vue控制的DOM区域，比如一个div块
> 3. 创建vm实例对象（vm是指ViewModel）

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <!-- 2. 在页面中声明一个要被vue控制的DOM区域（这里就是View），比如一个div块 -->
    <div id="app">
        {{username}}
    </div>
</body>
<!-- 1. 导入vue.js的脚本文件 -->
<script src="../lib/vue/vue_v2.6.14.js"></script>
<script>
    // 3. 实例化一个ViewModel对象
    const vm = new Vue({
        // 3.1 指定当前ViewModel实例所控制页面的区域位置
        el: "#app",
        // 3.2 指定Model数据源
        data: {
            "username": "sam"
        }
    })
</script>

</html>
```

> 上面代码中，`new Vue`是表示vue的构造函数，用来实例化一个vue对象（ViewModel对象）
>
> - `new Vue`构造函数里的值定义：
>
>     - el属性是固定写法，表示当前vm实例要控制的是页面某个区域，接收到的值是一个选择器
>         - el指定的区域就是root根节点
>
>     - data也是固定写法，表示要渲染到页面上的数据
>
> - div里的传值写法
>     - `{{username}}`表示将vue实例对象里的data里的`username`渲染到页面上
>     - 从下面就可以看到，data里的数据渲染到了页面上

![image-20220712003344784](vue%E7%AC%94%E8%AE%B0/image-20220712003344784.png)

#### 1.1 使用工具调试vue

> 使用[Vue Devtools](https://devtools.vuejs.org/)调试工具，就能看到vue的数据了
>
> 可以看到jam就是root根节点，也表示是id为app的div
>
> 上面代码里username是sam，可以在调试工具右边的data里进行数据修改，然后vue又自动渲染数据到页面上，达到了双向数据绑定

![image-20220712003836806](vue%E7%AC%94%E8%AE%B0/image-20220712003836806.png)

### 2、vue的指令

> 指令是vue提供的模板语法，用来帮助开发渲染页面的基本结构
>
> 指令分类：
>
> - 内容渲染指令
> - 属性绑定指令
> - 事件绑定指令
> - 双向绑定指令
> - 条件渲染指令
> - 列表渲染指令

### 3、内容渲染指令

> 该指令用来渲染DOM元素的文本内容
>
> 主要分为三个
>
> - v-text
> - {%raw%}{{}}{%endraw%}
> - v-html

#### 3.1 v-text

> 将vm实例对象的data里的数据，渲染到页面上

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <!-- 2. 在页面中声明一个要被vue控制的DOM区域，比如一个div块 -->
    <div id="app">
        <p v-text="username"></p>
        <p v-text="gender">性别</p>
    </div>
</body>
<!-- 1. 导入vue.js的脚本文件 -->
<script src="../lib/vue/vue_v2.6.14.js"></script>
<script>
    // 3. 实例化一个ViewModel对象
    const vm = new Vue({
        // 3.1 指定当前vm实例所控制页面的区域位置
        el: "#app",
        // 3.2 指定Model数据源
        data: {
            "username": "sam",
            "gender": "女"
        }
    })
</script>
</html>
```

> 输出结果
>
> - v-text会覆盖元素自身原有的值，比如就是将`div`第二个p标签里的`性别`替换成了`女`，但这并不是我们想要的，我们希望在`性别`后面展示`女`
> - 这个语法用的很少

![image-20220712005504173](vue%E7%AC%94%E8%AE%B0/image-20220712005504173.png)

#### 3.2 {%raw%}{{}}{%endraw%}

> `{%raw%}{{}}{%endraw%}`语法主要用来解决`v-text`引发的覆盖默认文本内容的问题
>
> `{%raw%}{{}}{%endraw%}`语法叫做插值表达式(英文是：Mustache)
>
> 这个语法用的很多

> 问题解决：
>
> `3.2标题`为什么要这么写的原因？
>
> - 因为hexo直接渲染插值表达式会报错，所以需要传入原始值
>
> - 原文地址：[https://hexo.io/docs/troubleshooting.html](https://hexo.io/docs/troubleshooting.html)

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <!-- 2. 在页面中声明一个要被vue控制的DOM区域，比如一个div块 -->
    <div id="app">
        <p>姓名:{{ username }}</p>
        <p>性别: {{ gender }}</p>
    </div>
</body>
<!-- 1. 导入vue.js的脚本文件 -->
<script src="../lib/vue/vue_v2.6.14.js"></script>
<script>
    // 3. 实例化一个ViewModel对象
    const vm = new Vue({
        // 3.1 指定当前vm实例所控制页面的区域位置
        el: "#app",
        // 3.2 指定Model数据源
        data: {
            "username": "sam",
            "gender": "女"
        }
    })
</script>

</html>
```

![image-20220712005610929](vue%E7%AC%94%E8%AE%B0/image-20220712005610929.png)

#### 3.3 v-html

> 要把包含html标签的字符串数据渲染为页面HTML元素，就需要`v-html`
>
> 使用v-text、差值表达式就会原样输出，只能渲染文本内容

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <!-- 2. 在页面中声明一个要被vue控制的DOM区域，比如一个div块 -->
    <div id="app">
        <p v-text="username"></p>
        <p>姓名: {{ username }}</p>
        <p v-html="username"></p>
    </div>
</body>
<!-- 1. 导入vue.js的脚本文件 -->
<script src="../lib/vue/vue_v2.6.14.js"></script>
<script>
    // 3. 实例化一个ViewModel对象
    const vm = new Vue({
        // 3.1 指定当前vm实例所控制页面的区域位置
        el: "#app",
        // 3.2 指定Model数据源
        data: {
            "username": "<h3 style='color:pink'>sam</h3>",
        }
    })
</script>

</html>
```

![image-20220712012102695](vue%E7%AC%94%E8%AE%B0/image-20220712012102695.png)

> 很清楚能看到，v-html把h3标签渲染到了页面上，因为H3标签里的文本内容的颜色变为设置的pink色

#### 3.4 el属性注意事项

> 如果有多个相同HTML标签在页面结构中，用vue控制页面时，vue的el属性只会控制第一个同名的HTML标签，其余的都会原样输出，不会进行渲染，所以一般约定成俗的都是使用一个id名叫`“app”`一个大的div包裹我们需要编写的页面。
>
> 并且在以后的项目中，vue会自动配置控制区域的ID，不用我们手动写

### 4、属性绑定指令

> 如果需要给元素的属性`动态绑定属性值`，就需要用到`v-bind`属性绑定指令
>
> 什么时候使用使用属性绑定指令？
>
> - 为元素的属性动态添加值时，就要考虑使用属性绑定指令了
>
> 这个指令用的非常多

```html
 <!-- v-bind 绑定元素属性的完整写法 -->
<input type="text" v-bind:placeholder="placeholderText">

 <!-- v-bind 绑定元素属性的省略写法，在元素属性前面不写v-bind，只留下英文的冒号: -->
<input type="text" :placeholder="placeholderText">
```

> 完整代码示例

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>vue第一天</title>
</head>

<body>
    <div id="app">
        <!-- v-bind 绑定元素属性 -->
        <input type="text" v-bind:placeholder="placeholderText">
    </div>
</body>
<script src="../lib/vue/vue_v2.6.14.js"></script>
<script>
    const vm = new Vue({
        "el": "#app",
        data: {
            "placeholderText": "请输入用户名",
        }
    })
</script>

</html>
```

> 如果用插值表达式给元素属性绑定值，就会报错，插值表达式内容会原样输出并且控制台报错

![image-20220712111704521](vue%E7%AC%94%E8%AE%B0/image-20220712111704521.png)

### 5、插值和属性绑定写JS语句

> 在插值表达式和属性绑定指令中都可以添加js语句

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>vue第一天</title>
</head>

<body>
    <div id="app">
        <p>1 + 2 = {{ 1 + 2 }}</p>
        <div :title="'box' + index">
            box盒子内容
        </div>
    </div>
</body>
<script src="../lib/vue/vue_v2.6.14.js"></script>
<script>
    const vm = new Vue({
        "el": "#app",
        data: {
            "placeholderText": "请输入用户名",
            "index": 3
        }
    })
</script>

</html>
```

![image-20220712132326072](vue%E7%AC%94%E8%AE%B0/image-20220712132326072.png)

> 可以看到当鼠标放到box盒子内容上时，提示了title内容，内容就是拼接的`box + index`

### 6、事件绑定指令

> vue中的`v-on`事件绑定指令，用来协助为DOM元素绑定事件监听

#### 6.1 v-on语法

```html
<!-- v-on绑定事件 -->
<!-- 语法为：v-on:事件名称="事件处理函数名称" -->
<button v-on:click="addCount">+1</button>
```

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>vue第一天</title>
</head>

<body>
    <div id="app">
        <p>count的值:{{count}}</p>
        <button v-on:click="addCount">+1</button>
        <button v-on:click="subCount">-1</button>
    </div>
</body>
<script src="../lib/vue/vue_v2.6.14.js"></script>
<script>
    const vm = new Vue({
        "el": "#app",
        data: {
            "count": 0,
        },
        // methods里面定义事件处理函数
        methods: {
            // 完整写法
            addCount: function() {
                this.count += 1
                console.log("add count")
            },

            // 简写写法
            subCount() {
                this.count -= 1
                console.log("sub count")
            }
        }
    })
</script>

</html>
```

#### 6.2 methods中函数写法

> 在vue的实例对象中
>
> - methods里定义处理函数，推荐使用简写写法，就是`函数名 小括号 花括号`

#### 6.3 this访问数据源的数据

> 在vue的methods中定义了处理函数，如何来访问修改vue实例对象中的数据源的数据呢？
>
> - 可以使用`this`关键字
>     - 类比到python中就是，在同一个实例对象中，可以使用`self关键字+点号`的方式一直访问这个对象的所有数据和方法，`self`就表示是这个实例对象本身
>     - 那么在同一个vue实例对象中，就可以用`this.数据源中的数据`来访问vue实例对象的数据源中的数据

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <div id="app">
        <p>count的值:{{count}}</p>
        <button v-on:click="addCount">+1</button>
        <button v-on:click="subCount">-1</button>
    </div>
</body>
<script src="../lib/vue/vue_v2.6.14.js"></script>
<script>
    const vm = new Vue({
        "el": "#app",
        data: {
            "count": 0,
        },
        // methods里面定义事件处理函数
        methods: {
            // 完整写法
            addCount: function() {
                console.log("add count")
                console.log(vm)
            },

            // 简写写法
            subCount() {
                console.log("sub count")
            }
        }
    })
</script>

</html>
```

> 在上面代码中，vue实例对象的methods里的addCount方法中打印了`vm`这个常量，下面是vm的值
>
> vm值可以看出来
>
> - 数据源中的`count`是vm这个实例对象的一个属性
> - 数据源中的`addCount`、`subCount`是vm这个实例对象的方法
> - 所以`count`、`addCount`、`subCount`对于vm实例对象来说，都可以用点的方式来调用

![image-20220712165856891](vue%E7%AC%94%E8%AE%B0/image-20220712165856891.png)

> 既然数据源中的`count`是`vm`这个实例对象的一个属性，那么在`addCount`方法里就可以通过`vm.count`访问到`data`里的`count`值

```javascript
// 部分代码
<script>
    const vm = new Vue({
        "el": "#app",
        data: {
            count: 10
        },
        // methods里面定义事件处理函数
        methods: {
            // 简写写法
            addCount() {
                console.log("vm.count的值" + vm.count)
            }
        }
    })
</script>
```

![image-20220713141257962](vue%E7%AC%94%E8%AE%B0/image-20220713141257962.png)

> 不过vue中不推荐使用`vm`这个实例对象来访问属性或方法，而是使用`this`
>
> 从执行结果可以看到`vm`和`this`是`全等的`，那么就可以用`this`来代替`vm`访问`vm`这个实例对象里的属性和方法
>
> 注意：
>
> - 用`console.log(vm === this)`时，一定不能在括号里再用`+号`拼接任何内容，否则返回结果是`false`

```javascript
<script>
    const vm = new Vue({
        "el": "#app",
        data: {
            count: 10
        },
        // methods里面定义事件处理函数
        methods: {
            // 简写写法
            addCount() {
                console.log("vm.count的值" + vm.count)
                // 判断vm是否全等于this
                console.log(vm === this)
            }
        }
    })
</script>
```

![image-20220713141949894](vue%E7%AC%94%E8%AE%B0/image-20220713141949894.png)

> 使用`this`访问属性，从执行结果来看，`this.count`和`vm.count`获取到的值一样

```javascript
// 部分代码
<script>
    const vm = new Vue({
        "el": "#app",
        data: {
            count: 10
        },
        // methods里面定义事件处理函数
        methods: {
            // 简写写法
            addCount() {
                console.log("vm.count的值" + vm.count)
                console.log(vm === this)
                console.log("this.count:" + this.count)
            }
        }
    })
</script>
```

![image-20220713142323371](vue%E7%AC%94%E8%AE%B0/image-20220713142323371.png)

#### 6.4 事件绑定传参

> 在事件绑定时，可以对绑定函数进行传递参数，那么对应的`vue`实例对象里的`methods`中定义的事件绑定函数就要定义形参

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <div id="app">
        <p>count的值:{{count}}</p>
        <!-- 因为addCount函数接收一个形参n，那么在调用时就需要传递一个实参，比如2 -->
        <button v-on:click="addCount(2)">+n</button>
    </div>
</body>
<script src="../lib/vue/vue_v2.6.14.js"></script>
<script>
    const vm = new Vue({
        "el": "#app",
        data: {
            count: 10
        },
        // methods里面定义事件处理函数
        methods: {
            // addCount函数接收一个形参n
            addCount(n) {
                this.count += n
                console.log("this.count:" + this.count)
            }
        }
    })
</script>

</html>
```

![image-20220713143104644](vue%E7%AC%94%E8%AE%B0/image-20220713143104644.png)

> 从上面代码可以看出来，`addCount`函数接收一个形参n，那么在调用时就需要传递一个实参，比如2，那么每次点击`+n`这个事件，那么每次的count值都是递增+2

#### 6.5 v-on简写格式

> v-on使用的非常多，vue提供了简写方式`@`
>
> 注意：
>
> - 原生DOM对象有`onclick`、`oninput`、`onkeyup`等原生事件，替换为vue的事件绑定后，对应的为
>     - v-on:click
>     - v-on:input
>     - v-on:keyup

```html
<body>
    <div id="app">
        <p>count的值:{{count}}</p>
        <!-- 因为addCount函数接收一个形参n，那么在调用时就需要传递一个实参，比如2 -->
        <button @click="addCount(2)">+n</button>
    </div>
</body>
```

![image-20220713143351140](vue%E7%AC%94%E8%AE%B0/image-20220713143351140.png)

> 执行结果和`事件绑定传参`看到的结果一样，`count`的值都是递增+2

#### 6.6 $event参数(不常用)

##### 6.6.1 只有一个形参

> 当事件绑定函数里有一个形参时：
>
> - 此时在div中调用该事件函数，但是`不传递任何实参`，此时事件函数里的形参值是有一个默认的值，比如时间绑定函数形参定义为`e`，那么`e`是的值是`MouseEvent`，也就是说e有一个自己的默认值
>     - `MouseEvent`中有一个`target`属性，可以对元素进行样式的修改
> - 此时在div中调用该事件函数，但是`传递了一个实参`，那么上面的默认值就没有了，传进来的实参是什么，那么e就是什么
>     - 就是传参了，e的值就会被覆盖为传进来的值

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <div id="app">
        <p>count的值:{{count}}</p>
        <!-- 事件绑定函数有形参时，不传值，那么事件绑定函数默认接收一个e参数 -->
        <button @click="addCount">+1</button>
    </div>
</body>
<script src="../lib/vue/vue_v2.6.14.js"></script>
<script>
    const vm = new Vue({
        "el": "#app",
        data: {
            count: 10
        },
        // methods里面定义事件处理函数
        methods: {
            // addCount函数
            addCount(e) {
                console.log(e)
                this.count += 1

                if (this.count % 2 === 0) {
                    e.target.style.backgroundColor = 'red'
                } else {
                    e.target.style.backgroundColor = ''
                }

            }
        }
    })
</script>

</html>
```

![image-20220713230638028](vue%E7%AC%94%E8%AE%B0/image-20220713230638028.png)

![image-20220713230651420](vue%E7%AC%94%E8%AE%B0/image-20220713230651420.png)

> 代码分析:
>
> - 代码其实逻辑就是点击按钮时，当`count`值是偶数时，按钮颜色变为红色，为奇数不变色
> - 能够看到e其实就是`MouseEvent`，每次点击时，e的值都同一个

##### 6.6.2 有2个以上形参

> vue提供了内置变量，固定写法:`$event`
>
> - 即想传入一个实参，还想传`MouseEvent`参数，那么就可以就在调用事件函数时，将`$event`传进去
> - 相应的vue实例对象的methods中，用形参e(约定成俗)来接收就可以了

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <div id="app">
        <p>count的值:{{count}}</p>
        <!-- 事件绑定函数有形参时，不传值，那么事件绑定函数默认接收一个e参数 -->
        <button @click="addCount(1, $event)">+1</button>
    </div>
</body>
<script src="../lib/vue/vue_v2.6.14.js"></script>
<script>
    const vm = new Vue({
        "el": "#app",
        data: {
            count: 10
        },
        // methods里面定义事件处理函数
        methods: {
            // addCount函数
            addCount(n, e) {
                console.log(e)
                this.count += n

                if (this.count % 2 === 0) {
                    e.target.style.backgroundColor = 'red'
                } else {
                    e.target.style.backgroundColor = ''
                }

            }
        }
    })
</script>

</html>
```

> 执行结果和只有一个形参一致

#### 6.7 事件修饰符

> vue提供了事件修饰符的功能，可以更方便的控制事件

| 事件修饰符 | 说明                                                         |
| ---------- | ------------------------------------------------------------ |
| .prevent   | 阻止默认行为，比如阻止a链接跳转，表单的提交等等              |
| .stop      | 阻止事件冒泡（当页面有父子关系的标签时，只想打印子标签里面的内容，如果没有阻止，就会在打印子里面的内容时，也把父标签的内容也打印出来，为了不出现这种情况，就需要阻止事件冒泡） |

#### 6.8 按键修饰符

> 监听键盘事件时，需要判断详细的按键内容，此时就可以用按键修饰符

```javascript
// 当按键是enter时，调用vue实例对象中的submit()方法
<input @keyup.enter="submit">
    
// 当按键是esc时，调用vue实例对象中的clearInput()方法
<input @keyup.esc="clearInput"> 
```

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <div id="app">
        提交数据:<input type="text" @keyup.enter="subData">
        <br> 清空数据:
        <input type="text" @keyup.esc="clearInput">
    </div>
</body>
<script src="../lib/vue/vue_v2.6.14.js"></script>
<script>
    const vm = new Vue({
        "el": "#app",
        data: {
            count: 10
        },
        // methods里面定义事件处理函数
        methods: {
            subData() {
                console.log("按了回车enter键")
            },
            clearInput(e) {
                console.log("按了清除esc键")
                e.target.value = ''
            }

        }
    })
</script>

</html>
```

![image-20220713235122466](vue%E7%AC%94%E8%AE%B0/image-20220713235122466.png)





### 7、双向绑定

#### 7.1 v-model用法

> vue提供了`v-model双向数据绑定`指令，用来在不操作DOM的前提下，快速获取表单数据

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <div id="app">
        <p>用户名:{{ username }}</p>
        <input type="text" v-model="username">
    </div>
</body>
<script src="../lib/vue/vue_v2.6.14.js"></script>
<script>
    const vm = new Vue({
        "el": "#app",
        data: {
            username: "sam"
        },
        // methods里面定义事件处理函数
        methods: {}
    })
</script>

</html>
```

![image-20220713235608487](vue%E7%AC%94%E8%AE%B0/image-20220713235608487.png)

> 上述代码分析：
>
> - p标签中的username值来自于data中的username，同时给p标签设置了一个`v-model`属性，并且指向了username
>     - 首先页面会将data里的username值渲染到页面上
>     - 当input输入框中的内容有改变时，vue会实时感知到，然后逆向再渲染到p标签中，这样data中的username值就变成了在input输入框中输入的内容，这样达到了不操作DOM就采集到表单标签的值的功能，这样vue实例里就可以通过`this`访问到实时更新的值
>
> 注意：
>
> - 表单元素才可以使用`v-model`
>     - 表单元素有：
>         - input输入框
>         - textarea(大文本输入框)
>         - select（下拉选择框标签）

#### 7.2 v-model在select使用

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <div id="app">
        <select v-model='city'>
            <option value="">请选择城市</option>
            <option value="1">北京</option>
            <option value="2">上海</option>
            <option value="3">河北</option>
        </select>
        <button @click='subData'>提交</button>
    </div>
</body>
<script src="../lib/vue/vue_v2.6.14.js"></script>
<script>
    const vm = new Vue({
        "el": "#app",
        data: {
            username: "sam",
            city: ''
        },
        // methods里面定义事件处理函数
        methods: {
            subData() {
                console.log('city:' + this.city)
            }
        }
    })
</script>

</html>
```

![image-20220714001206382](vue%E7%AC%94%E8%AE%B0/image-20220714001206382.png)



#### 7.3 v-model修饰符

> 为了对用户输入内容更方便处理，v-model提供了三个修饰符

| 修饰符  | 作用说明                       |
| ------- | ------------------------------ |
| .number | 自动将用户的输入值转为数值类型 |
| .trim   | 自动过滤用户输入的首尾空白字符 |
| .lazy   | 在“change”时而非“input”时更新  |

##### 7.3.1 number修饰符

> 当从input获取到的值转为int时，就可以用number
>
> 下面的加法例子，如果没有`.number`修饰符，那么再输入其他数字，结果就会变为字符串拼接而不是加法

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <div id="app">
        <input type="text" v-model.number='n1'> + <input type="text" v-model.number='n1'> = <span>{{ n1 + n2 }}</span>
    </div>
</body>
<script src="../lib/vue/vue_v2.6.14.js"></script>
<script>
    const vm = new Vue({
        "el": "#app",
        data: {
            n1: 2,
            n2: 2
        },
        // methods里面定义事件处理函数
        methods: {

        }
    })
</script>

</html>
```

![image-20220714002119320](vue%E7%AC%94%E8%AE%B0/image-20220714002119320.png)



##### 7.3.2 trim修饰符

> 将表单获取的数据，去除首尾空白字符

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <div id="app">
        <input type="text" v-model.trim='username'>
        <button @click='getUserName'>获取用户名</button>
    </div>
</body>
<script src="../lib/vue/vue_v2.6.14.js"></script>
<script>
    const vm = new Vue({
        "el": "#app",
        data: {
            username: ""
        },
        // methods里面定义事件处理函数
        methods: {
            getUserName() {
                console.log(this.username)
            }
        }
    })
</script>

</html>
```

![image-20220714002706450](vue%E7%AC%94%E8%AE%B0/image-20220714002706450.png)





##### 7.3.3 lazy修饰符

> 当输入内容只想在失去焦点时才同步给vue，那么就可以使用`.lazy`修饰符，因为vue双向绑定实时的，每次更新肯定会有性能损耗，当不需要这样，就可以使用lazy

```html
<body>
    <div id="app">
        <input type="text" v-model.lazy='username'>
        <button @click='getUserName'>获取用户名</button>
    </div>
</body>
```

![image-20220714002922976](vue%E7%AC%94%E8%AE%B0/image-20220714002922976.png)



### 8、条件渲染指令

> 条件渲染指令可以根据条件来控制DOM的显示与隐藏
>
> 有两个指令：
>
> - v-if
> - v-show

#### 8.1 v-if

> `v-if`原理：每次动态创建或移除元素，实现元素的显示和隐藏

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <div id="app">
        <p v-if='flag'>这是被v-if控制</p>
    </div>
</body>
<script src="../lib/vue/vue_v2.6.14.js"></script>
<script>
    const vm = new Vue({
        "el": "#app",
        data: {
            flag: true
        },
        // methods里面定义事件处理函数
        methods: {}
    })
</script>

</html>
```

![image-20220714103146845](vue%E7%AC%94%E8%AE%B0/image-20220714103146845.png)

![image-20220714103158870](vue%E7%AC%94%E8%AE%B0/image-20220714103158870.png)

> 从上面控制台的vue列和Elements列可以看出，当flag为true时，v-if的p标签就显示出来了
>
> 那把flag改为false时，可以看到整个v-if的p标签直接被移除了

![image-20220714103408859](vue%E7%AC%94%E8%AE%B0/image-20220714103408859.png)

![image-20220714103340885](vue%E7%AC%94%E8%AE%B0/image-20220714103340885.png)

#### 8.2 v-show

> `v-show`原理：动态为元素添加或移除`display: none`样式，实现元素的显示和隐藏

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>

<body>
    <div id="app">
        <p v-show='flag'>这是被v-show控制</p>
    </div>
</body>
<script src="../lib/vue/vue_v2.6.14.js"></script>
<script>
    const vm = new Vue({
        "el": "#app",
        data: {
            flag: true
        },
        // methods里面定义事件处理函数
        methods: {}
    })
</script>

</html>
```

![image-20220714103445240](vue%E7%AC%94%E8%AE%B0/image-20220714103445240.png)



![image-20220714103506521](vue%E7%AC%94%E8%AE%B0/image-20220714103506521.png)



> 从上面控制台的vue列和Elements列可以看出，当flag为true时，v-show的p标签就显示出来了
>
> 那把flag改为false时，可以看到整个v-show的p标签没有被移除，而是加了`display: none`的属性达到隐藏的效果

![image-20220714103612563](vue%E7%AC%94%E8%AE%B0/image-20220714103612563.png)

![image-20220714103624008](vue%E7%AC%94%E8%AE%B0/image-20220714103624008.png)

