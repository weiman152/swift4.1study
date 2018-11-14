//
//  main.swift
//  swift17(类)
//
//  Created by iOS on 2018/10/25.
//  Copyright © 2018年 weiman. All rights reserved.
//

import Foundation

/*
 新的业务需求忙了几天，有点空闲，继续系统学习swift。其实，学习一门语言的最好的方式还是使用它
 写项目。现在的系统学习只是有个印象，遇到相关情景的时候，能够想起来swift中有这样的特性可以使用。
 
 本节学习一个重要的内容——类。
 类是所有面向对象编程语言中最重要的类型，它往往具有非常丰富的语法特性，比如继承、多态等。
 
 在swift中，类类型属于引用类型，并且是除了引用类型以外唯一具有继承语法特性的类型。
 类和结构体的八大特性：
 1、可定义存储式实例与类型属性；
 2、可定义计算式实例与类型属性；
 3、可使用属性观察者；
 4、可定义实例与类型方法；
 5、可定义初始化器；
 6、可定义数组下标；
 7、可对结构体进行扩展；
 8、可遵循协议。
 
 类除了上面的八大特性之外还有四大特性：
 1.继承：允许一个类继承另一个类的特征。
 2.类型投射：允许在运行时检查并解释一个类的对象实例的类型。
 3.析构器：允许一个类的对象实例释放它所分配的任一资源。
 4.引用计数：允许对一个类的对象实例有多个引用。
 
 定义一个类的时候，使用关键字class 。
 
 注意：与OC不同的是，Swift的类不必一定继承NSObject。
 */

//1. 类型属性
/*
 类的属性与结构体的属性都一样。
 */

do {
    
    print("------------ 1. 类型属性 ----------\n")
    
    class Test {
        // 定义存储式实例属性a
        let a = 1
        // 定义一个惰性存储式实例属性
        lazy var str: String = {
            return "\(self)"
        }()
        
        // 定义一个计算属性
        var property: String {
            get {
                guard let index = str.range(of: ".")?.lowerBound else {
                    return str
                }
                let startIndex = str.index(after: index)
                return String(str[startIndex...])
            }
            set {
                str = newValue
            }
        }
        
        // 属性观察者
        var observer = 1.0 {
            willSet {
                print("new value is: \(newValue)")
            }
            didSet {
                print("original is: \(oldValue)")
                observer += oldValue
            }
        }
        
        // 存储式类型属性s，添加属性观察者
        static var s = 100 {
            willSet {
                print("new value: \(newValue)")
            }
            didSet {
                print("original value is : \(oldValue)")
            }
        }
        
        static var compute: Int {
            get {
                return s
            }
            set {
                s = newValue
            }
        }
    }
    
    // 使用类
    
    // 1.创建实例
    let test = Test()
    
    //2.第一次访问惰性属性
    print("str = \(test.str)")
    
    //3.访问计算式属性
    print("property： \(test.property)")
    
    test.property = "你好"
    print("str = \(test.str)")
    
    print("property: \(test.property)")
}

// 2. 类的方法
/*
 类的方法在大部分情况下也与结构体和枚举类型的一样。不过，由于类有继承的特性，所以会导致在某些方面
 类的方法与结构体的方法会有些差异。
 */

do {
    
    print("------------ 2. 类的方法 ----------\n")
    
    class Test {
        
        var a = 100
        
        func printP() {
            print("a = \(a)")
        }
        
        /// 定义一个类型方法
        static func say(words: String) {
            print("say \(words)")
        }
        
        // 定义一个下标
        subscript(index: Int) -> Int {
            return a + index
        }
    }
    
    let test = Test()
    test.printP()
    test.a = 1
    test.printP()
    
    Test.say(words: "你好")
    
}

//3. 类作为引用类型
/*
 结构体与枚举类型都是值类型，如果我们在一个函数中创建他们的对象实例，那么它们默认会被分配在当前
 函数的栈空间上，并且在概念上作为不同的对象实体。
 而类是引用类型，用类所声明的每一个对象其实都是引用的形式。
 */

do {
    print("------------ 3. 类作为引用类型 ----------\n")
    
    class Test {
        
        var a: Int
        
        /// 初始化方法
        init(a: Int) {
            print("a = \(a)")
            self.a = a
        }
        
        /// 析构方法
        deinit {
            print("\(self) is destroyed")
        }
    }
    
    /*
     这里创建一个Test的对象实例，由于没有指针指向它。所以创建了该对象实例之后，也就立马销毁了。
     */
    _ = Test(a: 10)
    
    /*
     这里创建了一个Test的对象实例，声明一个test对象指向它，对它有一次引用。
     */
    var test: Test! = Test(a: 20)
    
    // 这里声明一个temp对象，指向test的对象实例
    var temp: Test! = test
    temp.a = 5
    // 打印test的a属性，发现也改变了，说明temp和test指向的同一个对象实例。
    print("a = \(test.a)")
    test = nil
    print("Test instance will be destroyed")
    
    temp = nil
    
    /*
     打印结果：
     
     a = 10
     swift17_类_.(unknown context at 0x1004f5ca0).Test is destroyed
     a = 20
     a = 5
     Test instance will be destroyed
     swift17_类_.(unknown context at 0x1004f5ca0).Test is destroyed
     */
    
    /*
     由于类是引用类型，swift增加了 === 与 ！== 用于判断同一个类的两个对象引用是否指向同一个对象实例。
     虽然函数也是引用类型，但是这对操作符却不能用于函数。
    */
    
    class Person {
        
        let a: Int
        
        init(a: Int) {
            self.a = a
        }
    }
    
    let t1 = Person(a: 1)
    let t2 = Person(a: 2)
    
    let t = t1
    if t1 === t {
        print("相同的对象实例")
    }
    
    if t1 !== t2 {
        print("t1 !== t2")
    }
    
}

//4 继承
/*
 在swift中，一个类可以继承其他类。
 swift对于类类型的继承只能是单继承，也就是只能有一个父类。
 
 在swift中，继承语法特性中还有一个重要概念，那就是多态。
 什么是多态？
 当一个子类B继承了其父类A之后，它可以重写父类A中的计算属性以及方法，然后我们可以声明父类A的对象引用
 指向其子类B的对象实例。此时，当该对象引用调用被子类B所重写的方法的时候，实际调用的是B中被重写的方法，
 而不是父类A中原本的方法。当父类的某一计算属性或方法被重写之后，我们可以使用 super关键字来显示调用
 父类所实现的计算属性或者方法。
 */

do {
    print("------------ 4 继承 ----------\n")
    
    class Animal {
        
        var name: String = ""
        var type: String = "哺乳类"
        
        func eat(food: String) {
            print("\(name) 吃 \(food)")
        }
    }
    
    class Dog: Animal {
        
        let legs = 4
        let color = "黄色"
        
        func wangwang() {
            print("\(name) 汪汪叫")
        }
        
        override func eat(food: String) {
            print("\(name) 爱吃 \(food)， 它是一只小狗")
        }
    }
    
    let animal: Animal = Dog()
    animal.name = "斯皮尔格"
    // 这里调用的是Dog类的eat方法
    animal.eat(food: "骨头")
    
    /*
     打印：
     斯皮尔格 爱吃 骨头， 它是一只小狗
     */
    
    /*
     如果我们定义一个类，这个类不想被其他类继承，那么我们可以使用final关键字来修饰。
     我们也可以使用final来修饰类中的方法，是它不被继承。
     */
    
    do {
        final class LastLeaf {
            
            func desc() {
                print("这是最后一片叶子，不能被继承")
            }
        }
        
        class Song {
            
            var name = ""
            final func singThisSong() {
                print("这是一首不能被重写的歌，这个方法不能被子类重写")
            }
        }
        
        // 编译报错：Inheritance from a final class 'LastLeaf'
//        class Leaf: LastLeaf {
//
//        }
        class SongOfChina: Song {
            
            var type = "流行"
            
            func singer(name: String) {
                print("这首歌的名字是 \(self.name), 歌手是\(name), 类型是\(type)")
            }
        }
        
        let s = SongOfChina()
        s.name = "佛系少女"
        s.singer(name: "冯莫提")
    }
    
}

// 5.对属性的继承
/*
 当一个子类继承了父类的时候，子类可以访问父类除了私有之外的所有属性和方法。
 注意： 当子类继承了父类之后，子类就不可以定义与父类中同名的存储式属性了，但是子类可以重写父类
 的计算式属性以及针对存储式属性的观察者。
 */

do {
    print("------------ 4 继承 ----------\n")
    
    class Car {
        
        var type: String
        var discount: Double
        var originalPrice: Double
        
        var price: Double {
            get {
                return originalPrice * discount
            }
            
            set {
                discount = newValue / originalPrice
            }
        }
        
        var c = 0 {
            willSet {
                print("c 的new value is \(newValue)")
            }
            didSet {
                print("c 的old value is \(oldValue)")
            }
        }
        
        final var f: String {
            return "final"
        }
        
        static var ss = 10
        
        class var sc: Int {
            get {
                return ss
            }
            set {
                ss = newValue
            }
        }
        
        init(type: String, discount: Double, originalPrice: Double) {
            self.type = type
            self.discount = discount
            self.originalPrice = originalPrice
        }
    }
    
    class Truck: Car {
        
        //报错：Cannot override with a stored property 'type'
        //override var type = "大卡车"
        
        // 重写父类的计算式属性price
        override var price: Double {
            get {
                print("子类")
                return originalPrice * discount
            }
            
            set {
                print("子类")
                discount = newValue / originalPrice
            }
        }
        
        override var c: Int {
            willSet {
                print("大卡车：c 的new value is \(newValue)")
            }
            didSet {
                print("大卡车： c 的old value is \(oldValue)")
            }
        }
        
        // 重写父类的属性sc，且Truck的子类不能在重写这个属性
        override final  class var sc: Int {
            get {
                return super.ss + 10
            }
            set {
                ss -= newValue
            }
        }
    }
    
    var ref: Car = Truck(type: "大卡车", discount: 0.67, originalPrice: 1000000)

    print("price: \(ref.price)")
    print("c = \(ref.c)")
    ref.c = 100
    
    /*
     结果：
     子类
     price: 670000.0
     c = 0
     大卡车：c 的new value is 100
     c 的new value is 100
     c 的old value is 0
     大卡车： c 的old value is 0
     */
}
