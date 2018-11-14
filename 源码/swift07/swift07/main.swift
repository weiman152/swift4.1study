//
//  main.swift
//  swift07
//
//  Created by iOS on 2018/9/28.
//  Copyright © 2018年 weiman. All rights reserved.
//

import Foundation

//swift学习笔记07

/*
 控制流语句
 学过任何一种语言的小伙伴们都对控制流语句不陌生，几乎每一天都在用。
 控制流分类：
 1.分支
 2.循环
 */

/*
 1. do语句块
 这个语句块在我之前的学习中一直在使用，是一种在学习中很方便的写代码的方式。
 作用：
 1》作为一个单独的作用域，声明的局部对象外部是无法访问的。
 
 允许嵌套，如果内部的变量名字与外部相同，则会访问内部变量。
 */
do {
    let a = 1, b = 2
    do {
        let a = 10
        let b = 20
        let c = 5
        
        do {
            let a = 30
            let b = 40 + c
            
            print("最里层： a = \(a), b = \(b), c = \(c)")
            //a = 30, b = 45, c = 5
        }
        print("第二层： a = \(a), b = \(b), c = \(c)")
    }
    print("最外层： a = \(a), b = \(b)")
}

/*
 swift中如果不用do引出，而是单单用花括号{ }，那么它默认表达的是一个闭包表达式，而不是一个语句块。
 */

/*
 2.if语句
 注意：
 1》swift中if语句中的条件表达式的圆括号可以省略
 2》swift中if语句中的花括号不能省略，即使只有一条语句
 */

do {
    let a = 0, b = 10
    if a == 0 {
        print("a = 0")
    } else {
        print("a != 0")
    }
    
    if a + b > 10 {
        print("大于10")
    } else if a + b == 10 {
        print("等于10")
    } else {
        print("小于10")
    }
    
    /*
     初学者要注意
     if 表达式 {
     
     } else if 表达式 {
     
     }
     与
     if 表达式 {
     
     }
     if 表达式 {
     
     }
     这两者之间的不同
     */
}

/*
 3. 三目条件操作符
 表达式 ? 语句1 ：语句2
 意思是： 如果表达式==true，执行语句1，否则执行语句2
 是对if...else 语句的一种更加简单的表达
 */

do {
    var a = 1, b = 2
    a = a > 0 ? a + b : a - b
    print("a = \(a)")
    
    b = a > b ? a : b
    print("b = \(b)")
    
    /*
     注意： 三目运算符中的 ？一定要与表达式之间有空格，不然会被当做可选类型的？。最好三目运算符表达式之间都要加空格。
     */
}

/*
 4. switch语句
 条件选择多于等于三条的时候，就要考虑使用switch语句，使得逻辑更加的清晰。
 switch 表达式 {
 case 条件1：
 case 条件2：
 ...
 注意：
 1》swift中，switch后面的表达式可以是void类型。
 2》一般情况下switch语句块中，最后会跟一个default标签，以处理异常情况。但是，
 当switch的case语句已经列举了所有类型之后，default就不需要了，如果加了不必要的default，
 编辑器会报出警告。
 3》swift语言中，switch后面的表达式可以是任何遵循了Equatable协议的类型的表达式，
 甚至还可以是一个元类型。
 但是case后面的表达式必须是表示值类型的表达式。
 4》所有的case语句包括default语句都必须至少包含一条语句。
 5》默认情况下，执行完一个case语句块之后直接跳出switch，而不需要显式添加break语句。
 当我们在某些情况下想跳出当前的case语句的时候，可以使用break语句，跳出整个switch语句块。
 
 switch 常常与 enum 一起使用
 }
 
 */
do {
    enum Type: String {
        case iphone5 = "iphone5"
        case iphone6 = "iphone6"
        case iphone7 = "iphone7"
        case iphone8 = "iphone8"
        case iphoneX = "iphoneX"
    }
    
    var type: Type = .iphoneX
    type = .iphone6
    
    switch type {
    case .iphone5:
        print(type)
    case .iphone6:
        print(type)
    case .iphone7:
        print(type)
    case .iphone8:
        print(type)
    case .iphoneX:
        print(type)
    }
    
}

do {
    
    class Test: CustomStringConvertible {
        var a = 0, b = 100
        init(a: Int, b: Int) {
            self.a = a
            self.b = b
        }
        
        var description: String {
            return "a = \(a), b = \(b)"
        }
        
    }
    
    let t = Test.init(a: 5, b: 10)
    let q = Test.init(a: 6, b: 88)
    
    switch t {
    case let obj:
        print("obj = \(obj)")
        print("value = \(obj.a + t.b)")
    }
    
    switch type(of: t) {
    case let type:
        print("type is :\(type)")
    }
    
    switch type(of: q) {
    case let type:
        print("type is :\(type)")
    }
}

do {
    struct MyObject: Equatable {
        var a = 0
        var b = 1
        
        public static func == (lhs: MyObject, rhs: MyObject) -> Bool {
            return (lhs.a == rhs.a && lhs.b == rhs.b)
        }
    }
    
    let obj = MyObject(a: 3, b: 4)
    let obj2 = MyObject(a: 3, b: 3)
    
    switch obj {
    case MyObject():
        print("dummy object")
    case obj2:
        print("obj2")
    case MyObject(a:3, b:4):
        print("correct object")
    default:
        print("no match")
    }
    
    //打印出：correct object
}

/*
 5. case匹配模式
 swift编程语言中的case匹配非常的丰富，除了上面已经介绍过的匹配方式，还有
 1》复合case匹配，
 2》区间匹配，
 3》值绑定匹配形式
 4》以及where从句引出的谓词逻辑匹配。
 
 */

//1>复合case匹配
/*
 概念：一条case语句可以包含多个表达式，各个表达式之间用逗号分隔，这些表达式之间只要有一个能与
 switch表达式匹配上，那就执行该case下的语句。
 */

do {
    var a: Int8 = 10
    switch a {
        //复合case
    case 0, 1, 2:
        print("zero")
       //case后面的表达式亦需要一定是常量和字面量，也可以是变量
    case a + 1, a:
        print("加1")
        a = a + 1
        print("a = \(a)")
    default:
        break
    }
}

// case后面还可以跟一个范围表达式
do{
    let score = 88
    switch score {
    case 0..<60:
        print("不及格")
    case 60..<80:
        print("良好")
    case 80..<99:
        print("优")
    case 100:
        print("完美")
    default:
        break
    }
}

// swift语言中case匹配还有一个强大的功能——值绑定
/*
 一般情况下，我们可以直接在case后面直接跟let或者var声明一个局部对象，以捕获switch后面表达式的值。
 该对象只能在当前的case中可见。不需要default标签。
 */

do {
    let a = 8
    switch a {
    case 0, 1, 2..<5:
        print("正产值")
    case let v:
        print("v = \(v)")
    }
    
    switch a {
    case var v:
        v += 1
        print("v = \(v)")
    case 100:
        print("永远不会执行")
    }
    
    print("a = \(a)")
}

//基于值绑定基础上使用where从句
/*
 where后面直接跟一个bool表达式，表示当该表达式为真的时候则匹配当前的case，
 这么一来，只绑定也无法覆盖所有的case情况了，所以需要default处理。
 */

do {
    let a = 8
    switch a {
    case let v where v > 0 && v < 3:
        print("正常值")
    case let v where v >= 3 && v <= 10:
        print("\(v)在[3,10]之间")
    default:
        print("别的值")
    }
}

// 6. case 匹配模式用于元组对象

do{
    let tuple = (8, 9)
    switch tuple {
    case (0, 0):
        print("0")
    case (1, 2), (3, 4):
        print("one")
    case (5, 6), (7, 8):
        print("two")
    case (_, 8):
        print("哈哈哈哈")
    case (1...3, 5..<10), (_, 4...9):
        print("区间")
    default:
        print("其他值")
    }
}

/*
 说明：
 switch语句中的直通
 for-in循环
 省略
 为什么呢？
 因为我使用的电子书这部分内容有些损坏。
 */
