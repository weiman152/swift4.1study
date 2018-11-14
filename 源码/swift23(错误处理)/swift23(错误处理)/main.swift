//
//  main.swift
//  swift23(错误处理)
//
//  Created by iOS on 2018/10/31.
//  Copyright © 2018年 weiman. All rights reserved.
//

import Foundation

/*
 错误处理 （try - catch）
 
 这是swift学习中的第十八章了。坚持仔细的阅读每一行文字也是不容易的。还有一百多页就看完了，一起加油哈。
 
 对于大部分的现代面向对象的编程语言都拥有结构化的“错误处理”语法特性,swift也不例外。
 
 */

do {
    
    // 打开本地文件，并读取内容
    let str = try String.init(contentsOfFile: "/Users/ios/Desktop/study/swift/源码/swift23(错误处理)/text.txt")
    print("内容是 :\n \(str)")
} catch {
    print(" 文件读取错误 ")
}

// 如果把文件text.txt删掉，则会直接走到 catch中的内容。

// 1. swift中错误的表示
/*
 在swift中如果我们要定义一个表示错误的类型非常简单，只需要遵循Error协议即可。我们通常用枚举或者
 结构体类型来表示错误类型，枚举可能用的更多一些，因为它能够更加详细的表示出当前错误的细节。
 */

do {
    
    print("\n---------1. swift中错误的表示-----------\n")
    
    enum MyEnumError: Error {
        case errorOne
        case errorTwo
        
        // 实现Error协议的只读属性
        var localizedDescription: String {
            
            let desc = self == .errorOne ? "错误一" : "错误二"
            return "\(self): \(desc)"
        }
    }
    
    struct MyStructError: Error {
        
        var errorCode = 0
        
        var localizedDescription: String {
            return "错误码是 \(errorCode)"
        }
    }
    
    print("枚举的错误是： \(MyEnumError.errorOne.localizedDescription)")
    print("结构体的错误是： \(MyStructError().localizedDescription)")
}

// 2.swift中的错误抛出
/*
 本节详细描述如何在函数或方法中抛出错误对象。
 如果我们要在函数或者方法中可能抛出异常，那么我们在该函数或者方法的形参列表的后面，加上 throws 关键字。
 一旦我们抛出了错误，那么当前函数的后续代码就不会再继续执行了，也可以任务函数返回了。
 */

do {
    
    print("\n-------2.swift中的错误抛出--------\n")
    
    enum MyEnumError: Error {
        case errorOne
        case errorTwo
        case errorThree
        
        // 实现Error协议的只读属性
        var localizedDescription: String {
            
            var desc = ""
            switch self {
            case .errorOne:
                desc = "错误一"
            case .errorTwo:
                desc = "错误二"
            case .errorThree:
                desc = "错误三"
            }
            
            return "\(self): \(desc)"
        }
    }
    
    // 定义一个foo函数
    func foo(a: Int) throws -> Int{
        if a < -10 {
            throw MyEnumError.errorOne
        } else if a > 10 {
            throw  MyEnumError.errorTwo
        } else if a == 0 {
            throw MyEnumError.errorThree
        }
        
        print("a = \(a)")
        return a
    }
    
    let ref = foo(a:)
    let r = try ref(5)
    print("r = \(r)")
    
    func test(a: Int) throws {
        
        print("这是一个测试 a = \(a)")
        let value = try foo(a: a)
        
        print("value = \(value)")
    }
    
    do {
        try test(a: 100)
    } catch {
        if let error = error as? MyEnumError {
            print("抛出异常了, \(error.localizedDescription)")
        }
    }
    
    /*
     打印错误：
     a = 5
     r = 5
     这是一个测试 a = 100
     抛出异常了, errorTwo: 错误二
     */
}

// 3. 错误捕获与处理
/*
 swift中，我们使用 do-catch语句块对错误进行捕获。当我们在调用一个throws关键字声明的函数或方法
 的时候，我们必须把此调用语句放在do语句块中，同时在do语句块之后紧接着使用catch语句块。如果do语句
 块中抛出异常，则直接进入catch语句块中。如果没有异常，catch语句块不会被执行。
 */

do {
    
    print("\n-----------3. 错误捕获与处理--------------\n")
    
    enum ErrorType: Error {
        case errorOne
        case errorTwo
        case errorThree
        
        var localizedDescription: String {
            
            switch self {
            case .errorOne:
                print("抛出错误一")
            case .errorTwo:
                print("抛出错误二")
            case .errorThree:
                print("抛出错误三")
            }
            return "\(self)"
        }
    }
    
    func test(b: String) throws {
        
        if b.count == 0 {
            throw ErrorType.errorOne
        } else if b.count > 10 {
            throw ErrorType.errorThree
        }
        
        print("b = \(b)")
    }
    
    // 调用
    do {
        
        print("调用一")
        try test(b: "")
        print("调用二")
        try test(b: "abc")
        print("调用三")
        try test(b: "aaaaabbbbbsssssdddf")
        
    } catch {
        
        if let myerror = error as? ErrorType {
            print("myerror = \(myerror.localizedDescription)")
        }
    }
    
    /*
     结果：
     调用一
     抛出错误一
     myerror = errorOne
     */
    
    // 从结果中可以看出，try test(b: "") 抛出异常之后，下面的语句没有执行，直接跑出了异常。
    
    /*
     swift的catch语句也是很丰富的，跟case语句有点儿类似，后面可以跟各种不同的模式，而且多条
     catch语句去匹配多种不同的错误对象。此外，catch后面的表达式也可以缺省，一旦缺省，那么该
     catch语句块将可接收所有错误类型的对象。
     */
    
    do {
        
        print("\n")
         try test(b: "")
         try test(b: "aaaaa")
         try test(b: "hhhhhhhhhhhhhhhhhhhhhh")
    } catch ErrorType.errorOne {
        print("错误一发生")
    } catch let err as ErrorType {
        print("错误是 \(err.localizedDescription)")
    } catch {
        print("错误发生")
    }
    
    
}

/*
 注意：
 如果do语句块中抛出的异常没有任何一个catch语句块捕获到，那么这个错误就会抛给系统，引发崩溃！！！
 */

do {
    
    enum MyError: Error {
        case tooSmall(Double)
        case tooLarge(Double)
        case zero
    }
    
    func foo(value: Double) throws {
        
        if value < -100.0 {
            throw MyError.tooSmall(value)
        } else if value > 100.0 {
            throw MyError.tooLarge(value)
        } else if value == 0 {
            throw MyError.zero
        }
        
        print("正常数据 \(value)")
        
    }
    
    do {
        
        try foo(value: 0.0)
        try foo(value: -200.0)
        try foo(value: 200.0)
    } catch MyError.tooSmall(let value) {
        print("the value \(value) is too small")
    } catch MyError.tooLarge(let value) {
        print("the value \(value) is too large")
    } catch MyError.zero {
        print("the value  is zero")
    }
    
    print("完成")
    
    // 上面的 catch语句少了任何一项都会直接崩溃，因此我们在捕获异常的时候一定要把情况写全。
}

// 4. rethrows修饰的函数与方法
/*
 如果我们定义了一个函数或者方法，它含有一个可能会抛出错误的函数引用参数，并且对当前函数，只有当
 这个函数引用参数抛出错误时它才会把这个错误向上抛出，那么我们可以用rethrows来修饰这个函数。
 */
do {
    
    print("\n-------------------\n")
    
    enum MyError: Error {
        case tooSmall(Double)
        case tooLarge(Double)
        case zero
    }
    
    /// 定义一个foo函数，
    /// 它可能会抛出一个错误，
    /// 因此这里用throws限定
    func foo(value: Double) throws {
        if value < -100.0 {
            throw MyError.tooLarge(value)
        }
        else if value > 100.0 {
            throw MyError.tooLarge(value)
        }
        else if value == 0.0 {
            throw MyError.zero
        }
        
        print("value = \(value)")
    }
    
    // 定义一个rethrows修饰的test函数
    func test(a: Double, fun: (Double) throws -> Void) rethrows {
        try fun(a)
    }
    
    // 重载test函数
    func test(value: Double, fun: (Double) throws -> Void) rethrows {
        
        do {
            try fun(value)
        } catch {
            throw MyError.zero
        }
    }
    
    // 调用
    do {
        
        try test(a: 100.0, fun: foo(value:))
        try test(a: 0.0, fun: foo(value: ))
    } catch let err as MyError {
        
       print("error is \(err)")
    }
}

protocol Prot {
    
    func method(fun: (Int) throws -> Void) rethrows
    
    func method(ref: (Int) throws -> Void) throws
}

struct MyStruct: Prot {
    
    // 实现协议中的方法
    // 这里只能使用rethrows
    func method(fun: (Int) throws -> Void) rethrows {
        
        print("哈哈哈哈哈")
    }
    
    // 这里可以使用throws也可以使用rethrows
    func method(ref: (Int) throws -> Void) throws {
        
        print("呵呵呵呵呵呵呵呵呵呵")
    }
    
}

// 5. 将错误转换为可选值
/*
 swift编程语言引入了将错误转为可选值的语法机制，可使我们用if语句或者guard语句直接处理可能会抛出的
 错误。在swift中，我们可以直接使用 try? 将可能抛出的错误的函数或方法调用转为可选值。
 */

do {
    
    print("\n---------5. 将错误转换为可选值--------\n")
    
    enum YourError: Error {
        case tooSmall
        case tooLarge
    }
    
    func foo(value: Int) throws {
        if value < -100 {
            throw YourError.tooSmall
        } else if value > 100 {
            throw YourError.tooLarge
        }
        
        print("value = \(value)")
    }
    
    func test(a: Int) throws -> Int {
        try foo(value: a)
        return a
    }
    
    // 直接通过try调用foo函数
    let v1 = try? foo(value: -200)
    
    // 我们看一下v1的值
    print("v1 = \(String(describing: v1))")
    //打印： v1 = nil
    
    let v2 = try? foo(value: 10)
    print("v2 = \(String(describing: v2))")
    /*
     value = 10
     v2 = Optional(())
     */
    
    if let _ = try? foo(value: 200) {
        print("OK")
    }
    
    guard let value = try? test(a: 20) else {
        exit(-1)
    }
    
    print("value = \(value)")
    
}

// 6. 指定清理行为 defer
/*
 swift中defer语句块非常灵活，它作用于某个语句块作用域，而不是单单是函数作用域。
 */

do {
    
    print("\n----------6. 指定清理行为 defer-----------\n")
    
    enum CustomError: Error {
        case tooSmall
        case tooLarge
    }
    
    func foo(value: Int) throws {
        if value < -100 {
            throw CustomError.tooSmall
        } else if value > 100 {
            throw CustomError.tooLarge
        }
        print("value = \(value)")
    }
    
    func test(a: Int) {
        if a > 0 {
            defer {
                print("这是是defer，开始执行了")
            }
        }
        if a > 100 {
            print("即将执行return语句")
            return
        }
        print("a = \(a)")
        
        defer {
            print("我哈哈哈哈，这又是一个defer")
        }
        
        do {
            
            try foo(value: a)
        } catch let err {
            print("error \(err) 发生啦")
            return
        }
        
        print("测试结束")
    }
    
    // 调用
    test(a: 10)
    print("\n")
    
    test(a: 200)
    print("\n")
    
    test(a: -200)
    print("\n")
    
    test(a: -10)
    print("\n")
    
    /*
     结果：
     
     这是是defer，开始执行了
     a = 10
     value = 10
     测试结束
     我哈哈哈哈，这又是一个defer
     
     
     这是是defer，开始执行了
     即将执行return语句
     
     
     a = -200
     error tooSmall 发生啦
     我哈哈哈哈，这又是一个defer
     
     
     a = -10
     value = -10
     测试结束
     我哈哈哈哈，这又是一个defer
     */
}

/*
 如果同一个作用域出现多个defer语句，那么它们是如何执行的呢？
 */

do {
    
    func test() {
        
        defer {
            print("第一个defer")
        }
        
        print("第一段")
        
        defer {
            print("第二个defer")
        }
        print("第二段")
        
        defer {
            print("第三个defer")
        }
        print("第三段")
    }
    
    test()
    
    /*
     结果：
     
     第一段
     第二段
     第三段
     第三个defer
     第二个defer
     第一个defer
     */
}

// Never修饰的函数
/*
 当一个函数早执行后不会返回时，我们用Never作为该函数的返回类型，表示该函数不能返回。
 我们什么时候会用到不能返回的函数呢？
 如果我们程序因为某些状态而导致只能做崩溃或退出处理，那么我们就可以调用一个不能返回的函数来抛出错误或
 直接退出。
 在一个返回类型为Never的函数中，它不应该存在任何一个分支或条件使得该函数能够自然返回。
 */

do {
    
    enum HerError: Error {
        case positive, negative
    }
    
    func foo(a: Int) throws -> Never {
        throw a >= 0 ? HerError.positive : HerError.negative
    }
    
    func foo() -> Never {
        exit(-1)
    }
    
    func infinity() -> Never {
        
        while true {
            
        }
    }
    
//    func invalidNever() -> Never {
//        // 在此函数中，由于没有任何实现，该函数将直接返回，从而引发编译错误
//        // 报错：Function with uninhabited return type 'Never' is missing call to another never-returning function on all paths
//    }
    
}



