//
//  main.swift
//  swift11(闭包)
//
//  Created by iOS on 2018/10/10.
//  Copyright © 2018年 weiman. All rights reserved.
//

import Foundation

/*
 闭包
 闭包是swift中比较重要的一部分内容，也是个人认为比较难以理解的内容，也可能是之前没有
 细细的研究的缘故。
 
 1.闭包的概念
 
 闭包是将一个函数与执行环境存放在一起的一条记录。
 
 名字绑定：当闭包被创建的时候，它会将它所在的函数中的局部对象与它自己的执行环境中的对象名做一个值或者
 引用的关联映射。这就是“名字绑定”。
 捕获：如果闭包访问了它所在函数的局部对象，那么我们称它“捕获”了该局部对象。
 
 注意：
 由于闭包有自己的执行环境，我们称为上下文，因此即便当它所在的函数被返回值后，该闭包依然能正常调用。
 问题：那么闭包什么时候被销毁呢？
 
 
 我们之前提到过，捕获外部函数局部对象的嵌套函数属于命名闭包，它也是个闭包。但是，函数、闭包和方法还是各自独立的更好些。
 */

do {
    
    func foo() {
        print("这是一个函数")
    }
    
    g_func = foo
    CTest()
    
    //打印结果： 这是一个函数
    
    func boo() {
        var a = 10
        
        func inner() {
            print("这是一个内部函数")
        }
        
        g_func = inner
        CTest()
        
        func closure() {
            a += 10
            print("closure  a = \(a)")
        }
        // 报错：A C function pointer cannot be formed from a local function that captures context
        // 函数指针不能指向闭包
        //g_func = closure
        
        g_func = {
            print("哈哈哈哈哈")
        }
        CTest()
        
        struct MyStruct {
            let a: Int, b: Double
            
            func method() {
                print("a = \(a), b = \(b)")
            }
            
            static func typeMethod() {
                print("这是一个结构体")
            }
        }
        
        // 报错：A C function pointer can only be formed from a reference to a 'func' or a literal closure
       // g_func = MyStruct.typeMethod
        
        
        let obj = MyStruct(a: 10, b: 100.0)
        // 报错：A C function pointer can only be formed from a reference to a 'func' or a literal closure
       // g_func = obj.method
        
    }
    
    boo()
    
   /*
     小结：
     一个C函数指针对象只能指向一般的函数，包括不捕获其外部函数局部对象的嵌套函数，以及不捕获其外部函数局部对象的闭包。
     
     */
}

// 2. 闭包的定义与调用
/*
 在swift中，一个闭包又称为“闭包表达式”。
 基本语法形式：
 _ = { (参数1: 参数类型， 参数2: 参数类型....) -> 返回值类型 in
      闭包执行代码
 }
 
 */
do {
    
    _ = { () -> Void in
       print("这是一个简单的无参数的无返回值的闭包")
    }
    
    _ = { (a: Int) -> Void in
        print("这是一个有参数，无返回值的闭包，参数：a = \(a)")
    }
    
    // 有参数，有返回值的闭包，返回值是 () -> Void
    _ = { (a: Int, b: Int) -> () -> Void in
        let sum = a + b
        var x = sum * 2
        
        return { () -> Void in
            print("sum = \(sum)")
            x += sum
        }
    }
    
}

// 闭包的调用
// 闭包的调用与函数的调用一样，可以直接在闭包表达式的后面使用函数调用操作符，形成完整的函数调用表达式。

do {
    
    print("\n ----------- 闭包的调用-------------")
    
    _ = { () -> Void in
        print("无参数无返回值的闭包")
    } ()
    
    _ = { (a: Int) -> Void in
        print("a = \(a)")
    } (10)
    
}

// 3. 闭包表达式的简略表达（重点哟）
/*
 因为swift语言强大的类型推导特性，我们可以将闭包表达式简化。
 */

do {
    
    //1.缺省返回类型的表达式
    /*
     如果一个函数的返回类型省略，则函数的返回类型就是Void，但是，如果闭包的返回类型省略，
     则不一定是Void。
     */
    
    let ref = { (a: Int, b: Int) in
        
        return a + b
    }
    
    print("value = \(ref(1, 2))")
    // 结果： value = 3
    
    // 上述闭包表达式中，返回值就是 （Int, Int）-> Int 类型
    
    //2.缺省参数类型的闭包表达式
    // swift不仅能够推导出闭包的返回值类型，还能推导出参数的类型，因此，闭包的形参也是可以省略的。
    // 并且小括号也是可以省略的。如果闭包形参列表的圆括号省略了，那么每个形参的类型都必须缺省。
    
    var ref2: (Int, Int) -> Int = { a, b in
        return a + b
    }
    print("1: \(ref2(2, 3))")
    
    ref2 = { a, b -> Int in
        return a + b
    }
    print("2: \(ref2(4, 6))")
    
    ref2 = { (a, b: Int) in
       return a + b
    }
    print("3: \(ref2(4, 5))")
    
    // 3. 缺省return关键字
    // 如果闭包表达式中其执行语句只有一个单独的 return语句构成，那么关键字return也可以缺省
    
    let ref3: (Int, Int) -> Int = { a, b in
        a + b
    }
    print("value = \(ref3(1, 1))")
    
    // 返回值是一个元组的第二个元素
    print("\n")
    let ref4 = { (a: Int) -> Int in
        (print("a = \(a)"), a + 1).1
    }
    print("value2 = \(ref4(3))")
    
    // 4. 省略 in 关键字
    // 如果一个闭包确定其每个形参的类型以及返回类型，那么该表达式中连 in 关键字都能缺省。
    // 当我们要引用其形参时使用 $ 符号加上形参索引：第一个形参的索引值为0，第二个索引值为1,后续参数
    // 依次类推。
    print("\n")
    var r: (Int, Int) -> Int  = { $0 + $1 }
    print("value: \(r(3, 3))")
    
    let r2 = {
        print("hello")
    }
    r2()
    
    r = {
        print("第一个参数: \($0)")
        print("第二个参数: \($1)")
        return $0 + $1
    }
    print("result: \(r(5, 8))")
    
    
    let r3: (Int) -> Void  = {
        print("参数： \($0)")
        let a = $0 * $0
        print("a = \(a)")
    }
    r3(5)
}

// 4. 尾随闭包
/*
 如果一个闭包表达式作为函数调用的最后一个实参，那么我们可以采用“尾随闭包”语法糖。
 */

do {
    
    print("\n ----------尾随闭包---------------")
    
    func foo(_ a: Int, callback: (Int) -> Void) {
        callback(a)
    }
    
    foo(10) { (aa) in
        print("参数是 \(aa)")
    }
    //或者简写
    foo(12, callback: { print("参数： \($0)")})
    
    //尾随闭包, 这个时候callback标签必须省略
    foo(14){
        print("参数是： \($0)")
    }
    
    func boo (_ a: Int, _ b: Int, callback: ((Int, Int) -> Int)?) {
        if let callback = callback {
            let value = callback(a, b)
            print("value = \(value)")
        }
    }
    
    boo(2, 3) { (a: Int, b: Int) -> Int in
        return a * a + b * b
    }
}

// 5. 捕获局部对象与闭包执行上下文
// 闭包所捕获的对象是按照引用进行捕获的，同时闭包本身是一个引用对象。

do {
    print("\n ----------捕获局部对象与闭包执行上下文---------------")
    
    var a = [1, 2, 3]
    var b = a
    a[0] += 10
    
    print("a = \(a)")
    // 结果： a = [11, 2, 3]
    
    func foo() {
        var a = 10
        let closure = {
            print("a = \(a)")
        }
        
        closure()
        
        a += 10
        
        closure()
    }
    
    foo()
    
    /*
     结果：
     a = 10
     a = 20
     */
    
    func boo() -> () -> Void {
        var x = 10
        return {
            x += 10
            print("x = \(x)")
        }
    }
    
    var closure = boo()
    
    var ref = closure
    
    closure()
    
    ref()
    
    closure()
    
    /*
     
     结果：
     x = 20
     x = 30
     x = 40
     */
    
    // 重新赋值后再次调用
    ref = boo()
    
    closure()
    
    ref()
    
    /*
     结果：
     x = 50
     x = 20
     */
    
    /*
     小结：
     上述实例证明了闭包属于引用类型，闭包所捕获的外部局部对象也是以引用的方式 捕获的。
     */
    
}

// 6. 逃逸闭包
/*
 如果我们定义了一个函数，它有一个形参为函数类型，如果在此函数中将通过异步的方式调用该函数引用对象，
 那么我们需要将此函数类型声明为“逃逸的”，以表示该函数类型的形参对象将可能在函数调用操作结束后的某一
 时刻才会被调用。
 */

do {
    
    print("\n --------逃逸闭包----------")
    
    var ref: (() -> Void)!
    
    func foo(closure: @escaping () -> Void) {
        ref = closure
    }
    
    foo {
        print("你好")
    }
    
    ref()
}

// 7. 自动闭包
/*
 自动闭包也是swift中的一个语法糖。如果一个函数的某个形参为函数类型，并且不含有任何形参，那么我们
 就可以将此参数声明为“自动闭包”。
 */

do {
    
    print("\n---------自动闭包----------")
    
    func foo(closure: () -> Void) {
        closure()
    }
    
    foo {
        print("简单的闭包")
    }
    
    func boo(auto closure: @autoclosure () -> Void) {
        closure()
    }
    
    boo(auto: print("这是个自动闭包"))
    
    func doo() {
        let a = 1, b = -1
        
        func isLarger(compare: @autoclosure () -> Bool) -> Bool {
            return compare()
        }
        
        let result = isLarger(compare: a > b)
        print("result: \(result)")
    }
    
    doo()
    
    /*
     小结：
     不推荐各位在制作公共的API的时候使用自动闭包。
     */
}
