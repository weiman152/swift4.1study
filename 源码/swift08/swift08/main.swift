//
//  main.swift
//  swift08
//
//  Created by iOS on 2018/9/28.
//  Copyright © 2018年 weiman. All rights reserved.
//

import Foundation

//swift学习笔记8

/*
 1. for-in 循环
 swift中使用for-in循环还是很频繁的。在swift中，没有OC中的for（,,）{}循环了，遍历数组、字典、
 区间、字符串等都是使用for-in循环。
 */

do {
    // 1.遍历数组
    let names = ["小明", "Ann", "小蓝", "张三"]
    for name in names {
        print("Hello, \(name)")
    }
    
    //2.遍历字典
    let numbersOfLegs = ["蜘蛛": 8, "螃蟹": 8, "猫咪": 4, "蚂蚁": 6]
    for (name, legs) in numbersOfLegs {
        print("\(name) have \(legs) legs")
    }
    
    //3.遍历范围
    for index in 1...5 {
        print("\(index) * 5 = \(index * 5)")
    }
    
    /*
     注意：
     上面例子中的循环变量是不需要显式声明的，它是一个每次循环开始时被自动赋值的常量。
     如果不需要它，可以使用 _ 代替。
     */
}

// 2. while循环
/*
 swift中的while循环与C语言类似，语法为：
 while 表达式 {
    ...
 }
注意：
 1.这里的表达式可以省略小括号
 2.花括号不能省略，哪怕只有一条语句
 */

do {
    
    // 计算1到10000的求和
    var sum = 0
    var num = 1
    while num <= 10000 {
        sum += num
        num += 1
    }
    
    print("sum = \(sum), num = \(num)")
    
    //计算10的阶乘
    num = 10
    var f = 1
    while num > 1 {
        f = f * num
        num -= 1
    }
    print("f = \(f)")
}

/*
 break语句：跳出当前循环体；
 continue语句: 跳过当前这一次的循环，继续下一次循环。
 */

do {
    var i = 3
    while i > 0 {
        var j = 4
        while j > 0 {
            print("i = \(i), j = \(j)")
            j -= 1
            if i + j < 3 {
                break
            }
        }
        i -= 1
        if i == 2 {
            continue
        }
        print("外层 i = \(i)")
    }
    
    /*
     i = 3, j = 4
     i = 3, j = 3
     i = 3, j = 2
     i = 3, j = 1
     i = 2, j = 4
     i = 2, j = 3
     i = 2, j = 2
     i = 2, j = 1
     外层 i = 1
     i = 1, j = 4
     i = 1, j = 3
     i = 1, j = 2
     外层 i = 0
     */
}

//3. repeat-while循环
/*
 语法：
 repeat {
  ...
 }
 while 表达式
 执行逻辑： 先执行repeat语句块中的语句，然后判断表达式是否为真，如果为真就继续执行repeat语句块
 的语句，如果为假，就停止循环，继续执行while下面的语句。
 */
do {
    // 计算1到10的和
    var sum = 0
    var num = 10
    repeat {
        sum += num
        num -= 1
    }
    while num > 0
    print("sum = \(sum), num = \(num)")
    
    // 10的阶乘
    var jc = 1
    var n = 10
    repeat {
        jc *= n
        n -= 1
        print("n = \(n), jc = \(jc)")
    }
    while n > 0
    print("10! = \(jc)")
}

// 4. 标签语句
/*
 标签语句是做什么的？
 可以方便地跳出指定的do语句块、if语句块、switch语句块、for-in语句块、
 while语句块或者repeat语句块。
 如何跳出？
 当我们需要跳出指定的语句块的时候，我们可以在语句块之前加上标签，然后通过
 break label
 语句跳出。
 在循环体中，标签也可以与continue一起使用跳过某个指定循环的当前迭代，直接执行下一次迭代。
 */

do {
    var a = 100
    label: do {
        label2: if a > 50 {
            break label
        }
        else {
            label3:if a < 50 {
                break label3
            }
            else {
                break label2
            }
            
        }
        break label
    }
}

/*
 个人建议：
 标签语句会破坏代码的可读性，建议尽量少的使用，不然时间一长，自己都不知道这块为什么要这样跳来跳去的
 */
