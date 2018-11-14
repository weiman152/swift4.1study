//
//  main.swift
//  swift15(协议)
//
//  Created by iOS on 2018/10/16.
//  Copyright © 2018年 weiman. All rights reserved.
//

import Foundation

// 协议
/*
 OC中也有协议，swift中的协议的作用与OC中基本一样，只是在写法上有一点区别。
 我们使用 protocol关键字来定义一个协议。在一个协议中只能存放计算式属性以及方法的声明，
 而不能对他们进行定义。
 */

// 1. 协议的定义

// 定义一个协议
protocol MyProt {
    
    /// 声明一个普通的方法
    func foo()
    
    /// 声明一个可修改存储式实例属性的方法
    mutating func doSomething(a: Int) -> Int?
    
    /// 声明一个静态方法
    static func typeMethod()
    
    /// 声明一个初始化器方法
    init(a: Int)
    
    /// 声明一个下标
    subscript(index: Int) -> Int {get set}
    
    /// 声明一个计算式属性
    var property: Int { get set }
    
    /// 声明一个计算式属性，并且是只读的
    static var typeP: Double { get }
    
}

// 2. 协议的遵循
/*
 只有协议是没有意义的，协议是用来遵循的，是需要实现的。
 swift中，枚举、类以及结构体类型都可以遵循协议。
 遵循了某一协议的类型必须实现该协议中所生命的所有方法与计算式属性，其中也包括初始化器
 */

do {
    struct Test: MyProt {
        
        /// 定义自己的存储式属性a
        var a = 100
        
        func foo() {
            print("foo")
        }
        
        mutating func doSomething(a: Int) -> Int? {
            print("doSomething")
            self.a = a
            return a == 0 ? nil : self.a
        }
        
        static func typeMethod() {
            print("study")
        }
        
        init(a: Int) {
            self.a = a
        }
        
        subscript(index: Int) -> Int {
            get {
                return a + index
            }
            set {
                a = newValue + index
            }
        }
        
        var property: Int {
            get {
                return self.a / 2
            }
            
            set {
                self.a = newValue / 2
            }
        }
        
        static var typeP: Double {
            return Double.pi
        }
    }
    
    var t =  Test(a: 10)
    t.foo()
    print("---- \(t.doSomething(a: 100))")
    t.property = 12
    print("a: \(t.a)")
    print("p: \(t.property)")
}

/*
 协议是一种比较灵动的动态类型，根据为它所初始化的对象实例的性质不同，它所采取的拷贝与引用
 策略也会有不同。
 */

protocol P {
    
    func foo()
}

do {
    
    print("\n")
    
    struct TestA: P {
        
        var a: Int = 0
        
        func foo() {
            print("这是一个foo")
            print("a = \(a)")
        }
    }
    
    /// 定义枚举类型，遵守协议P
    enum TestB: Int, P {
        case one = 1, two, three
        
        func foo() {
            print("enum = \(self)")
            print("value = \(self.rawValue)")
        }
    }
    
    var a = TestA()
    // 声明P协议类型的对象p，用a对它初始化
    var p: P = a
    p.foo()
    
    withUnsafePointer(to: a.foo) {
        print("\($0)")
    }
    withUnsafePointer(to: p.foo) {
        print("\($0)")
    }
    
    withUnsafePointer(to: &a) {
        print("p:\($0)")
    }
    
    withUnsafePointer(to: &p) {
        print("p:\($0)")
    }
    
    a.a = 10
    p.foo()
    
    withUnsafePointer(to: &a) {
        print("\($0)")
    }
    withUnsafePointer(to: &p) {
        print("p:\($0)")
    }
    
    /*
     打印：
     这是一个foo
     a = 0
     这是一个foo
     a = 0
     */
    
    /*
     结果说明，p对象不受对象a的影响,为什么呢？
     因为结构体和枚举都是值类型,值类型和引用类型是不一样的。
     执行var p: P = a的时候，系统已经分别给 p开辟了新的空间，所以，改变a，并不会对p造成什么影响。
     */
    
   p = TestB.two
   p.foo()
}

/*
 写时拷贝
 由于协议类型是一种抽象类型，swift在实现它的时候采用了一种十分灵活的机制——写时拷贝。
 对于像枚举、结构体这种值类型的对象实例，即便用一个他们所遵循的协议去指向值类型的对象实例，
 当协议类型自身或它所指向的对象实例任一方修改了存储式实例属性的值的时候，此时就会发生写时拷贝。
 这时，swift会将协议类型对象分配一个新的存储空间，然后将它所指向的值类型的对象实例的当前状态
 拷贝过去。
 */

// 一个类型可以遵循多个协议，我们可以用逗号来分割遵循的多个协议的名称。一个类型若遵循了多个协议
//,那么它必须实现它所遵循的所有协议中声明的所有方法和属性。

protocol ProtA {
    func foo()
    func method()
    
    var property: Int { get set }
}

protocol ProtB {
    
    mutating func method(a: Int)
    static var property: Double { get }
}

do {
    
    print("\n")
    
    struct Test: ProtA, ProtB {
        
        var a = 0
        
        func foo() {
            print("协议A的方法，foo")
        }
        
        func method() {
            print("协议A的方法， method")
        }
        
        var property: Int {
            get {
                return a
            }
            set {
                a = newValue
            }
        }
        
        mutating func method(a: Int) {
            print("协议B的方法，method，a = \(a)")
            self.a = a
        }
        
        static var property: Double {
            return M_E
        }
    }
    
    let a: ProtA = Test()
    a.foo()
    a.method()
    print("a = \(a.property)")
    
    var b: ProtB = Test()
    b.method(a: 10)
    print("a = \(type(of: b).property)")
}

// 3. 协议继承
/*
 在swift编程中，一个协议可以继承自另一个协议或者其他多个协议。当一个协议继承了其他协议的时候，该
 协议会将它所继承的其他协议中的所有声明的方法与属性全部包含在自己的协议之中。
 注意：
 设计的时候，注意命名。
 */

/// 定义一个协议C，继承自协议A和协议B
protocol ProtC: ProtA, ProtB {
    /// 重载了ProtA的方法
    func foo()
    
    /// 自己的方法
    func Coo()
}

do {
    
    print("\n")
    
    /// 自定义结构体，遵守了ProtC协议
    struct Test: ProtC {
        
        var x = 100
        
        // 以下是要实现的协议方法和属性
        func foo() {
            print("我就是个方法,foo")
        }
        
        func Coo() {
            print("我是C协议的方法，Coo")
        }
        
        func method() {
            print("我是A的方法，method")
        }
        
        var property: Int {
            get {
                return x
            }
            
            set {
                x = newValue
            }
        }
        
        mutating func method(a: Int) {
            print("我是B的方法，method， 参数a = \(a)")
            x = a
        }
        
        static var property: Double {
            get {
                return 0
            }
        }
    }
    
    var t = Test()
    t.foo()
    t.Coo()
    t.method()
    t.method(a: 60)
    print("property: \(t.property)")
    
    print("static property: \(Test.property)")
    
}

// 4. class协议
/*
 我们可以将一个协议限定为只适用于类类型。我们只需要在一个协议后面使用:class 即可将该协议声明
 为类协议，这样只有类类型才能遵守该协议。
 */

/// 定义一个协议ProtD，是一个类协议
protocol ProtD: class {
    
    /// 声明类型计算式属性
    static var type: String {  get set }
    
    func hello()
}

/// 定义一个协议ProtE，普通协议
protocol ProtE {
    
    func welcome()
}

/// 定义一个协议ProtF, 是一个类协议，继承自ProtE
protocol ProtF: class, ProtE {
    
    var property: Int { get set }
}

/// 定义一个协议ProtG，继承自ProtD和ProtE
protocol ProtG: ProtD, ProtE {
    
}

do {
    
    print("\n")
    
    class Dog: ProtF {
       
        var name: String = "ww"
        
        /// 使用class覆盖协议中的类类型属性
        class var type: String {
            get {
                return "中华田园犬"
            }
            set {
                
            }
        }
        
        var property: Int {
            get {
                return 10
            }
            set {
               
            }
        }
        
        /// 实现ProtE的方法
        func welcome() {
            print("欢迎来到狗狗之家")
        }
    }
    
    let dog = Dog()
    dog.name = "小花花"
    dog.welcome()
    print("这只小狗已经 \(dog.property) 岁了")
    
    print("这只狗狗的品种是 \(Dog.type)")
    
    /// 定义了结构体 Cat，并实现ProtE
    struct Cat: ProtE {
        
        var name = "mimi"
        
        /// 定义自己的方法
        func eat(fishCount: Int) {
            print("给猫咪喂了 \(fishCount) 只小鱼")
        }
        
        /// 实现ProtE协议的方法
        func welcome() {
            print("你们好，这里是猫咪的乐园")
        }
    }
    
    var cat = Cat()
    cat.name = "小黄"
    cat.welcome()
    cat.eat(fishCount: 3)
    
    /*
     注意，如果一个协议继承了某个类协议，那么他自己也就成了类协议。
     如果一个非类类型遵循了一个类协议，那么就会引发编译报错。
     */
    
}

// 5.协议组合
/*
 有时，我们需要声明一个对象，其类型需要遵循多个协议，以便能够调用这些协议中的方法或者访问属性。
 我们可以在定义一个协议，然后继承我们想要遵循的协议，但是这会显得很繁琐。swift中提供了“协议组合”
 这一语法特性，使得我们能够很轻松的将所要遵循的协议给组合起来。
 */

protocol P1 {
    func foo()
    func method()
}

protocol P2 {
    mutating func method(a: Int)
    
    var age: Int { get set }
}

do {
    
    print("\n")
    
    // 定义结构体Test，遵循了p1,p2协议
    struct Test: P1,P2 {
        /// 自己的属性a
        var a = 0
        
        /// 以下是实现协议的方法和属性
        func foo() {
            print("P1:这个世界怎么了，这个世界上的人太疯狂了")
        }
        
        func method() {
            print("P1: 还能怎么办呢？沧海一粟，宇宙一蜉蝣而已，小小屁民，苟活于世")
        }
        
        mutating func method(a: Int) {
            print("p2: 好好生活，好好挣钱吧，多挣一点，养活好自己和家人。a: \(a)")
            self.a = a
        }
        
        var age: Int {
            get {
                return a
            }
            set {
                self.a = newValue
            }
        }
    }
    
    var t = Test()
    t.a = 100
    t.foo()
    t.method()
    t.method(a: 50)
    print("age: \(t.age)")
    t.age = 102
    print("向天再借： \(t.age) 年")
    
    
    /// 声明一个对象p，遵循了P1和P2，这里就使用了协议组合的语法特性。
    var p: P1 & P2 = Test()
    
    p.foo()
    p.age = 100
    p.method(a: 6)
    print("age = \(p.age)")
    
}

// 6.关联类型
/*
 我们在协议中声明一些方法，这些方法的参数类型根据不同的实现可能会有所不同，此时swift提供了协议的
 “关联类型”语法特性，使得我们可以在协议中声明泛化的抽象类型，每个遵循它的类型可以指定其自己的
 具体类型。
 */

protocol P6A {
   
    /// 声明了关联类型DataType
    associatedtype DataType
    
    /// 声明了实例方法method，具有一个关联类型参数value
    func method(value: DataType)
    
}

do {
    
    print("\n")
    
    struct MyStruct:P6A {
        
        /// 通过typealias指定协议关联类型的具体类型，这里把DataType指定为Int类型
        typealias DataType = Int
        
        let data: DataType = 100
        
        func method(value: Int) {
            print("哈哈哈哈，这里是关联类型的测试场地： \(data + value)")
        }
    }
    
    /// 在定义一个枚举类型
    enum MyEnum: String, P6A {
        
        // 这里把DataType指定为String类型
        typealias DataType = String
        
        case one = "1", two = "2", three = "3"
        
        func method(value: String) {
            print("这里是一个枚举，\(self.rawValue + value)")
        }
    }
    
    // 定义一个函数test
    // 泛型 T 必须遵循P6A协议
    func test<T>(prot: T, param: T.DataType) where T: P6A {
        prot.method(value: param)
    }
    
    test(prot: MyStruct(), param: -1)
    
    test(prot: MyEnum.two, param: "apple")
    
}


// 7.关于协议中的self类型
/*
 在swift编程语言的协议中有一个内建的关联类型——self，用于指代遵循该协议的具体类型。
 */

protocol P7A {
    
    mutating func method(obj: Self)
}

do {
    
    print("\n")
    
    struct MyStruct:P7A {
        
        var data = 1
        
        mutating func method(obj: MyStruct) {
            data += obj.data
        }
    }
    
    enum MyEnum: String, P7A {
        case red = "red", green = "green",blue = "blue"
        case red_and_green = "red and green"
        case red_and_blue = "red and blue"
        case green_and_blue = "green and blue"
        
        mutating func method(obj: MyEnum) {
            
            guard let newValue = MyEnum(rawValue: self.rawValue + "and" + obj.rawValue) else {
                return
            }
            
            self = newValue
        }
    }
    
    func test<T>(dst: inout T, src: T) where T: P7A {
        dst.method(obj: src)
    }
    
    var sd = MyStruct()
    let ss = MyStruct(data: 100)
    
    test(dst: &sd, src: ss)
    print("sd = \(sd.data)")
    
    var ed = MyEnum.red
    let es = MyEnum.green
    test(dst: &ed, src: es)
    print("ed = \(ed)")
}





