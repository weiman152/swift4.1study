//
//  main.swift
//  swift03
//
//  Created by iOS on 2018/9/21.
//  Copyright © 2018年 weiman. All rights reserved.
//

import Foundation

/*
 swift学习笔记4
 */

// 1.元组
/*
 元组是swift中一种复合类型。它很强大哦，可以吧任意类型的有限个对象整理为一个对象。
 */

do {
    let a = 10
    let b = "小花"
    let tuple = (a,b)
    print(tuple)
    print(tuple.0)
}

// 注意：如果我们要表示一个元组，那么圆括号中至少要有两个元素，否则，圆括号被看做是圆括号操作符。

//1》访问元组中的元素
//要访问元组的对象，可以使用成员访问操作符.,后面跟上元素的索引位置。
do {
    let tuple = ("小明","男",8,"北京")
    print(tuple.0) //输出 “小明”
    let sex = tuple.1
    print(sex)
}

//我们还可以给元组指定标签进行访问
do {
    let tuple = (name: "老王", age: 78, address: "上海市")
    print(tuple.name)
    print(tuple.age)
    print(tuple.address)
}

//2》元组分解
do {
    let tuple = (10, 20.6, true)
    let (i, d, b) = tuple
    print("i = \(i)")
    print("d = \(d)")
    print("b = \(b)")
    
    // 提取部分值
    let (x, _, y) = tuple
    print("x = \(x)")
    print("y = \(y)")
    
    // 交换两个对象的值
    var w = 1, n = 2
    (w, n) = (n, w)
    print("w:\(w), n:\(n)")
}
//注意： 上面声明的(i, d, b)并不是元组，而是三个常量，用于萃取元组中的元素。

//3》元组比较
//两个相同元素类型的元组，如果每个元素都遵循了Equatable协议，那么这两个元组对象可以用==或者！=操作符来比较是否相等。
/*
 元组相等： 如果元组的每一个元素的值都是相等的，那么这两个元组相等。
 */

do {
    var a = 10
    let result: Void = a += 100
    print("result: \(result), a: \(a)")
    //result: (), a: 110
    let obj: Any = result
    let isVoid = obj is Void
    print("obj:\(obj), isVoid:\(isVoid)")
    //obj:(), isVoid:true
    
}

//4》 元组计算顺序
do {
    var loop = 3
    repeat {
        print("Hello,world")
        print("loop: \(loop)")
    } while(loop -= 1, loop).1 > 0
    /*
     Hello,world
     loop: 3
     Hello,world
     loop: 2
     Hello,world
     loop: 1
     */
    
    //元组的计算顺序是从左到右进行计算的，从第一个元素到最后一个元素。
    
}

