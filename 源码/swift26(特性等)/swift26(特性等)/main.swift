//
//  main.swift
//  swift26(特性等)
//
//  Created by iOS on 2018/11/7.
//  Copyright © 2018 weiman. All rights reserved.
//

import Foundation

/*
 特性、编译标志与检查API的可用性
 
 本节的内容都属于编译时行为。swift与C、C++、OC不同，它没有预处理器这个概念，所以不存在任何预处理时的概念。
 我们可以认为swift源码的解析和处理都包含在编译时。
 
 扩展：什么是预处理？
 预处理是C语言的一个重要功能，它由预处理程序负责完成。当对一个源文件进行编译时，系统将自动引用预处
 理程序对源程序中的预处理部分作处理，处理完毕自动进入对源程序的编译。
 C语言提供多种预处理功能，主要处理#开始的预编译指令，如宏定义(#define)、文件包含(#include)、
 条件编译(#ifdef)等。合理使用预处理功能编写的程序便于阅读、修改、移植和调试，也有利于模块化程序设计。
 */

/*
 1. swift中的特性
 
 swift语言的特性（attribute）与GNU C语言中的 _sttribute_非常类似，用于修饰一个对象、函数和类型，
 用于指定所修饰对象的某些特定编译时的行为。
 
 @attribute(args)
 func foo() {
 
 }
 
 swift可以叠加多个特性，我们只需要将多个特性做一般的叠加即可，特性之间没有任何先后顺序。
 */

class A {
    
    
    @inline(__always)
    @available(macOS 12.0, *)
    func foo() {
        print("特性学习")
    }
}

// 一起学习swift有哪些常用特性
/*
 (1) available
 
 available特性用于指明一个对象、函数或者类型的可用性。这个特性常用于指明ios的版本号，因为有些
 方法只有新版本才能使用，为了兼容，加上特性标识。
 
 当前Apple用于自家平台的Swift支持以下平台：
 iOS、iOSApplicationExtension、macOS、macOSApplicationExtension、watchOS、
 watchOSApplicationExtension、tvOS、tvOSApplicationExtension、swift。
 */

class B {
    
    /*
     available限定了MyTest函数只能用于iOS 10.0或者更高版本；
     macOS 10.13或者更高版本
     这里的 * 表示出了ios10.0以及macOS 13.0之外，其他更高版本以及其余平台也可用。
     */
    @available(iOS 10.0, macOS 10.13, *)
    func MyTest() {
        print("Hello china")
    }
    
    @available(swift 3.0)
    @available(iOS 10.0, macOS 10.12, *)
    struct MyStruct {
        
    }
}

let b = B()
b.MyTest()

_ = B.MyStruct()

/*
 几个常用参数:
 introduced: 从哪个版本开始引入；
 deprecated: 从哪个版本开始废弃；
 obsoleted: 从哪个版本开始被移除，被移除的实体在当前环境中将无法访问。
 message: 当我们使用了已经废弃或者移除的接口的时候引发的编译警告或者错误。
 
 这几个参数在苹果的API文档中经常出现。我们在使用某个方法的时候，有时候会出现一道删除线在方法上面，
 就是因为这个方法已经标识为废弃。
 */

class C {
    
    @available(macOS 10.10, *)
    @available(*, introduced: 10.10, deprecated: 10.12, message: "方法不可用啦")
    func hello() {
        print("哈哈哈哈哈")
    }
}

let c = C()
// 'hello()' is deprecated: 方法不可用啦
c.hello()


/*
 (2) discardableResult
 
 此特性一般用于修饰带有返回值的函数或方法，以指明当前函数或方法的返回值可被缺省。
 */

class D {
    
    @discardableResult
    func foo(a: Int) -> Int {
        return a * 2
    }
    
    func boo() -> String {
        print("好孩子是什么？")
        return "boo"
    }
}

let d = D()
/*
 这里调用foo，而不必管它的返回值，也不会引发警告
 */
d.foo(a: 10)
// 调用boo，就会出现警告：
// Result of call to 'boo()' is unused
d.boo()


/*
 (3) objc
 
 这个特性只能用于Apple自家平台。表示一个类型或者方法可用于OC中的相关类型或方法来表示。
 其实这个特性还是挺常用的，尤其是在#selector()事件的方法外面，都要加一个objc标识。
 */

@objc
protocol MyProt {
    // 此方法必须实现
    func method()
    
    // 这里方法不是必须实现
    @objc
    optional func foo()
}

class E: MyProt {
    
    // 这个方法是必须实现的
    func method() {
        print("你好")
    }
}

/*
 (4) autoclosure
 
 这个特性可以让一个表达式自动封装成一个不带参数的闭包。
 */

/*
 (5)convention
 
 此特性用于修饰一个函数对象的类型，以指定其调用约定。swift共有三种调用约定：
 1》swift：表示该函数对象为一个swift函数的引用。
 2》block：表示该函数与OC的Block引用相兼容。
 3》c: 用于指示该函数对象是一个C函数的引用。也就是说该函数引用不带任何执行上下文，并且直接使用C语言
 函数调用约定。
 */

class F {
    
    func test() {
        var x = 100
        
        /// 它可以对捕获局部对象的闭包进行引用
        let ref1: @convention(swift)(Int) -> Void  = {
            (a: Int) -> Void in
            
            x += a
        }
        
        /// ref2具有block调用约定，可以直接与OC中的Block进行交互，也可以作为OC的对象引用
        let ref2: @convention(block) (Int) -> Void  = {
            (a: Int) -> Void in
            x -= a
        }
        
        let ref3: @convention(c) (Int) -> Void = {
            (a: Int) -> Void in
            print("a = \(a)")
        }
        
        ref1(10)
        ref2(5)
        ref3(1)
        
        print("x = \(x)")
    }
}

let f = F()
f.test()

/*
 (6) escaping
 
 该特性用于修饰一个函数或方法的形参类型，指明该形参将会在稍后执行，因而要被存放一下。这意味着该形参
 的生命周期将延伸到此函数或方法调用结束之后也不会消失。
 */

/*
 (7). inline
 
 inline特性暗示该函数或方法可以被内联或不被内联。它有一个参数用于指明所修饰的函数或方法是否可被内联。
 __always: 总是被内联；
 never: 表示该函数无论什么时候都不应该被内联。
 
 什么是内联？
 函数的实现是在另一个函数内部。
 */

class G {
    
    @inline(never)
    func noInlineFunc() {
        print("永不内联")
    }
    
    @inline(__always)
    func alwaysInlineFunc() {
        print("总被内联的函数")
    }
    
    /*
     注意：
     一般情况下，swift编译器会根据上下文环境决定某一函数是否需要内联，所以我们一般无需使用@inline(__always)。
     */
}

/*
 (8). _silgen_name
 
 _silgen_name特性可用于指明当前所引用的函数是一个遵循C语言标准API的函数。
 此特性可以让我们直接在swift中引用一个具有外部链接的全局C函数，即便该函数没有桥接头文件中声明。
 */

/*
 关于swift的特性部分，已经差不多学习完了，真的具有好多特性啊。这些特性属于小知识点，比较零碎，不容易记忆。
 不过只要有印象，当我们在某个情境下需要的时候，能够回过头来找到这些特性运用就可以了。
 */


/*
 2. 编译标志
 
swift编译器同C语言编译器类似，可以设置一些编译选项。
 
 #if ... #else ... #endif
 
 注意：
 swift下的编译标志不能像C语言那样加 “-D  FLAG = 1”这种。因为swift再用#if判定的时候已经假定了每个
 标志都是一个布尔类型。只要该标志被定义了，就是true，反而，就是false。
 
 我们定义编译标志是在 xcode的
 Build Settings ——》 Swift Compiler - Custom Flags ——》Other Swift Flags 中进行设置。
 设置格式是：
 “-D”"标识名字"
 
 
 这也是项目中经常使用的，debug模式下的打印与release下的不同时，常常这样设置。
 */

@inline(__always)
func debug_log(str: String) {
    
    #if DEBUG
       print("嘎嘎嘎嘎嘎嘎")
    #else
       print(str)
    #endif
}

debug_log(str: "好不好啊")

/*
 3. 检查API的可用性
 
 swift是一门趋于静态编译的编程语言，尽管它也能被解释执行，但是从设计上，它没有像OC那样具有众多的
 动态特性。这反而使它在运行时变得高效。
 
 */

class H: NSObject {
    
    override init() {
        super.init()
        
        Timer.scheduledTimer(timeInterval: 1.0,
                             target: self,
                             selector: #selector(timerHandler(timer:)),
                             userInfo: nil,
                             repeats: false)
    }
    
    @objc func timerHandler(timer: Timer) {
        print("哈哈哈哈哈哈哈哈")
    }
}

if #available(iOS 10, macOS 10.12, *) {
    
    /*
     Timer这个类型方法只有在iOS10.0以及macOS 10.12开始才能用
     */
    Timer.scheduledTimer(withTimeInterval: 1.0, repeats: false) { (timer) in
        print("开始执行呗")
    }
} else {
    
    _ = H()
}

