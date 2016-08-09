//
//  vector.swift
//  mylearning
//
//  Created by 直井　真一郎 on 2016/08/03.
//  Copyright © 2016年 Shinichiro Naoi. All rights reserved.
//

import Accelerate

struct Vector {
    private var _vec:[Double]
    private(set) var count : Int
    init(_ c: Int) {
        _vec = Array(count: c, repeatedValue: 0.0)
        count = _vec.count
    }
    init(_ arr: [Double]) {
        _vec = arr
        count = _vec.count
    }
    subscript(i: Int) -> Double {
        get {
            return _vec[i];
        }
        
        set {
            _vec[i] = newValue
        }
    
    }
    
    func dot (r: Vector) -> Double {
        var v = 0.0
        vDSP_dotprD(_vec, 1, r._vec, 1, &v, vDSP_Length(_vec.count))
        return v
    }
    
    

}

func + (l: Vector, r: Vector) -> Vector {
//    assert(l.count == r.count, "Different length vector cannot be added")
//    return Vector(l._vec.enumerate().map {i,n in
//        return n + r[i]
//        })
    
    var v = [Double](count : l.count, repeatedValue : 0.0)
    vDSP_vaddD(l._vec, 1, r._vec, 1, &v, 1, vDSP_Length(l.count))
    return Vector(v)
    
}

func * (l: Vector, r: Vector) -> Vector {
    var v = [Double](count : l.count, repeatedValue : 0.0)
    vDSP_vmulD(l._vec, 1, r._vec, 1, &v, 1, vDSP_Length(l.count))
    return Vector(v)
    
}

func / (l: Vector, r: Vector) -> Vector {
    var v = [Double](count : l.count, repeatedValue : 0.0)
    vDSP_vdivD(l._vec, 1, r._vec, 1, &v, 1, vDSP_Length(l.count))
    return Vector(v)
    
}

func + (l: Vector, r: Double) -> Vector {
    var v = [Double](count : l.count, repeatedValue : 0.0)
    var s = r
    vDSP_vsaddD(l._vec, 1, &s, &v, 1, vDSP_Length(l.count))
    return Vector(v)
}

func * (l: Vector, r: Double) -> Vector {
    var v = [Double](count : l.count, repeatedValue : 0.0)
    var s = r
    vDSP_vsmulD(l._vec, 1, &s, &v, 1, vDSP_Length(l.count))
    return Vector(v)
}

func - (l: Vector, r: Vector) -> Vector {
    var v = [Double](count : l.count, repeatedValue : 0.0)
    vDSP_vsubD(l._vec, 1, r._vec, 1, &v, 1, vDSP_Length(l.count))
    return Vector(v)
}

