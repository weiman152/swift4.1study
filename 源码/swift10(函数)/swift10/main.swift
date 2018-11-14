//
//  main.swift
//  swift10
//
//  Created by iOS on 2018/9/29.
//  Copyright © 2018年 weiman. All rights reserved.
//

import Foundation

// 函数
/*
 学过任何一门语言的小伙伴们对函数都会感到不陌生。
 Apple官方将swift中的函数定义为： 执行一个特定任务的，自包含的代码块。
 */

// 1. 函数的定义和调用
/*
 func 函数名(参数1，参数2，...) -> 返回值 {
     函数体
 }
注意： 如果没有返回值， “->返回值” 可以省略
 */

do {
    //无参数、无返回值的函数
    func hello() {
        print("你好")
    }
    
    //无参数，有返回值的函数
    func helloWorld() -> String {
        return "你好啊, 嘈杂的世界"
    }
    
    //有参数，无返回值的函数
    func hello(name: String) {
        print("你好， \(name)")
    }
    
    // 有参数，有返回值的函数
    func helloWorld(name: String) -> String {
        return "你好， \(name)"
    }
    
    //函数调用
    hello()
    hello(name: "太阳")
    let a = helloWorld()
    print(a)
    let b = helloWorld(name: "月亮")
    print(b)
}

do {
    func add(a1: [Int], a2: [Int]) -> [Int] {
        return a1 + a2
    }
    
    let a = add(a1: [1, 2, 3], a2: [4, 5, 6])
    print(a)
    
    // 求数组中的最大值和最小值
    func maxAndMin(a: [Int]) -> (max: Int, min: Int) {
        
        var max = a[0]
        var min = a[0]
        for i in a {
            if i > max { max = i }
            if i < min { min = i }
        }
        return (max, min)
    }
    
    let value = maxAndMin(a: [8,3,5,3,2,5,78,4,3,2,3,45,43,333,65,456,886,3433,33,44,56])
    print("max: \(value.max), min: \(value.min)")
}

// 2. 函数的实参标签
/*
 每个函数否包含一个实参标签和一个形参名。
 注意：
 1. 实参标签可以省略，但是形参名不能省略；
 2. 实参标签可以相同，形参名不能相同；
 */
do {
    func myFunc(firstName name: String, secondName name2: String) -> String {
        let str = name + "·" + name2
        return str
    }
    
    // 调用
    let name = myFunc(firstName: "迈克尔", secondName: "杰克逊")
    print(name)
}

// 3. 默认形参值
/*
 swift编程语言可以对函数形参设置一个默认值。如果一个形参具有一个默认值，那么我们在调用
 这个函数的时候可以无需对此参数传递实参，也就是说带有默认值的形参所对应的实参可以缺省。
 */

do {
    func hello(name: String = "wrold") {
        print("hello, \(name)")
    }
    
    //调用
    hello()
    hello(name: "🇨🇳")
    
    /*
     打印：
     hello, wrold
     hello, 🇨🇳
     */
    
    /*
     注意：
     swift的默认参数与C++相比更加的灵活，因为它不仅仅可以放在最后，还可以放在参数列表的任何位置。
     */
    
    func myHello(name: String, years: String = "2018", ages: Int) {
        print("hello, \(name), 今年是\(years)年, 我已经编程\(ages)年了")
    }
    
    myHello(name: "杰克", ages: 10)
    myHello(name: "小土豆", years: "2020", ages: 5)
}

// 4. 不定个数的形参
/*
 swift语言和C语言一样，支持不定个数的形参。
 当我们使用不定个数的形参时，可以将它视作为它所指定类型的额数组，我们可以通过count属性获取实参所
 传递过来的参数个数；通过下标操作符来获取对应的实参值。
 */
do {
    func foo(a: Int, b: Int...) {
        var sum = a
        if b.count > 0 {
            for i in b {
                sum += i
            }
        }
        print("sum = \(sum)")
    }
    
    foo(a: 0)
    foo(a: 0, b: 1)
    foo(a: 0, b: 1, 2, 3, 4, 5)
    
    func boo(a: Int..., b: Int = -1) {
        if a.count > 0 {
            print("value = \(a[0] + a[1])")
        } else {
            print("value = \(b)")
        }
    }
    
    boo()
    boo(a: 1, 2, 3)
    boo(a: 1, 2, 3, 4, b: 10)
    boo(b: 100)
}

// 5. 输入输出形参(inout)
/*
 在swift语言中，所有的形参默认都是常量。因此我们在函数体内如果对一个普通的形参修改其值，那么
 就会引发编译报错。
 swift引入了一种输入输出形参，使得该形参的值不仅能被修改，而且还能影响它所对应的实参值。
 //实现步骤
 1. 当函数在调用前，先将实参的值拷贝到所对应的输入输出形参中。
 2. 在执行函数中的代码时，对输入输出形参的值进行修改。
 3. 在函数返回之后，将修改后输入输出形参的值拷贝回对应的实参中。
 */

do {
    func foo(a: Int, b: inout Int) {
        b += a
    }
    
    var x = 100
    
    foo(a: 10, b: &x)
    print("x = \(x)")
    // 输出： x = 110 ， 在函数内部，b = 110， 函数外部的参数x也跟着改变了，这就是 inout的作用
    
    var array = [1, 2, 3]

    foo(a: array[0], b: &array[2])
    print("array: \(array)")
    // 结果： array: [1, 2, 4]
    
    func boo(t: inout (Double, Double)) {
        t.0 *= 0.5
        t.1 *= 0.5
    }
    
    var point = (10.0, 20.0)
    boo(t: &point)
    print("point: \(point)")
}

// 6. 函数重载
/*
 swift 语言跟C++ 一样，默认支持函数重载。
 什么是函数重载？
 如果在同一作用域以及名字空间中出现一组相同名字的函数，这些函数具有不同的形参类型或者形参个数，或是
 带有不同的返回类型，那么称这组函数为重载函数。
 */

do {
    func foo() {
        print("无参数")
    }
    
    func foo(a: Int) {
        print("有一个整型参数 \(a)")
    }
    
    func foo(b: Float) {
        print("有一个浮点型参数 \(b)")
    }
    
    foo()
    foo(a: 10)
    foo(b: 20.0)
    
}

// 7. 函数类型和函数签名
/*
 函数类型是由其形参列表中各个形参的类型与函数返回类型构成。
 */

do {
    // 返回值为 () -> void
    func foo() {
        print("这是一个函数")
    }
    
    // 返回值为 (Int) -> void
    func foo(_ a: Int) {
        print("有参数的函数 \(a)")
    }
    
    // 返回值为 (Int, String) -> String
    func foo(a: Int, b: String) -> String {
        return "\(a), \(b)"
    }
    
    let b = foo(_ :)
    b(100)
    
    let a = foo(a: b:)
    let r = a(10, "11")
    print(r)
    
    // 定义一个函数magic，含有一个输入输出参数 func,类型是 (Int) -> Void
    // magic的函数的类型为 (inout (Int) -> Void) -> Void
    func magic(fun: inout (Int) -> Void) {
        fun = foo(_ :)
    }
    
    var ref = foo(_ :)
    
    magic(fun: &ref)
    ref(200)
    
    let magicRef: (inout (Int) -> Void) -> Void = magic
    magicRef(&ref)
}

/*
 函数签名
 函数签名这个语法特性其实引申自OC的方法签名。在swift语言中，一个函数名并不是唯一标识当前函数的标志。
 而是需要通过结合每个形参所持有的实参标签。
 */
do {
    func foo() {
        print("foo")
    }
    
    func boo(_ : Void) {
        print("boo")
    }
    
    func moo(a: Int) {
        print("moo")
    }
    
    func poo(a: Int, _: Int, c: Int) {
        print("poo")
    }
    
    //调用
    foo()
    boo(())
    moo(a: 10)
    poo(a: 100, 20, c: 77)
    
}

do {
    func foo(_ : Void) {
        print("foo Void")
    }
    
    func foo(a: Int) {
        print("foo Int")
    }
    
    func foo(i: Float) {
        print("foo float")
    }
    
    func foo(j: Double) {
        print("foo Double")
    }
    
    func foo(_: Void, _: Int) {
        print("foo Void,Int")
    }
    
    let ref1 = foo(_:) as (()) -> Void
    ref1(())
    
    let ref2 = foo(a:)
    ref2(100)
    
    let ref3 = foo(i:)
    ref3(0.5)
    
    let ref4 = foo(_: _:)
    ref4((), 10)
}

print("\n")
//8.嵌套函数定义
/*
 swift语言中，允许在函数中定义一个嵌套函数，这是很多其他语言多不具备的。
 */

do {
    func hello(a: Int) {
        print("value = \(a)")
    }
    
    func outside() -> (Int) -> Void {
        let a = 10
        var b = 20
        
        //定义一个嵌套函数
        func inner(input: Int) {
            print("inner value = \(input)")
        }
        
        func hello(input: Int) {
            b += a + input
            print("b = \(b)")
        }
        
        //调用内部函数
        inner(input: a)
        
        return hello
    }
    
    hello(a: 100)
    let ref = outside()
    ref(5)
    ref(5)
    
    /*
     输出结果：
     value = 100
     inner value = 10
     b = 35
     b = 50
     */
}

// swift的嵌套函数不仅可以直接定义在函数体内，还可以定义在语句块作用域内。
do {
    func foo() {
        print("外面的foo")
        
        func foo() {
            print("中层的foo")
            
            func foo() {
                print("内部的foo")
            }
            
            //调用
            foo()
        }
        foo()
    }
    
    foo()
}

/*
 打印结果：
 外面的foo
 中层的foo
 内部的foo
 
 个人建议：在没有必要的情况下，还是不要这么写，可能自己都给绕晕了。
 */

//9.统一的函数引用体系
/*
 什么是统一的函数引用？
 就是在swift中，我们可以定义一个引用对象，这个对象除了能够引用函数之外，还能引用闭包以及结构体、
 枚举、类类型对象的实例方法。
 */
print("\n ------------统一的函数引用体系----------------- ")
do {
    func foo () {
        print("foo")
    }
    
    var ref = foo
    ref()
    // g_block是OC中定义的Block对象，现在指向foo函数
    g_block = foo
    // 调用OC中的CTest，判断g_block是否为空
    CTest()
    /*
     打印结果
     foo
     foo
     */
    // 说明g_block已经指向了foo函数
    
    // 定义一个boo函数，返回值是() -> Void
    func boo() -> () -> Void {
        var a = 10
        /*
         定义一个嵌套的函数inner，捕获了局部变量a，因此它是一个闭包
         */
        func inner() {
            a += 10
            print("a = \(a)")
        }
        
        return inner
    }
    
    ref = boo()
    ref()
    
    
    g_block = boo()
    CTest()
    /*
     打印结果：
     a = 20
     a = 20
     */
    
    //从打印结果看，g_block还是不为空，并且指向了inner函数
    
    // 定义了一个结构体类型
    struct MyStruct {
        
        let a: Int, b: Double
        
        func method () {
            print("a = \(a), b = \(b)")
        }
    }
    
    let obj = MyStruct.init(a: 10, b: 100.0)
    
    //ref指向了一个结构体的实例方法
    ref = obj.method
    ref()
    
    g_block = ref
    CTest()
    
    /*
     结果：
     a = 10, b = 100.0
     a = 10, b = 100.0
     */
    
    /*
     小结：
     我们发现，swift中的一个函数类型引用可以指向函数、闭包、实例方法三种类型中的任意一种，这是很方便也是很先进的。
     我们跟其他语言做个对比：
     C++：指向函数的指针类型与指向成员函数的指针类型是完全不一样的。
     OC：没有指向成员函数的指针，而是统一使用selector机制。
     Java：使用指向方法的引用更加的繁琐。
     
     比较遗憾的是，函数引用不能比较相等性，因为swift会对函数、闭包做相关优化，因此在运行时无法确定两个引用是否是完全相同的。
     */
}

// 把函数的引用放在数组、字典等容器中。
do {
    func foo () {
        print("这是一个函数")
    }
    
    let ref = foo
    
    let array = [foo, ref]
    
    // 调用第一个元素
    array[0]()
    // 调用第二个元素
    array[1]()
    
//    报错：Binary operator '==' cannot be applied to two '() -> ()' operands
//    let isequal = foo == ref
//    print("isequal = \(isequal)")
}
