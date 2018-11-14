//
//  main.swift
//  swift28(swift访存模型与引用机制)
//
//  Created by iOS on 2018/11/8.
//  Copyright © 2018 weiman. All rights reserved.
//

import Foundation


/*
 swift 编程语言的访存模型与对象引用机制
 
 前面已经学习过，swift将类型根据访存机制分为两大类： 值类型和引用类型。
 
 值类型：
 像枚举、结构体都是数据值类型，传递过程中是值拷贝。
 
 引用类型：
 像类和函数则属于引用类型，传递过程中采用的是引用计数的机制。
 
 既然有引用类型就不得不介绍内存管理中的引用机制——自动引用计数，也称为ARC。学习过OC的肯定对ARC并不陌生。
 
 ARC是相对于很久之前的MRC(手动内存管理)说的，经历过MRC的童鞋们肯定觉得ARC实在是一项伟大的发明啊，
 简化了多少代码啊。ARC能够将引用计数为0的对象自动释放掉，而不需手动释放。那么ARC就万无一失吗？当然
 不是了，还是会有很多注意点，一不小心还是会掉坑里的。
 
 */

/*
 1. ARC工作机制与强引用
 
 在每次创建一个类的新实例的时候，ARC都会创建一个存储块用于存放该实例的信息。这些信息包括该实例的类型
 以及与该对象实例相关联的存储式属性。
 当这个实例不再需要的时候，ARC就会释放这个存储块，其他实例就可以使用这个存储块了。
 什么情况下会崩溃呢？
 当ARC释放了某个存储块的实例，但是这个实例又被访问了，这个时候就会直接崩溃啦。
 */

class MyObject {
    
    var tag = 0
    deinit {
        print("MyObject \(tag) 被释放了。")
    }
}

class MyContainer {
    
    // MyObject的对象引用实例
    var objReference: MyObject?
    
    func method(refObj: MyObject, tmpTag: Int) {
        objReference = refObj
        let tmpObj = MyObject()
        tmpObj.tag = tmpTag
    }
    
    deinit {
        print("MyContainer 被销毁了")
    }
}

_ = {
    
    let obj = MyObject()
    let container = MyContainer()
    container.method(refObj: obj, tmpTag: 1)
    print("闭包结束")
}()

/*
 打印结果：
 MyObject 1 被释放了。
 闭包结束
 MyContainer 被销毁了
 MyObject 0 被释放了。
 
 分析打印：
 在外部的闭包里，我们首先创建一个 obj 对象实例，此时它的引用计数为1。然后创建一个 container 对象实例，
 此时它的引用计数也为1。当我们调用 container 对象的 method 方法时，由于该方法的 refObj 形参
 对实参 obj 对象作了一次引用，因此这里 obj 对象的引用计数再次递增，变成2。而在 method 方法内部，
 MyContainer 类的对象的 objReference 属性对 refObj 形参做了一次引用，因此对于外部的 obj
 对象来说，其引用计数再次递增，变为了3。而这里又创建了一个 MyObject 类的一个局部临时对象  tmpObj，
 其引用计数为1。当 method 方法退出之时，refObj 形参由于不再被使用而被释放掉，因此引用计数减1，
 这样外部的 obj 对象的引用计数变为了2。而由于局部临时对象 tmpObj 也不再被使用，因此将其释放，
 让它引用计数减1，由于此时 tmpObj 的引用计数变为了0，因此它被真正地释放掉了，这里会输出：
 “MyObject 1 is deallocated!”。而对于外部闭包，当它结束调用时先输出：“closure over!”。
 由于 obj 对象不再被使用，因此它被释放掉，即将它的引用计数递减，此时由原来的2变为1。同样，
 由于 container 对象不再被使用，因此它也被释放掉，将其引用计数递减，由一开始的1变为了0，
 触发对它真正的释放，这里会输出：“MyContainer is deallocated!”。既然 container 对象被真正
 释放掉了，那么它所引用的所有其他对象实例也会被释放掉，这样使得其 objReference 属性所引用的对象
 引用计数递减，这样外部的 obj 也被减到了0，触发对它的真正释放，这里将会输出：“MyObject 0 is deallocated!”。
 */

/*
 大部分时候强引用都没有问题，但是强引用也会引起麻烦——强引用循环（循环引用）。
 什么是循环引用？
 如果有两个类类型，一个称为类A，另一个叫做类B，如果A中有一个存储式实例属性对类B实行了强引用，而该
 类B的对象实例也有一个存储式实例属性对此类A的对象实例也进行了强引用，那么这就形成了类A与类B对象实例
 的强引用循环。
 更形象一点呢就像是两个人打架，A掐着B的脖子说，你放手，B抱着A的腰说，你先放，结果两个人僵在那里，
 谁也不肯放手。这就是循环引用了。
 */

class A {
    
    var b: B?
    deinit {
        print("A 被释放了")
    }
}

class B {
    
    var a: A?
    deinit {
        print("B 被释放了")
    }
}

_ = {
    
    let a = A()
    let b = B()
    
//    a.b = b
//    b.a = a
}()

/*
 上述闭包执行完成的时候，a和b都不会被释放，因为他们的引用计数都不是0，造成了内存泄漏。那么该如何
 解决这种问题呢？
 这里我们就可以使用“弱引用”来解决这种困境。
 */

/*
 2. 弱引用
 
 什么是弱引用？
 一个弱引用不会对它所引用的实例进行强保持，也就是说不会使得它引用的实例对象引用计数增加。
 使用弱引用，我们只需要在一个属性或者变量前面添加一个weak关键字来指明该对象引用为一个弱引用。
 
 那么，弱引用何时释放呢？
 当它引用的对象实例被释放时，弱引用依然对它进行引用着。因此，ARC会自动将这个弱引用设置为空(nil)。
 同时，由于弱引用需要允许他们的值在运行时变为空，所以总是将弱引用声明为变量，而不是常量，同时，
 弱引用类型应该是一个Optional类型。
 
 注意：
 当ARC将一个弱引用设置为空时，属性观察者不会被调用。
 */

class C {
    
    // 声明一个弱引用
    weak var d: D? {
        willSet(value) {
            print("d will be set")
        }
    }
    
    deinit {
        print("C 被释放了")
    }
}

class D {
    
    var c: C?
    deinit {
        print("D 被释放了")
    }
}

_ = {
    let c = C()
    var d: D? = D()
    
    c.d = d
    d?.c = c
    
    d = nil
    
    print("c.d = \(String(describing: c.d))")
}()

/*
 3. 非所属引用
 
 与弱引用一样，非所属引用并不对它所引用的对象实例做强保持。不过，与弱引用不同的是，一个非所属引用
 所引用的对象实例 必须 至少要与该非所属引用的对象实例具有相同的生命周期。
 
 我们可以通过在一个属性声明之前放置一个 unowned 关键字来声明它作为一个非所属引用。
 一个非所属引用总是期望具有一个值。这样，ARC不会将一个非所属引用设置为空值，这也就意味着非所属引
 用不能使用Optional类型进行声明。所以非所属引用可以是一个常量。因此我们这里需要注意，只有当我们
 确定某一引用总是能够引用一个对象实例，而不在该引用所属的对象实例被释放前释放所引用的对象实例时，
 我们才能将它设置为一个非所属引用。
 如果我们在一个非所属引用所引用的对象实例被释放之后再去访问它，那么此时会引发运行时错误，应用则会崩溃。
 */

do {
    
    class A {
        
        unowned let b: B
        init(instanceB: B) {
            b = instanceB
        }
        
        deinit {
            print("A 被释放了")
        }
    }
    
    class B {
        
        var a: A?
        deinit {
            print("B 被释放了")
        }
    }
    
    _ = {
        
        var b: B? = B()
        let a = A.init(instanceB: b!)
        b?.a = a
        
        b = nil
        
        //print("a.b = \(a.b)")
        
        /*
         崩溃：
         Fatal error: Attempted to read an unowned reference but object 0x101a04070 was already deallocated2018-11-08 16:06:18.702012+0800 swift28(swift访存模型与引用机制)[10549:761100] Fatal error: Attempted to read an unowned reference but object 0x101a04070 was already deallocated
         
         */
        
    }()
}

/*
 4. 解决针对闭包的强循环引用
 
 swift的闭包在默认情况下会对外部所引用的对象进行强引用。为了避免闭包对外部对象因为进行强引用而导致的
 强引用循环，swift对闭包引入了一组 捕获列表 。
 
 比如，对于两个雷的对象实例之间的强引用循环，我们可以定义每个所捕获的引用采用弱引用或者是非所属引用
 而不是强引用。
 */

print("\n----4-----\n")

class RootViewController {
    
    var subController: SubViewController?
    
    func presentViewController() {
        subController = SubViewController.init(controller: self)
    }
    
    func popViewController() {
        subController = nil
    }
    
    func info() {
        print("这是一个 RootViewController")
    }
    
    deinit {
        print("RootViewController 释放了")
    }
}

class SubViewController {
    
    /// 非所属引用
    unowned let superViewController: RootViewController
    
    var closure: ((Int) -> Int)?
    
    init(controller: RootViewController) {
        superViewController = controller
    }
    
    func setup() {
        
        closure = {
            // 这里是一个闭包捕获列表
            // 其中将self作为unowned引用
            [unowned self, weak ref = self.superViewController]
            (param: Int) -> Int in
            
            ref?.info()
            self.showInfo()
            return param + 1
        }
        
        print("the value is \(closure!(100))")
    }
    
    func showInfo() {
        superViewController.info()
    }
    
    deinit {
        print("SubViewController 释放啦")
    }
}

_ = {
    
    let rootVC = RootViewController()
    rootVC.presentViewController()
    
    rootVC.subController?.setup()
    rootVC.popViewController()
}()

/*
 结果：
 
 这是一个 RootViewController
 这是一个 RootViewController
 the value is 101
 SubViewController 释放啦
 RootViewController 释放了
 
 */

