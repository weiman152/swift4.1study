//
//  main.swift
//  swift06
//
//  Created by iOS on 2018/9/25.
//  Copyright © 2018年 weiman. All rights reserved.
//

import Foundation

//swift学习笔记6

/*
 字符和字符串
 在swift中，String类型也是结构体，属于值类型，而不是引用类型。这一点，与OC是不一样的。
 */

// 概述
do {
    let a = "a"
    print(a)
    
    let b = "hello"
    print(b)
    
    let c = "你好呀"
    print(c)
    
    let d = """
            今天天气很好，我出去逛逛。
            it is a good day today, I'm going to have a walk.
            今日は天気がよいので,私は出かけて出かけます.
            """
    print(d)
}

//注意，swift中引入了多行字符串字面量的表达形式，通过 """三个双引号包围起来，可以输入换行符。

// 输出不想有换行符，但是文字较长，在书写的时候有换行符，这个时候我们可以在换行符前面加上 \,例如：
do {
    let a = """
                白日依山尽，\
                黄河入海流。\
                欲穷千里目，\
                更上一层楼
            """
    print(a)
    
    /*
     输出：  白日依山尽， 黄河入海流。 欲穷千里目， 更上一层楼
     */
}

// 字符
/*
 在swift编程语言中，对字符的表示是独立于某一种特定的Unicode编码的。
 整个Unicode标准编码由三个平面构成：
 1.基本多语言平面：大部分拉丁字母、希腊字母、标点符号、亚洲的部分字母；
 2.补充平面：包含了某些不在基本多语言平面的非拉丁字符、亚洲文字等，所有Emoji表情；
 3.保留平面：永久保留的码点部分。
 */

do {
    // 创建一个字符对象 ‘0’
    // 注意，使用UnicodeScalar构造出来的对象是可选的。
    let zero = UnicodeScalar("0")
    if let z = zero {
        print("z = \(z)")
        print("scalar value = \(z.value)")
    }
    
    // 使用类型标注的方式声明并初始化a
    let a: UnicodeScalar = "a"
    print("a = \(a)")
    print("scalar value = \(a.value)")
    
    let pai = UnicodeScalar("π")
    if let p = pai {
        print("pai = \(p)")
        print("scalar value = \(p.value)")
    }
    
    let 好: UnicodeScalar = "好"
    print("好 = \(好)")
}

/*
 UnicodeScalar可以表示字符，那么为什么还需要Character呢？
 因为现在充斥着各种丰富的Emoji表情，光20位的码点已经无法满足需求了，需要Emoji已经用两个
 码点进行表示了，比如各国的国旗。所以，swift中使用Character类型以覆盖所有的可被编码的字符。
 也就是说，一个Characteru对象可包含多个UnicodeScalar对象。
 */

//let flag: UnicodeScalar = "🇺🇸"
//报错 Cannot convert value of type 'String' to specified type 'UnicodeScalar' (aka 'Unicode.Scalar')
let flag: Character = "🇺🇸"
print("flag: \(flag)")

// 通过码点来构造UnicodeScalar类型的对象。

let c = UnicodeScalar(127464)!
let n = UnicodeScalar(127475)!
print("c = \(c), n = \(n)")

//我们将两个UnicodeScalar对子昂的字符对象拼在一起，构成一个String对象，然后用Character
//构造方法将这个String对象中的内容转换为Character相应的值。
let cn = Character(String([Character(c),Character(n)]))
print("cn = \(cn)")


// 2. 转义字符
print("\n")
print("---------转义字符-------------")
/*
 什么是转义字符？
 转义字符用来表示这些无法在源代码中表示的特殊字符。
 如何表示？
 swift中使用反斜杠作为转义字符的引导前缀。
 */

do {
    let s = "Say, \"Hello\",很好！"
    print(s)
    
    let a = "🇺🇸".unicodeScalars.first?.value
    let b = "🇺🇸".unicodeScalars.last?.value
    print("a = \(a), b = \(b)")
}

//3. 字符串（String）
do {
    // 空字符串
    let a = ""
    print(a)
    
    let b = String()
    print(b)
    
    let c = "hello"
    print(c)
    
    let d = "你好"
    print(d)
    
    // 常用属性
    
    //1. 拼接字符串
    let e = c + d
    print("e = \(e)")
    
    //2. +=拼接
    var f = "aaa"
    f += "bbb"
    print("f = \(f)")
    
    //3. == 比较
    if a == b {
        print("字符串相等")
    } else {
        print("不相等")
    }
    
    //4. 判断是否为空字符串
    if a.isEmpty {
        print("a是空字符串")
    } else {
        print("非空字符串")
    }
    
    //5. 包含子串
    if f.contains("a") {
        print("包含子串")
    } else {
        print("不包含子串")
    }
    
    //6.是否以某字符串开头
    if f.hasPrefix("a") {
        print("以a开头")
    } else {
        print("不是以a开头")
    }
    
    //7. 是否以某字符串结尾
    if f.hasSuffix(".mp4") {
        print("结尾包含.mp4")
    } else {
        print("结尾不包含.mp4")
    }
}

// 4. 字符串插值
/*
 什么是字符串插值？
 swift语言提供了一种十分便利的方式可以将几乎任一类型的对象转换为一个字符串的表示形式，
 这就叫做字符串插值。
 其实，我们在之前的打印中已经多次用到了字符串插值，只是没有提出这一概念。
 语法：\(Obj)
 */

do {
    let x = 10, y = 20
    let s = "x + y = \(x + y)"
    print("s is \(s)")
    // 或
    print("s is:" + s)
    
    // 自定义类型
    struct MyType {
        var x = 10, y = 20
    }
    
    let str = "my type: \(MyType())"
    print("自定义类型： \(str)")
    
    // 自定义类型定制字符串表达描述
    struct MyStruct: CustomStringConvertible {
        
        var a = 10
        var b = 20
        
        var description: String {
            return String("MyStruct: a = \(a), b = \(b)")
        }
    }
    
    var obj = MyStruct()
    obj.a = -obj.a
    obj.b *= 2
    
    print("哈哈哈，自定义: \(obj)")
}

// 5.字符串的characters属性
/*
 如果我们想要迭代访问一个字符串的每个字符，或者是查询当前字符串中包含了多少字符个数，那么我们可以访问
 String对象的characters属性。
 注意：characters属性是swift3.2以下的属性，之后就不建议使用了。
 我们在这里简单了解以下。
 
 @available(swift, deprecated: 3.2, message: "Please use String or Substring directly")
 public var characters: String.CharacterView
 
 */

do {
    var str = "看看旗帜1：\u{1f1e8}"
    print("count: \(str.count)")
    
    print("before appending :", separator: "",terminator: "")
    
    // 输出字符序列
    for ch in str.characters {
        print("\(ch)", separator: "", terminator: " ")
    }
    
    print("\n")
    
    //新增一个字符
    str.append("\u{1f1f3}")
    
    //输出当前字符串中字符个数
    print("count: \(str.count)")
    
    for ch in str {
        print("\(ch)", separator: "", terminator: " ")
    }
    
    let str2 = "看看旗帜2：\u{1f1e8}\u{1f1f3}"
    print("count: \(str2.count)")
    print(str2)
    
    // 字符串的最后和第一个字符属性
    print("第一个字符： \(str2.first ?? " " )")
    print("最后一个字符: \(str2.last ?? " " )")
    
   // 注意：first和last属性都是返回的可选类型
}

// 6. 字符串的索引以及字符访问
/*
注意：我们不能通过下标索引的方式访问字符串中的指定位置的字符，那么我们该如何访问单独的字符呢？
 swift编程语言为string类型引入了索引类型String.Index用于表示字符串对象中字符序列的索引值。
 由于String.Index类型遵循了Comparable协议，所以它可以作为范围操作符的操作数。
 
 swift中String.Index的声明如下：
 
 /// A position of a character or code unit in a string.
 public struct Index {
 }
 */

do {
    // 常用属性
    //1.开始位置,结束位置
    var str = "00000000000000000000"
    let start = str.startIndex
    let end = str.endIndex
    
    //2.获得指定的索引值
    // index( _ , offsetBy: _)
    // 第一个参数：开始位置
    // 第二个参数：偏移量，为正数：返回的索引值往后挪n位，为负数：往前挪n位。
    let index = str.index(start, offsetBy: 5)
    str.insert("1", at: index)
    print("newstr: \(str)")
    // newstr: 000001000000000000000
    
    /*
     index(_, offsetBy: _, limitedBy: _)
     作用与 index( _ , offsetBy: _) 一样。
     第一个参数：开始位置
     第二个参数：偏移量
     第三个参数：边界检测，如果索引计算的结果超过了边界，此方法就会返回空，因此返回值是一个可选值。
     */
    if let index2 = str.index(end, offsetBy: -5, limitedBy: start) {
        str.insert("2", at: index2)
        print("str2: \(str)")
        //str2: 0000010000000002000000
    }
    
    //3.Substring类型
    /*
     public struct Substring : StringProtocol {
     ....
     }
     Substring类型的对象是一个优化过的子串对象模型，它不仅具有String几乎全部的属性和方法
     ，而且它共享了其原始字符串的存储空间，使得对它的操作非常快捷。
     */
    let myString = "好好学习，天天向上，每天都是好天气。🇨🇳"
    let startIndex = myString.startIndex
    let endIndex = myString.endIndex
    let index3 = myString.index(startIndex, offsetBy: 3)
    let index10 = myString.index(startIndex, offsetBy: 10, limitedBy: endIndex)
    if let temp = index10 {
        let subStr = myString[index3 ..< temp]
        var ch = subStr.first
        print("first = \(ch ?? " " )")
        
        ch = subStr.last
        print("last: \(ch ?? " " )")
    }
   
    
    /*
     注意：
     endIndex属性指定的是字符串中最后一个字符的后一个索引位置，所以该属性的前一个位置才是此字符串
     中的最后一个字符的位置，这一点一定要注意。
     */
    
}


