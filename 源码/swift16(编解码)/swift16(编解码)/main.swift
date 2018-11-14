//
//  main.swift
//  swift16(编解码)
//
//  Created by iOS on 2018/10/16.
//  Copyright © 2018年 weiman. All rights reserved.
//

import Foundation

/*
 本节来学习swift的编码、解码和串行化。
 
 为什么需要编解码？
 许多的编程任务涉及到通过网络发送数据、将数据保存到磁盘上，或是将数据提交到API以及
 服务上。这些任务往往需要将数据进行编码到一个中间格式然后在进行传输，或是在传输结束后将中间格式转换回
 原始数据，然后在进行处理。这就需要提供一种能方便对数据进行编码、解码的机制了。
 
 原始数据---编码---提交传输----解码----原始数据
 
 swift 提供了标准化的方法对数据进行编码和解码。
 编码： Encodable协议
 解码： Decodable协议
 如果自定义类型要同时遵循Encodable与Decodable协议，就可以直接用 Codable 协议。
 
 Apple的Foundation库提供了两种编码器类，分别是 JSONEncoder / JSONDecoder,
 PropertyListEncoder / PropertyListDecoder
 
 JSONEncoder / JSONDecoder: 对象实例与json数据格式之间进行转换；
 PropertyListEncoder / PropertyListDecoder： 对象实例与XML数据格式之间进行互相转换。
 */

do {
    
    struct MyObject: Codable {
        var a = 10
        var str = "Hello"
        var array = [1, 2, 3]
    }
    
    let obj = MyObject()
    // 将obj转为JSON字符串
    let encoder = JSONEncoder()
    // 注意，JSONEncoder的encoder方法返回的是一个Data类型的对象
    let jsonData = try? encoder.encode(obj)
    
    if let jsonData = jsonData,
        let jsonStr = String(data: jsonData, encoding: .utf8) {
        print("Json string is : \(jsonStr)")
    }
    
    // 以下是将一个json data转为MyObject对象
    let decoder = JSONDecoder()
    let newObj = try? decoder.decode(MyObject.self, from: jsonData!)
    if let obj = newObj {
        print("a = \(obj.a)")
        print("str = \(obj.str)")
        print("array = \(obj.array)")
    }
}

// 将自定义类型转为XML
do {
    struct MyObject: Codable {
        var a = 10
        var str = "Hello"
        var array = [1, 2, 3]
    }
    
    let obj = MyObject()
    let encoder = PropertyListEncoder()
    encoder.outputFormat = .xml
    let xmlData = try? encoder.encode(obj)
    if let xmlData = xmlData,
        let xmlStr = String.init(data: xmlData, encoding: .utf8) {
        print("Xml string is: \(xmlStr)")
    }
    
    // 将XML Data转为MyObject对象
    let decoder = PropertyListDecoder()
    let newObj = try? decoder.decode(MyObject.self, from: xmlData!)
    if let obj = newObj {
        print("a = \(obj.a)")
        print("str = \(obj.str)")
        print("array = \(obj.array)")
    }
    
}



