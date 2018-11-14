//
//  main.swift
//  swift18(类)
//
//  Created by iOS on 2018/10/26.
//  Copyright © 2018年 weiman. All rights reserved.
//

import Foundation

/*
 本节继续学习 类
 上一节学习了类的概念、类的属性和方法、继承的定义、类作为引用类型以及对属性的继承。
 本节我们继续学习，主要内容如下：
 1.对方法的继承
 2.对下标的继承
 3.类的初始化器方法
 
 */

// 1. 对方法的继承
/*
当子类B继承了父类A之后，B就可以访问父类的所有除了私有之外的方法。如果B想重写A的某个方法，可以使用
 override关键字进行声明。
 注意：
 在swift语言支持方法重载，注意重载和重写的不同。重写父类的方法需要使用override关键字；而重载
 父类的方法，只是方法名字与父类相同，参数类型或者参数个数与父类是不同的，也不需要override关键字。
 */

do {
    
    print("\n------------1. 对方法的继承--------------\n")
    
    class Animal {
        
        func eat() {
            print("动物都要吃食物")
        }
        
        func set(legs: Int) {
            print("这只动物有 \(legs)只脚")
        }
        
        /// 类型方法
        class func happy() {
            print("动物很开心")
        }
        
        /// 类型方法，该方法不能被子类重写
        static func run() {
            print("动物都会跑啊")
        }
    }
    
    class Cat: Animal {
        
        var name: String
        
        init(name: String) {
            self.name = name
        }
        
        /// 重写父类的方法
        override func eat() {
            print("这是一只小猫，它喜欢吃鱼，它的名字叫做\(name)")
        }
        
        /// 方法重载
        func set(legs: Int, eyes: Int) {
            print("这只猫有\(legs)只脚，\(eyes)只眼睛")
        }
        
        /// 重写父类的类型方法
        override  class func happy() {
            print("这只小猫很开心")
        }
    }
    
    // 使用
    // 利用了类的多态特性，父类的对象指向子类的实例
    let animal: Animal = Cat(name: "Tom")
    // 这里调用的是Cat的eat的方法
    animal.eat()
    // 这里调用的是父类Animal的set（legs:）方法
    animal.set(legs: 4)
    // 报错：Extra argument 'eyes' in call
    // animal无法访问Cat中重载的方法
    //animal.set(legs: 4, eyes: 2)
    
    // 这里就是正常的Cat的对象指向Cat的实例
    let lihua: Cat = Cat(name: "狸花")
    // 调用父类的set(:)方法
    lihua.set(legs: 4)
    // 调用cat自己的set方法
    lihua.set(legs: 4, eyes: 2)
    
    
    // 调用类型方法
    //Animal的happy的方法
    Animal.happy()
    //Cat的happy方法
    Cat.happy()
    //Animal的run方法
    Animal.run()
    // Animal的run方法
    Cat.run()
    
    /*
     结果：
     这是一只小猫，它喜欢吃鱼，它的名字叫做Tom
     这只动物有 4只脚
     这只动物有 4只脚
     这只猫有4只脚，2只眼睛
     动物很开心
     这只小猫很开心
     动物都会跑啊
     动物都会跑啊
     */
}

// 注意：方法的多态性
// 当父类A的方法M调用了方法N，方法N被B重写，这个时候B调用M的时候，N是B类的，而不是A类的。
do {
    
    print("-------多态特性------")
    
    class F {
        
        func M() {
            print("这是F种的M")
            N()
        }
        
        func N() {
            print("这是F种的N")
        }
    }
    
    class C: F {
        
        override func N() {
            print("这是C中的N")
        }
    }
    
    let c = C()
    c.M()
    /*
     结果：
     这是F种的M
     这是C中的N
     */
    /*
     总结：
     方法的调用在查找的时候，就是先找自己的方法中有没有这个方法，如果没有，再去父类中寻找，父类中
     没有就再去父类的父类中去找，直到找到最后一个根类中，如果没有就返回报错，如果有，就调用这个方法。
     像上面的例子中，查找过程是这样的：
     c.M()
     先去C中找M方法，没有，再去父类F中寻找，发现有，就调用它。当M执行到
     N()
     的时候，再去C中寻找N方法，发现有，直接返回，再继续执行M方法，直到遇到结束符大括号“}”.
     */
}

// 2. 对下标的继承
/*
 之前我们在学习结构体的时候，就学习过了下标特性。
 在类类型中，下标也能继承并且重写，由于下标方法本身类似于实例方法，其特质更像是计算式实例属性。
 */

do {
    
    print("\n-------------2. 对下标的继承-----------------\n")
    
    class F {
        
        var member = 1
        
        // 定义下标
        subscript(index: Int) -> Int {
            return index + member
        }
        
        // 定义下标
        subscript(str: String) -> Int {
            return str.count + member
        }
    }
    
    class C: F {
        
        /// 重写父类的下标方法
        override subscript(index: Int) -> Int {
            return index - member
        }
        
        /// 重写父类的下标方法，并且不允许子类再次重写
        override final subscript(str: String) -> Int {
            return str.count - member
        }
    }
    
    // 使用
    
    let f: F = C()
    // 调用子类的下标方法
    var v = f[10]
    print("v = \(v)")
    // 调用子类的下标方法
    v = f["abc"]
    print("v = \(v)")
    
    /*
     结果：
     
     v = 9
     v = 2
     */
    
    /*
     结果：
     下标的重写与方法重写类似，都是在前面加上override关键字
     */
}

// 3.类的初始化器方法
/*
 类的初始化器与结构体的初始化器语法上基本一样。不过呢，类的初始化器没有默认的逐成员的形式。还记得吗？
 就是如果没有定义初始化器，结构体会自动生成一个逐成员的初始化器，把所有的参数包括在内的。
 既然如此，那么在类中，如果有未初始化的存储类属性，就要显示的使用初始化器对它进行初始化。
 
 注意：
 由于继承关系，在初始化器中需要显示的调用父类的初始化器，使得初始化向上传递。
 */

do {
    
    print("\n---------------3.类的初始化器方法-------------------\n")
    
    class A {
        
        var a: Int
        
        /// 定义一个不带参数的初始化器，并且对a进行初始化
        init() {
            a = 0
        }
        
        /// 定义一个带参数的初始化器
        init(a: Int) {
           self.a = a
        }
        
        /// 定义一个便利初始化器，带一个参数
        convenience init(b: Int) {
            // 调用指定的初始化器
            self.init(a: b)
            print("这里是便利初始化器b")
        }
        
        convenience init(c: Int) {
            print("这里是便利初始化器c")
            self.init(b: c)
        }
    }
    
    // 通过不带参数的指定初始化器来创建A的实例
    var a = A()
    print("a1 = \(a.a)")
    
    // 通过指定初始化器创建A的实例
    a = A(a: 10)
    print("a2 = \(a.a)")
    
    // 通过便利初始化器创建A的实例
    a = A(b: 20)
    print("a3 = \(a.a)")
    
    // 通过便利初始化器创建A的实例
    a = A(c: 30)
    print("a4 = \(a.a)")
    
    /*
     注意：
     每个类中必须有一个指定初始化器，而便利初始化器必须调用一个初始化器，只是对初始化的属性进行一个
     过滤或者其他的操作。
     */
}



