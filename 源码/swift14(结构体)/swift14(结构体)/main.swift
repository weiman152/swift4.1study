//
//  main.swift
//  swift14(结构体)
//
//  Created by iOS on 2018/10/15.
//  Copyright © 2018年 weiman. All rights reserved.
//

import Foundation

// 结构体（二）
/*
 继续上节内容，学习结构体的相关知识。
 上一节的学习中，我们主要学习了结构体中的属性，包括：
 1.存储式实例属性
 2.惰性存储式属性
 3.计算式属性
 4.属性观察者
 5.类型属性
 
 本节，我们来学习结构体中的方法，包括：
 1.实例方法
 2.类型方法
 3.初始化器方法
 4.逐成员的初始化器方法
 5.值类型的初始化器代理
 6.可失败的初始化器
 7.下标语法
 */

// 1. 实例方法
/*
 定义：当我们在枚举、类、结构体类型中定义一个函数时，该函数被称为“方法”。
 
 每个实例方法都具有一个隐式的属性 self ，它指向调用此方法的对象实例，所以self的类型为当前对象的类型。
 */

do {
    
    struct Test {
        // 存储属性
        var a = 10
        
        let s = "hello"
        
        func printS() {
            // 这里，self可以省略。
            print("a = \(a)")
            print("s = \(s)")
        }
        
        // 由于这个方法中，对实例属性进行了修改，所以需要加上mutating关键字。
        mutating func method2(a: Int) {
            // 这里的参数 a 与 实例属性 a重名，所以需要加上self加以区分。
            self.a += a + 1
        }
        
        // 将关联的对象实例重新修改为默认状态。
        mutating func method3() {
            self = Test()
        }
    }
    
    var test = Test()
    test.method2(a: 10)
    test.printS()
    test.method3()
    test.printS()
}

// 实例方法的引用
/*
 由于实例方法必须要与某一对象实例进行关联，所以我们用一个函数引用对象指向某一对象实例的方法时
 需要将对象实例也一起带上。
 */

do {
    
    print("\n")
    
    struct Test {
        var property = 100
        
        mutating func method(a: Int) {
            property += a
        }
        
        func foo(_ : Void = ()) {
            print("property = \(property)")
        }
        
        func foo(a: Int) {
            print("value = \(property + a)")
        }
    }
    
    var test = Test()
    test.property += 10
    
    // 这里通过method方法签名来对它进行调用。
    // 由于mutating方法不允许通过函数引用对象对它进行引用，
    // 所以这里只能直接通过方法签名做直接调用，
    // 这是允许的。
    test.method(a:)(5)
    
    let ref = { test.method(a: 6) }
    ref()
    
    let ref1 = test.foo(_:)
    ref1(())
    
    let ref2 = test.foo(a: )
    ref2(10)
    
    /*
     小结：
     对实例方法的引用必须包含与它关联的对象实例。
     */
}

// 2. 类型方法
/*
类型方法与类型属性类似，是与类型相关联的方法，而不是对象实例。
 定义一个类型方法也很简单，直接在func 前面添加static就可以了。
 如果当前类型是类类型，那么我们还能使用class关键字修饰，表示当前类型方法能够被子类重写。
 如果在类类型中用了static关键字修饰，那么该类型方法不允许被子类重写。
 */

do {
    
    print("\n")
    
    struct Test {
        static var a = 100
        
        /// 类型方法
        static func method() {
            // 可以修改类型属性
            self.a += 20
            print("method: a = \(a)")
        }
        
        static func getValue(a: Int) -> Int {
            return self.a + a
        }
        
        static func foo(_: Void) {
            print("这是一个foo")
        }
        
        /// 重载方法
        static func foo(a: Int) {
            print("a = \(a)")
        }
    }
    
    // 调用类型方法method
    Test.method()
    
    let a = Test.getValue(a: 5)
    print("a = \(a)")
    
    var ref = Test.foo(_:)
    ref(())
    
    let ref2 = Test.foo(a: )
    ref2(1)
    
    /*
     打印结果：
     method: a = 120
     a = 125
     这是一个foo
     a = 1
     */
}

// 3. 初始化器方法
/*
 初始化器方法用于在创建一个类、结构体或者枚举类型的对象实例时为该对象的实例属性进行初始化。
 在swift中使用init关键字表示当前类型的初始化器方法，然后后面跟着形参列表。
 注意：
 由于一个类型的初始化器方法肯定返回它所创建的对象实例，因此其返回类型不需要写，就是当前类型本身。
 */

do {
    
    struct Test {
        var a = 10
        let b: Float
        var c: String
        var d: Int?
        
        init() {
            b = 1.0
            self.c = "Hello"
        }
    }
    // 省略init
    var test = Test()
    test = Test.init()
    
    let ref = Test.init
    test = ref()
}

// 4. 逐成员的初始化器方法
/*
 对于结构体类型，有一种默认的初始化形式，叫做逐成员的初始化器方法。
 当我们在结构体中定义了一些存储式属性，并没有对他们进行初始化，也没有显示的提供初始化器方法，那么
 我们在用该结构体去创建一个对象实例时就可以使用逐成员的初始化方法来为该结构体对象中的每个存储式实例属性
 进行指定具体的值。
 */

do {
    
    print("\n")
    
    struct Test: CustomStringConvertible {
        var a = 10
        let b: Float
        var c: String
        var d: Int?
        
        var description: String {
            return "a = \(a), b = \(b), c = \(c), d = \(d)"
        }
    }
    // 逐成员的初始化器方法
    let test = Test.init(a: 10, b: 1.9, c: "生活在社会底层，也要努力活着。", d: 8)
    print("test : \(test)")
}

// 5. 值类型的初始化器代理
/*
 当我们在一个初始化器方法中调用另一个初始化器方法以执行对一个对象实例的部分初始化，那么这个过程就
 叫做初始化器代理。
 */

do {
    
    print("\n")
    
    struct Test {
        var a = 10
        let b: Float
        var c: String
        var d: Int?
        
        init(b: Float) {
            self.b = b
            c = ""
        }
        
        init(b: Float, c: String) {
            self.init(b: b)
            self.c = c
        }
        
        init(b: Float, c: String, d: Int) {
            self.init(b: b, c: c)
            self.d = d
        }
    }
    
    var test = Test.init(b: 1.0)
    test = Test.init(b: 2.0, c: "OK")
    print("test: \(test)")
    test = Test.init(b: 3.4, c: "哈啊哈哈", d: 8)
    print("test: \(test)")
}

// 6. 可失败的初始化器
/*
 有时候需要定义某些类型，这些类型根据用户的输入或者当前的执行环境可能造成其对象实例的创建失败，此时
 我们可以使用“可失败的初始化器”。
 可失败的初始化器可根据当前条件返回空值。因此，当我们使用可失败的初始化器来创建一个对象时，该对象的
 类型为Optional类型。
 */

do {
    
    print("\n")
    
    struct Test {
        var a: Int
        
        init? (value: Int) {
            if value == 0 {
                return nil
            }
            
            a = 100 / value
        }
    }
    
    let test = Test(value: 0)
    if test == nil {
        print("failed")
    } else {
        print("test: \(test)")
    }
}

// 7. 下标语法
/*
 swift语言中，允许我们在自定义类型中使用下标。
 */

do {
    
    print("\n")
    
    struct Test {
        // 存储式实例属性a
        var a = 10
        
        // 定义下标方法
        subscript(index: Int) -> Int {
            
            get {
                return a + index
            }
            
            set(value) {
                a = value + index
            }
        }
        
        subscript(str: String) -> Int {
            return str.count
        }
        
        subscript(value: Int, str: String) -> Int? {
            get {
                guard let count = Int(str) else {
                    return nil
                }
                
                return value + count
            }
            
            set {
                if let data = newValue, let strValue = Int(str) {
                    a = value + data + strValue
                }
            }
        }
        
        subscript(_: Void) -> Int {
            
            get {
                return a
            }
            
            set {
                a = newValue
            }
        }
    }
    
    var test = Test()
    /// 这里调用了test对象的小标方法subscript(index: Int)的setter方法
    test[1] = 10
    print("test[5] = \(test[5])")
    //打印：test[5] = 16
    
    print("count = \(test["abc"])")
    
    test[2, "123"] = 100
    
    print("test: \(test)")
}

// 8. key path
/*
 有时候，一个结构体、枚举或者类类型中的某个属性的类型比较复杂，类型嵌套比较深，在swift4中，引入了
 Smart KeyPaths这一概念来简化对一些嵌套比较深的属性访问。
 
 */

do {
    
    print("\n")
    
    struct MyRect {
        
        struct Point {
            var x: Float
            var y: Float
        }
        
        struct Size {
            var width: Float
            var height: Float
        }
        
        var position: Point
        
        var size: Size
    }
    
    struct MyStruct {
        var property: Int
        var rect: MyRect
    }
    
    /// 这里用Smart KeyPath字面量
    /// 定义一个widthKeyPath关键路径，
    /// 它是对MyStruct.rect.size.width
    /// 这一实例属性的访问路径
    let widthKeyPath = \MyStruct.rect.size.width
    
    var obj = MyStruct(property: 10, rect: MyRect(position: MyRect.Point(x: 0.0, y: 1.0), size: MyRect.Size(width: 10.0, height: 20.0)))
    let width = obj[keyPath: widthKeyPath]
    print("width: \(width)")
    
    obj[keyPath: \MyStruct.rect.position.x] += obj.rect.position.y * 8.0
    print("x = \(obj.rect.position.x)")
}



