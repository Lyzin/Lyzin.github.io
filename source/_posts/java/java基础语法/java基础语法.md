---
title: Java基础语法
date: 2024-09-22 15:08:33
updated: 2024-09-22 15:08:33
tags: Java
cover: /posts_cover_img/java/java_logo.png
categories: Java
---

## 一、数据类型

### 1、第一行代码

> java的文件名和代码的类名必须一致

```java
public class HelloWorld{
    public static void main(String[] args){
        System.out.println("Hello World");
    }
}
```

> 保存上面代码为 HelloWorld.java

```bash
# 先编译，编译会产生HelloWorld.class
javac HelloWorld.java

# 再执行
java HelloWorld.class
```

> Java的执行原理就是最终翻译成计算机底层可以识别的机器语言

### 2、JDK组成

> - JDK组成
>   - JVM（Java Virtual Machine）：Java虚拟机，真正运行Java程序的地方
>   - 核心类库：Java自己写好的程序，给程序自己的程序调用的
>   - JRE（Java Runtime Environment）：Java的运行环境
>   - JDK（Java Development Kit）：Java开发工具包（包括上面所有）

![JDK组成](java基础语法/image-20240922230458755.png)

### 3、IDEA创建Java项目

> 由如下顺序组成
>
> - project（项目、工程）
> - module（模块）
> - package（包）
> - class（类）

> 所以在idea中应该是这样的

#### 1.1 创建空项目

![image-20240923001637286](java基础语法/image-20240923001637286.png)

#### 1.2 项目下创建模块

![image-20240923001733155](java基础语法/image-20240923001733155.png)

![image-20240923001755578](java基础语法/image-20240923001755578.png)

![image-20240923001833039](java基础语法/image-20240923001833039.png)

#### 1.3 模块下创建包

![image-20240923001957834](java基础语法/image-20240923001957834.png)

![image-20240923002117952](java基础语法/image-20240923002117952.png)

![image-20240923002131176](java基础语法/image-20240923002131176.png)

#### 1.4 包下创建类

![image-20240923002222772](java基础语法/image-20240923002222772.png)

![image-20240923002328065](java基础语法/image-20240923002328065.png)

![image-20240923002347586](java基础语法/image-20240923002347586.png)

### 4、数据类型

#### 1.1 基础数据类型

> - 整型
>   - byte
>   - short
>   - int（默认）
>   - long
> - 浮点型（小数）
>   - float
>   - double（默认）
> - 字符型
>   - char
> - 布尔型
>   - boolean

![基本数据类型](java基础语法/image-20240922231417210.png)

#### 1.2 自动类型转换

> 类型范围小的变量，可以直接赋值给类型范围大的变量
>
> 比如：byte类型可以自动转为int类型

```java
public class MyName {
    public void typeStudy() {
        byte n1 = 30;
        // 可以吧byte类型直接赋值到int类型
        int b = n1;
        System.out.println(n1);
        System.out.println(b);
    }
}
```

![自动类型转换](java基础语法/image-20240922232218052.png)

#### 1.3 表达式自动类型转换

> 表达式类型转换是指：不同类型的变量或数据一起运算，最终的数据类型
>
> 表达式中，小范围类型的变量，会自动转换为表达式中较大范围的类型再参与运算
>
> 注意：
>
> - 表达式的最终结果类型由表达式中的最高类型决定
> - 在表达式中，byte、short、char是直接转为int类型参与运算的

![image-20240922232629156](java基础语法/image-20240922232629156.png)

```java
package com.basic.type;

public class MyName {
    public void typeStudy() {
        byte n1 = 30;
        int b = n1;
        long c = 40;
        // 表达式以最高类型决定
        long res = n1 + b + c;
        System.out.println(res);

        double res1 = n1 + b + c + 1.0;
        System.out.println(res1);

        // 注意，byte、short、char是直接转为int运算的
        byte f1 = 10;
        short f2 = 90;
        int f3 = f1 + f2;
        System.out.println(f3);
    }
}
```

#### 1.4 强制类型转换

> 类型大的数据或变量直接赋值给类型范围小的变量会报错
>
> 强制类型转换：
>
> - 强行将类型范围大的变量、数据赋值给类型范围小的变量

```java
// 格式
数据类型 变量2 = (数据类型)变量1
```

```java
package com.basic.type;

public class MyName {
    public void forceChangeType() {
        int a = 12;
        byte b = (byte) a;
        System.out.println(a);
        System.out.println(b);
    }
}
```

#### 1.5 字符串类型

> 字符串在JAVA中是引用类型

```java
String name = "sam";
```

### 4、变量定义

> 格式：数据类型 变量名 = 数据;

```java
// 数据类型 变量名 = 数据;
int age = 19;
```

### 5、运算符

#### 1.1 加减乘除

```java
package com.basic.type;

public class MyName {
    public void calcStudy() {
        int a = 10;
        int b = 2;
        System.out.println(a + b); // 12
        System.out.println(a - b); // 8
        System.out.println(a * b); // 20
        System.out.println(a / b); // 5
    }
}

```

#### 1.2 +连接符

> `+`符号与字符串运算的时候作为连接符，结果是字符串

```java
package com.basic.type;

public class MyName {
    public void combineString() {
        int age = 30;
        String b = "年龄:" + age;
        System.out.printf(b);
    }
}
```

#### 1.3 自增自减

> 自增：++ 放在变量前面或后面，对变量自身值加1
>
> 自增：-- 放在变量前面或后面，对变量自身值减1

```java
package com.basic.type;

public class MyName {
    public void incrNum() {
        int a = 20;
        a++;
        System.out.println(a);

        int b = 30;
        ++b;
        System.out.println(b);

        int c = 40;
        c--;
        System.out.println(c);

        int d = 40;
        --d;
        System.out.println(d);
    }
}
```

![自增自减注意事项](java基础语法/image-20240922234444314.png)

#### 1.4 关系运算符

> 和go语言关系运算符一样

![关系运算符](java基础语法/image-20240922234640896.png)

#### 1.5 逻辑运算符

> 逻辑运算符和go一样
>
> &&  逻辑与
>
> ||  逻辑或
>
> !   逻辑非

![image-20240922234947521](java基础语法/image-20240922234947521.png)

```java
package com.basic.type;

public class MyName {
    public void logicStudy() {
        int i = 10;
        int j = 30;
        System.out.println(i == 10 && j == 30); // true
    }
}

```

#### 1.6 三元运算符

> 格式：条件表达式?值1:值2

```java
package com.basic.type;

public class MyName {
    public void easyCalc() {
        int age = 30;
        String res = age == 30 ? "age == 30" : "age < 30";
        System.out.println(res); // age == 30
    }
}
```



## 二、流程控制

### 1、if-else

> if - else if - else流程控制和go一模一样

```java
package com.basic.type;

public class MyName {
    public void branchCheck() {
        int a = 30;
        if (a == 30) {
            System.out.println("a==30");
        } else if (a < 30) {
            System.out.println("a<30");
        } else {
            System.out.println("a>30");
        }
    }
}
```

### 2、switch

> 与go类似

```java
package com.basic.type;

public class MyName {
    public void switchStudy(int a) {
        switch (a) {
            case 30:
                System.out.println("a=30");
            case 40:
                System.out.println("a=30");
            default:
                System.out.println("a:" + a);
        }
    }
}

```

### 3、for循环

> 支持break、continue

```java
package com.basic.type;

public class MyName {
    public void forLoop() {
        for (int i = 0; i > 5; i++) {
            System.out.println(i);
        }
    }
}
```

### 4、while循环

> 支持break、continue

```java
package com.basic.type;

public class MyName {
    public void whileLoop() {
        int i = 5;
        while (i > 0) {
            System.out.println(i);
            i--;
        }
    }
}

```



## 三、数组

### 1、静态初始化数组

> 定义数组的时候给数组赋值

![image-20240923000652274](java基础语法/image-20240923000652274.png)

```java
package com.basic.type;

import java.util.Arrays;

public class ArrayStudy {
    public void arrayStatic() {
        // 完整格式
        int[] nums1 = new int[]{1, 2, 3, 4};
        // 简化格式
        int[] nums2 = {1, 2, 3, 4};

        // [1, 2, 3, 4]
        System.out.println(Arrays.toString(nums1));

        // [1, 2, 3, 4]
        System.out.println(Arrays.toString(nums2));
    }
}
```

### 2、动态初始化数组

> 定义数组时先不存入具体的元素值，只确定数组存储的数据类型和数组的长度
>
> 和go语言初始化数组一样

```java
// 格式
int[] arr = new int[3];
```

![image-20240923002631699](java基础语法/image-20240923002631699.png)



### 3、数组长度

```java
package com.basic.type;

public class ArrayStudy {
    public void arrayStatic() {
        // 简化格式
        int[] nums = {1, 2, 3, 4};

        // nums1.length
        // 下面长度: 4
        System.out.println(nums.length);
    }
}
```

### 4、数组遍历

> 数组使用for循环遍历

```java
package com.basic.type;

public class ArrayStudy {
    public void loopArray() {
        int[] nums = {1, 2, 3, 4, 5};
        for (int i = 0; i < nums.length; i++) {
            System.out.println("i=" + i);
        }
    }
}
```



## 四、方法

### 1、方法

> 方法封装了代码，方便重复调用，也就是函数

```java
// 格式
修饰符 返回值类型 方法名(形参列表) {
    方法的代码块;
    return 返回值;
}
```

> 下面是方法的一个例子

```java
package com.lystudy.func;

public class StudyFunc {
    public void Func1() {
        System.out.println("this is func1");
    }
}
```

### 2、方法传参

> 方法传参支持：
>
> - 基本数据类型
>   - int、double、short等
> - 引用类型
>   - String、array、接口

> 方法传参机制都是值传递
>
> - 基础数据类型参数是值传递，在方法传递进去的是`实参的副本`，在方法内部修改不会影响方法外形参的值
> - 引用类型参数也是值传递，在方法传递进去的是引用类型实参的`内存地址副本`，在方法内部修改会影响方法外引用类型实参的值

```java
package com.lystudy.func;

public class StudyFunc {
    public void Func1(String name, int age) {
        System.out.println("name=" + name);
        System.out.println("age=" + age);
    }
}
```

### 3、方法重载

> 方法重载是一个类中，出现多个方法的名称相同，但是他们的形参列表是不同的，那这些方法就是方法重载了
>
> 其实方法重载的原因就是java在方法里
>
> - 不支持默认值参数设置
> - 不支持可变长参数
>
> 所以才需要相同方法名，但是参数不同来支持，这就是方法重载

```java
package com.lystudy.func;

public class StudyFunc {
    public void Func1(String name, int age) {
        System.out.println("name=" + name);
        System.out.println("age=" + age);
    }

    public void reloadFunc1() {
        System.out.println("reload func1");
    }

    public void reloadFunc1(int name) {
        System.out.println("reload func1 name:" + name);
    }

    public void reloadFunc1(int name, int age) {
        System.out.println("reload func1 name:" + name);
        System.out.println("reload func1 age:" + age);
    }
}
```

> reloadFunc1方法出现了三次，但是每个的形参个数和类型都不一样，那reloadFunc1就实现了方法重载

## 五、面向对象

### 1、类的定义

> 类：一组属性或方法的集合，抽象了所有内容，实现了对象的模板
>
> 对象：从类实例化出来的一个对象
>
> 类中即可有变量、也可以有方法

```java
package com.lystudy.func;

public class StudyFunc {
    // public 修饰符表示这个是类的公共变量
    public String name;

    // 没有public修饰符表示这个是类的私有变量
    int age;

    public void showUserInfo() {
        System.out.println("这是showUserInfo类方法");
    }
}
```

#### 1.2 成员变量与局部变量

| 区别         | 成员变量                   | 局部变量                                   |
| ------------ | -------------------------- | ------------------------------------------ |
| 类中位置不同 | 类中，方法外               | 方法中                                     |
| 初始化值不同 | 有默认值，不需要初始化赋值 | 没有默认值，使用之前必须赋值               |
| 内存位置不同 | 堆内存                     | 栈内存                                     |
| 作用域不同   | 整个对象                   | 在所归属的大括号中                         |
| 生命周期不同 | 与对象公存亡               | 随之方法的调用而生，随着方法的运行结束而亡 |

### 2、实例化对象

#### 1.1 new关键字

> 类的实例化是用`new`关键字

```java
package com.lystudy.func;

public class StudyFunc {
    // public 修饰符表示这个是类的公共变量
    public String name;

    // 没有public修饰符表示这个是类的私有变量
    int age;

    public void showUserInfo() {
        System.out.println("这是showUserInfo类方法");
    }
}
```

> 实例化对象

```java
import com.lystudy.func.StudyFunc;

public class Main {
    public static void main(String[] args) {
        StudyFunc sf = new StudyFunc();
        System.out.println(sf);
    }
}
```

> 直接打印对象变量会得到内存地址

![image-20240923005520477](java基础语法/image-20240923005520477.png)

#### 1.2 public修饰符理解

> - public修饰符在类中可以将变量、方法变为公共变量、方法，那么实例化对象后，实例化对象就可以直接调用public修饰的变量或方法
>
> - public修饰符就和go语言的结构体中，结构体字段首字母大写、结构体方法名首字母大写，变为公共变量和公共方法，让外部文件可以实例化后调用，
>
> - 没有public修饰符的变量、方法，就默认都是私有变量、方法
>   - 实例化对象不可以调用
>   - 变量、方法只能在类内部类自我调用

### 3、this关键字

> - this是一个变量，在方法中可以拿到当前对象，比较好理解
>
>   - 类似于python语言的类中的self
>
>   - 类似于go语言的结构体方法的接收者
>
> - this可以用点`.`的方式调用类中的变量、方法
>
> - 哪个对象调用方法，this就指向哪个对象，也就是拿到哪个对象
> - this主要来解决：
>   - 解决对象的成员变量与方法内部变量的名称一样时，导致访问冲突问题

> 类定义

```java
package com.lystudy.func;

public class StudyFunc {
    // public 修饰符表示这个是类的公共变量
    public String name;

    // 没有public修饰符表示这个是类的私有变量
    int age;

    public void showUserInfo() {
        System.out.println("这是showUserInfo类方法");
    }

    public void showAge() {
        this.showUserInfo();
        int incrAge = this.age + 1;
        System.out.println("incrAge=" + incrAge);
    }
}

```

> 类实例化

```java
import com.lystudy.func.StudyFunc;

public class Main {
    public static void main(String[] args) {
        StudyFunc sf = new StudyFunc();

        // com.lystudy.func.StudyFunc@7a81197d
        System.out.println(sf);

        // incrAge=1
        sf.showAge();
    }
}
```

![image-20240923010543070](java基础语法/image-20240923010543070.png)

### 4、构造器

#### 1.1 构造器定义

> - 构造器就是构造函数，定义了类的初始状态
>   - 类比python的类中的`__init__`方法，也是接收参数，但是没有返回值，即没有return语句
> - 构造器定义
>   - 在类中定义一个方法名，方法名和类名一样就是构造器
> - 构造器是`可重载`，本质还是方法
> - 构造器可分为：
>   - 无参数构造器，构造器方法不传参
>   - 有参数，构造器方法支持传参
>
> 这块理解和python的面向对象的`__init__`方法一模一样

```java
package com.lystudy.func;

public class StudyFunc {
    // public 修饰符表示这个是类的公共变量
    public String name;

    // 没有public修饰符表示这个是类的私有变量
    int age;

    // 无参数构造器
    public StudyFunc() {
        this.age = 30;
    }

    // 有参数构造器
    public StudyFunc(int age) {
        this.age = age;
    }

    public void showUserInfo() {
        System.out.println("这是showUserInfo类方法");
    }

    public void showAge() {
        this.showUserInfo();
        int incrAge = this.age + 1;
        System.out.println("incrAge=" + incrAge);
    }
}
```

> 实例化对象

```java
import com.lystudy.func.StudyFunc;

public class Main {
    public static void main(String[] args) {
        StudyFunc sf1 = new StudyFunc();
        System.out.println(sf1);

        StudyFunc sf2 = new StudyFunc(13);
        System.out.println(sf2);
        sf2.showAge();

    }
}
```

![image-20240923011534588](java基础语法/image-20240923011534588.png)

#### 1.2 注意事项

##### 1.1.1 必须带public修饰符

> 构造器必须带public修饰符，变为公共方法可以给外部文件暴露，这样在其他文件才可以使用`new`调用

![image-20240923011643672](java基础语法/image-20240923011643672.png)

#### 1.1.2 未定义构造器方法实例化对象

> 当类中未定义构造器方法，那么使用`new`实例化对象时，java类会自己生成并调用一个无参数构造器进行实例化对象

### 5、封装

> 封装就是类设计对象处理某一个事物的数据时，应该要把处理的数据以及处理数据的方法涉及到一个对象中去

#### 1.1 设计规范

> - 合理隐藏
>   - 根据真正的业务逻辑实现
> - 合理暴露
>   - 需要合理暴露属性和方法

#### 1.2 公开和隐藏

> 公开成员：可以用public(公开)进行修饰
>
> 隐藏成员：使用private(私有，隐藏)进行修饰

### 6、实体JavaBean

> 实体类是一种特殊形式的类，要求
>
> - 某个类中的成员变量都是私有，并且要对外提供相应的getXxx，setXxx方法
> - 类中必须要有一个公共的无参的构造器
>
> 可以理解为数据仓库

#### 1.1 使用场景

> - 实体类只负责数据存取
>
> - 而对数据的处理交给其他类来完成，已实现数据和数据业务处理相分离

```java
package com.lystudy.func;

public class JavaBeanStudy {
    // 实体类的书写要求，特点、应用场景
    // 1.必须要有私有成员变量，并未每个成员变量提供get set方法
    private String name;
    private double score;

    // 2.必须为类提供一个公开的无参数构造器
    public JavaBeanStudy() {
    }

    // 3.可以生成一个带参数的构造器，比较方柏霓他人操作
    public JavaBeanStudy(String name, double score) {
        this.name = name;
        this.score = score;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }
}
```

> 操作类

```java
package com.lystudy.func;

// 操作数据类
// 将数据和数据操作分离开
public class StudentOperator {
    // JavaBean实体，默认都是private
    private Student student;

    public StudentOperator(Student student) {
        this.student = student;
    }

    public void showStudent() {
        if (student.getScore() >= 60) {
            System.out.println("大于60分，已经合格");
        } else {
            System.out.println("小于60分，学生成绩不合格");
        }
    }
}
```

#### 1.2 电影类实操

```java
package com.lystudy.func;

// javaBean 类
// 只用来保存数据
public class Movie {
    // 电影ID
    private int id;

    // 电影名
    private String name;

    // 电影价格
    private double price;

    // 电影分数
    private double score;

    // 电影导演
    private String director;

    // 电影演员
    private String actor;

    // 电影信息
    private String info;

    public Movie() {
    }

    public Movie(int id, String name, double price, double score, String director, String actor, String info) {
        this.id = id;
        this.name = name;
        this.price = price;
        this.score = score;
        this.director = director;
        this.actor = actor;
        this.info = info;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public String getActor() {
        return actor;
    }

    public void setActor(String actor) {
        this.actor = actor;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(String info) {
        this.info = info;
    }
}
```

```java
package com.lystudy.func;

public class MovieOperator {
    // 电影的数组
    private Movie[] movies;

    public MovieOperator(Movie[] movies) {
        this.movies = movies;
    }

    // 展示所有Movie电影信息
    public void printAllMovies() {
        System.out.println("---系统全部电影信息---");
        for (int i = 0; i < movies.length; i++) {
            Movie m = movies[i];
            System.out.println("编号：" + m.getId());
            System.out.println("名称：" + m.getName());
            System.out.println("价格：" + m.getPrice());
            System.out.println("---------------");
        }
    }


    // 根据ID查询电影信息
    public void queryMovieInfoById(int id) {
        for (int i = 0; i < movies.length; i++) {
            Movie m = movies[i];
            if (m.getId() == id) {
                System.out.println("---id=" + id + "，该电影信息如下---");
                System.out.println("编号：" + m.getId());
                System.out.println("名称：" + m.getName());
                System.out.println("价格：" + m.getPrice());
                System.out.println("导演：" + m.getActor());
                return;
            }
        }
        System.out.println("---id=" + id + "，电影未找到---");
    }
}
```

## 六、常用API

### 1、包

> 包主要是用来分门别类的管理不同程序的，类似于文件夹，建包有利于程序的管理和维护

```java
// 语法
package com.slowNo.javabean;
public class Student{
    ...
}
```

#### 1.1 导包

> - 如果在当前程序中，要调用自己所在包下的其他程序，可以直接调用（同一个包下的类，互相可以直接调用）
>
> - 访问其他包下的程序，必须导入包才可以访问
> - 在自己的程序中调用Java提供的程序，也需要先导入包才可以使用
>   - Java.Lang包下的程序不需要我们导入，可以直接使用
> - 访问多个其他包下的程序，这些程序名又一样的情况，那么默认只能导入一个程序，另一个程序必须带包名和类型来访问

```java
// 导包语法
import com.xx.xxx
```

### 2、String

> String主要用来处理字符串
>
> String类表示字符串

#### 1.1 

















