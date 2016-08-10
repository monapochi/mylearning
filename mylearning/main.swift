//
//  main.swift
//  mylearning
//
//  Created by 直井　真一郎 on 2016/08/03.
//  Copyright © 2016年 Shinichiro Naoi. All rights reserved.
//

import Foundation

print("Hello, World!")

//var v2 = Vector([1.1,2,3,4,5])
//var v1 = Vector([1,2,3,4,5])
//
//var v3 = v1 + v2
//
//print(v3)
//
//var d = v1.dot(v2)
//
//print(d)


//for _ in 0..<20 {
//    var r = arc4random_uniform(200801011) % 2
//    print("> \(r)")
//}







//// 2016.8.9 A　下はいろいろ失敗なのでやりなおし
//func rnd() -> Double {
//    return (Double)(arc4random_uniform(200801011) % 2)
//}
//
//func judge(arr: [Int]) -> Bool {
//    return arr[0] & arr[1] == 1 ? true : false
//}
//
//func train (v: Vector, w: Vector, result: Int) {
//    var count = 0
//    let r = 0.1
//    var b = w.dot(v)
//    var nw = w
//    
//    let t = Double(result)
//    
//    while(b != 0) {
//        let l = nw + v * t * r
//        
//        nw =  l
//        
//        
//        b = nw.dot(v)
//        
//        print("\(count) ------------")
//        print("dot > \(b)")
//        
//        count += 1
//    }
//}
//
//
//let T = [[1,0],[1,1],[0,0],[1,0],[0,0],[1,0],[1,0],[1,0],[1,1],[1,0],[1,1],[1,0],[1,0],[0,0],[1,0],[1,1],[1,0],[1,0]]
//
//var w = Vector([rnd(), rnd()])
//
//T.forEach { (d) in
//    print("----------------------------")
//
//    let x = Double(d[0])
//    let y = Double(d[1])
//    let res = judge(d)
//    print("teacher > \(x), \(y) -> \(res)")
//    
//    var vec = Vector([x,y])
//    
//    let ans = vec.dot(w) == 0 ? true : false;
//    print("1st answer > \(ans)")
//    
//    if(res != ans) {
//        print("start training ...")
//        train(vec, w: w, result: res ?  1 : -1)
//        
//    }
//    
//}

// --------------------------------------------------------------------------------------


//// 2016.8.9 B
let T = [[1,0],[1,1],[0,0],[1,0],[0,0],[1,0],[1,0],[1,0],[1,1],[1,0],[1,1],[1,0],[1,0],[0,0],[1,0],[1,1],[1,0],[1,0]]
let TT = [[1,1],[0,1],[1,0],[0,0],[1,0],[1,1],[1,0],[0,0],[1,0],[1,0],[0,1],[1,1],[1,0],[1,1],[1,0],[1,1],[0,0],[0,1]]


func rnd() -> Double {
    return (Double)(arc4random_uniform(20080111) % 10) / 10000
}

var w = [rnd(), rnd(), rnd()] // 初期値は適当 2次元データを対象にしてるので n+1 次

// 教師データ作成
func T2(c: uint, max: uint = 2) -> [[Double]] {
    var arr = Array<Array<Double>>()
    for _ in 0..<c {
        let a = (Double)(arc4random_uniform(20080111) % max)
        let b = (Double)(arc4random_uniform(20120904) % max)
        arr.append([a, b])
    }
    
    return arr
}


func judge(arr: [Double]) -> Double {
    let a = arr[0] == 1 ? true : false
    let b = arr[1] == 1 ? true : false
//    return  a && b  ? 1 : 0 // AND
    return  a || b  ? 1 : 0 // OR
}

func stepFunc(n: Double) -> Double {
    return n < 0 ? 0 : 1
}

func train(T: [[Double]]) -> Bool {
    var flag = false
    
    T.forEach { (d) in
        
        let x = Double(d[0])
        let y = Double(d[1])
        
        // 内積計算
        var dot = 1 * w[0] + x * w[1] + y * w[2] // 最初の 1 はしきい値を気にせずに済むように
        //print("dot> \(dot)")
        
//        let teacher = judge(d) // AND, OR
//        var ans = stepFunc(dot)
        let teacher = x + y
        var ans = round(dot)
        while(ans != teacher) {
            flag = true
            print("  training ...")
            
            w[0] += 0.001 * (teacher - ans) * 1
            w[1] += 0.001 * (teacher - ans) * x
            w[2] += 0.001 * (teacher - ans) * y
            
//            dot = 1 * w[0] + x * w[1] + y * w[2]
//            ans = stepFunc(dot)
            dot = 1 * w[0] + x * w[1] + y * w[2]
            ans = round(dot)
            
            print("  dot> \(dot)")
            
        }
        
    }
    
    return flag
}


var fLoop = true
let trainingData = T2(100, max: 10)
print("training data> \(trainingData)")
while(fLoop) {
    fLoop = train(trainingData)
}



print("----------------------------")
print(" result")
print("----------------------------")

//TT.forEach { (d) in
//    let x = Double(d[0])
//    let y = Double(d[1])
//    let res = judge([x, y]) == 1 ? true : false
//    let dot = 1 * w[0] + x * w[1] + y * w[2]
//    let ans = stepFunc(dot) == 1 ? true : false
//    print("teacher > \(x), \(y) -> \(res)")
//    print("answer  >             \(ans)")
//    print("")
//}

print("w  > \(w)")
print("----------------------------")

T2(30, max: 20).forEach { (d) in
    let x = Double(d[0])
    let y = Double(d[1])
    let teacher = x + y
    let dot = 1 * w[0] + x * w[1] + y * w[2]
    let ans = round(dot)
    let res = ans == teacher ? true : false
    print("teacher > \(x), \(y) -> \(teacher)")
    print("answer  >             \(ans)")
    print("result  >             \(res)")
}


















