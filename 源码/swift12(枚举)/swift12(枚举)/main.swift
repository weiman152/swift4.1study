//
//  main.swift
//  swift12(枚举)
//
//  Created by iOS on 2018/10/11.
//  Copyright © 2018年 weiman. All rights reserved.
//

import Foundation

/*
 枚举
 
 swift的枚举类型也是一个很强大的类型，与其他语言相比，swift中枚举应用更加灵活、广泛。
 
 例如：
 像C或者OC中都有枚举类型，但是他们的枚举类型默认为整数类型int兼容。
 而在swift中，我们可以自己指定一个枚举类型与哪种类型兼容。
 
 注意：
 swift中，枚举属于值类型，而不是引用类型。
 
 */

// 1. 枚举类型与枚举对象的一般定义
do {
    // 定义简单的枚举类型
    enum Type {
        case red
        case green
        case yellow
    }
    
    // 交通指示灯的枚举
    enum TrafficLight {
        case red, yellow, green
    }
    
    let light = TrafficLight.green
    var light2 = TrafficLight.red
    
    // 根据类型推导，可以省略TrafficLight
    light2 = .yellow
    print("light = \(light), light2 = \(light2)")
    
    switch light {
    case .red:
        print("红灯")
    case .yellow:
        print("黄灯")
    case .green:
        print("绿灯")
    }
    
    //元组中使用枚举
    let tuple: (TrafficLight, TrafficLight) = (.red, .yellow)
    print(tuple.0)
    
}

// 2. 指定基本类型与原生值
/*
 swift中，能够用于指定枚举的基本类型有：
 1.各类整数类型
 2.各类浮点数类型
 3.字符类型
 4.字符串类型
 
 这些类型都遵循了rawrepresentable协议以及Equatable协议。
 
 */

do {
    
    print("\n---------指定基本类型与原生值-----------")
    
    enum IntEnum: Int {
        case zero
        case one = 1, two, three
        case six = 6, seven, eight
    }
    
    print("one = \(IntEnum.one.rawValue)")
    print("two = \(IntEnum.two.rawValue)")
    print("three = \(IntEnum.three.rawValue)")
    print("six = \(IntEnum.six.rawValue)")
    print("seven = \(IntEnum.seven.rawValue)")
    print("eight = \(IntEnum.eight.rawValue)")
    
    enum DoubleEnum: Double {
        case one = 1.0, two = 2.0
        case π = 3.141592653
        case e = 2.71828
    }
    
    print("one = \(DoubleEnum.one.rawValue)")
    print("two = \(DoubleEnum.two.rawValue)")
    print("π = \(DoubleEnum.π.rawValue)")
    print("e = \(DoubleEnum.e.rawValue)")
    
    enum CharEnum: Character {
        case apple = "🍎"
        case orange = "🍊"
        case banana = "🍌"
        case cherry = "🍒"
    }
    
    print("I like \(CharEnum.apple.rawValue), she likes \(CharEnum.cherry.rawValue).")
    print("But we all like \(CharEnum.orange.rawValue).")
    print("we don't like \(CharEnum.banana.rawValue).")
    
    /*
     注意：
     如果我们用整型来指定一个枚举，那么枚举值的原生值是可以省略的，默认第一个值为0，以后每次加1.
     如果用字符串来指定枚举，也可以为枚举值省略原生值。对于制定了字符串类型的枚举中的某个枚举值
     不指定原生值，那么该枚举值的原生值就是该枚举值的标识符所构成的字符串字面量。
     
     枚举中的枚举值属于常量。
     
     */
    
    print("\n")
    
    do {
        enum TrafficLight: UInt {
            case red        // 默认值为0
            case yellow     // 值为1
            case green      // 值为2
        }
        
        // 使用初始化构造器来构造一个TrafficLight实例对象
        var light = TrafficLight(rawValue: 0)
        if let l = light {
            print("light is \(l)")
            print("light value is \(l.rawValue)")
        }
        
        // TrafficLight中没有值为5的枚举值，这里light得到一个空值
        light = TrafficLight(rawValue: 5)
        if light == nil {
            print("light is nil")
        } else {
            print("light is not nil")
        }
        
        enum MyNumber: Float {
            case 一 = 1.0
            case 二点五 = 2.5
            case 三 = 3.0
        }
        
        var num = MyNumber(rawValue: 2.5)
        
        if let n = num {
            print("num is \(n)")
            print("num value is \(n.rawValue)")
        }
    }
}

// 3. 枚举关联值
/*
 枚举关联值与原生值类似的是，它也是将某个值与指定的枚举case存放在一起。不过枚举关联值的语法对每个
 case均可指定不同类型、不同个数的关联值。因此就所指定的值的类型与个数而言，枚举关联值比原生值要
 灵活的多。
 注意：
 如果我们为一个枚举类型中的任意枚举case用上了枚举关联值，那么对于该枚举类型就不能为它指定一个
 原生类型，也不能为其枚举case指定原生值。
 */
do {
    
    print("\n")
    
    enum MyTestEnum {
        // 这里的value1具有Void类型的关联值
        case value1(Void)
        // 这里的value2具有Int类型的关联值
        case value2(Int)
        case value3(Float, Int, Void, String)
        case value4(dict: [String: Int], array: [Double], tuple: (Int, Double))
        case value5
    }
    
    // 使用
    let e1 = MyTestEnum.value1(())
    print("e1 = \(e1)")
    
    let e2 = MyTestEnum.value2(10)
    print("e2 = \(e2)")
    
    let e3 = MyTestEnum.value3(2.3, 4, (), "努力学习，天天向上")
    print("e3 = \(e3)")
    
    let e4 = MyTestEnum.value4(dict: ["one": 1, "two": 2],
                               array: [1.0, 2.0, 3.0],
                               tuple: (1, 2.0))
    print("e4 = \(e4)")
    
    func processMyTest(en: MyTestEnum) {
        switch en {
        case .value1(let v):
            print("value1 = \(v)")
        case .value2(var v):
            print("value2 = \(v)")
            v += 10
            print("new value2 = \(v)")
        case .value3(let a, let b, let c, let d):
            print("a = \(a)")
            print("b = \(b)")
            print("c = \(c)")
            print("d = \(d)")
        case .value4(let dict, let array, let tuple):
            print("dict: \(dict)")
            print("array: \(array)")
            print("tuple: \(tuple)")
            
        case .value5:
            print("这是第五个值")
        }
    }
    
    processMyTest(en: e1)
    processMyTest(en: e2)
    processMyTest(en: e3)
    processMyTest(en: e4)

    /*
     从swift3.0开始，swift引入了通过if语句以及guard语句来捕获枚举关联值的语法形式。在这种
     语法体系下，是将if或guard与case关键字连用指定一个枚举case，然后对该枚举case的关联值进行捕获。
     */
    if case let .value1(value) = e1 {
        print("value1 = \(value)")
    }
    
    if case let .value2(value) = e2 {
        print("value2 = \(value)")
    }
    
    guard case .value4(let dict, var arr, let tup) = e4 else{
        exit(0)
    }
    
    print("dict = \(dict)")
    arr = [2.2, 3.4, 5.9]
    print("array = \(arr)")
    print("tuple = \(tup)")
    
    // 通过逗号对if中的捕获的值做进一步的判断
    if case let .value2(value) = e2, value > 5 {
        print("哈哈哈哈，捕获的值大于五")
    } else {
        print("哎哟")
    }
    
    // 也可以在一个if中用两个case捕获两个值，这两个case是“并且”的关系。
    if case let .value2(value) = e2,
        case let .value3(x, y, z, w) = e3,
        value > 5, x > 1.0 {
        print("哇卡卡卡卡")
    }
    
    // switch-case也有丰富的匹配特性
    func fetch(enum en: MyTestEnum) {
        switch en {
        case .value1(()), .value5:
            print("没有关联值或者关联值为空")
        case  .value2(10...20):
            if case let .value2(v) = en {
                print("value2 = \(v)")
            }
        case .value2(var value) where value >= 50 :
            print("哈哈哈哈")
            value -= 20
            print("value = \(value)")
        default:
            print("没有匹配的")
            break
        }
    }
    
    fetch(enum: e1)
    let e5 = MyTestEnum.value5
    fetch(enum: e5)
    
    fetch(enum: e2)
    fetch(enum: .value2(30))
    fetch(enum: .value2(60))
    
    fetch(enum: .value2(100))
}

// 4. 递归枚举
/*
 如果一个枚举类型中某一个枚举case的其中一个关联值的类型为该枚举类型本身，那么我们称之为“递归枚举”。
 我们在声明该枚举case的时候需要在它前面加上indirect关键字，该关键字指示编译器在当前枚举case中
 插入了一个间接层。
 */

do {
    
    print("\n")
    
    enum MyEnum {
        case value1(Int)
        indirect case value2(MyEnum)
    }
    
    // 也可以在枚举的最前面加上indirect关键字，表示这里的每一个case都插入了间接层。
    indirect enum indEnum {
        case value1(Int)
        case value2(indEnum)
    }
    
    // 使用举例
    enum FoodAndDrink {
        case name(String)
        indirect case eat(FoodAndDrink)
        indirect case drink(FoodAndDrink)
    }
    
    func treatFoodAndDrink(item: FoodAndDrink) {
        switch item {
        case .name(let str):
            print("name = \(str)")
        case let .eat(food):
            if case let .name(foodName) = food {
                let newItem = FoodAndDrink.name("eat \(foodName)")
                treatFoodAndDrink(item: newItem)
            } else {
                print("不合法的食物")
            }
        case let .drink(drinks):
            if case let .name(drinkName) = drinks {
                let newItem = FoodAndDrink.name("drink \(drinkName)")
                treatFoodAndDrink(item: newItem)
            } else {
                print("不合法的饮品")
            }
        }
    }
    
    let orange = FoodAndDrink.name("橘子")
    let wine = FoodAndDrink.name("🍷")
    
    let eatOrange = FoodAndDrink.eat(orange)
    let drinkWine = FoodAndDrink.drink(wine)
    
    let awfulCombination = FoodAndDrink.drink(eatOrange)
    
    treatFoodAndDrink(item: orange)
    treatFoodAndDrink(item: wine)
    treatFoodAndDrink(item: eatOrange)
    treatFoodAndDrink(item: drinkWine)
    treatFoodAndDrink(item: awfulCombination)
}

//5. 枚举中的属性和方法
/*
 swift中枚举类型十分的灵活，我们还可以为其定义属性和方法，与结构体中的属性和方法类似。
 不过我们在枚举中不能为它定义存储式实例属性，其他都可以。
 */
do {
    
    print("\n")
    
    enum MyEnum {
        case one(Int)
        case two(Int)
        case three(Int)
        
        init() {
            self = .one(0)
        }
        
        func fetchValue() -> (Int, String) {
            switch self {
            case let .one(value):
                return (value, "one")
            case .two(let value):
                return (value, "two")
            case .three(let value):
                return (value, "three")
            }
        }
        
        static func makeEnum(with value: Int) -> MyEnum {
            switch value {
            case 0..<10:
                return .one(value)
            case 20..<30:
                return .two(value)
            default:
                return .three(value)
            }
        }
        
        // 这里定义了一个计算式实例属性
        var p: Int {
            set(i){
              self = .two(i)
            }
            get {
                return self.fetchValue().0
            }
        }
        
        // 这里定义了一个存储式属性
        static var storedP: Int = 100
        
        static var p2: Int {
            set(i) {
                storedP = i
            }
            get {
                return storedP
            }
        }
    }
    
    func process(enum value: MyEnum) {
        let (value, name) = value.fetchValue()
        print("value = \(value), name is \(name)")
    }
    
    process(enum: .makeEnum(with: 5))
    process(enum: .makeEnum(with: 26))
    process(enum: .makeEnum(with: -1))
    
    var e = MyEnum()
    process(enum: e)
    
    e.p = 20
    print("e = \(e)")
    
    MyEnum.storedP += 10
    print("s = \(MyEnum.storedP)")
    
}
