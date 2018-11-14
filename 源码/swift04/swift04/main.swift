//
//  main.swift
//  swift04
//
//  Created by iOS on 2018/9/21.
//  Copyright © 2018年 weiman. All rights reserved.
//

import Foundation

/*
 swift学习笔记4-2
 */

//一、收集类型
// 数组（Array），集合（Set），字典（Dictionary）

print("-----------------1.数组---------------------")
//1.数组
//概念：数组是一个可以存放相同类型的多个元素对象的有序线性列表，这些元素对象可以是任意类型，包括元组。
do {
    // 声明一个空数组
    let a = Array<Int>()
    let b: [Int] = []
    let c = [Int]()
    print("a: \(a), b:\(b),c:\(c)")
    //a: [], b:[],c:[]
    
    // 声明非空数组
    let d = [Double](repeating: 3.0, count: 10)
    print("d:\(d)")
    //d:[3.0, 3.0, 3.0, 3.0, 3.0, 3.0, 3.0, 3.0, 3.0, 3.0]
    
    let e = [(Int, Double)](repeating: (1, 0.6), count: 5)
    print("e: \(e)")
    //e: [(1, 0.6), (1, 0.6), (1, 0.6), (1, 0.6), (1, 0.6)]
    
    let f = [1.0, 0.3, 0.4, 0.8, 1.2]
    print("f:\(f)")
    //f:[1.0, 0.3, 0.4, 0.8, 1.2]
    
    // 通过+操作符构建新的数组
    let g = [1, 2, 3]
    let h = [4, 5, 6]
    let i = g + h
    print("i: \(i)")
    //i: [1, 2, 3, 4, 5, 6]
    //数组之所以能够相加，是因为Array声明了 + 这个方法
    /*
       public static func + <Other>(lhs: Array<Element>, rhs: Other) -> Array<Element> where Other : Sequence, Element == Other.Element
     */
}

// 数组元素的访问
do {
    //通过下标操作符访问数组元素
    let a = [1, 2, 3, 4, 5]
    let x = a[0]
    let y = a[2]
    print("x:\(x), y:\(y)")
    
    //注意：只有遵循了Collection协议的类型对象才能作为下标操作符的操作数。
    
}

// 数组的常用属性
do {
    //1. 获取元素个数
    let a = [1, 2, 3, 34,5]
    print("个数： \(a.count)")
    
    //2. 判断数组是否有元素
    print("是否为空： \(a.isEmpty)")
    
    //3. 是否包含某元素
    print("是否包含3： \(a.contains(3))")
    
    //4. 增加元素
    var b = [1, 2, 3, 4, 5, 6]
    
    //在数组最后增加新元素
    b.append(100)
    print(b)
    //在数组中间插入新元素
    b.insert(0, at: 0)
    print(b)
    //移除索引为2的元素
    b.remove(at: 2)
    print(b)
}

// 注意：使用数组的时候，一定要注意数组的越界问题，一旦越界，会造成崩溃

print("-----------------2.集合---------------------")
// 2. 集合
/*
 概念：
 集合：能够存放多个相同类型元素的集合。
 与数组不同点：
 1.集合中不允许出现两个完全相同的元素；
 2.几个钟的数据元素是无序的；
 3.并不是所有类型的对象都能作为集合的元素，只有遵循了Hashable协议类型的对象才能作为集合的元素。
 
 swift中的基本类型（String，Int，Float，Double，Bool）都遵循了Hashable协议。
 */

do {
    let a = [1, 2, 3, 4, 5, 5]
    let b: Set = [1, 2, 3, 4, 5, 5]
    print(a)
    print(b)
    /*
     输出：
     [1, 2, 3, 4, 5, 5]
     [5, 3, 1, 4, 2]
     */
    
    //Int类型的空集合
    var setA = Set<Int>()
    
    //创建含有不定元素个数但是包含某些元素的集合
    setA = Set<Int>(arrayLiteral: 1 ,2, 3)
    print(setA)
}

//对集合元素的访问
/*
 注意： 集合是无序的，所以不能通过下标访问集合的元素。集合对元素的存放不是基于索引，而是基于哈希值。
 
 访问集合的方法：
 1.for-in循环
 2.flatMap方法
 */

//常用属性
do {
    //1.元素个数
    let a: Set = [1, 2, 3, 4, 5, 6]
    print("个数: \(a.count)")
    
    //2.是否为空
    print("是否为空集合: \(a.isEmpty)")
    
    //3.是否包含某个元素
    print("是否包含: \(a.contains(5))")
    
    //4.插入元素
    //注意：集合插入的元素位置不定
    var b: Set = ["a", "b"]
    b.insert("c")
    print(b)
    
    //5.删除元素
    b.remove("b")
    print(b)
    
    //6.自定义类型对象作为集合的元素
    struct MyStruct: Hashable {
        
        // 定义属性
        var a = 0
        var b = 0.0
        
        // 只是demo,实现hashValue方法
        public var hashValue: Int {
            return a.hashValue ^ b.hashValue
        }
        
        // 实现Equatable协议中的 == 操作符类型方法
        public static func == (lhs: MyStruct, rhs: MyStruct) -> Bool {
            return lhs.a == rhs.a && lhs.b == rhs.b
        }
    }
    
    var set = Set<MyStruct>()
    let e1 = MyStruct(a: 10, b: 1.0)
    let e2 = MyStruct(a: -10, b: 0.5)
    print("e1: \(e1)")
    print("e2: \(e2)")
    // 插入对象
    set.insert(e1)
    set.insert(e2)
    
    print("set = \(set)")
    
    //7.两个集合相等
    let s1: Set = [1, 2, 3]
    let s2: Set = [3, 2, 1]
    if s1 == s2 {
        print("s1 == s2")
        
    }
}

print("-----------------3.字典---------------------")
//3. 字典
/*
 概念：字典也是无序集合。不过字典与数组和集合不同，存储的是键值对。
 注意：
 1.字典中的键的类型和值的类型都是在声明中直接确定的。
 2.键的类型必须遵循Hashable协议。
 3.值的类型可以是任意类型.
 */

do {
    // 创建字典
    // 创建一个键是string类型，值是Int类型的空字典
    var a = Dictionary<String, Int>()
    a = ["a": 1]
    print(a)
    
    // 通过字典的不定参数个数的构造方法创造一个字典
    let b = Dictionary<String, Int>(dictionaryLiteral: ("one", 1), ("two", 2))
    print(b)
    
    // 默认构造方法创造字典
    let c = [Int: Float]()
    print(c)
    
    // 通过字典字面量创建字典
    var d: [String: Int] = [:]
    print(d)
    
    d = ["age": 18, "num": 100]
    print(d)
}

do {
    // 访问字典的元素
    var dict:[String: Any] = ["name": "小明",
                              "age": 20,
                              "score": 100,
                              "new": true]
    if let name = dict["name"] {
        print(name)
    }
    
    dict.updateValue("王小明", forKey: "name")
    print(dict)
    
    let test = dict["test"]
    print(test ?? "没有这个值")
}

do {
    // 常用属性
    var dict: [String : Any] = ["name": "Lili",
                                "age": 10,
                                "class": "1班",
                                "from": "England"]
    // 1.元素个数
    print("元素个数： \(dict.count)")
    
    // 2.是否为空
    print("是否空： \(dict.isEmpty)")
    
    // 3. 所有的键
    print("所有的键: \(dict.keys)")
    
    // 4. 所有的值
    print("所有的值： \(dict.values)")
    
    // 5. 更新值
    dict.updateValue("2班", forKey: "class")
    print("更新后： \(dict)")
    
    dict["age"] = 11
    print(dict)
    
    // 6.新增键值对
    dict["interest"] = "看动漫，爬山"
    print(dict)
    
    // 7.删除
    dict.removeValue(forKey: "class")
    print(dict)
}
