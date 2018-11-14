//
//  main.swift
//  swift22(扩展)
//
//  Created by iOS on 2018/10/30.
//  Copyright © 2018年 weiman. All rights reserved.
//

import Foundation

/*
 扩展
 
 swift语言中有一项非常强大而又灵活的功能——扩展。
 扩展语法可以对已有的类、结构体、枚举或者协议添加新的功能。
 扩展在项目中是非常经常使用的一个特性。
 
 */

// 1. 扩展计算式属性

// 对CGSize进行扩展
extension CGSize {
    
    var diagonal: CGFloat {
        return sqrt(width * width + height * height)
    }
}

let size = CGSize(width: 3.0, height: 4.0)
print("diagonal = \(size.diagonal)")

// 对自定义的结构体进行扩展
struct Circle {
    
    var r = 0.0
}

extension Circle {
    
    var zhijing: Double {
        get {
            return 2 * r
        }
        
        set {
            r = newValue / 2.0
        }
    }
    
    var zhouchang: Double {
        get {
            return zhijing * Double.pi
        }
        
        set {
            zhijing = newValue / Double.pi
        }
    }
    
    var mianji: Double {
        
        get {
            return r * r * Double.pi
        }
        
        set {
            r = sqrt(newValue / Double.pi)
        }
    }
}

var circle = Circle(r: 3.0)

print("半径： \(circle.r)")
print("直径： \(circle.zhijing)")
print("周长： \(circle.zhouchang)")
print("面积： \(circle.mianji)")

// 2. 对方法进行扩展
/*
 对某一类型的方法进行扩展与计算式属性的扩展类似。
 */

print("\n------------2. 对方法进行扩展---------------\n")

enum Light: String {
    case red = "red"
    case green = "green"
    case blue = "blue"
}

extension Light {
    
    init() {
        self = .red
    }
    
    func discribe() -> String {
        return self.rawValue
    }
    
    subscript(index: Int) -> Light {
        let match = ["red", "green", "blue"]
        let currIndex = match.index{
            return $0 == self.rawValue
        }!
        
        return Light(rawValue: match[(currIndex + index) % 3])!
    }
}

let light = Light()
print("current light = \(light.discribe())")

// 使用扩展出的下标
print("light[0] = \(light[0])")
print("light[1] = \(light[1])")
print("light[2] = \(light[2])")

// 3. 对协议的扩展
/*
当一个协议具有许多属性与方法，或者由于它继承了其他许多协议而使得它的属性与方法变得很多的时候，我们
 就要对它们一一实现显然会显得非常麻烦。
 swift提供了对协议的扩展，使我们可以对协议中的已有的计算式属性以及方法提供默认的实现，甚至还能扩展
 出没有声明在该协议中的属性与方法。这样，当我们遵循一个协议的时候，所有默认实现的属性和方法在当前类型中
 都可以无需强制实现。
 */

print("\n------------3. 对协议的扩展--------------\n")

protocol Prot {
    
    func method()
    var property: Int { get set }
}

extension Prot {
    
    static func typeMethod() {
        print("这是一个方法")
    }
    
    static var typeProperty: Int {
        get {
            return 10
        }
        set {
            print("value = \(newValue)")
        }
    }
    
    func foo() {
        print("foo")
    }
    
    func method() {
        print("这是method")
    }
    
    var property: Int {
        get {
            return 1
        }
        set {
            print("input value = \(newValue)")
        }
    }
}

struct MyStruct: Prot {
    // 这里不对Prot做任何实现
}

class MyClass: Prot {
    
    var member = 100
    
    var property: Int {
        get {
            return member
        }
        set {
            member = newValue
        }
    }
    
    static func typeMethod() {
        print("MyClass的typeMethod方法")
    }
    
    func foo() {
        print("MyClass的foo")
    }
}

var p: Prot = MyStruct()
p.method()
p.property = 5
print("property = \(p.property)")

// 创建Myclass对象实例
p = MyClass()
p.method()
p.property += 20
print("property = \(p.property)")

p.foo()

MyClass().foo()

// 4. 对已有类型做协议遵循的扩展
/*
 协议在swift中是重要的部分。因为swift中，枚举、结构体等值类型不具备继承特性，一般只能通过协议来做模板化。
 对已有类型做协议扩展的语法非常简单，我们先定义好相关所需扩展的协议，然后通过extension对已有类型进行
 扩展。
 */

print("\n----------4. 对已有类型做协议遵循的扩展-------------\n")

protocol Addable {
    
    static func + (lhs: Self, rhs: Self) -> Self
    
    static func += (lhs: inout Self, rhs: Self) -> Self
}

extension Int: Addable {
    
    static func += (lhs: inout Int, rhs: Int) -> Int {
        return lhs + rhs
    }
}

extension Double : Addable {
    static func += (lhs: inout Double, rhs: Double) -> Double {
        return lhs + rhs
    }
}

func test<T: Addable>(a: inout T, b: T) {
    let sum = a + b
    print("sum = \(sum)")
    a += b
}

var m = 100
let n = 50
test(a: &m, b: n)
print("m = \(m)")

var x = 50.2
let y = 40.4
test(a: &x, b: y)
print("x = \(x)")

// 5.对泛型类型进行扩展
/*
 对泛型类型做扩展与非泛型类型类似，只不过我们在对泛型类型进行计算式属性与方法的扩展时需要注意当前属性
 或者方法所设计的类型是否为与当前类型相一致的泛型。
 */

print("\n---------5.对泛型类型进行扩展-----------\n")

struct YourStruct<T> {
    var member: T
}

extension YourStruct {
    
    var property: T {
        
        get {
            return member
        }
        set {
            member = newValue
        }
    }
    
    func method(obj: T) {
        print("obj = \(obj)")
    }
}

var s = YourStruct(member: 100)
s.property = s.property + 10
print("member = \(s.member)")

s.method(obj: 30)

// 6. 从一条泛型where从句进行扩展
/*
 与泛型约束一样，对一个泛型类型进行扩展，我们也可以通过where从句对扩展添加约束。
 添加了where从句之后，扩展中的计算式属性与方法可针对约束协议中所包含的操作进行有针对性的功能实现。
 */

print("\n------------6. 从一条泛型where从句进行扩展--------------\n")

struct HisStruct<T> {
    
    var member: T
}

extension HisStruct where T: BinaryInteger {
    
    mutating func divide(obj: T) {
        if obj != 0 {
            member = member % obj
        }
    }
}

extension HisStruct where T: BinaryFloatingPoint {
    
    mutating func divide(obj: T) {
        if obj != 0.0 {
            member = member / obj
        }
    }
}

var si = HisStruct(member: 5)
si.divide(obj: 3)
print("member = \(si.member)")

var sf = HisStruct(member: 1.0)
sf.divide(obj: 2.0)
print("member = \(sf.member)")
