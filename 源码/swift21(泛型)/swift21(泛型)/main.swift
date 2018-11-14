//
//  main.swift
//  swift21(泛型)
//
//  Created by iOS on 2018/10/29.
//  Copyright © 2018年 weiman. All rights reserved.
//

import Foundation

/*
 泛型
 
 本节我们一起学习泛型这一概念。在项目中，多次用到了泛型，但是对它的理解总是不够透彻，运用也不熟练。
 趁此机会，好好熟悉一下。
 
 什么是泛型？
 比如我们要实现一种算法，例如搜索、排序等，相对于传统C语言，如果我们要针对不同的类型实现相同的算法，‘
 每种数据类型都要写一遍，显得乏味而又冗余。这个时候我们就可以使用泛型，提供一种算法的实现函数，然后
 在调用此函数的时候在确定相关数据的类型就可以了。
 */

print("---------泛型的概念--------------")

struct A {
    /*
     这里定义了函数calculate
     其泛型遵循了BinaryInteger协议。
     */
    static func calculate<T: BinaryInteger> (a: T, b: T) -> T {
        return a * a + b * b
    }
    
    static func calculate<T: FloatingPoint> (a: T, b: T) -> T {
        return a * a + b * b
    }
   
}

do {
    
    let i = A.calculate(a: 3, b: 4)
    print("i = \(i)")
    
    let j = A.calculate(a: 3.0, b: 4.0)
    print("j = \(j)")
}

/*
 小结：
 通过上面的例子可以看出来，使用泛型之后，函数定义一下子简单了。我们不仅可以使用Int8，Int16，Int32
 等整数类型，还可以使用Float、Double等浮点类型。如果没有泛型，那么我们要写10多种函数实现，
 是不是简化了很多呢？
 */

// 1. 泛型基本使用
/*
 swift 中，我们可以对函数以及方法使用泛型，但是不能用于闭包，不能用于协议。
 无论是对函数还是对类型使用泛型，我们均可以在函数或者类型标识符后面跟 <>，里面放泛型形参列表。
 */

do {
    
    // 定义一个泛型结构体，泛型形参为T
    struct MyStruct<T> {
        
        /// 用泛型T定义存储成员t
        var t: T
        
        /// 定义一个实例方法，其参数也是泛型T
        mutating func method(value: T) {
            t = value
            print("new value = \(value)")
        }
        
        /// 定义类型方法swap，是一个泛型方法，泛型形参为E
        static func swap<E>(a: inout E, b: inout E) {
            
            let tmp = a
            a = b
            b = tmp
        }
    }
    
    /*
     将MyStruct类型特化为MyStruct<Int32>，表示其泛型实参为Int32类型。
     */
    var st = MyStruct<Int32>(t: 100)
    // 调用method方法
    st.method(value: 200)
    
    // 这里缺省<Int32>，此时MyStruct将被类型推导为MyStruct<Int>。
    var ss = MyStruct(t: 100)
    ss.method(value: 200)
    
    var a = 10, b = 20
    // 这里调用了MyStruct的swap类型方法，
    // 并且其泛型被推导为Int类型。
    // 这里注意，即便我们没有直接使用MyStruct对象实例，
    // 但依然需要对MyStruct做泛型特化，
    // 由于这里不需要做特殊处理，
    // 所以对MyStruct直接指定空元组即可。
    MyStruct<()>.swap(a: &a, b: &b)
    print("a = \(a), b = \(b)")
    
    var x = 0.5, y = 5.0
    MyStruct<()>.swap(a: &x, b: &y)
    print("x = \(x), y = \(y)")
    
    var c = 100, d = 200
    MyStruct<Int>.swap(a: &c, b: &d)
    print("c = \(c), d = \(d)")
    
    var e = "a", f = "b"
    MyStruct<String>.swap(a: &e, b: &f)
    print("e = \(e), b = \(f)")
    
    var arr1 = [1, 2, 3]
    var arr2 = [10, 20, 30, 40]
    MyStruct<[Int]>.swap(a: &arr1, b: &arr2)
    print("arr1 = \(arr1), arr2 = \(arr2)")
    
}

/*
 小结：
 上述代码可以看出，泛型是多么方便啊。对于交换两个对象的值，我们只需要使用泛型，就可以写一种算法，针对
 各个类型都可以使用了。
 */

/*
 对于函数以及方法的泛型特化，我们不能显示指定泛型实参，只能通过推导得出。
 如果某一函数只有返回类型是一个泛型类型，那么调用它的时候，必须显式提供左值类型。
 */

do {
    
    func foo<T: SignedInteger>() -> T {
        return T()
    }
    
    let a: Int16 = foo()
    print("a = \(a)")
}

// 2. 类型约束
/*
 swift中引入了泛型的“类型约束”，用于说明当前泛型类型必须遵循哪些协议，或者继承自哪个类。有了这个
 设定之后，我们的泛型的灵活性就大大增强了。
 */

do {
    
    print("\n--------2. 类型约束-----------\n")
    
    // 定义了一个泛型函数，必须遵循Comparable协议
    func foo<T: Comparable>(a: T, b: T, c:T) {
        
        var minValue = min(a, b)
        minValue = min(minValue, c)
        
        var maxValue = max(a, b)
        maxValue = max(maxValue, c)
        
        let range = minValue ... maxValue
        
        print("the range is : \(range)")
    }
    
    foo(a: 10, b: 30, c: 20)
}

// 3. 泛型where从句
/*
 有时我们在一个结构体或类中遵循了带有关联类型的协议，此时我们想实现一个泛型类型或泛型函数，使得该泛型遵循该协议，并且对该协议的泛型进行约束，那么我们可以使用Swift中的where从句来实现。
 */

protocol Prot {
    
    // 这里定义一个关联类型，相当于协议中的泛型
    associatedtype ArgType
    
    func method(obj: ArgType)
}

do {
    
    print("\n-----------3. 泛型where从句---------------\n")
    
    struct MyStruct: Prot {
        
        typealias ArgType  = Int
        
        func method(obj: Int) {
            print("obj = \(obj)")
        }
    }
    
    /*
     这里定义了泛型结构体Test，其泛型T遵循了Prot协议，使用where语句用来约束Prot协议中关联类型
     必须遵循Comparable协议。
     */
    struct Test<T: Prot> where T.ArgType: Comparable {
        
        func method<E: Prot>(e: E) where E.ArgType == Int {
            
            print("e = \(e)")
            e.method(obj: 100)
        }
    }
    
    let test = Test<MyStruct>()
    test.method(e: MyStruct())
}

// 4. swift4.0之后对泛型特征的补充
/*
 swift 4.0之后，我们允许对下标使用泛型。
 */

do {
    
    print("\n-----------4. swift4.0之后对泛型特征的补充------------\n")
    
    struct Test {
        
        subscript<T: FixedWidthInteger>(index: T) -> T {
            return index + T(1)
        }
    }
    
    let a = Test()[Int8(10)]
    print("a = \(a), a type is: \(type(of: a))")
    
    let b = Test()[UInt16(600)]
    print("b = \(b), b type is: \(type(of: b))")
}


