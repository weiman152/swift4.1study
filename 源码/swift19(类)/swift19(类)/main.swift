//
//  main.swift
//  swift19(类)
//
//  Created by iOS on 2018/10/27.
//  Copyright © 2018年 weiman. All rights reserved.
//

import Foundation

/*
 本节来继续学习类，本节主要内容：
 1.初始化器方法的继承与重写；
 2.必须实现的初始化器方法；
 3.类的析构器方法；
 4.类类型与协议类型的组合；
 5.类遵循协议时的更多特性。
 */

//1. 初始化器方法的继承与重写
/*
 可以使用父类初始化器的情景：
 1.子类没有定义自己的存储式实例属性；
 2.子类定义了自己的存储式属性，这些属性在定义的时候就进行了初始化。
 
 否则，就要定义自己的初始化器了。
 
 注意：swift中我们不能用final去修饰一个初始化器方法。
 */

do {
    
    print("\n-----------1. 初始化器方法的继承与重写--------------\n")
    
    enum FoodType: String {
        case fruits = "水果"
        case dairy  = "奶制品"
        case vegetables = "蔬菜"
    }
    
    class Food {
        
        let type: FoodType
        
        init() {
            // 初始化没有初始化的属性
            type = .vegetables
        }
        
        init(type: FoodType) {
            self.type = type
        }
    }
    
    class Apple: Food {
        
        // 定义自己的属性并且初始化
        let price = 3.5
    }
    
    // 通过继承自Food的不带参数的指定初始化器来创建Apple对象
    var f: Food = Apple()
    // 通过继承自Food的带参数的指定初始化器来创建Apple对象
    f = Apple.init(type: .fruits)
    print("f = \(f.type.rawValue)")
    
}

/*
 如果子类有自己的存储式实例属性，并且没有初始化；或者子类希望在初始化的时候进行一些操作，就需要
 定义自己的初始化器，也可以重写父类的初始化器。初始化器也是方法，与一般方法重写是一样的。
 
 注意：
 1.一旦子类中实现了自己的初始化器，那么在创建子类的时候就必须使用自己的初始化器。
 2. 便利初始化器不允许被重写.
 */

do {
    
    // 看下初始化器方法的重写
    class F {
        
        let a: Int
        
        init() {
            a = 0
        }
        
        init(a: Int) {
            self.a = a
        }
        
        // 定义一个便利初始化器方法
        convenience init(str: String) {
            self.init(a: str.count)
            print("str = \(str)")
        }
    }
    
    class C: F {
        
        let ch: Int
        
        override init() {
            ch = 0
            super.init()
        }
        
        override init(a: Int) {
            ch = a
            super.init(a: a + ch)
        }
        
        /// 定义自己的指定的初始化器方法
        init(b: Int) {
            ch = b
            print("b = \(b)")
            super.init(a: b)
        }
        
        /// 重载父类的方法
        init(a: Double) {
            print("double: a = \(a)")
            ch = Int(a)
            super.init(a: ch + 1)
        }
        
        /// 定义自己的便利初始化器方法
        convenience init(str: String) {
            print("c string: \(str)")
            if let value = Double(str) {
                self.init(a: value)
            } else {
                self.init()
            }
        }
    }
    
    var ref: F = C()
    print("a = \(ref.a)")
    
    ref = C(a: 10)
    print("a = \(ref.a)")
    
    ref = C(a: 1.5)
    print("a = \(ref.a)")
    
    ref = C(str: "abcd")
    print("a = \(ref.a)")
    
    ref = C(str: "12.34")
    print("a = \(ref.a)")
}

// 2. 必须实现的初始化器方法
/*
 swift编程语言引入了 “必须实现的初始化方法”.一旦d父类的某个指定的初始化方法前面加上了required
 关键字，那么子类必须重写该指定的初始化方法，在重写该初始化方法的时候，无需使用override关键字，
 而是使用required关键字。
 */

do {
    
    print("\n-------------2. 必须实现的初始化器方法------------\n")
    
    class F {
        
        let a: Int
        
        required init() {
            a = 0
        }
        
        required init(a: Int) {
            self.a = a
        }
        
        init(a: String) {
            self.a = a.count
        }
    }
    
    class C: F {
        
        let ch: Int
        
        required init() {
            ch = 0
            super.init()
        }
        
        required init(a: Int) {
            ch = a * a
            super.init(a: ch)
        }
        
        override init(a: String) {
            ch = a.count - 1
            super.init(a: a)
        }
    }
    
    var ref: F = C()
    print("ref: a = \(ref.a)")
    ref = C.init(a: 10)
    print("ref: a = \(ref.a)")
    ref = C.init(a: "abc")
    print("ref: a = \(ref.a)")
}

// 3. 类的析构器方法
/*
 在swift中，析构器方法是类类型独有的。为什么呢？因为类类型是引用类型，有可能出现内存泄漏。析构方法可以
 帮助我们知道当前类是否释放。
 析构方法比初始化方法要简单的多，它形式单一，不接受任何参数，而且也没有返回值。
 */

do {
    
    print("\n-------------3. 类的析构器方法------------\n")
    
    class Animal {
        
        var name = ""
        
        deinit {
            print("Animal 被释放了")
        }
    }
    
    class Person: Animal {
        
        var phoneNum = ""
        
        deinit {
            print("Person 被销毁了")
        }
    }
    
    // 定义一个闭包
    _ = {
        
        // 此时对象实例的引用计数为1
        var a: Person? = Person()
        // 引用计数 = 2
        var b = a
        // 将a置空
        a = nil
        print("将要销毁")
        b = nil
        
        print("另一组测试")
        
        var ref = Person()
        print("更改了")
        ref = Person()
        print("Over")
    }()
    
    /*
     结果：
     将要销毁
     Person 被销毁了
     Animal 被释放了
     另一组测试
     更改了
     Person 被销毁了
     Animal 被释放了
     Over
     Person 被销毁了
     Animal 被释放了
     */
    
    /*
     注意：
     析构方法的调用顺序：先调用自己的析构方法，再调用父类的析构方法。
     */
    
}

// 4. 类类型与协议类型的组合

print("\n-------------4. 类类型与协议类型的组合------------\n")

protocol MyP {
    func foo()
}

protocol MyP2 {
    func method()
}

do {
    
    class F {
        
        func father() { }
    }
    
    class S: F, MyP, MyP2 {
        func foo() { }
        func method() { }
    }
    
    let obj: F & MyP & MyP2 = S()
    
    obj.father()
    obj.foo()
    obj.method()
    
    // 这种组合形式在项目中是非常常用的形式
}

// 5. 类遵循协议时的更多特性
/*
 当协议用于类类型的时候还会有一些其他的特性。
 1、一个协议如果既可用于结构体与枚举类型，也能用于类类型，那么当在里面声明了一个 mutating 实例方法时，一个类遵循该协议之后，对此 mutating 方法的实现不需要加 mutating 关键字。因为类的实例方法没有 mutating 这个概念，它本身就是引用类型，所以也没有所谓的“写时拷贝”机制。
 2、一个协议可以通过添加 class 特性将它作为仅对类类型有效的协议类型。如果一个协议用了 class 限定，并且需要继承其他协议，那么必须将 class 写在最前面，然后后面再跟其他协议名。此外，在被 class 所限定的协议中不可直接声明 mutating 的实例方法。如果一个被 class 所限定的协议继承了某个声明了 mutating 实例方法的协议，此时不会产生语法错误。但是，当一个类继承该 class协议并实现了那个实例方法之后，我们去调用那个实例方法会引发运行时异常。
 3、协议中如果要声明类型方法，则只能使用 static 关键字进行声明，而不能使用 class 关键字，无论它是否被 class 限定，不过类在遵循该协议并实现该类型方法时，仍然可以使用 class 关键字表示其子类可以重写该类型方法。
 4、协议中如果声明了初始化器方法，那么对于遵循该协议的类类型而言则必须显式实现该初始化器方法，并且同时要用 required 进行修饰，除非该类已被 final 修饰从而无法再被继承。而对于结构体和枚举类型而言，像不带任何参数的初始化器方法，在这些值类型中则可以不给出显式实现。

 */

print("\n-------------5. 类遵循协议时的更多特性------------\n")

protocol P {
    
    mutating func method()
    
    init(a: Int)
}

protocol PA: class, P {
    
    static func typeMethod()
}

do {
    
    class Test: PA {
        
        required init(a: Int) {
            print("a = \(a)")
        }
        
        func method() {
            print("method")
        }
        
        class func typeMethod() {
            print("class func typeMethod")
        }
    }
    
    var prot: PA = Test(a: 10)
    prot.method()
    
    type(of: prot).typeMethod()
    
    /*
     结果;
     a = 10
     method
     class func typeMethod
     
     */
    
    // prot.method() 并没有出现异常
    
}
