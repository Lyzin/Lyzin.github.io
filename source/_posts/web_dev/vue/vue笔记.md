---
title: VUE笔记
date: 2022-07-08 11:39:30
updated: 2022-07-08 11:39:30
tags: VUE
cover: /posts_cover_img/web_dev/vue_logo.png
categories: VUE笔记
---

## 一、vue介绍

> [https://www.bilibili.com/video/BV1zq4y1p7ga?p=75&vd_source=501c3f3a75e1512aa5b62c6a10d1550c](https://www.bilibili.com/video/BV1zq4y1p7ga?p=75&vd_source=501c3f3a75e1512aa5b62c6a10d1550c)

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

### 1、第一行vue代码

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

#### 3.2 插值表达式

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

### 4、属性绑定指令(重要)

> 如果需要给元素的属性`动态绑定属性值`，就需要用到`v-bind`属性绑定指令
>
> 什么时候使用使用属性绑定指令？
>
> - 为元素的属性动态添加值时，就要考虑使用属性绑定指令了
> - 任何元素需要使用动态值时，就可以使用属性绑定指令，这样属性就可以动态的接收值，达成了动态的展示不同的数据
>   - 比如要给`input`的`placholder`动态绑定值，就在`placholder`前面加一个`v-bind`或`:`，表示`placholder`属性的值时vue的数据源动态赋予的，达成了复用的效果
>
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

### 5、JS语法在指令中的使用

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

> vue中的`v-on`事件绑定指令，用来协助为DOM元素绑定事件监听，绑定的及时可执行函数

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

#### 6.3 this访问数据源数据

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
> - 既想传入一个实参，还想传`MouseEvent`参数，那么就可以就在调用事件函数时，将`$event`传进去
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

#### 8.3 v-else-if

> 相当于是用v-if的一个分支，但是必须要和`v-if`配套使用，否则不会被识别

```html
<body>
    <div id="app">
        <div v-if="count === 1">1级</div>
        <div v-else-if="count === 2">2级</div>
        <div v-else="count === 3">3级</div>
    </div>
</body>
<script src="../lib/vue/vue_v2.6.14.js"></script>
<script>
    const vm = new Vue({
        "el": "#app",
        data: {
            flag: true,
            count: 1
        }
    })
</script>
```

![image-20220725232754842](vue%E7%AC%94%E8%AE%B0/image-20220725232754842.png)

### 9、列表渲染指令

#### 9.1 v-for

> 主要是用来将数组循环渲染成一个列表的结构
>
> v-for用`item in items`形式的语法
>
> - `items`是待循环的数组
> - `item`是被循环的每一项
>
> 需要循环哪个DOM结构，就给那个页面结构加v-for，所以v-for在标签元素的后面紧跟，就代表需要循环标签元素，所以一定注意需要跟在`<标签元素`的后面

```html
# 举例
<li v-for="item in userinfos">name: {{ item.name }}</li>

# vue代码
<script>
    const vm = new Vue({
        "el": "#app",
        data: {
            userinfo: [{
                id: 1,
                name: "Sam"
            }, {
                id: 2,
                name: "Jam"
            }, {
                id: 3,
                name: "Tom"
            }, ]
        }
    })
```

#### 9.2 v-for支持索引

> v-for支持可选的第二个参数，也就是当前项的索引
>
> `(item, index) in items`
>
> 注意：
>
> - v-for中的`item`项和`index`索引都是形参，所以可以替换成别的形参名
> - 索引是按需添加，不强制

```html
# 举例
<li v-for="(item, index) in userinfos">index:{{ index }}, name: {{ item.name }}</li>

# vue代码
<script>
    const vm = new Vue({
        "el": "#app",
        data: {
            userinfo: [{
                id: 1,
                name: "Sam"
            }, {
                id: 2,
                name: "Jam"
            }, {
                id: 3,
                name: "Tom"
            }, ]
        }
    })
```

> 示例

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        li {
            list-style: none;
        }
        
        table {
            border-collapse: collapse;
            width: 200px;
            height: 160px;
        }
        
        table,
        th,
        td {
            border: 1px solid black;
            text-align: center;
        }
    </style>
</head>

<body>
    <div id="app">
        <table>
            <thead>
                <th>index</th>
                <th>id</th>
                <th>name</th>
            </thead>
            <tr v-for="(item, index) in userinfo">
                <td>索引:{{ index }}</td>
                <td>{{ item.id }}</td>
                <td>{{ item.name }}</td>
            </tr>
        </table>
    </div>
</body>
<script src="../lib/vue/vue_v2.6.14.js"></script>
<script>
    const vm = new Vue({
        "el": "#app",
        data: {
            userinfo: [{
                id: 1,
                name: "Sam"
            }, {
                id: 2,
                name: "Jam"
            }, {
                id: 3,
                name: "Tom"
            }, ]
        }
    })
</script>

</html>
```

![image-20220725234559909](vue%E7%AC%94%E8%AE%B0/image-20220725234559909.png)

#### 9.3 v-for推荐添加key

> vue官方推荐，只要用到了v-for指令，那么一定要绑定一个`:key`属性，
>
> key值注意事项：
>
> - 对于key的值只能是字符串或数字类型
> - 并且key的值不能重复，否则会报`Duplicate keys detected`的错误
> - 并且尽量以`当前循环项的id`作为`key`的值
> - 不推荐`index`作为key的值，会出现数据错乱
>     - 原因是如果添加数据时，添加数据成功以后，当前数据的索引值会变化，所以索引就不唯一了，并且和数据不是唯一绑定的，只有id才是和数据唯一绑定的
> - 指定key可以提升性能，放置列表错乱

```html
<body>
    <div id="app">
        <table>
            <thead>
                <th>index</th>
                <th>id</th>
                <th>name</th>
            </thead>
            <!-- v-for绑定key属性， 推荐以id作为key的值 -->
            <tr v-for="(item, index) in userinfo" :key="item.id">
                <td>索引:{{ index }}</td>
                <td>{{ item.id }}</td>
                <td>{{ item.name }}</td>
            </tr>
        </table>
    </div>
```

## 三、npm使用

### 1、npm使用虚拟环境

> npm可以像python一样，使用虚拟环境来管理多个版本的node，可以在电脑中安装多个版本的node以及npm，方便我们使用
>
> nvm就是一款可以支持多个版本node和npm的工具，官网:https://github.com/nvm-sh/nvm

> 下图是nvm安装的情况，可以看到有个"- >"表示当前使用的npm版本，当然nvm可以使用其他版本，具体使用查看nvm的官方地址即可

![image-20230529212053843](vue笔记/image-20230529212053843.png)

### 2、nrm管理镜像仓库

> nrm是用来对npm的镜像仓库进行管理的工具，官网：https://github.com/Pana/nrm

> 对于nrm查看镜像列表没有显示星号的解决办法

```javascript
# 打开安装nrm目录下找到cli.js，一般是在虚拟环境的目录：~/.nvm/versions/node/v16.20.0/lib/node_module/nrm
# 找到如下代码，将&&换成||，然后保存退出
 if (hasOwnProperty(customRegistries, name) && (name in registries || customRegistries[name].registry === registry.registry)) {
                    registry[FIELD_IS_CURRENT] = true;
                    customRegistries[name] = registry;
                }
```

> 星号表示当前的npm镜像仓库是什么，我们可以对其进行增加，后续切换镜像仓库会非常方便

![image-20230529212549870](vue笔记/image-20230529212549870.png)

### 3、查看npm的仓库镜像源

```bash
npm config ls -l
```

![image-20230529213919046](vue笔记/image-20230529213919046.png)

## 四、vue-cli介绍

### 1、vue-cli介绍

> vue-cli是vue.js开发的标准工具，简化基于webpack创建工程化vue项目的过程
>
> 网址：[https://cli.vuejs.org/zh](https://cli.vuejs.org/zh)

> 以下来源于vue-cli官网
>
> Vue CLI 是一个基于 Vue.js 进行快速开发的完整系统，提供：
>
> - 通过 `@vue/cli` 实现的交互式的项目脚手架。
> - 通过 `@vue/cli` + `@vue/cli-service-global` 实现的零配置原型开发。
> - 一个运行时依赖 (@vue/cli-service)，该依赖：
>     - 可升级；
>     - 基于 webpack 构建，并带有合理的默认配置；
>     - 可以通过项目内的配置文件进行配置；
>     - 可以通过插件进行扩展。
> - 一个丰富的官方插件集合，集成了前端生态中最好的工具。
> - 一套完全图形化的创建和管理 Vue.js 项目的用户界面。
>
> Vue CLI 致力于将 Vue 生态中的工具基础标准化。它确保了各种构建工具能够基于智能的默认配置即可平稳衔接，这样你可以专注在撰写应用上，而不必花好几天去纠结配置的问题。与此同时，它也为每个工具提供了调整配置的灵活性，无需 eject。

#### 1.1 vue-cli组件

> Vue CLI 有几个独立的部分——如果你看到了我们的[源代码](https://github.com/vuejs/vue-cli/tree/dev/packages/%40vue)，你会发现这个仓库里同时管理了多个单独发布的包。

##### 1.1.1 CLI

> CLI (`@vue/cli`) 是一个全局安装的 npm 包，提供了终端里的 `vue` 命令。它可以通过 `vue create` 快速搭建一个新项目，或者直接通过 `vue serve` 构建新想法的原型。你也可以通过 `vue ui` 通过一套图形化界面管理你的所有项目。我们会在接下来的指南中逐章节深入介绍。

##### 1.1.2 CLI服务

> CLI 服务 (`@vue/cli-service`) 是一个开发环境依赖。它是一个 npm 包，局部安装在每个 `@vue/cli` 创建的项目中。
>
> CLI 服务是构建于 [webpack](http://webpack.js.org/) 和 [webpack-dev-server](https://github.com/webpack/webpack-dev-server) 之上的。它包含了：
>
> - 加载其它 CLI 插件的核心服务；
> - 一个针对绝大部分应用优化过的内部的 webpack 配置；
> - 项目内部的 `vue-cli-service` 命令，提供 `serve`、`build` 和 `inspect` 命令

### 2、vue-cli安装和卸载

#### 2.1 vue-cli安装

> 安装vue-cli需要对node有版本要求
>
> Vue CLI 4.x
>
> - 需要[Node.js](https://nodejs.org/) v8.9 或更高版本 (推荐 v10 以上)
> - 可以使用 [n](https://github.com/tj/n)，[nvm](https://github.com/creationix/nvm) 或 [nvm-windows](https://github.com/coreybutler/nvm-windows) 在同一台电脑中管理多个 Node 版本。

```bash
npm install -g @vue/cli
```

![image-20220727132545206](vue%E7%AC%94%E8%AE%B0/image-20220727132545206.png)

> 如果已经安装过了，会提示下方报错

![image-20220727131119691](vue%E7%AC%94%E8%AE%B0/image-20220727131119691.png)

> 安装之后，就可以在命令行中访问 vue 命令

```bash
# 可以通过简单运行 vue，看看是否展示出了一份所有可用命令的帮助信息，来验证它是否安装成功。
vue
```

![image-20220727132629020](vue%E7%AC%94%E8%AE%B0/image-20220727132629020.png)

> 还可以用这个命令来检查其版本是否正确

```bash
vue -V
```

![image-20220727132657452](vue%E7%AC%94%E8%AE%B0/image-20220727132657452.png)

#### 2.2 vue-cli卸载

```bash
# vue-cli2版本
npm uninstall vue-cli -g

# vue-cli3版本
npm uninstall @vue/cli -g
```

### 3、vue初体验

#### 3.1 创建第一个vue项目

> 使用vue-cli创建工程化的vue项目，vue2项目和vue3项目创建的步骤一模一样，就是vue版本选择时不同，所以下面的步骤是以vue2为例子来创建vue项目，vue3也同样适用
>

```bash
# 进入需要存放项目的目录，使用命令行来创建vue项目，注意create后面跟的就是项目的文件夹名称
vue create tester-tools
```

![image-20220727133457863](vue%E7%AC%94%E8%AE%B0/image-20220727133457863.png)

> 可以看到有两个提示
>
> - 第一个提示是询问我们需要更换npm的镜像源吗？可以选否
> - 第二个提示是询问`pick a preset`，表示`请选择预设`，可以用上下箭头选择
>     - 如果选择`Default ([Vue 3] babel, eslint) `，会自动安装vue3，并安装`babel、eslint`
>     - 如果选择`Default ([Vue 2] babel, eslint) `，会自动安装vue2，并安装`babel、eslint`
> - 建议选择`Manually select features`，表示手动选择需要的功能，这样定制更高

![image-20220727133956649](vue%E7%AC%94%E8%AE%B0/image-20220727133956649.png)

> 可以看到有很多选项，有选中的表示已经选择了该功能
>
> - Babel解决js兼容性，必须`选中`
> - TypeScript是微软的一种js语言，可以`不选`
> - Progressive Web App (PWA) Support是渐进式的框架，可以`不选`
> - Router是路由，可以`不选`
> - Vuex，可以`不选`
> - CSS Pre-processors是css预处理器，建议`选中`，
>     - 使用空格就可以选中
> - Linter / Formatter是代码风格，可以`不选`
>     - 如果团队中有人用双引号，有人用单引号，那么这个工具就会报错，项目跑步起来，所以这个插件建议不安装
> - Unit Testing是单元测试，可以`不选`
> - E2E Testing是端对端测试，可以`不选`
>
> 最终选择完的结果如下

![image-20220727134848045](vue%E7%AC%94%E8%AE%B0/image-20220727134848045.png)

> 选择好以后，按`回车`进行下一步，会提示选择vue的版本
>

![image-20220727134950708](vue%E7%AC%94%E8%AE%B0/image-20220727134950708.png)

> 选择CSS预处理，这里选择`less`后回车

![image-20220727135106581](vue%E7%AC%94%E8%AE%B0/image-20220727135106581.png)

![image-20230529211111443](vue笔记/image-20230529211111443.png)

> 接下来继续提示下面的插件的配置文件想放到package.json，还是放到插件的独立的配置文件
>
> - 这里建议选择插件的独立的配置文件，这样可以更加独立的维护
> - 因为package.json是项目依赖的管理文件，肯定不希望这些插件的配置信息在里面

![image-20220727135415371](vue%E7%AC%94%E8%AE%B0/image-20220727135415371.png)

> 此时会提示：是否想当前预设保存给未来的项目，这里可以选择否，输入`N`，后面创建vue项目可以自定义选择别的插件
>
> - 也可以选择`y`，当前配置就会给后面创建项目的时候来使用

![image-20220727135533651](vue%E7%AC%94%E8%AE%B0/image-20220727135533651.png)

> 接着会提示，选择安装依赖的包管理器，可选`Yarn`或`NPM`，这里可以选择`NPM`
>
> 选择`NPM`后，就会开始创建项目了

![image-20220727135923350](vue%E7%AC%94%E8%AE%B0/image-20220727135923350.png)

> 到这第一个vue项目就创建好了

#### 3.2 运行第一个vue项目

> 从上面的创建好vue项目后的提示可以看到提示了我们如何运行项目

```bash
# 切换到项目目录
$ cd tester-tools

# 启动项目
$ npm run serve
```

![image-20220727140349959](vue%E7%AC%94%E8%AE%B0/image-20220727140349959.png)

> 从上面的启动项目可以看出来
>
> - vue项目先启动了开发服务器
>     - 从这句话就可以看出来：`INFO  Starting development server...`
> - 应用运行在本地和网络地址也提示出来了
>       - Local:http://localhost:8080/
>         - 表示本机IP和端口
>       - Network: http://10.1.108.84:8080
>         - 表示网络IP和端口

> 那访问下本机的IP和端口，看下我们创建的第一个vue项目，浏览器打开`http://localhost:8080/`

![image-20220727140704208](vue%E7%AC%94%E8%AE%B0/image-20220727140704208.png)

> 可以看到浏览器打开是VUE的默认欢迎页面，那么我们的第一个vue项目就启动成功了
>
> 注意：
>
> - `npm run serve`这个窗口不要关闭，关闭了上面访问`http://localhost:8080/`就无法访问了

#### 3.3 vue项目结构

> 上面我们成功的创建并启动了第一个vue项目，下面来分析下vue项目的目录结构，更加充分了解vue项目
>
> 从下面截图可以看出，vue项目基本分为下面几个目录
>
> - node_modules
> - public
> - src

![image-20220727141741534](vue%E7%AC%94%E8%AE%B0/image-20220727141741534.png)

##### 3.3.1 src目录

> src目录，见名知意也知道是`source`源码的意思，表示所有写的代码都在这个目录下

![image-20220727150745362](vue%E7%AC%94%E8%AE%B0/image-20220727150745362.png)

> src目录的目录结构
>
> - assets目录
>     - 项目中的静态资源，包括图片、css样式表
>
> - components（`重要`）
>     - 将`封装好`、`可复用`的组件放到`components`目录中
> - App.vue
>     - 项目的根组件
>     - 定义页面的UI结构
> - main.js
>     - 是项目入口文件，整个项目运行时，优先运行`main.js`

##### 3.3.2 public目录

> public目录，公共目录，里面存储了存放公共内容的目录，常见的内容有
>
> - `favicon.ico`，网站的icon
> - `index.html`，单页面项目，所有内容都是在`index.html`里面

```html
<template>
  <div id="app">
    <img alt="Vue logo" src="./assets/logo.png">
    <!-- <HelloWorld msg="Welcome to Your Vue.js App"/> -->
    <HelloWorld msg="欢迎来到VUE项目"/>
  </div>
</template>

<script>
import HelloWorld from './components/HelloWorld.vue'

export default {
  name: 'App',
  components: {
    HelloWorld
  }
}
</script>

<style lang="less">
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
```

> 可以看到里面有div，id是app，就和实例化vue里传递给`el`属性的值是同一个，vue控制的就是这个`div`块

##### 3.3.3 node_modules目录

> 下载的第三方包的存储目录，所以这个目录尽量不需要传到git管理仓库，否则项目目录的磁盘占用会很大

#### 3.4 vue运行流程

> 工程化的vue项目，vue的功能
>
> - 核心概念：通过`src/main.js`将`src/components/App.vue`的页面UI结构渲染到`index.html`的指定区域中
>     - `App.vue`用来编写需要被渲染的模板结构
>     - `index.html`中预留一个`el`区域
>     - `main.js`把`App.vue`的页面UI结构渲染到`index.html`预留的`el`区域

> 下面是vue2中的main.js的文件内容

```js
// 下面是src/main.js文件的内容
import Vue from 'vue'

// 导入App.vue组件，将来要把App.vue中的模板结构渲染到html页面中去
import App from './App.vue'

Vue.config.productionTip = false

// 创建vue实例对象
new Vue({
  // 把render函数指向的组件，渲染到html页面中去
  render: h => h(App),
}).$mount('#app')
```

> 下面是vue3中的main.js的文件内容

```javascript
// 导入vue包，得到createApp
import { createApp } from 'vue'
import App from './App.vue'

createApp(App).mount('#app')
```

> 下面是src/components/App.vue文件的内容

```vue
<template>
  <div id="app">
    <img alt="Vue logo" src="./assets/logo.png">
    <!-- <HelloWorld msg="Welcome to Your Vue.js App"/> -->
    <HelloWorld msg="欢迎来到VUE项目"/>
  </div>
</template>

<script>
import HelloWorld from './components/HelloWorld.vue'

export default {
  name: 'App',
  components: {
    HelloWorld
  }
}
</script>

<style lang="less">
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
```

```html
# 下面代码是public/index.html
<!DOCTYPE html>
<html lang="">
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width,initial-scale=1.0">
    <link rel="icon" href="<%= BASE_URL %>favicon.ico">
    <title><%= htmlWebpackPlugin.options.title %></title>
  </head>
  <body>
    <noscript>
      <strong>We're sorry but <%= htmlWebpackPlugin.options.title %> doesn't work properly without JavaScript enabled. Please enable it to continue.</strong>
    </noscript>
    
    <!-- 这里是需要被渲染的div区域 -->
    <div id="app"></div>
    <!-- built files will be auto injected -->
  </body>
</html>
```

> 注意:
>
> - main.js中的render函数把`App.vue`的页面结构渲染给`index.html`时，`render函数`本质会将`App.vue`里UI结构，完全替换index.html里的`<div id="app"></div>`这一块，相当于是全部替换了，此时去查看页面结构，会发现没有id为`app`的div块，显示的页面结构是`App.vue`里的页面结构内容

![image-20220727162915860](vue%E7%AC%94%E8%AE%B0/image-20220727162915860.png)

##### 3.4.1 main.js中的vue实例对象

> - vue实例vue对象时，都会传一个`el`属性指向`#app`
>
> - 但是在`main.js`中这个属性没有了，但是可以看到render函数后面有一个`$mount(“#app”)`
>     - `$mount(“#app”)`作用就是和`el`属性都完全一样的，表示绑定了id为app的div块

## 五、组件(component)

### 1、vue组件化开发

#### 1.1 vue组件化开发

> 根据封装的意思，将页面上可`重用`的UI结构封装为组件，进而方便项目的开发和维护
>
> vue本身是支持组件化开发的框架
>
> vue中规定
>
> - 组件的文件后缀名是`.vue`
>     - 第一个vue项目的`src/App.vue`这个文件就是一个vue组件

#### 1.2 vue组件开发三部曲

> 每个`xxx.vue`组件都由3部分组成，分别是：
>
> - template：组件的模板结构
> - script：组件的JavaScript行为
> - style：组件的样式
>     - 本质就是组件的css样式

##### 1.2.1 组件中的template节点

> vue规定每个组件对应的模板结构，需要定义到`<template>`节点
>
> 注意：
>
> - `<template>`节点是vue提供的容器标签，只能有包裹性质的作用，它不会被渲染为真正的DOM元素
> - 组件的`<template>`节点中支持所有的`指令语法`，比如：
>     - 插值表达式
>     - v-bind
>     - v-on
>     - v-for等等

```javascript
// 组件第一部分：template
<template>
    <div>
        <p>这是index.vue组件</p>
        <p>这是我的第一个组件</p>
        <p>username: {{ username }}</p>
    </div>
</template>
```

##### 1.2.2 组件中的script节点

> vue规定`<script>`节点是可选的，可以在`<script>`节点中封装组件的`javascript`业务逻辑

```javascript
<script>
    // 默认导出，固定写法
    export default {
    }
</script>
```

> 组件的script节点下name节点
>
> 可以通过name节点为当前组件定义一个名称，在使用vue-devtools进行调试时，自定义组件名称可以很清晰区分出来

```javascript
<script>
    // 默认导出，固定写法
    export default {
        // name表示当前组件的名称，规范为首字母大写
		name: "MyApp",
    }
</script>
```

> 组件的script节点下data节点表示需要被渲染的数据源
>
> 注意事项：
>
> - `xx.vue`组件中的data不能像之前vue实例对象里的一样，不能指向对象
> - 组件中的data必须是一个函数，然后data这个函数将数据源给返回

> 如果data数据源指向了对象，那么就会报错，报错如下

```javascript
<script>
    // 默认导出，固定写法
    export default {
    // data数据源，下面这么写vue会报错
		// data指向了一个对象，就会报错
        data: {
            username: "sam"
        }
    }
</script>
```

![image-20220727174142040](vue%E7%AC%94%E8%AE%B0/image-20220727174142040.png)

> 需要让data是一个函数，这样组件中的`template`区域才可拿到正确的数据

```javascript
<script>
    // 默认导出，固定写法
    export default {
        // data数据源
        // data数据源必须是一个函数
        data(){
            return {
                username: "sam"
            }
            
        }
    }
</script>
```

![image-20220727174527920](vue%E7%AC%94%E8%AE%B0/image-20220727174527920.png)

> 组件的script节点下methods节点
>
> 组件中定义methods方法和vue实例对象中一样，在`methods`中定义方法即可

```vue
<template>
    <div>
        <p>这是index.vue组件</p>
        <p>这是我的第一个组件</p>
        <br>
        <p>用户名{{ username }}</p>
        <button @click="showMsg">点击修改用户名</button>
    </div>
</template>

<script>
    // 默认导出，固定写法
    export default {
        // data数据源
        // data数据源必须是一个函数
        data(){
            return {
                username: "修改前是:admin"
            }
            
        },
        // methods中定义方法
        methods: {
            showMsg() {
                this.username = "修改后是:sam"
            }
        }

    }
</script>

<style>
    p {
        font-size: 24px;
        color: deeppink;
    }
</style>
```

![image-20220727175431493](vue%E7%AC%94%E8%AE%B0/image-20220727175431493.png)

> 组件中`methods`里的方法的`this`是什么？
>
> - 在vue组件中，`this`表示当前组件的实例对象
>     - 组件的实例对象中也有`username`属性，那么就可以直接用this来调用

![image-20220727175612828](vue%E7%AC%94%E8%AE%B0/image-20220727175612828.png)

##### 1.2.3 组件的style节点

> vue规定组件内`<style>`节点是可选的，在`<style>`节点中编写美化当前组件的UI结构
>
> `<style>`标签上的lang="css"属性是可选的，表示为所使用的样式语言，默认支持普通css语法，可选less、scss等

```javascript
<style>
    h1 {
        font-size: 14px;
    }

</style>
```

#### 1.3 vue组件注意事项

##### 1.3.1 vue组件的唯一根节点

> 在vue2.x中，`<template>`只能有一个根节点，否则会报错

```vue
# 下面在组件的template中定义了两个div，就会报错
<template>
    <div>
        <p>这是index.vue组件</p>
        <p>这是我的第一个组件</p>
        <br>
        <p>用户名{{ username }}</p>
        <button @click="showMsg">点击修改用户名</button>
    </div>
	<!-- 这里是第二个div，但是会报错 -->
    <div>
        <p>第二个div</p>
    </div>
</template>
```

![image-20220727231603798](vue%E7%AC%94%E8%AE%B0/image-20220727231603798.png)

> 在vue3.x中，`<template>`支持定义多个根节点

##### 1.3.2 启动less语法

> 在创建vue工程化项目时，选择了less插件，那如何在vue组件中启用less呢？如下代码

```css
<style lang="less">
    p {
        font-size: 24px;
        color: deeppink;
    }
</style>
```

### 2、组件的使用

#### 2.1 组件关系

> 组件创建好以后，彼此之间是相互独立的，不存在父子关系

![image-20220727232531377](vue%E7%AC%94%E8%AE%B0/image-20220727232531377.png)

> 组件嵌套后，才产生了父子关系、兄弟关系
>
> - 组件A嵌套了组件B和组件C，组件A和（组件B、组件C）是父子关系
> - 组件B和组件C是兄弟关系

![image-20220727232734321](vue%E7%AC%94%E8%AE%B0/image-20220727232734321.png)

> vue中注册组件分为下面两种方式
>
> - 全局注册：被全局注册的组件，可在全局任何一个组件内使用
> - 局部注册：被局部注册的组件，只能在当前注册的范围内使用

#### 2.2 使用组件三步骤

> 当组件写好以后，如何使用组件有三个步骤
>
> - 步骤一：在组件(`xxx.vue`的`script`节点中)中使用import语法导入需要的组件
> - 步骤二：在组件(`xxx.vue`的`script`节点中)中使用components节点注册组件
> - 步骤三：在组件(`xxx.vue`的`template`节点中)中以标签形式使用注册的组件

```vue
<template>
  <div>
    <!-- 步骤3：以标签形式使用注册的组件 -->
    <Card></Card>
  </div>
</template>

<script>
// 步骤1：导入components目录下的自定义组件
import Card from '@/components/Card.vue'

export default {
  // 步骤2：在components节点下注册组件
  components: {
    Card
  }
}
</script>

<style lang="less">
</style>

```

![image-20220727234712929](vue%E7%AC%94%E8%AE%B0/image-20220727234712929.png)

> 需要注意事项是：
>
> - 步骤1中导入组件的`@`符号，是表示从项目的`./src`目录开始查找组件，这个是webpack里的内容，vue使用`@`很有好的自定义了这个快捷方式，表示从`./src`目录下开始导入`components`目录里的组件
> - 步骤2中在`components`节点注册组件时，只写了`Card`，表示`{“Card”:“Card”}`，就是说这个对象的key和value都是一样的，那就可以简写为`Card`

> 推荐vscode插件：
>
> - Path Autocomplete
>
>     - 使用这个插件时，一定要记得vscode打开的是项目目录，比如项目根目录名字叫`tester-tool`，那么就需要用vscode打开这个目录，不能打开上一级，否则这个插件无法提示components路径
>
>     - 在vscode的settings.json中配置如下
>
>         -  "path-autocomplete.extensionOnImport": true,
>
>             ​    "path-autocomplete.pathMappings": {
>
>             ​        "@": "${folder}/src"
>
>             ​    }
>
> - Vuter

##### 2.2.1 全局注册组件

> 在vue项目的`main.js`入口文件中，通过`Vue.component()`方法来注册全局组件

```javascript
import Vue from 'vue'
import App from './App.vue'

// 导入需要全局注册的组件
import Count from '@/components/Count.vue'

// 注册全局组件
// 参数1：字符串格式，表示组件的”注册名称“
// 参数2：导入的需要被全局注册的组件
Vue.component("Count", Count)


Vue.config.productionTip = false

new Vue({
    render: h => h(App),
}).$mount('#app')
```

![image-20220728001832174](vue%E7%AC%94%E8%AE%B0/image-20220728001832174.png)

> 全局注册组件

![image-20220728003835277](vue%E7%AC%94%E8%AE%B0/image-20220728003835277.png)

> 在根组件App调用组件Left、Right组件

![image-20220728004101194](vue%E7%AC%94%E8%AE%B0/image-20220728004101194.png)

> 上面代码中：
>
> - Count组件被注册为全局组件
> - 根组件App引入了组件Left、组件Right
> - 组件Left、组件Right中又分别引入了全局组件Count
>
> 最终页面展示的效果

![image-20220728004134774](vue%E7%AC%94%E8%AE%B0/image-20220728004134774.png)

##### 2.2.3 局部注册组件

> 在单独的组件A中的`components`节点下注册了组件B，那么组件B只能在当前组件A中使用，不能被其他组件C使用，组件B就是私有组件

##### 2.2.4 组件注册名称写法

> 在进行组件注册时，定义组件注册名称的方式有：
>
> - 使用keybab-case命名法，俗称短横线命名法，比如：my-swiper、my-date等
> - 使用PascalCase命名法，俗称帕斯卡命名法或大驼峰命名法，比如MySwiper等

```javascript
import Swiper from './components/Swiper.vue'
import Test from './components/test.vue'

// 使用keybab-case命名法
vue.component("my-test", Swiper)

// 使用PascalCase命名法
vue.component("MySwiper", Swiper)
```

> 通过name属性注册组件
>
> - 在注册组件期间，除了可以直接提供组件的注册名称外，还可以把组件的name属性作为注册后组件的名称

```javascript
// Swiper.vue
<template>
  
</template>

<script>
export default {
    name: 'Swiper',

}
</script>

<style>

</style>
```

```javascript
import Swiper from './components/Swiper.vue'

// 使用PascalCase命名法，使用组件的name属性来声明组件注册名称
vue.component(Swiper.name, Swiper)
```

##### 2.2.5 组件样式冲突

> 在`.vue`组件中的样式会全局生效，因此会造成多个组件之间的样式冲突问题，导致的根本原因：
>
> - 所有组件的DOM结构，都是基于唯一的index.html页面进行渲染
> - 每个组件的样式，都会影响整个index.html页面的DOM结构

> 为每个组件分配唯一的自定义属性，在编写组件样式，使用属性选择器来控制样式的作用域，但是每个组件都要写唯一自定义属性，比较麻烦

```javascript
// Swiper.vue
<template>
  // 添加自定义属性 data-v-001
  <div class="box" data-v-001>
    <h3 data-v-001>首页</h3>
	</div>
</template>

<script>
export default {
    name: 'Swiper',

}
</script>

<style>
  // 用过中括号的属性选择器，来防止组件之间的样式冲突问题
  // 给每个组件分配的自定义属性都是唯一的
  	.box[data-v-001] {
      color: red;
    }

</style>
```

> vue为了解决上述出现的问题，vue为style节点提供了`scoped`属性，从而防止组件的样式冲突问题

```javascript
// 在App.vue组件中注册UserList.vue组件，可以看到在App.vue中的p标签设置了color属性
<template>
  <img alt="Vue logo" src="./assets/logo.png">
  <p>这是App.vue</p>
  <UserList/>
</template>

<script lang="ts">
import { defineComponent } from 'vue';

// 注册UserList.vue组件
import UserList from './components/UserList.vue'

export default defineComponent({
  name: 'App',
  components: {
    UserList,
  }
});
</script>

<style lang="less" scoped>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
 p{
   color: red;
 }
</style>
```

```javascript
// UserList.vue组件，也有个p标签设置了color属性
<template>
  <div>
      <p>姓名：{{uname}}，年龄：{{age}}
          <a href="">点击抽奖</a>
      </p>
  </div>
</template>

<script>
export default {
    name: "UserList",
    data() {
        return {
            uname: "sam",
            age: 19
        }
    }

}
</script>

// 给style节点设置了scoped属性，防止组件之间的样式冲突
<style scoped>
    p {
        color: brown;
    }
    p a {
        color: brown;
    }

</style>
```

> 从渲染的html结构来看，vue的style节点设置了一个scoped属性以后，vue会自动给组件设置了一个唯一的自定义属性，用来防止组件之间的样式冲突问题
>
> 可以看到UserList.vue组件有了一个data-v-4a3fa6b9的属性，不需要我们手动再去写自定义的唯一属性了
>
> 并且后面的的data-v-7ba5bd90这个属性是父组件里的唯一自定义属性

![image-20230126195857912](vue笔记/image-20230126195857912.png)

##### 2.2.6 /deep/样式穿透

> 如果给当前组件的style节点添加了scoped属性，则当前组件的样式对其子组件是不生效的，如果想让某些样式对子组件生效，可以使用/deep/深度选择器

```javascript
<style>
  // 先给当前组件设置样式
  h3 {
    color: pink;
  }

// 在给子组件里的标签将对应样式透传下去
 /deep/ h3{
   color: pink;
 }
</style>
```

#### 2.3 组件props属性

> props是组件的`自定义属性`，组件的调用者可以通过props属性将数据传递到子组件内部，供子组件内部进行使用
>
> props作用：父组件通过`props`向子组件传递要展示的数据
>
> props好处：提高组件的复用性

##### 2.3.1 props属性基本使用

> 在封装vue组件是，可以把动态的数据项声明为props自定义属性，自定义属性可以在当前组件的模板结构中直接被使用

```javascript
// 语法结构
export default {
    // 组件的自定义属性
  	// 父组件传递给 当前组件的数据，必须在 props 节点中声明
    props: ['自定义属性A', '自定义属性B', '其它自定义属性...']
}
```

> 在封装通用组件的时候，合理的使用`props`属性可以极大提高组件复用性
>
> - 上面这句话怎么理解更好呢？
>    - 比如封装了一个组件A，组件B和组件C地方都用到了这个组件A，但是希望组件B和组件C给组件A传进去的值是不一样，使用props属性，就可以在组件B和组件C调用组件A，传进去不同的值，后面的动态路由就可以使用props进行传参
> - props作为自定义属性，允许调用者通过自定义属性，给当前组件指定初始值
>     - 这句话理解为调用封装好的组件时，调用格式为`<组件名></组件名>`，封装好的组件有props属性时，就可以再调用的时候，将props里定义的属性拿过来到调用格式里当做属性，格式会变为`<组件名 props中的属性></组件名>`，表示设置组件的props属性的默认值

```vue
// Count.vue组件
<template>
  <div class="count">
      <p>组件Count</p>
      <p>count:{{ init }}</p>
      <button @click="addCount">+1</button>
  </div>
</template>

<script>
export default {
  // 自定义props属性的初始化值
  props: ["init"]
}
</script>
```

> 从上面的Count组件中可以看到props自定义属性，那么调用Count组件方就可以使用这些自定义属性了
>
> 比如Left.vue中就以标签形式调用Count组件，并且给Count组件标签中添加Count组件的props自定义属性init

```vue
// Left.vue组件
<template>
  <div class="left">
      <p>这是Left组件</p>
      <hr>
      // 这里首先Count被注册为全局组件了
      // 然后Count组件有一个自定义的init属性
      <Count init="9"></Count>
  </div>
</template>
```

> 此时打开浏览器页面查看Left.vue结构，从下面可以看到Left组件中的Count组件的props中的init自定义属性值就是传进去的9，但是要注意的是，此时的init值的类型是字符串，那么在页面操作Left组件的`+`号操作，可以看到Count组件中的加法结果其实是字符串拼接了，因为init值是字符串9，每次+1都和`9`这个字符串拼接

> 注意：
>
> - 父组件传递给了子组件中未声明的props属性，则传递进来的这些props属性会被忽略，无法被子组件使用
>   - 比如子组件的props只有`title`属性，但是父组件调用子组件时，还给子组件传了`title`和`author`属性，那么子组件只能使用`title`属性，不能使用`author`属性

##### 2.3.2 动态绑定props属性

> 外界组件调用方想动态的给封装好的组件的props自定义属性传值时，就可以对props的值使用属性绑定指令(v-bind)

```vue
// Left.vue组件
<template>
  <div class="left">
      <p>这是Left组件</p>
      <hr>
      // 这里首先Count被注册为全局组件了
      // 然后使用属性绑定指定，动态的进行props属性绑定，提高了组件的复用性
      <Count :title="info.title" :author="'post by' + info.author"></Count>
  </div>
</template>
<script>
export default {
    data(){
        return: {
            info: {
                "title": "vue的用法",
                "author": "sam"
            }
        }
    }
}
</script>
```

![image-20230529223231193](vue笔记/image-20230529223231193.png)

![image-20230529223253244](vue笔记/image-20230529223253244.png)

##### 2.3.3 props的大小写命名 

> 组件中如果使用"camelCase（驼峰命名法）"声明了props属性的名称，则有两种方式可以绑定属性的值

```javascript
// 子组件
<template>
  <p>发布时间：{{ pubTime }}</p>
</template>

<script>
   export default {
      name: "Count",
      props: ['pubTime']
    }
</script>
```

```javascript
<template>
    <!- - 方式1：使用"驼峰命名"的形式为组件绑定属性的值>
    <my-post pubTime=""1999"></my-post>

    <!- - 方式2: 使用"短横线分隔命名"的形式为组件绑定属性的值>
    <my-post pub-time=""1999"></my-post>
</template>
```

#### 2.4 组件props验证

##### 2.4.1 对象类型的props节点

> 在2.3小节的`组件props属性`中，我们在子组件中的props属性使用的是列表形式，无法对props属性进行数据类型的校验
>
> vue组件除了使用列表形式的props属性，还可以使用对象类型的props属性节点，来对每个props属性的数据类型进行校验

```javascript
<script>
export default {
  name: "Count",
  // props: ['title', 'author']
  // 通过对象类型的props节点，指定每个props属性的数据类型
  props: {
    title: String,
    state: Boolean
  }
}
</script>
```

![image-20230529230244948](vue笔记/image-20230529230244948.png)

> 如果传递给子组件的props属性的数据类型和子组件中定义的props属性的数据类型不一致，就会在浏览器的console调试面板中有提示告警信息
>
> 可以看到提示了`Invalid prop`，无效的prop，表示期望是`Boolean`，但实际得到了`String`

![image-20230529230411326](vue笔记/image-20230529230411326.png)



##### 2.4.2 基础类型的检查

> 可以为组件的prop属性指定基础的校验类型，从而防止组件的使用者为其绑定一个错误的数据

```javascript
// 下面是比较常见的基础数据类型，前5中使用比较多
<script>
export default {
  // 基础数据类型
  props: {
    title1: String, // 字符串类型
    title2: Number, // 数字类型
    title3: Boolean, // 布尔值类型
    title4: Array, // 数组类型
    title5: Object, // 对象类型
    title6: Date, // 日期类型
    title7: Function, // 函数类型
    title8: Symbol, // 符号类型
  }
}
</script>
```

##### 2.4.3 多个可能的类型

> 可以对某一个prop属性指定多个数据类型

```javascript
<script>
export default {
  // 基础数据类型
  props: {
    title1: [String,Boolean,Number]
  }
}
</script>
```

##### 2.4.4 必填项校验

> 如果组件的某个prop属性是必填项，必须要让组件调用者为其传递属性的值，需要通过配置对象的形式，为prop属性定义验证规则
>
> 注意：
>
> - 当prop属性的required为true时，表示当前属性的值时必填项，如果调用者没有指定该属性的值，就会在console中报错

```javascript
<script>
export default {
  props: {
    // 使用"配置对象"的形式，来为title定义"验证规则"
    title: {
      type: String, // 当前属性的值必须是字符串类型
      required: true // 当前属性的值必须是必填项
    },
    state: Boolean
  }
}
</script>
```

![image-20230529231643567](vue笔记/image-20230529231643567.png)



##### 2.4.5 属性默认值

> 封装组件时，可以为某个prop属性指定默认值

```javascript
<script>
export default {
  props: {
    // 使用"配置对象"的形式，来为title定义"验证规则"
    title: {
      type: String, // 当前属性的值必须是字符串类型
      default: "vue是最棒的！" // 当前属性的默认值
    },
    state: Boolean
  }
}
</script>
```

![image-20230529231940456](vue笔记/image-20230529231940456.png)

![image-20230529231832938](vue笔记/image-20230529231832938.png)

##### 2.4.6 自定义验证函数

> 在封装组件时，可以为prop属性定义自定义的验证函数，从而对prop属性进行精准控制

```javascript
<script>
export default {
  props: {
    // 使用"配置对象"的形式，来为title定义"验证规则"
    title: {
      type: String, // 当前属性的值必须是字符串类型
      default: "vue是最棒的！",
      validator(value) {
        // title属性的值，必须匹配下面的列表中的任意一个
        // 如果没有匹配的，则函数返回值为false，表示验证失败，反之为true表示验证通过
        return ["vue1", "vue2"].indexOf(value) !== -1
      }
    }
  }
}
</script>
```

> 如果组件调用方出传的prop的属性值不是validator函数中return列表的任意一个，则报错

![image-20230529234402504](vue笔记/image-20230529234402504.png)

#### 2.5 组件的计算属性

> 计算属性本质上是一个函数，可以实时监听data中数据的变化，并return一个计算后的新值，提供给组件渲染
>
> 计算属性需要以`函数`的形式声明到组件的`computed`选项中

```javascript
<template>
  <p> {{ count }} + 2 = {{ add }} </p>
</template>

<script>
export default {
  data() {
    return {
      count: 1
    }
  },
  computed: {
    // 计算属性：监听 data函数中的count值的变化，自动计算出 count + 2 的新值
    add() {
      return this.count + 2
    }
  }
}
</script>

<style scoped>

</style>
```

![image-20230530230903502](vue笔记/image-20230530230903502.png)

> 注意：
>
> - 计算属性侧重于得到一个计算的结果，所以计算属性中必须使用`return`返回计算的新值
> - 计算属性必须定义在computed节点中
> - 计算属性必须是一个function函数
> - 计算属性必须有返回值
> - 计算属性必须当做普通属性返回

#### 2.6 组件的watch侦听器

> watch侦听器是允许开发者监视数据的变化，从而对数据的变化做特定的操作，比如监听用户名的变化而发起请求，判断用户名是否可用

##### 2.6.1 watch侦听器的基本用法

> 需要在watch节点下，定义自己的侦听器，也就是声明属于自己的侦听函数方法
>
> 我们需要监听哪个值的变化，那就把需要监听的值的名字拿过来当成函数名，写在watch节点下，然后watch侦听器的侦听函数的形参列表，第一个值是"变化后的新值"，第二值是"变化之前的旧值"

```javascript
<template>
  <p> {{ count }} + 2 = {{ add }} </p>

  <p>您输入了：{{ msg }}</p>
  姓名：<input type="text" v-model.trim="msg">
</template>

<script>
export default {
  data() {
    return {
      count: 1,
      msg: ""
    }
  },
  computed: {
    add() {
      return this.count + 2
    }
  },
  watch: {
    // 监听 data函数 中 msg值的变化
    // msg函数的形参列表，第一个值是"变化后的新值"，第二值是"变化之前的旧值"
    msg(newVal, oldVal){
      console.log("newVal:" + newVal);
      console.log("oldVal:" + oldVal);
    },
  },
}
</script>

<style scoped>

</style>
```

![image-20230530233715930](vue笔记/image-20230530233715930.png)

> 每次input框输入完成以后，就会打印出新值和旧值，特别适合用来做用户名、商品名等唯一性的校验，比如给用户名、商品名进行侦听，每次变化时就发起ajax请求，由接口返回用户名、商品名是否可用

##### 2.6.2 immediate选项

> 默认情况下，组件在初次加载完成后不会调用watch侦听器，如果想让watch侦听器在组件初始化时就被立即调用，那么可以使用`immediate`选项
>
> - 比如组件的data中某个变量被watch侦听了，并且这个变量有初始值，如果组件首次加载，但是侦听器中的侦听函数是不会被调用的，所以就需要`immediate`选项来让组件侦听器在组件初始化时就可以使用

> 注意：
>
> - 需要被监听的值不是函数了，而是一个对象，并且对象中有一个固定的`handler`函数，表示来接受值的前后变化
> - 在被监听值的对象中定义`immediate: true`，表示组件加载完成后立即调用一次当前msg的watch侦听器

```javascript
<template>
  <p>您输入了：{{ msg }}</p>
  姓名：<input type="text" v-model.trim="msg">
</template>

<script>
export default {
  data() {
    return {
      msg: "admin"
    }
  },
  watch: {
    // 监听 data函数 中 msg值的变化
    // msg就变成了一个对象，而不是函数了
    msg: {
      // 在msg对象中有一个固定的写法handler，当 msg变化时，就自动调用handler函数
      handler(newVal, oldVal){
        console.log("newVal:" + newVal);
        console.log("oldVal:" + oldVal);
      },
      // 表示组件加载完成后立即调用一次当前msg的watch侦听器
      immediate: true
    },
  },
}
</script>

<style scoped>

</style>
```

![image-20230530235311494](vue笔记/image-20230530235311494.png)

> 从上面代码可以看出：
>
> - data的msg初始值是admin，并且对msg值设置了侦听器以及`immediate`为true
> - 那么刷新页面后，组件加载完毕，会自动调用一次msg值的侦听器，我们在console中就看到`newVal:admin`和"oldVal:undefined"
>   - 为什么"oldVal"的值是undefined?
>     - 因为是组件加载完毕后就调用msg的侦听器函数，那么msg的初始值admin就是组件获取到的最新值，那么msg的旧值没有自定义，所以就是undefined

##### 2.6.3 deep选项

> 当watch侦听的是一个对象时，如果对象中的某些值发生了变化，则无法被侦听到，此时需要使用deep属性
>
> 注意：
>
> - 当侦听器的hanler函数的旧值用不到，就可以在handler函数中不传第二个oldVal

```javascript
<template>
  <p>姓名：{{ user.name }}</p>
  姓名：<input type="text" v-model.trim="user.name">
</template>

<script>
export default {
  data() {
    return {
      user: {
        name: "sam"
      }
    }
  },
  watch: {
    // 监听 data函数 中 user对象值的变化
    user: {
      // 在user对象中有一个固定的写法handler，当 user中的值变化时，就自动调用handler函数
      handler(newVal){
        console.log("newVal:" + JSON.stringify(newVal));
        if (newVal.name === "vue3") {
          console.log("用户名可用:" + JSON.stringify(newVal));
        }
      },
      // 表示组件加载完成后立即调用一次当前msg的watch侦听器
      immediate: true,
      deep: true
    },
  },

}
</script>

<style scoped>

</style>
```

![image-20230531102811860](vue笔记/image-20230531102811860.png)

> 从上面代码看出：
>
> - 当对user对象的侦听器设置了deep为true以后，当user对象的name发生了变化时，那就会自动调用handler函数，并且当name等于"vue3"时，还执行了user侦听器函数中if语句的console函数

##### 2.6.4 监听对象单个属性的变化

> 监听对象时，如果我们设置了true，那么任何对象的任意一个值发生了变化，那么都会调用一次侦听器，我们只想让单个属性发生变化才进行侦听，就需要对单个属性设置侦听器了

```javascript
<script>
export default {
  data() {
    return {
      user: {
        name: "sam",
        age: 0
      }
    }
  },
  methods: {
    addAge(){
      console.log("年龄+1")
      this.user.age += 1
    }
  },
  watch: {
    // 仅仅监听 data函数 中 user对象的name值的变化
    "user.name": {
      // 在user对象中有一个固定的写法handler，当 user中的name值变化时，就自动调用handler函数
      // name的值就是newVal
      handler(newVal){
        console.log("newVal:" + newVal);
        if (newVal === "vue3") {
          console.log("用户名可用:" + newVal);
        }
      },
      // 表示组件加载完成后立即调用一次当前的watch侦听器
      immediate: true,
    },
  },

}
</script>
```

##### 2.6.5 计算属性和侦听器的区别

> 计算属性和侦听器侧重的应用场景不同
>
> - 计算属性侧重于监听多个值的变化，得到return一个新值
> - 侦听器侧重于监听单个数据的变化，最终执行我们设置的逻辑，并且不需要任何返回值

#### 2.7 组件的生命周期

> 组件的运行过程如下图所示，其中组件运行最关键的就是"以标签形式使用组件"
>
> 组件的生命周期是指：组件从【创建】-【运行(渲染)】-【销毁】的整个过程，主要是组件的运行时间段

![image-20230531230609579](vue笔记/image-20230531230609579.png)

##### 2.7.1 生命周期函数

> vue为组件内置了不同时刻的生命周期函数，生命周期函数会随着组件的运行而自动调用
>
> - 当组件在内存中被创建以后，会自动调用`created`函数
> - 当组件被成功渲染到页面上以后，会自动调用`mounted`函数
> - 当组件被销毁完成以后，会自动调用`unmounted`函数

```javascript
// 显示生命周期的组件
<template>
  <LifeCycle v-if="flag"></LifeCycle>
  <button @click="hiddenLifeCycle">点我隐藏LifeCycle组件</button>
  <button @click="showLifeCycle">点我显示LifeCycle组件</button>
</template>

<script>
import LifeCycle from "@/components/LifeCycle";

export default {
  name: "Left",
  components: {
    LifeCycle
  },
  data() {
    return {
      flag: true,
    }
  },
  methods: {
    hiddenLifeCycle(){ this.flag = false },
    showLifeCycle(){ this.flag = true },
  }

}
</script>

<style scoped>
  button{
    margin-right: 15px;
  }
</style>
```

```javascript
// 生命周期函数组件
<template>
    <p>这是LifeCycle组件</p>
</template>

<script>
export default {
  name: "LifeCycle",
  created() {
    console.log("created: LifeCycle组件在内存中创建成功了")
  },
  mounted() {
    console.log("mounted: LifeCycle组件第一次被渲染成功了")
  },
  unmounted() {
    console.log("unmounted: LifeCycle组件被销毁了")
  },
}
</script>

<style scoped>

</style>
```

![image-20230531232414015](vue笔记/image-20230531232414015.png)

> 上面的代码很好理解，在Left组件中对于LifeCycle组件是否展示设置了一个flag标志位来控制，如果不显示，设置为false，显示设置为true

> - 当首次进入页面时，会看到console控制台输出了"created: LifeCycle组件在内存中创建成功了"和"mounted: LifeCycle组件第一次被渲染成功了"，表示组件创建以及渲染成功
>
> - 当点击隐藏LifeCycle组件时，console出现了"unmounted: LifeCycle组件被销毁了"，表示切换了LifeCycle组件，那么就触发了组件的销毁函数

![image-20230531232551225](vue笔记/image-20230531232551225.png)







> 当点击"显示LifeCycle组件"时，又会看到console控制台输出了"created: LifeCycle组件在内存中创建成功了"和"mounted: LifeCycle组件第一次被渲染成功了"，表示组件创建以及渲染成功，表示组件又再次被创建了以及渲染成功了，因为看到了LifeCycle组件的p标签的文字

![image-20230531232909198](vue笔记/image-20230531232909198.png)

##### 2.7.2 监听组件的data数据更新

> 当组件的`data`数据更新以后，vue会自动重新渲染组件的DOM结构，从而保证view视图展示的数据和Model数据源一致，当组件重新被渲染完成后，会自动调用update函数

```javascript
// Left组件
<template>
  <LifeCycle v-if="flag"></LifeCycle>
  <button @click="hiddenLifeCycle">点我隐藏LifeCycle组件</button>
  <button @click="showLifeCycle">点我显示LifeCycle组件</button>
</template>

<script>
import LifeCycle from "@/components/LifeCycle";

export default {
  name: "Left",
  components: {
    LifeCycle
  },
  data() {
    return {
      flag: true,
    }
  },
  methods: {
    hiddenLifeCycle(){ this.flag = false },
    showLifeCycle(){ this.flag = true },
  },
    
  // 组件重新被渲染以后，会自动调用update函数
  updated() {
    console.log("Left组件的data发生了变化，自动调用了update函数")
  }

}
</script>

<style scoped>
  button{
    margin-right: 15px;
  }
</style>
```



![image-20230531233432521](vue笔记/image-20230531233432521.png)

> 还是以`2.7.1`小节的Left和LifeCycle组件代码为例，仅在Left组件新增了update函数，因为我们在Left组件中定义了两个方法：hiddenLifeCycle和showLifeCycle，并且这两个方法对data数据源中的flag进行了修改，那么在页面上操作时，因为对data数据源进行了修改，那么Left组件就会自动调用update函数，就是我们在console控制台看到的内容

##### 2.7.3 生命周期主要函数

| 生命周期函数 |           执行时机           | 所属阶段 | 执行次数 |              场景              |
| :----------: | :--------------------------: | :------: | :------: | :----------------------------: |
|   created    |    组件在内容中创建完毕后    | 创建阶段 | 唯一1次  | 适合组件刚被创建就获取初始数据 |
|   mounted    |  组件初次在页面中渲染完毕后  | 创建阶段 | 唯一1次  |          操作DOM结构           |
|   updated    | 组件在页面中重新被渲染完毕后 | 运行阶段 | 0或多次  |               -                |
|  unmounted   |   组件在页面或内容中销毁后   | 销毁阶段 | 唯一1次  |               -                |

> 下图是vue官网的组件生命周期示意图：[https://cn.vuejs.org/guide/essentials/lifecycle.html#lifecycle-diagram](https://cn.vuejs.org/guide/essentials/lifecycle.html#lifecycle-diagram)

![img](vue笔记/lifecycle.16e4c08e.png)

#### 2.8 组件关系

##### 2.8.1 父向子传值

##### 2.8.2 子向父传值



#### 2.9 插槽





## 六、vue路由

> 前端路由指的就是Hash地址与组件之间的对应关系
>
> 不同组件之间的切换需要通过前端路由来实现

### 1、路由工作方式

> 路由变化过程：
>
> 1. 用户点击了页面了的路由链接
> 2. 导致了URL地址栏中的Hash值发生了变化
> 3. 前端路由监听到了Hash地址的变化
> 4. 前端路由把当前Hash地址对应的组件渲染到浏览器中

![image-20230127215524192](vue笔记/image-20230127215524192.png)

#### 1.2 路由原理

> 使用锚链接模拟路由
>
> 使用锚点每次点击的时候，都会将a链接中的href中的路由拼接到浏览器地址栏的后面

```html
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <style>
        #b1 {
            background-color: pink;
            height: 120px;
        }
        
        #b2 {
            background-color: red;
            height: 120px;
        }
        
        #b3 {
            background-color: orange;
            height: 120px;
        }
    </style>
</head>

<body>
    <a href="#b1">b1</a>
    <a href="#b2">b2</a>
    <a href="#b3">b3</a>
    <div id='b1'></div>
    <div id='b2'></div>
    <div id='b3'></div>
</body>

</html>
```

![image-20230127223940280](vue笔记/image-20230127223940280.png)

> location这个属性可以拿到当前页面的链接以及Hash地址
>
> - location.href表示当前路由
> - location.hash表示hash地址，从地址栏的#号开始包含#号，表示hash地址

![image-20230127224058733](vue笔记/image-20230127224058733.png)

### 2、vue-router

#### 2.1 vue-router介绍

> vue-router是vue给出的路由解决方案，只能在vue项目中使用

> vue-router的版本
>
> - vue-router3.x只能结合vue2使用，地址：https://router.vuejs.org/zh/
> - vue-router4.x只能结合vue3使用，地址：https://next.router.vuejs.org/

#### 2.2 vue-router4.x使用步骤

> 1、在项目中安装vue-router

```bash
npm i vue-router@next -S
```

![image-20230130181514845](vue笔记/image-20230130181514845.png)

> 2、定义路由组件
>
> - 在项目中定义好需要路由控制的组件

> 3、声明路由链接和占位符
>
> - 使用`<router-link>`标签来声明路由链接(用来代替普通的a标签)，并使用`<router-view>`标签来声明路由占位符，占位符就是需要在哪里展示组件，就声明到什么位置
> - 使用`<router-link>`声明路由标签时，里面的`to`属性指定路由时，不需要显式的写成`#/home`，vue会自动给to属性的路由前面拼接`#`

```javascript
<template>
  <div class='app-box'>
      <p>这是App根组件</p>

      <!-- 声明路由链接 -->
      <router-link to="/home"></router-link>
      <router-link to="/goods"></router-link>
      <router-link to="/about"></router-link>

      <!-- 路由声明占位符 -->
      <router-view></router-view>
  </div>
</template>
```

> 4、创建路由模块
>
> - 在项目中创建`router.js`路由模块，并在`router.js`中按照如下步骤创建获得路由的实例对象
>     1. 从vue-router中按需导入两个方法
>         1. createRouter 方法适用于创建路由的实例对象
>         2. createWebHashHistory 用于指定路由的工作模式，hash模式
>     2. 导入需要使用路由控制的组件
>     3. 创建路由实例对象
>     4. 向外共享路由实例对象
> - 下面的文件名为`router.js`，可以放在component文件夹下，需要注意导入组件时的路径

```javascript
// 从vue-router中按需导入两个方法
// createRouter 方法适用于创建路由的实例对象
// createWebHashHistory 用于指定路由的工作模式，hash模式

import { createRouter, createWebHashHistory } from "vue-router"


// 导入组件
import Home from './Home.vue'
import Goods from './Goods.vue'
import About from './About.vue'


// 创建路由实例对象
const router = createRouter({
    // 通过history指定路由工作模式
    history: createWebHashHistory(),

    // 通过router数组指定路由规则
    routes: [
        { path: '/home', component: Home },
        { path: '/goods', component: Goods },
        { path: '/about', component: About },
    ],
})

// 导出路由实例对象
export default router
```

> 5、导入并挂载路由模块
>
> - 在项目根目录下，vue2是main.js文件，vue3是main.ts文件，导入第4步创建的路由模块
> - 然后按如下代码进行路由挂载
>
> 注意：
>
> - 在vue3中，默认使用了typescript语法，所以在main.ts导入router时，会报错："Could not find a declaration file for module './components/router.js'. 'xxxxx  implicitly has an 'any' type."
> - 解决办法：在项目根目录下的tsconfig.json文件中的compilerOptions节点添加"noImplicitAny": false，即可

```javascript
import { createApp } from 'vue'
import App from './App.vue'

// 导入路由模块
import Router from './components/router.js'

// 创建app
const app = createApp(App)

// 挂载路由
app.use(Router)

// 挂载app
app.mount('#app')
```

#### 2.3 路由重定向

> 重定向是指在访问地址A时，强制跳转至地址B，从而展示地址B组件的内容页面
>
> 通过路由规则的`redirect`属性，可以来指定一个新的路由地址

```javascript
// 从vue-router中按需导入两个方法
// createRouter 方法适用于创建路由的实例对象
// createWebHashHistory 用于指定路由的工作模式，hash模式

import { createRouter, createWebHashHistory } from "vue-router"


// 导入组件
import Home from './Home.vue'
import Goods from './Goods.vue'
import About from './About.vue'


// 创建路由实例对象
const router = createRouter({
    // 通过history指定路由工作模式
    history: createWebHashHistory(),

    // 通过router数组指定路由规则
    routes: [
        // redirect重定向，访问'/'会自动重定向到'/home'路由
        { path: '/', redirect: '/home' },
        { path: '/home', component: Home },
        { path: '/goods', component: Goods },
        { path: '/about', component: About },
    ],
})

export default router
```

#### 2.4 路由高亮

> 被激活的路由链接高亮有两种方式
>
> - 被激活的路由链接，默认会应用一个叫`router-link-active`的类名，可以在编写高亮样式时，使用该类名选择器为激活的路由链接编写高亮样式
> - 使用自定义的路由高亮class类
>     - 在路由文件中，也就是声明路由的位置，添加`linkActiveClass`属性，指定一个自定义的类名，就会替换掉默认的`router-link-active`类名

```css
// 使用默认的`router-link-active`的类名编写高亮样式
.router-link-active{
  backgroud-color: red;
  color: white;
  font-weight: 700;
}
```

```css
// 创建路由实例对象中设置自定义的路由激活时使用的类名
const router = createRouter({
    // 通过history指定路由工作模式
    history: createWebHashHistory(),
		
    // 默认的router-link-active会被覆盖掉
    linkActiveClass: 'router-class',
      
    // 通过router数组指定路由规则
    routes: [
        { path: "/", component: "" },
        { path: "/pay-moon-box", component: PayMoonBox },
    ],
});
```

#### 2.5 嵌套路由

##### 2.5.1 子路由声明

> 嵌套路由就是组件中嵌套组件再嵌套组件，那么最里面的组件的路由就是嵌套路由

> 如下图：
>
> - App组件中嵌套主页组件，主页组件嵌套列表组件
> - 那么列表组件的路由就是:/home/list
> - 那么列表组件的路由就是嵌套路由

![image-20230301222037167](vue笔记/image-20230301222037167.png)

> 那么如何声明嵌套路由呢？
>
> - 使用`children`属性去声明嵌套的子路由
> - 在`children`属性的`path`声明子路由时，官方推荐不在路由前面加`/`，直接写路由的内容即可

```javascript
// 在项目的router.js中
const router = createRouter({
    // 通过history指定路由工作模式
    history: createWebHashHistory(),

    // 通过router数组指定路由规则
    routes: [
        {
            path: "/home",
            component: Home,
            // 声明子路由
            children: [
                { path:'list', component: List }, // 访问/home/list时，展示List组件
            ]
        }
    ],
});
```

> 在router.js声明完路由以后，那就需要在Home组件中声明`router-link`和占位符`router-view`了

```javascript
// 在Home组件声明跳转路由
<template>
  <div>
      <router-link to="/home/list">列表路由</router-link>
    	<router-view></router-view>
  </div>
</template>
```

##### 2.5.2 默认子路由

> 添加默认子路由有两种那个方式
>
> - 在`router.js`文件中使用`redirect`属性，重定向到需要的路由

```javascript
// 在项目的router.js中
const router = createRouter({
    // 通过history指定路由工作模式
    history: createWebHashHistory(),

    // 通过router数组指定路由规则
    routes: [
        {
            path: "/home",
            component: Home,
            redirect: '/home/list1',
            // 声明子路由
            children: [
                { path:'list1', component: List1 }, // 访问/home/list1时，展示List1组件
            		{ path:'list2', component: List2 }, // 访问/home/list1时，展示List2组件
            ]
        }
    ],
});
```

> 当进入/home路由时，默认进入/home/list1路由

#### 2.6 动态路由

> 动态路由是指把Hash地址中可变部分定义为参数项，提高路由重复性使用
>
> 在`vue-router`中使用`英文冒号(:)`来定义路由的参数项

> 动态路由理解：
>
> - 就是在跳转链接时，链接上有些参数可以动态拼接，比如：id
> - 动态路由可以理解为后端路由上查询不同id时拼接的路由，只不过现在变为了前端也支持动态路由

##### 2.6.1 动态路由配置

> 下面是在router中这是动态路由参数

```javascript
// 在router.js中声明路由的动态参数
const router = createRouter({
    // 通过history指定路由工作模式
    history: createWebHashHistory(),

    // 通过router数组指定路由规则
    routes: [
        { path: "/goods/:id", component: Goods } // id为动态获取的值
    ],
});
```

##### 2.6.2 动态路由的参数获取

> 下面在组件中获取动态路由传递过来的参数和值
>
> 在通过动态路由匹配的方式渲染出来的组件中，可以使用`$route.params`对象访问到动态匹配的参数值

```javascript
// 在组件中获取传递过来的动态参数
<template>
  <p>动态参数id：{{ $route.params }} </p>
</template>
```

> 下面是获取到的数据示例

![image-20230601152042740](vue笔记/image-20230601152042740.png)

##### 2.6.3 使用props接收动态路由参数

> 为了便于获取路由参数，vue-router允许在路由规则中开启props传参

```javascript
import { createRouter, createWebHashHistory } from "vue-router"
import Left from "@/components/Left";

// 在项目的router.js中
const router = createRouter({
    // 通过history指定路由工作模式
    history: createWebHashHistory(),

    // 通过router数组指定路由规则
    routes: [
        {
            path: "/left/:id",
            component: Left,
            // 在路由中开启props传参
            props: true
        }
    ],
});

export default router
```

> 在路由指向的组件中使用props获取动态路由参数

```javascript
export default {
  name: "Left",
  components: {
    LifeCycle
  },
  props: ['id'],
  data() {}
}
```

> 使用props接收动态路由参数的好处
>
> - 可以在路由指向的组件中使用`this.`的方式获取到动态路由参数，那么就可以将动态路由参数的值传给methos节点的函数里、生命周期函数里，这样通用性更强，

##### 2.6.4 路径参数和查询参数获取

> 在vue组件中，在`script`节点下，可以使用`this.$route`获取到路径参数和查询参数，都是对象类型

```javascript
<script>
  created(){
    console.log(this.$route);
  },    
</script>
```

![image-20230602131422364](vue笔记/image-20230602131422364.png)

> 从上图可以看出，打印`this.$route`，可以看到
>
> - 路径参数是在`params`这个对象中
> - 查询参数是在`query`这个对象中
>
> 所以获取动态路由的参数时，按需获取就可以了

#### 2.7 路由导航

##### 2.7.1 声明式导航

> 通过点击链接跳转导航的方式，叫做声明式导航，比如：
>
> - 普通网页中点击<a>链接、vue项目中点击<router-link>都属于声明式导航

##### 2.7.2 编程式导航

> 通过调用API实现导航的方式，叫做编程式导航，比如：
>
> - 普通网页调用location.href跳转到新页面的方式，叫做编程式导航

> 在vue-router提供了编程式导航的API
>
> - this.$router.push('hash地址')：跳转到指定Hash地址，从而展示对应的组件页面
> - this.$router.go(数值n)：实现导航历史的前进、后退

##### 2.7.3 $router.push

> 在组件中跳转另一个组件，使用编程式导航

```javascript
// Left组件
<template>
  <p>这是Left组件</p>
  <button @click="jumpCycle">跳转至LifeCycle组件</button>
</template>

<script>


export default {
  name: "Left",
  components: {},
  data() {
    return {
      flag: true,
    }
  },
  methods: {
    // 使用push跳转至指定的组件
    jumpCycle(){ 
        console.log("触发了：this.$router.push('/life-cycle') ")
        this.$router.push('/life-cycle') 
    },
  },


}
</script>

<style scoped>
  button{
    margin-right: 15px;
  }
</style>
```

```javascript
// LifeCycle组件
<template>
    <p>这是LifeCycle组件</p>
</template>

<script>
export default {
  name: "LifeCycle",
  created() {
    console.log("created: LifeCycle组件在内存中创建成功了")
  },
  mounted() {
    console.log("mounted: LifeCycle组件第一次被渲染成功了")
  },
  unmounted() {
    console.log("unmounted: LifeCycle组件被销毁了")
  },
}
</script>

<style scoped>

</style>
```

> 从下图看出，在Left组件的页面点击button跳转了到LifeCycle组件页面

![image-20230602133239630](vue笔记/image-20230602133239630.png)

##### 2.7.4 $router.go

> 可以回退或者前进页面

```javascript
// LifeCycle组件
<template>
    <p>这是LifeCycle组件</p>
  <button @click="goBack">回到Left组件</button>
</template>

<script>
export default {
  name: "LifeCycle",
  methods: {
    // 增加回退页面，回到上一页
    goBack(){
      console.log("触发了：this.$router.go(-1)")
      this.$router.go(-1)
    }
  },
  created() {
    console.log("created: LifeCycle组件在内存中创建成功了")
  },
  mounted() {
    console.log("mounted: LifeCycle组件第一次被渲染成功了")
  },
  unmounted() {
    console.log("unmounted: LifeCycle组件被销毁了")
  },
}
</script>
```

![image-20230602133731588](vue笔记/image-20230602133731588.png)

> 可以看出跳转到LifeCycle组件以后，点击"回到Left组件"按钮，又跳转回到了Left组件
>

#### 2.8 导航守卫

> 导航守卫可以控制路由的访问权限，即对需要登录的路由访问时，需要先登录，登陆成功以后再去访问

##### 2.8.1 声明全局导航守卫

> 全局导航守卫回拦截每个路由规则，并对每个路由进行访问权限的控制

```javascript
// 在项目的router.js中
const router = createRouter({...});

// 调用路由实例对象的 beforeEach 函数，声明"全局前置守卫"
// fn 必须是一个函数，每次拦截到路由的请求，都会调用 fn 进行处理，fn也叫"守卫方法"，一般使用箭头函数来代替fn函数
router.beforeEach(() => {
    console.log("导航守卫函数...")
})
```

![image-20230604175900961](vue笔记/image-20230604175900961.png)

##### 2.8.2 全局守卫的3个形参

> 全局导航守卫可以接收3个形参，分别为to、from、next
>
> - to：表示目标路由对象，也就是页面当前访问的路由
> - form：当前导航正要离开的路由对象，也就是当前访问的路由的上一级路由是从什么
> - next：放行函数
>   - 如果在beforeEach的守卫访问方法中不声明next参数，那么beforeEach中不需要调用next方法，所有路由都可以放行
>   - 如果在beforeEach的守卫访问方法中声明了next参数，那么beforeEach就需要调用next方法对路由进行放行，否则不允许访问任何一个路由

```javascript
// 调用路由实例对象的 beforeEach 函数，声明"全局前置守卫"
// fn 必须是一个函数，每次拦截到路由的请求，都会调用 fn 进行处理，fn也叫"守卫方法"
router.beforeEach((to, from, next) => {
    console.log("导航守卫函数...")
    console.log('to:', to)
    console.log('from:', from)
    next()
})
```

![image-20230604181313336](vue笔记/image-20230604181313336.png)

##### 2.8.3 next函数的调用方式

> 直接全部放行：next()
>
> 强制让路由停留在当前页面：next(false)
>
> 强制让路由跳转到登录页面：next('/login')

> 下面是示例，结合token展示最简单的路由守卫

```javascript
// 路由处理
// 调用路由实例对象的 beforeEach 函数，声明"全局前置守卫"
// fn 必须是一个函数，每次拦截到路由的请求，都会调用 fn 进行处理，fn也叫"守卫方法"
router.beforeEach((to, from, next) => {
    const token = localStorage.getItem('token')
    if (to.path === "/left" && !token) {
        // 需要访问登录页面
        console.log("未登录，跳转登录中...")
        next('/login')
    } else {
        // 直接放行
        next()
    }
})
```

```javascript
// Login组件
<template>
  <p>登录页面</p>
  用户名：<input type="text" v-model="username">
  <button @click="LoginFunc">登录</button>
</template>

<script>
export default {
  name: "Login",
  data(){
    return {
      username: ""
    }
  },
  methods: {
    LoginFunc() {
      localStorage.setItem("token", this.username);
    }
  }

}
</script>

<style scoped>

</style>
```

> 下面是另外一个全局导航守卫的写法

```javascript
router.beforeEach((to, from, next) => {
    // 如果访问登录页面，放行
    if ( to.path === '/login') return next()

    // 获取token值
    const token = localStorage.getItem('token')
    // token失效的话，跳转登录页面
    if (!token) {
        // 需要访问登录页面
        console.log("未登录，跳转登录中...")
        return next('/login')
    }
    // token有效则直接放行
    next()
})
```

