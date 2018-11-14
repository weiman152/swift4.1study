//
//  main.swift
//  swift24(操作符方法与操作符的定制)
//
//  Created by iOS on 2018/11/1.
//  Copyright © 2018 weiman. All rights reserved.
//

import Foundation

/*
 操作符方法与操作符的定制
 
 到目前为止，我们已经学习了swift的绝大部分的语法特性。本节中，我们还要学习swift的另一个灵活
 多样的语法特性 —— 操作符方法。我们可以为自己定义的类或者结构体类型构建出一套已有的基本算数逻辑
 操作符（加减乘除），而且我们还能自己创建出swift语法系统没有的独特操作符（比如 +++, =>等等）。
 
 操作符简介：
 1.前缀操作符： -x， !x, ~x
 2.中缀操作符: a + b, a - b , a * b
 3.后缀操作符: x...  , a.count(成员访问操作符), a[0](下标)
 
 */

// 1. 对已有操作符的重载
/*
 我们为自己定义的结构体和类类型的对象提供了对已有操作符方法的重载。比如，我们定义一个复数类型，然后
 用基本的加减乘除等符号对两个复数类型的对象进行操作。
 */

print("\n---------1. 对已有操作符的重载-----------\n")

struct ComplexNumber {
    
    /// 表示实数的存储式实例属性
    var real: Double
    
    /// 表示虚数的存储式实例属性
    var imag: Double
    
    /// 对正数前缀操作符进行重载
    static prefix func + (num: ComplexNumber) -> ComplexNumber {
        return num
    }
    
    /// 对取相反数的前缀操作符进行重载
    static prefix func - (num: ComplexNumber) -> ComplexNumber {
        return ComplexNumber(real: -num.real, imag: -num.imag)
    }
    
    /// 对 ~ 前缀操作符进行重载
    static prefix func ~ (num: ComplexNumber) -> ComplexNumber {
        return ComplexNumber(real: num.real, imag: -num.imag)
    }
    
    /// 对加法中缀操作符进行重载
    static func + (a:ComplexNumber, b: ComplexNumber) -> ComplexNumber {
        return ComplexNumber(real: a.real + b.real, imag: a.imag + b.imag)
    }
    
    /// 对减法中缀操作符进行重载
    static func - (a: ComplexNumber, b: ComplexNumber) -> ComplexNumber {
        return ComplexNumber(real: a.real - b.real, imag: a.imag - b.imag)
    }
    
    /// 对乘法中缀操作符进行重载
    static func * (a: ComplexNumber, b: ComplexNumber) -> ComplexNumber {
        return ComplexNumber(real: a.real * b.real, imag: a.imag * b.imag)
    }
    
    /// 对除法中缀操作符进行重载
    static func / (a: ComplexNumber, b: ComplexNumber) -> ComplexNumber {
        return ComplexNumber(real: a.real / b.real, imag: a.imag / b.imag)
    }
    
    /// 对 ++ 后缀操作符进行重载
    /// 这里将它作为复数的取模运算
    /// 从swift3.0之后， ++ 已经不能作为递增运算符来使用了
    static postfix func ++ (num: ComplexNumber) -> Double {
        return sqrt(num.real * num.real + num.imag * num.imag)
    }
    
    /// 对 += 进行重载哦
    static func += (a: inout ComplexNumber, b: ComplexNumber) -> Void {
        a.real += b.real
        a.imag += b.imag
    }
    
    /// 对 -= 进行重载
    static func  -= (a: inout ComplexNumber, b: ComplexNumber) -> Void {
        a.real -= b.real
        a.imag -= b.imag
    }
}

// 使用
var a = ComplexNumber(real: 3.0, imag: 4.0)
var b = ComplexNumber(real: -1.0, imag: 2.0)

// 对两个复数相加
var c = a + b
print("a + b = \(c)")
print("a - b = \(a - b)")
print("a * b = \(a * b)")
print("a / b = \(a / b)")

c = -a
print("-a = \(c)")

c = ~a
print("~a = \(c)")

/*
 注意：
 当我们要重载一个前缀操作符的时候，就需要添加prefix关键字进行显式声明；
 当我们要重载一个后缀操作符的时候，就需要添加postfix关键字进行显示指明。
 当我们要重载一个中缀操作符的时候，不需要添加任何关键字。
 */

// 2. 可定制的操作符
/*
 当我们定制在swift语法系统中不存在的操作符，比如， +++， =>等，我们可以定制的操作符可包含swift
 中大部分的标点符号，而以下标点符号不允许出现在定制的操作符中：
( 、) 、[ 、] 、{ 、} 、" 、' 、; 、: 、@ 、\ 、` 、, 、# 、_ 和 $
 如果我们要在定制操作符中包含 . 符号，那么它必须出现在一开始，然后后面可进行任意添加。所以像 .+ 、.. 、.+. 都是合法的可定制的操作符；而像 +. 、+.- 都是非法的。
 定制操作符可以用以下符号作为首字符：/ 、= 、- 、+ 、! 、* 、% 、< 、> 、& 、| 、^ 、? 及 ~。但是，当我们要定制后缀操作符时，就不能以 ? 和 ! 作为首字符了。
 Swift规定了以下操作符作为编译器保留的操作符，不可进行定制和重载：= 、-> 、// 、/* 、*/ 、. 。< 、& 、? 这些不可作为前缀操作符进行定制或重载。? 不可作为中缀操作符被重载。> 、! 、? 这些不可作为后缀操作符被定制或重载。
 在Swift编程语言中，我们使用操作符的过程中还得注意：前缀操作符与后缀操作符跟其操作数之间应该紧贴，两者之间不应该存在任何空白符，否则该操作符可能被Swift编译器判定为中缀操作符，从而引起编译错误。而在使用中缀操作符时，操作符与左操作数和右操作数之间都分别应该用一个空白符隔开，这样既美观，而且也能减轻编译器的词法、语法解析压力。
 */

// 3.定制前缀操作符
/*
 本节中我们一起学习如何定制前缀操作符。
 */

print("\n---------3.定制前缀操作符----------\n")

/// 声明新的操作符 &^
prefix operator &^

/// 实现 &^
prefix func &^ (op: Int) -> Int {
    return op & (op * op)
}

/// 定义结构体MyData类型
struct MyData {
    
    // 存储属性
    var data: Int
    
    static prefix func &^ (op: MyData) -> MyData {
        return MyData(data: op.data & (op.data * op.data))
    }
}

let x = 3
let y = &^x
print("y = \(y)")


let m = MyData(data: 5)
let n = &^m
print("n = \(n.data)")

let f = &^(m.data + 1)
print("c = \(f)")

// 4. 定制后缀操作符
/*
 定制后缀操作符的过程与前缀操作符差不多，不过在声明定制后缀操作符的时候使用关键字postfix operator.
 */

print("\n--------4. 定制后缀操作符-----------\n")

/// 定义一个新的定制操作符
postfix operator |<

postfix func |< (op: Int) -> Int {
    return op < 0 ? -op : op * 2
}


let me = -1|<
print("me = \(me)")
// 结果是：me = -2
/*
 为什么呢？
 因为负数操作符的优先级低于后缀操作符，所以先执行后缀操作符，结果是 2， 再与负数操作符结合，就变成了 -2 .
 */

let you = 3|< + (-1)|<
print("you = \(you)")
// 注意： 一般前缀操作符的优先级要低于后缀操作符

// 5. 定制中缀操作符
/*
 定制中缀操作符要复杂一些，因为中缀操作符种类丰富，在表达式中也往往用得最多。
 定制中缀操作符方法：
 infix operator 关键字 ： 优先级组
 */

print("\n--------5. 定制中缀操作符----------\n")

/// 声明一个 *+ 中缀操作符
infix operator *+ : MultiplicationPrecedence

/// 实现这个中缀操作符
func *+ <T: SignedInteger>(a: T, b: T) -> T {
    return (a * a) + (b * b)
}

/// 实现这个中缀操作符
func *+ <T: FloatingPoint>(a: T, b: T) -> T {
    return (a * a) + (b * b)
}

// 使用
let hh = 3 *+ 4
print("hh = \(hh)")

let gg = 3.0 *+ 5.0
print("gg = \(gg)")

/*
 我们要想深度定制中缀操作符，还可以通过 precedencegroup 关键字来定义自己的优先级组。
 优先级组有四个属性：
 1. higherThan: 表示所定义的优先级组的优先级所指定已有的优先级组。
 2. lowerThan: 表示所定义的优先级组的优先级低于所指定的已有的优先级组。
 3. associativity: 表示所定义的优先级组的结合性，只能取3种值，left表示左结合，right表示右结合，
 none表示无结合。
 4. assignment: 表示是否数据赋值型的操作符（比如 +=, -=）等。true表示当前定义的优先级组所关联的操作符
 均为赋值型操作符；false则表示非赋值型操作符。
 */

precedencegroup MyPre {
    /// 其优先级比AdditionPrecedence优先级高
    higherThan: AdditionPrecedence
    
    /// 优先级比MultiplicationPrecedence优先级低
    lowerThan: MultiplicationPrecedence
    
    /// 属于右结合
    associativity: right
    
    /// 表示非赋值型操作符
    assignment: false
}

/// 定义一个中缀操作符
infix operator |-& : MyPre

func |-& <T: BinaryInteger>(a: T, b: T) -> T {
    return (a | b) - (a & b)
}

let jj = -1 + 3 |-& 2 * 0
print("jj = \(jj)")


// 6.对操作符方法的引用
/*
 既然操作符方法其本质是一个函数，或是一个方法，那么我们自然就能对它进行引用了。
 */

print("\n--------6.对操作符方法的引用----------\n")

// 先引用一个已有的操作符： <
// 注意这里的圆括号不能省略。
let lessref: (Int, Int) -> Bool = (<)
let result = lessref(20, 30)
print("is less? \(result)")

func lessRefTest(op: (Double, Double) -> Bool) {
    let result = op(30.1, 20.6)
    print("is less: \(result)")
}

lessRefTest(op: <)

/*
 注意：
 我们自己在写代码的时候尽量用文字说明函数的具体用途，而不要搞一些莫名其妙的符号，如果怪异的符号太多，
 然后再把他们作为实参一传，阅读代码的人很容易晕头转向。
 */



