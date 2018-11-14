//
//  main.swift
//  swift20(类型定义投射)
//
//  Created by iOS on 2018/10/28.
//  Copyright © 2018年 weiman. All rights reserved.
//

import Foundation

/*
 今天为止，我们终于把swift中大部分的数据类型都给细细的学习了一遍。也写了很多很多的测试代码，相信大家对swift应该有了全新的认识。接下来我们继续学习swift语言的一些特性。
 
本节呢，我们来学习 类型定义和类型投射等操作
在本节中，我们也能领略swift编程语言的动态特性。
 
 */

// 1.类型定义
/*
 学过C语言的小伙伴们都知道有类型别名的概念，就是将已经定义好的类型定义为我们自己所指定的自定义类型。
 swift中，使用typealias关键字声明。
 
 //typealias <#type name#> = <#type expression#>
 */

do {
    
    print("\n-----------1.类型定义----------------\n")
    
    // 这里将MyInt定义为Int32类型
    typealias MyInt = Int32
    
    // 这里将MyArray定义为一个整型数组
    typealias MyArray = [MyInt]
    
    // 这里将VoidFuncType定义为 () -> Void 的函数类型
    typealias VoidFuncType = () -> Void
    
    // 这里将Tuple定义为(Int, Float, String)的元组
    typealias Tuple = (Int, Float, String)
    
    // 使用
    // 这里的a的类型是MyInt ，实际上相当于Int32类型
    let a: MyInt = 100 + MyInt.min
    print("a = \(a)")
    
    let array: MyArray = [1, 2, 3]
    print("array: \(array)")
    
    let tuple: Tuple = (10, 1.5, "abc")
    print("tuple: \(tuple.0)")
    
    func foo() {
        print("今天天气不错 ")
    }
    
    let ref: VoidFuncType
    ref = foo
    ref()
}

//2. 元类型
/*
 什么是元类型？
 元类型是指可引用某个类型的类型对象的类型。
 有点儿像绕口令，不甚明白。
 */

protocol Prot {
    
    /// 计算式属性
    static var s: Int { get }
    
    /// 类型方法
    static func method()
}

do {
    
    print("\n----------2. 元类型------------\n")
    
    struct MyStruct: Prot {
        
        static var s: Int {
            return 1
        }
        
        static func method() {
            print("这是一个结构体")
        }
    }
    
    class MyClass: Prot {
    
        static var s: Int {
            return 100
        }
        
        static func method() {
            print("这是一个类")
        }
    }
    
    /*
     这里使用MyStruct结构体的元类型定义了一个类型对象st，其类型是MyStruct.Type，
     而MyStruct.self 则是MyStruct这一类型的实体。
     */
    let st: MyStruct.Type = MyStruct.self
    
    /*
     这里用MyClass类的元类型定义了一个类型对象ct，其类型是MyClass.Type， MyClass.self是
     这一类型的实体。
     */
    let ct: MyClass.Type = MyClass.self
    
    /*
     这里使用Prot的元类型定义了一个类型对象pt,然后指向了st的元类型实体。
     */
    var pt: Prot.Type = st
    
    print("pt: \(pt.s)")
    pt.method()
    
    pt = ct
    print("pt: \(pt.s)")
    pt.method()
    
    /*
     结果：
     pt: 1
     这是一个结构体
     pt: 100
     这是一个类
     */
    
    /*
     小结：
     从这里可以看出，元类型能够使用同一个对象指向不同类型的实体。
     */
}

/*
 swift中，不仅类类型可以访问self属性，对象也是可以访问self的，只不过得到的结果不是元类型实体
 而是自身的值。
 */

do {
    
    let a = 10.self
    print("a = \(a)")
    
    let tuple = (10, 12.3, "哈哈哈").self
    print("tuple: \(tuple)")
}

//3. 类型获取
/*
 上面我们了解到元类型以及元类型实体。在传递的过程中，我们想知道目前对象指向的到底是什么类型呢？
 这个时候我们就能使用 “类型获取”来了解当前的类型。
 */

print("\n--------------3. 类型获取----------------\n")

protocol PA {
    
    static var s: Int { get }
    static func method()
    init()
    func foo()
}

do {
    
    struct MyStruct: PA {
        
        static var s: Int {
            return 10
        }
        
        static func method() {
            print("哈哈哈哈，结构体啊")
        }
        
        func foo() {
            print("结构体中的方法")
        }
    }
    
    class MyClass: PA {
        
        static var s: Int {
            return 100000
        }
        
        static func method() {
            print("哟呼呼， 这是一个类")
        }
        
        func foo() {
            print("这是一个类中的方法")
        }
        
        required init() {
           print("这是一个类的初始化方法")
        }
        
        deinit {
            print("类被销毁了")
        }
    }
    
    // 定义一个方法，参数是PA的元类型
    func typeFetch(t: PA.Type) {
       
        print("value: \(t.s)")
        t.method()
        
        let obj = t.init()
        print("obj: \(obj)")
        obj.foo()
    }
    
    let ms: PA = MyStruct()
    let mc: PA = MyClass()
    
    typeFetch(t: type(of: ms))
    typeFetch(t: type(of: mc))
    
    /*
     结果:
     这是一个类的初始化方法
     value: 10
     哈哈哈哈，结构体啊
     obj: MyStruct()
     结构体中的方法
     value: 100000
     哟呼呼， 这是一个类
     这是一个类的初始化方法
     obj: swift20_类型定义投射_.(unknown context at 0x1004e634c).MyClass
     这是一个类中的方法
     类被销毁了
     类被销毁了
     */
}

// 4.Any与AnyObject
/*
 本节中，我们谈谈swift的根类型。大部分现在化的面向对象编程语言都有自己的根类型。这些面向对象编程语言中
 的根类型的对象引用可以指向该编程语言中任意类类型的对象实例。
 
 swift编程语言有两个根类型，
 一个是Any，它可以指向swift中的任一类型；
 还有一个是AnyObject，它其实是一个协议类型，用于指向任一类类型的对象引用。
 */

do {
    
    struct MyStruct {
        
    }
    
    class MyClass {
        
    }
    
    func foo() {
        
    }
    
    var obj: Any
    
    obj = MyStruct()
    obj = MyClass()
    obj = foo
    
    print("obj = \(obj)")
    
    let cla: AnyObject = MyClass()
    print("cla = \(cla)")
    
    /*
     不过，这两种类型声明的对象一般无法直接使用，需要类型投射才能进行使用。
     */
}

// 5. 类型投射

/*
 当我们有根类型的对象，如何将这个对象转为具体的类型呢？这个时候就需要类型投射了。
 swift语言中，提供了两种投射操作符，分别是 as! 和 as?
 由于向下投射可能会失败，所以一般情况下，我们使用as?进行操作，它返回一个optional对象。
 */

do {
    
    print("\n-----------5. 类型投射------------\n")
    
    var obj: Any = 10
    /*
     这里编译的时候回报错：
      Could not cast value of type 'Swift.Int' (0x1005720b0) to 'Swift.Double' (0x100571718).
     为什么呢？因为obj是Int类型，不能直接投射成Double。
     */
    //let value = obj as! Double
    //print("value = \(value)")
    
    let value2 = obj as! Int
    print("value2 = \(value2)")
    // 结果：value2 = 10
}

protocol PB {
    
    func method()
}

do {
    enum MyEnum: PB {
        case one, two, three
        
        func method() {
            print("现在的值是 \(self)")
        }
        
        func foo() {
            print("这是枚举中的方法 foo")
        }
    }
    
    struct MyStruct: PB {
        
        func method() {
            print("这是一个结构体 method")
        }
        
        func foo() {
            print("这是一个结构体, foo")
        }
    }
    
    class Father: PB {
        
        func method() {
            print("这是一个类，method")
        }
        
        func foo() {
            print("这是类呢，哈哈哈哈哈")
        }
    }
    
    class Child: Father {
        
        override func method() {
            print("这里是Child，method")
        }
        
        override func foo() {
            print("这里是Child，foo ")
        }
    }
    
    func test(ref: Any) {
        
        if let obj = ref as? MyEnum {
            obj.foo()
        }
        
        if let obj = ref as? MyStruct {
            obj.foo()
        }
        
        if let obj = ref as? Father {
            obj.foo()
        }
        
        if let obj = ref as? Child {
            obj.foo()
        }
        
        if let obj = ref as? PB {
            obj.method()
        }
    }
    
    let ref: Any = test(ref: )
    let fun = ref as! (Any) -> Void
    
    fun(MyEnum.one)
    fun(MyStruct())
    fun(Father())
    fun(Child())
    
    /*
     结果：
     这是枚举中的方法 foo
     现在的值是 one
     这是一个结构体, foo
     这是一个结构体 method
     这是类呢，哈哈哈哈哈
     这是一个类，method
     这里是Child，foo
     这里是Child，foo
     这里是Child，method
     */
    
}

// 6. 类型检查
/*
 我们了解了类型投射之后，有时候我们需要检查某个对象类型的时候就可以使用as?进行判断。但是这不够直接，
 我们可以使用更加直观的操作符 is。
 */

protocol PC {
    
}

do {
    
    print("\n-----------6. 类型检查------------\n")
    
    class Father: PC {
        
    }
    
    class Child: Father {
        
    }
    
    var obj: Any = Father()
    
    if obj is PC {
        print("这是一个协议PC")
    }
    
    if obj is Father {
        print("这是一个Father类")
    }
    
    obj = Child()
    
    if obj is PC {
        print("哈哈哈哈，pc")
    }
    
    if obj is Child {
        print("这是一个Child")
    }
    
    if obj is Father {
        print("哈哈哈哈，Father")
        print("\(type(of: obj))")
    }
}

// 7. 嵌套类型
/*
 与C++ 、Java等传统的面向对象的编程语言一样，swift也支持嵌套类型。
 */

do {
    
    print("\n-------------7. 嵌套类型--------------\n")
    
    struct Test {
        
        private var member: Int = 1
        
        enum MyEnum {
            
            case one, two, three
            
            class MyClass {
                
                private var p = 0.5
                
                func hello(test: Test) {
                    print("value = \(test.member)")
                }
            }
            
            func test(cl: MyClass) {
                print("哈哈哈哈哈，test \(self)")
            }
        }
        
        func foo(cls: MyEnum.MyClass) {
            
            cls.hello(test: self)
        }
    }
    
    let t = Test()
    let e = Test.MyEnum.two
    let c = Test.MyEnum.MyClass()
    
    t.foo(cls: c)
    e.test(cl: c)
}



