//
//  main.swift
//  swift27(与C语言的交互)
//
//  Created by iOS on 2018/11/8.
//  Copyright © 2018 weiman. All rights reserved.
//

import Foundation

/*
 与C语言的交互
 
 本节学习swift与C语言是如何交互的。
 
 如果我们用xcode开发的话，swift与C语言和OC交互都是比较容易的，因为我们新建一个C或者OC的源文件的时候
 xcode会询问我们是否要建一个bridge头文件，点击确定，就会自动创建一个桥接文件了。
 */

// 1.swift中导入C语言的基本类型
/*
 C 语言常用类型与swift语言类型对应
 
    C语言      中间类型        swift语言
 
    _Bool       CBool           Bool
    char        CChar           CChar
signed char   CSignedChar       Int8
   short        CShort          Int16
    int         CInt            Int
 
 还有很多类型不一一列举。
 */

// 2. swift中导入C语言的枚举类型
/*
 C语言的枚举类型可以被导入到swift之中，只要我们将该枚举声明在桥接文件中即可。当C语言的枚举类型被
 导入swift中之后，它就成为了swift中的一个结构体类型，并且其每个枚举值都成了全局的该结构体中的一个
 只读计算式实例属性。
 
 比如我们在桥接头文件中定义了以下枚举类型：
 enum MyCEnum {
 MyCEnum_VALUE1 = 1,
 MyCEnum_VALUE2 = 2,
 MyCEnum_VALUE3 = 3
 };
   
 那么该枚举类型在Swift中就好比如下的结构体类型：
 struct MyCEnum : RawRepresentable, Equatable {
   
 }
 */

/*
 3. swift导入C语言的结构体类型
 
 C语言中的结构体导入到Swift中也是非常自然。如果我们要将自己定义的一个结构体导入到Swift中，
 那么直接在桥接头文件中定义它即可。C语言的结构体导入到Swift中之后，自带一个默认的初始化器
 以及逐成员的初始化器。C语言结构体中的每个成员对应为Swift中的存储式实例属性。
 
 我们在桥接头文件中定义以下结构体类型：
 struct MyCStruct
 {
 int a;
 float b;
 double d;
 };
 然后 MyCStruct 结构体类型在Swift中的形式就类似于：
 public struct MyCStruct {
    public var a: Int32 = 0
    public var b: Float = 0.0
    public var d: Double = 0.0
 }
 
 我们可以这么用 MyCStruct 结构体类型：
 let s1 = MyCStruct()
 print("s.a = \(s1.a)")
   
 let s2 = MyCStruct(a: 1, b: 2.1, d: 3.5)
   
 print("s2.b = \(s2.b)")
 
 */


/*
 4. Swift中导入C语言的联合体类型
 
 Swift也可导入C语言中的联合体类型。与结构体类似，被导入的C语言中的联合体将自动包含一个默认
 的无参数的初始化器以及针对每个成员进行初始化的初始化器。C联合体中的所有成员均会作为计算式
 实例属性出现在Swift中。
 我们这里要注意的是，由于C语言中的联合体对象，其所有成员共享一个存储单元，因此我们在Swift
 中访问联合体对象属性的时候就必须注意这一点。
 
 /// 定义一个联合体类型
 union MyCUnion
 {
 int a;
 float f;
 double d;
 };
 
 然后，导入到Swift中，它就好比于以下的结构体类型：
 struct MyCUnion {
   
 var a: Int32 { get set }
   
 var f: Float { get set }
   
 var d: Double { get set }
   
 init() {
   
 }
   
 init(a: Int32) {
 self.a = a
 }
   
 init(f: Float) {
 self.f = f
 }
   
 init(d: Double) {
 self.d = d
 }
 }
 
 */


