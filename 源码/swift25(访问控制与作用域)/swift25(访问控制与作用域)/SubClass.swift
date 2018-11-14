//
//  SubClass.swift
//  swift25(访问控制与作用域)
//
//  Created by iOS on 2018/11/6.
//  Copyright © 2018 weiman. All rights reserved.
//

import Cocoa

/// 我们有新建了一个文件，定义了一个类，叫做SubClass，是OpenClass的子类
class SubClass: OpenClass {

    /// 对父类的open存储式属性a添加属性观察者
    override var a: Int {
        willSet {
            print("a will be set to : \(newValue)")
        }
        didSet {
            print("original a = \(oldValue)")
        }
    }
    
    /// 对父类的open实例方法进行重写
    override func method() {
        print("这是在子类SubClass中的method")
    }
    
}
