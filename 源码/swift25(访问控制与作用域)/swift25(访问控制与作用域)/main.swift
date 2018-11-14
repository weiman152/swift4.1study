//
//  main.swift
//  swift25(访问控制与作用域)
//
//  Created by iOS on 2018/11/6.
//  Copyright © 2018 weiman. All rights reserved.
//

import Foundation

/*
 访问控制与作用域
 
 前言：本节内容容易验证，只要访问等级不对，那么编译器就会报错。
 
 什么是访问控制？
 就是控制我们在某一swift源文件中在文件作用域所写的函数、类型以及对象，或是类型中属性和方法对其他
 源文件的可见性。就是那些文件可以访问这些函数、类型以及对象。
 
 模块：
 swift有模块这一概念，模块在swift中其实就是一个framework。我们平时在写代码时候用的import后面的名字
 就是模块名，import则表示在当前上下文中导入指定的模块。
 */

// 1. 访问等级
/*
 swift提供可五种不同的访问等级：
 open > public > internal > fileprivate > private
 
 (1) open:
 只能应用于类类型以及类类型的成员。
 注意：初始化器和析构器不能使用open修饰，final修饰的属性和方法也不能用open修饰。
 被open修饰的类，说明该类在其他模块中能被子类化，也就是该类能够被继承。
 
 注意： 一个类、枚举和结构体类型的初始化器方法最高只能使用public访问等级修饰。类的析构器方法不能
 用任何访问等级进行修饰。因为析构器只是对当前类进行销毁释放的，只有当前类的所有属性和方法都被释放了，
 当前类的引用等于零的时候，会自动调用该类的析构函数。
 
 (2) public:
 可以用于修饰所有文件作用域的函数、对象、协议、枚举、结构体、类以及各种类型中的属性和方法。
 用public修饰的对象能被其他模块所使用。但是，其他模块不能继承当前所定义的类类型，也不能对当前
 类类型中的属性和方法进行重写。所以public访问等级要比open要低一级，但是它的适用范围比open要广。
 
 (3) internal:
 internal访问等级能用于修饰的元素与public一样，只不过用internal所修饰的函数、对象、类型以及
 类型中的方法和属性只能在当前模块内部访问，也就是说只能被当前模块中的各个swift源文件访问。
 注意：
 如果我们定义了一个函数、属性或方法没有使用任何访问控制符，那么默认等级就是internal。
 
 (4) fileprivate:
 fileprivate访问等级能用于修饰的元素实体与internal一样，不过fileprivate所修饰的元素实体只能
 在当前源文件作用域内可见。
 
 (5) private:
 private访问等级一般用于修饰某个类型中的属性和方法，表示该属性或方法仅对当前类型或者该类型的对象可见。
 
 注意：访问等级用于修饰一个元素实体的时候，往往都是写在声明的最前面。
 
 */

print("\n-------1. 访问等级----------\n")

/// 其他模块可以继承的类
open class OpenClass {
    
    /// 存储属性a，其他模块可以对该属性设置属性观察者。
    open var a = 0
    
    /// 其他模块可以重写该方法
    open func method() {
        print("这是一个open修饰的方法")
    }
    
    /// 一个类的初始化器最高只能使用public进行修饰
    public init() {
        
    }
    
    final func foo() {
        print("这是一个final修饰的foo，子类不能重写")
    }
    
    /// 最高只能使用public修饰，不能使用open
    public final func boo() {
        print("这是一个public final修饰的boo，子类不能重写")
    }
    
    deinit {
        print("OpenClass被释放了")
    }
    
}


/*
 2. 访问等级的指导原则
 
 一个实体的访问等级必须小于等于它所关联的实体中的最小访问等级。
 有点儿烧脑，看例子。
 */

/*
 (1) 一个public的对象不能用具有internal、fileprivate以及private访问等级的类型来定义。
 因为这些类型可能会一起随着该对象出现在它们不应该可见的地方。
 */

internal enum MyEnum {
    case one, two, three
}

/*
 报错：
 Constant cannot be declared public because its type 'MyEnum' uses an internal type
 */
//public let e = MyEnum.one


/*
 (2) 一个open访问等级的类不能继承public、 internal、 fileprivate、private访问等级的类。
 */

public class MyClass {
    
}

/*
 报错：
 Superclass 'MyClass' of open class must be open
 */
//open class Child: MyClass {
//
//}

/*
 (3) 一个函数的访问等级不能高于其返回类型以及形参类型的访问等级。
 */

internal enum YourEnum {
    
}

fileprivate struct YourStruct {
    
}

/*
 报错：
 Function cannot be declared public because its result uses a fileprivate type
 */
//public func foo(e: YourEnum) -> YourStruct {
//    return YourStruct()
//}

/*
 (4) 对于我们自己定义的一个类型，
 如果它具有open、public或internal访问等级，那么其成员具有默认的internal访问等级；
 如果一个类型被声明为fileprivate，那么其成员默认具有fileprivate访问等级；
 如果一个类型被声明为private访问等级，那么其成员默认具有private访问等级。
 
 
 (5) 对于我们自己定义的类型，我们可以在它内部定义比该类型访问等级更高的成员，可以定义比该类型访问等级更低的成员。
 */

fileprivate struct Test {
    
    public func method() {
        
    }
    
    private func foo() {
        
    }
}

/*
 3. 元组的访问等级
 
 一个元组类型的访问等级是它所有元素中访问等级最低的那个等级。
 */

struct TestStruct {
    
}

private struct PrivateStruct {
    
}

/// 在文件作用域内，fileprivate和private两者等同
fileprivate var tuple: (Int, TestStruct, PrivateStruct)

// 对于元组字面量，它不受各个元素对象的访问等级的影响。

private let s = "Hello"
public let f: Float = 0.5
let i = 100

public let tuplenew = (s, f, i)
print("tuplenew = \(tuplenew)")



/*
 4. 枚举类型的访问等级
 
 一个枚举类型的每个枚举值都会默认具有该枚举类型所拥有的访问等级。
 我们不能给某一个枚举值指定一个不同的访问等级。
 */

public enum TrafficLight {
    case red, green, yellow
}

public let e1 = TrafficLight.red

fileprivate enum Light {
    case red, green, blue
}

/// 这里只能用fileprivate来限定e2枚举对象，而不是public或internal
fileprivate let e2 = Light.blue

// 枚举类型的访问等级不能高于其原生值的访问等级
fileprivate struct MyInt {
    
}

/*
 这里的LightNew必须是fileprivate或者是private，因为使用了MyInt是fileprivate的访问等级。
 枚举类型的访问等级不得高于其原生类型的访问等级。
 */
fileprivate enum LightNew {
    case red(MyInt)
    case green(Int)
    case blue
}

/*
 借着枚举类型，再说说嵌套类型的访问等级。在一个private访问等级中定义的嵌套类型默认具有private访问
 等级；在一个filePrivate访问等级中定义的嵌套类型默认具有filePrivate的访问等级。
 */

/// 具有internal访问等级
struct HisStruct {
    
    // 具有private访问等级
    private enum HisEnum {
        
    }
    
    // 具有internal访问等级
    open class HisClass {
        
    }
    
    // 具有internal访问等级
    struct InnerStruct {
        
    }
    
}


/*
 5.类继承的访问等级
 
 子类的访问等级不得高于父类。
 */

public class Father {
    
    func method() {
        
    }
    
    func foo() {
        
    }
}

class Child: Father {
    
    /// 重写父类的method方法，并且提升了访问权限
    public override func method() {
        
    }
    
    /// 重写父类的方法，并且提升访问等级
    open override func foo() {
        
    }
}

// 6. 属性getter与setter方法的访问等级
/*
 一个属性和下标的getter和setter方法的访问等级默认为该属性或虾兵自身所拥有的访问等级。
 */

struct TestA {
    
    /// 这里定义一个internal访问等级的存储式实例属性，但是写操作的等级是private
    private(set) var a = 10
    
    /// b的访问属性是public但是写操作的访问等级是internal
    public internal(set) var b = 20
    
    fileprivate(set) var p: Int {
        set {
            a = newValue
        }
        get {
            return a
        }
    }
    
    fileprivate private(set) subscript(index: Int) -> Int {
        set {
            b = index
        }
        get {
            return index
        }
    }
}

var t = TestA()
// 这里没有问题
t.b = t.a

/*
 报错：Cannot assign to property: 'a' setter is inaccessible
 */
//t.a = 100

class TestClass {
    
    open public(set) var prop: Int {
        
        set {}
        get {
            return 0
        }
    }
}

/*
 7. 初始化器的访问等级
 
 结构体、枚举以及类的初始化器可以给予小于等于其类型访问等级的访问等级。对于类中的required初始化器，
 其访问等级必须与类的访问等级保持一致。不过，当类的访问等级是open的时候，required初始化器的访问
 等级则必须是public，因为初始化器的最高等级就是public。
 */

open class TestB {
    
    init(a: Int) {
        
    }
    
    public required init() {
        
    }
}

/*
 8. 协议相关的访问等级
 
 一个协议中所声明的每个属性与方法自动跟协议本身的访问等级保持一致，并且我们不能对其中任一属性或
 方法的访问等级进行修改。
 */

public protocol MyPort {
    // 访问等级也是public
    var p: Int { get set }
    // 访问等级也是public
    func method()
}

/*
 如果有协议A继承了协议B，那么协议A的访问等级不得高于协议B。
 */

fileprivate protocol HisPort {
    // 这里的访问等级也是fileprivate
    func method()
}

public struct HerStruct: HisPort {
    
    internal func method() {
        
    }
}

/*
 9. 扩展相关的访问等级
 
 我们可以对任一类型在其可见的上下文中对它进行扩展。如果我们扩展的是一个public的类型，那么新扩展的
 成员将默认具有 internal访问等级。而对于扩展类型为小于 public访问等级的，那么所扩展的新成员将
 默认具有与该类型相同的访问等级。
 */

public struct ThisStruct {
    
}

extension ThisStruct {
    
    /// internal访问等级
    func method() {
        
    }
    
    /// private访问等级
    private func foo() {
        
    }
}

fileprivate extension ThisStruct {
    
    /// fileprivate访问等级
    func method(a: Int) {
        
    }
    
    /// private的访问等级
    private func foo(a: Int) {
        
    }
}

/*
 从swift4.0开始，如果一个扩展与它所扩展的类型处于同一个源文件中，那么扩展中能访问该类型的私有成员。
 */

struct StructA {
    
    private var a = 10
    private func method() {
        
    }
}

extension StructA {
    
    static var b = 1
    private func foo() {
        
        print("a = \(self.a)")
    }
}

extension StructA {
    
    private var p: Int {
        return StructA.b + 1
    }
}

/*
 注意：
 只有当他们处于同一个源文件的时候才会相互访问私有成员，不然是不能访问的。
 */


/*
 10. 类型定义的访问等级
 
 我们所定义的任一类型定义都作为单独的类型，从而可以为他们指定不同的访问等级。
 但是，我们要指定一个类型定义的访问等级时，它不能高于定义它的原始类型的访问等级。
 */

// 这里是internal访问等级
class ThatClass {
    
    
}

//这里只能使用低于internal的等级来修饰ThatType
fileprivate typealias ThatType = ThatClass

/*
 11. 作用域
 
 swift 包含了以下几种作用域：
 模块作用域，文件作用域，类型作用域以及函数、语句块作用域。
 */

// 我们自定义了一个String结构体，把swift标准库中的String给覆盖掉了。
struct String {
    
}

// 这里是自定义的String类型
let ss = String()

// 这里是swift标准库中的String类型
let str = Swift.String("abc")

do {
    
    // 在文件作用域定义了对象a
    var a = 100
    
    // 在文件作用域定义了函数 foo
    func foo() {
        
    }
    
    // 在文件作用域定了结构体MyType
    struct MyType {
        
    }
    
    struct MyStruct {
        
        // 这里的a属性直接覆盖了文件作用域的a
        static var a = 0
        
        func foo() {
            
            let value = MyStruct.a + MyType.one.rawValue
            print("value = \(value)")
        }
        
        // 覆盖了前面的MyType
        enum MyType: Int {
            case one, two, three
        }
    }
    
}








