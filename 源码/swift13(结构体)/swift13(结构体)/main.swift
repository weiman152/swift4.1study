//
//  main.swift
//  swift13(结构体)
//
//  Created by iOS on 2018/10/12.
//  Copyright © 2018年 weiman. All rights reserved.
//

import Foundation


/*
 结构体
 大部分语言中都会有结构体。swift中的结构体属于四大基本类型(函数、枚举、结构体、类)之一，他属于值类型。
 标准库中的很多类型都是结构体类型，像Int、Float、String、Array。
 
 swift中的结构体还有很多灵活的语法特性：
 
 1. 可定义存储式实例与类型属性；
 2. 可定义计算式实例与类型属性；
 3. 可使用属性观察者；
 4. 可定义实例与类型方法；
 5. 可定义初始化器；
 6. 可定义数组下标；
 7. 可对结构体进行扩展；
 8. 可遵循协议。
 
 */

// 1. 结构体基本语法
do {
    struct myStruct {
        
        /// 属性
        let name = "小蓝"
        let age = 10
        var nationality: String
        
        /// 初始化器
        init() {
            nationality = "美国"
        }
        
        /// 实例方法
        func study() {
            print("好好学习，天天向上")
        }
    }
    
    /// 创建结构体的实例，访问其属性以及实例方法
    var xiaoming = myStruct()
    print("\(xiaoming.name), \(xiaoming.age), \(xiaoming.nationality)")
    
    xiaoming.study()
    
    xiaoming.nationality = "新加坡"
    print("\(xiaoming.name)修改了国籍，去了\(xiaoming.nationality)")
}

// 2. 存储式实例属性
/*
 存储式实例属性是结构体与类类型中最简单的属性形式。我们直接在这些类型中使用var或者let来声明
 一个变量或者常量，另外也可以直接对它们进行初始化，那么这些声明在类型中的对象就成为该类型的存储式
 实例属性。
 */

do {
    
    print("\n")
    
    struct Test {
        
        /// 存储式实例属性
        let year = 2018
        var language = "汉语"
        var array = [1, 2, 3, 4]
        let tuple = (1.0, "a", true)
        let null: Void = ()
    }
    
    var test = Test()
    test.language += "、英语"
    test.array += [4, 5]
    
    var test2 = test
    test2.language = "西班牙语"
    test2.array.removeLast()
    
    print("test = \(test)")
    print("test2 = \(test2)")
    
    // 小结：由此可以看出，struct是值类型。
    
}

// 3. 惰性存储式属性(懒加载)
/*
 当一个对象实例被创建的时候，其所有的存储式实例属性都会完成初始化。不过，有时候，我们会将一些
 耗费资源的属性声明成惰性存储式属性，当我们使用的时候才会去创建它。
 惰性存储属性在声明的时候在前面加上 lazy 关键字。并且只能用var来声明，不能用let，这个就不用解释了。
 */

do {
    
    print("\n")
    
    func fetchData() -> Int {
        print("data fetched")
        return 100
    }
    
    struct Test {
        // 声明一个惰性存储式实例属性prop, 当它被第一次访问的时候才会调用fetchData函数
        // 对它进行初始化。
        lazy var prop = fetchData()
    }
    
    var test = Test()
    print("test被创建了")
    
    // 第一次访问
    test.prop += 10
    // 第二次访问
    print("test.prop = \(test.prop)")
}

// 4. 计算式属性
/*
 swift 是一门主张简洁、直观的编程语言。如果一些属性可以不通过用户的输入获得，而是通过已有的属性计算
 获得，我们就可以使用计算式属性。
 */

do {
    
    print("\n")
    
    /// 圆结构体
    struct Circle {
       
        /// 半径
        var radius = 0.0
        /// 计算属性:直径
        var diameter: Double {
            get {
                return radius * 2.0
            }
            
            set {
                radius = newValue / 2.0
            }
        }
        
        /// 计算属性：周长
        var perimeter: Double {
            get {
                return Double.pi * self.diameter
            }
            set {
                diameter = newValue / Double.pi
            }
        }
        
        /// 计算属性： 面积
        var area: Double {
            get {
                return Double.pi * radius * radius
            }
            set {
                radius = sqrt(newValue / Double.pi)
            }
        }
    }
    
    var circle = Circle()
    circle.radius = 3.0
    
    print("直径： \(circle.diameter), 周长： \(circle.perimeter), 面积： \(circle.area)")
    
    /*
     注意：
     计算式属性的setter方法可以缺省，但是getter方法不可以缺省。如果setter方法省略了，那么这个
     计算式属性就变成了只读属性。
     */
    
    /// 再举一个”矩形“的例子
    struct Rect {
        var width = 0.0
        var height = 0.0
        
        /// 对角线
        var diagonal: Double {
            get {
                return sqrt(width * width + height * height)
            }
        }
        
        /// 周长
        /// 如果只有getter方法，get {} 关键字可以省略
        var perimeter:Double {
            return 2 * (width + height)
        }
        
        /// 面积
        var area: Double {
            return width * height
        }
    }
    
    var rect = Rect()
    rect.width = 2.0
    rect.height = 3.0
    print("对角线： \(rect.diagonal), 周长： \(rect.perimeter), 面积： \(rect.area)")
}

// 5. 属性观察者
/*
 有时候为了逻辑上的简化需要，我们可能需要获取某个存储属性的值当前被修改了，从而可以做一些输入值的过滤
 或者其他操作。swift中使用”属性观察者“这一语法特性，从而提供了针对存储式属性值的变化的响应。
 关键字：
 willSet:指定属性修改前，会调用它的willSet方法；
 didSet:指定属性修改后，会调用didSet。
 */

do {
    
    print("\n")
    
    struct Test {
        /// 观察number属性的变化
        var number = 0 {
            
            // 注意：隐式参数newValue
            willSet {
                print("current value = \(number)")
                print("new value = \(newValue)")
            }
            // 注意：隐式参数oldValue
            didSet {
                print("original value  = \(oldValue)")
                print("modified value = \(number)")
            }
        }
    }
    
    var test = Test()
    test.number = 10
    
    test.number = 20

}

// 6.类型属性
/*
 之前介绍的都是实例属性，实例属性的特点就是当前枚举、结构体、类等类型的对象实例各自持有各自的
 实例属性，它们占据着对象实例自身的存储空间。
 类型属性：类型属性就属于类型自己，与用该类型所创建的实例无关。
 声明方法很简单：
 在前面加上 static 关键字就可以了。
 */

do {
    
    print("\n")
    
    struct Test {
        /// 类型属性
        static var ti = 10
        
        static var cp: Int {
            get {
                print("get ti = \(ti)")
                return ti - 10
            }
            
            set {
                print("setter value = \(newValue)")
                ti = newValue + 10
            }
        }
        
        static var str = "Hello" {
            willSet {
                print("current \(str)")
                print("new: \(newValue)")
            }
            didSet {
                print("old: \(oldValue)")
                print("修改后： \(str)")
            }
        }
        
        static let si = 1.5
        // 注意，这两个变量可以重名，不会报错。
        var si = -1
        
    }
    
    var test = Test()
    test.si += 2
    print("实例属性 si = \(test.si)")
    
    print("类型属性 si = \(Test.si)")
    
    Test.ti += 100
    print("类型属性 ti = \(Test.ti)")
    
    Test.cp += 5
    
    Test.str += "，小雨"
    
    func foo() {
        
        struct Test {
            static var ti = -10
            static let si = -1.5
        }
        
        /// 这里的调用的Test是foo中的Test
        print("foo ti = \(Test.ti)")
        print("foo si = \(Test.si)")
        
    }
    
    foo()
}

