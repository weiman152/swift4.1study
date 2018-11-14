//
//  main.swift
//  swift05
//
//  Created by iOS on 2018/9/25.
//  Copyright © 2018年 weiman. All rights reserved.
//

import Foundation

//swift学习笔记5

//1. 范围操作符
/*
  这是一个新的概念，在swift中常常使用。
  1.闭区间范围操作符：（...）,例如： a...b 在数学中的含义是[a,b]
  2.半开区间范围操作符： (..<), 例如， a..<b在数学中的含义是[a, b)
 
 这两种类型都属于结构体类型。
 
 注意：
 1.范围操作的两个操作数都要遵循Comparable协议，即要能比较出大小；
 2.左边的值必须小于等于右边的值；
 */

// 应用实例
let stringRange = "aaa"..."ccc"
print(stringRange)

let charRange = Character("a")..<Character("c")
print(charRange)

switch "ccb" {
case stringRange:
    print("在stringRange范围内")
default:
    print("不在stringRange范围内")
}

switch Character("b") {
case charRange:
    print("在 charRange 内")
default:
    print("不在 charRange 内")
}

// 通过for-in循环依次输出range内的值
for i in 0...10 {
    print("i = \(i)")
}
print("\n")
for i in 0..<10 {
    print("i = \(i)")
}

let array = [1, 2, 3, 4, 5, 6, 7, 8]
let range = 1...4
//取数组的子数组
let subArray = array[range]

print("子数组： \(subArray)")

print("上边界： \(range.upperBound)")
print("下边界：\(range.lowerBound)")
print("是否为空: \(range.isEmpty)")

// 2. 单边范围操作符(swift4.0以后)
/*
 只对范围操作数的一端设置操作数，另一端缺省。
 三种类型：
 1. a... : 大于等于a的范围 ， >=a
 2. ...b : 小于等于b的范围， <=b
 3. ..<b : 小于b的范围，<b
 
 应用：
 获取数组的子数组，获取字符串的子串
 */
do {
    let array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    
    //1. 取array从索引2到最后一个元素的子数组
    let sub1 = array[2...]
    print("sub1: \(sub1)")
    
    //2. 取从0开始到第6个位置的子数组
    let sub2 = array[...6]
    print("sub2: \(sub2)")
    
    //3. 取从索引0到5，不包括5的子数组
    let sub3 = array[..<5]
    print("sub3: \(sub3)")
    
}

/*
 注意：
 由于单边操作符不能表示一个有限范围的值，因为它不能遵循Sequence协议，
 从而我们不能将它们用在for-in循环中。
 */
