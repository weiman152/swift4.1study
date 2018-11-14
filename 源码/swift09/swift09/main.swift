//
//  main.swift
//  swift09
//
//  Created by iOS on 2018/9/29.
//  Copyright © 2018年 weiman. All rights reserved.
//

import Foundation

// swift学习笔记9
/*
 Optional：可选类型  ？
 可选类型是swift特色之一，也是很多初学者不适应的原因之一。
 Optional体现了swift对类型的安全性考虑。
 特点：
 1.只有Optional类型才能作为空值（nil），这一点在参数中使用的非常多；
 2.swift中任何类型都能作为optional类型，甚至是元组！
 3.Optional提供了一种非常简洁的表达可选执行表达式的方式。
 
 什么时候使用？
 当我们声明一个对象而无法确定其当前的值，这个时候就可以先将它声明成一个可选类型。
 */

// 1. 基本使用
do {
    let a: Int? = 100
    let f: Float? = nil
    var s: String?
    
    if s == nil {
        print("s是空")
    }
    
    s = "hello"
    let c = Int?(100)
    let arr: [Int?]? = [1, 2, 3, 4, c]
    let tuple: (Int?, Float?, String?)? = (a, f, s)
    if let arr = arr {
        print("arr = \(arr)")
    }
    if let t = tuple {
        print("tuple = \(t)")
    }
    
    /*打印：
     arr = [Optional(1), Optional(2), Optional(3), Optional(4), Optional(100)]
     tuple = (Optional(100), nil, Optional("hello"))
     */
}

/*
 我们还可以使用 Optional<类型>来声明可选类型
 */
do{
    // 可选整型a，初始化为100
    let a: Optional<Int>  = 100
    
    let b: Optional<String> = nil
    
    let c = Optional<Float>(nilLiteral: ())
    
    print("a = \(a)")
    if b == nil {
        print("b = nil")
    }
    print("c = \(c)")
    
    /*
     注意，平时使用的时候还是使用 ？声明可选类型多一些，因为很方便啊。
     */
}

print("\n")
// 2. Optional 链
do {
    var a: Int? = nil
    
    /*
     这里使用 Optional 链 操作符
     表示如果a不为空，就执行赋值操作 a = 10
     否则不执行任何操作。
     */
    a? = 10
    
    print("a = \(String(describing: a))")
    //输出：a = nil
    
    /*
     这句话与上面的赋值是不一样的
     这里的赋值一定会被执行，而不判断a是否为nil
     */
    a = 10
    print("a = \(String(describing: a))")
    // 输出： a = Optional(10)
    
    var arr: [Int]? = [1, 2, 3]
    // arr?.count 会先判断arr是否为nil，如不空才会继续执行.count
    print("数量： \(String(describing: arr?.count))")
    
    arr? [1] = 10
    print("arr = \(String(describing: arr))")
    
}

print("\n")
//3. Optional的强制拆解 ！
/*
 注意：这一功能还是谨慎使用，一旦被被强制拆解的可选类型为nil，那么程序就是崩溃。。。
 什么是强制拆解？
 强制拆解是和可选类型一起使用的，当我们确定一个可选类型不为nil了，我就可以把这个可选类型强制拆解成
 一个普通的类型。
 用法：
 在可选类型的数据后面加上感叹号 ！
 */

do {
    var a: Int? = 100
    let ca = a!
    print("ca = \(ca)")
    
    a! = a! * a!
    print("a! = \(a!)")
}


print("\n")
// 4. Optional绑定
/*
 上面我们介绍了强制解包的方式把一个可选类型变成一个正常的类型，但是我们也说了这种方式是不够安全的。
 我们还有更加安全的解包的方式，就是 可选绑定 和 空结合操作符（??）
 语法形势：
 if let obj = 可选类型 {
 
 }
 */
do {
    var a = Optional(0)
    if let c = a {
       print("c = \(c)")
    }
    
    a? = 100
    if let c = a {
        print("c = \(c)")
    }
    
    let x: Int? = 10
    var y: Int? = nil
    /*
     我们可以在if声明中使用多个绑定局部变量，这个时候，每个可选绑定都要用let 或 var 引出。
     此时，多个声明之间的关系是“并且”，有一个为假，则if语句块不执行。
     */
    if let x = x, let y = y {
        print("1: x = \(x), y = \(y)")
    } else {
       print("条件为假")
    }
    y = 20
    if let x = x, var y = y {
        y += 20
        print("2: x = \(x), y = \(y)")
    } else {
        print("条件2为假")
    }
}

//5.guard语句
/*
 guard，顾名思义，就是守卫的意思。
 它也是swift语言中的新的语法，是一个很好用的语法，使用也和广泛。
 作用：
 也是用于Optional绑定的。
 */
do {
    
    func test() {
        let a: Int? = 100
        
        guard let b = a else {
            return
        }
        // 注意，这里可以使用b
        print("--------\(b)")
    }
    
    test()
}
/*
 注意：
 guard 与 if 很相似，都可以作为条件语句，对条件表达式进行判断。但是，不同点是，if语句中声明的
 常量或者变量的作用域是if语句块内部，而guard语句则是guard语句以下的部分都可以使用它声明的常量
 或者变量，这在实际应用的时候是很方便的。
 
 */

//6. 空结合操作符 (??)
/*
 什么是 空结合操作符？
 这又是一种轻量便捷的拆解Optional对象的方式。
 */
do {
    let a = Int?(0)
    let b = 10
    
    var c = a ?? b
    print("c = \(c)")
    
    /*
     a ?? b的意思是，a为nil吗？如果为nil，c = b, 否则， c = a
     使用三目运算符解释一下,相当于
     */
    c = a != nil ? a! : b
    
    print("c = \(c)")
    
    // 空结合表达式也是一种简便表达形势的语法糖，可以使用三目运算符来代替。
    
}

// 7. 隐式拆解的Optional类型
/*
 隐世拆解的Optional类型的表示与Optional类似，就是在类型名后紧跟 ！。
 比如 Int！， Float！， String！ 等等。
 它表示当前对象作为一个Optional类型，不过使用此对象时，它已经被断言确保不为空了。
 */

print("\n")
do {
    var a: Int! = 10
    let b = a
    print("b = \(String(describing: b))")
    
    a! += 20
    a? += 5
    
    print("a = \(String(describing: a))")
    
    // 这里声明了一个隐式拆解的Optional数组变量arr
    var arr: [Int]! = [1, 2, 3]
    
    // 这里对arr使用 ! 操作符，
    // 使得 arr! 表达式作为 += 的左操作数
    // 这里的 ! 不能缺省
    arr! += [4, 5, 6]
    
    // 这里就彰显出隐式拆解的Optional的便捷性了。
    // 这里可直接将arr作为下标操作符的操作数，
    // 而无需使用optional-chaining操作符
    arr[0] = arr[1] + arr[2]
    
    // 这里需要使用强制拆解，
    // 因为 arr 作为 += 的右操作数时，
    // 它将会转回 Optional 类型，这里需要各位留意
    arr! [0] += arr! [3]
    
    // 输出：arr[0] = 9，
    // 说明arr[0]是Int类型
    print("arr[0] = \(arr[0])")
    
    // 这里声明了carr，其类型为[Int]?
    var carr = arr
    
    // 这里对carr操作时，? 或 ! 都不能缺省
    carr![3] = carr![2] - carr![1]
    
    // 这里声明了一个指向 () -> Void 函数类型的
    // 隐式拆解的Optional的引用常量ref
    let ref: (() -> Void)! = {
        print("This is a closure!")
    }
    
    // 这里可直接对ref做函数调用，
    // 无需使用optional-chaining操作符
    ref()
    
    // 这里声明了一个String类型的
    // 隐式拆解的Optional常量s
    let s: String! = "abcd"
    
    // 这里可直接对s使用成员访问操作符，
    // 而不需要添加optional-chaining操作符，
    // c的类型为Int
    let c = s.count
    
    // 输出：c = 4
    print("c = \(c)")
    
    // 如果我们使用了optional-chaining操作符 ?
    // 那么整个表达式就变成了optional-chaining表达式了，
    // 这里count的类型就变为了 Int?
    let count = s?.count
    
    // 输出：count = Optional(4)
    print("count = \(String(describing: count))")
    
    // 这里请各位务必注意！
    // 由于之前已经提到了，
    // 一个隐式拆解的Optional类型，即ImplicitlyUnwrappedOptional，
    // 当它作为右值表达式时，其类型会被隐式转为Optional。
    // 所以这里的option的类型为 String? ，而不是 String!
    let option = Optional("abc")
    
    // 这句没有问题
    _ = option?.count

    
   
}
