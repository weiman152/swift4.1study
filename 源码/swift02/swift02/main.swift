//
//  main.swift
//  swift02
//
//  Created by iOS on 2018/9/21.
//  Copyright © 2018年 weiman. All rights reserved.
//

import Foundation

/*
 swift学习笔记3
 */

/*
 1. 整数字面量
 
 表示方式： 二进制(0b)、八进制(0o)、十进制、十六进制(0x)
 */
let dec = 100
let bin = 0b0110_0100
let oct = 0o144
let hex = 0x64

//思考：还记得进制之间的转换吗？
/*
 十进制转二进制：除以二取余数
 二进制转八进制：从右到左，依次取三位，最后一组不够三位用0补足，每一组的每个位置加起来，然后组合在一起，就是八进制了
 二进制转十六进制：与八进制类似，不过是依次取四位
 */

/*
 2. 整数类型(Int)
 
 */

//打印本机Int类型的表示范围
let max = Int.max
print("max: \(max)")
//max: 9223372036854775807

let min = Int.min
print("min: \(min)")

let a: Int8 = 127
let b: UInt8 = 255

// 注意：对于固定位宽的整数类型，赋值的时候要注意他们的表示范围，不要超出表示范围，不然会报错
// 报错：Integer literal '200' overflows when stored into 'Int8'
// let aa: Int8 = 200


// 3. 浮点数类型
do {
    let a: Float
    let b = 0.5
    let c: Double
    let pi = 3.141592653
    a = Float(b)
    c = pi
    print("\(a),\(b),\(c),\(pi)")
    
}

/* 注意：swift中没有隐式转换，不同类型之间一定要显示转换。这是为什么呢？因为通过查看swift的API发现，swift的Int，Float，Double都是Struct类型的独立类型，既然是独立类型，互相赋值的时候当然需要类型转换了。之所以能够顺利的进行转换，是因为在Float结构体中定义了下面这个方法：
 ///     let x: Double = 21.25
 ///     let y = Float(x)
 ///     // y == 21.25
 ///
 ///     let z = Float(Double.nan)
 ///     // z.isNaN == true
 ///
 /// - Parameter other: The value to use for the new instance.
 public init(_ other: Double)
 
 Float(b) 相当于 Float.init(b),init是可以省略的
*/

// 4. 布尔类型
/*
 注意： swift的bool类型与C、OC以及C++不同，不再是非零为真，零为假，而是回归独立的类型，
       只有true和flase两个类型，与整数完全分离。
 */

do {
    let a = true
    let b = false
    
    //逻辑计算
    print("a&&b: \(a&&b)")
    //a&&b: false
    
    print("a||b: \(a||b)")
    
}

// 5. 各种数值类型之间的转换
/*
 注意：swift中各个数值类型都是struct类型的，是各自独立的类型，转换的时候需要使用构造方法进行显示转换。
 swift中个的每种数值类型以及布尔类型还提供了一个可供NSNumber类型作为输入参数的构造方法。该构造方法可以通过NSNumber对整数或浮点数进行封装，然后内部采用高位截断或符号位扩充的形势转换为目标数据类型。
 */
do {
    let n = 1000
    let c = Int8(truncating: NSNumber(value: n))
    print("----\(c)")
    
}

// 6. 计算操作符
// >, < , >=, <=, ==, !=

//7. 溢出计算操作
// swift中包含了允许计算时发生溢出的操作符，以允许开发者对整数做运算时发生结果溢出，而不引发异常。
// 可溢出加法：&+
// 可溢出减法：&-
// 可溢出乘法：&*
do {
    let a: Int8 = 120
    let b: Int8 = 100
    
    var c = a &+ b
    print(c)
    
    c = -100 &- a
    print(c)
}


