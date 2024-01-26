//
//  Number.swift
//  GuessDecimal
//
//  Created by นางสาวชลิศา ธรรมราช on 19/1/2567 BE.
//

import Foundation

struct Num {
    var number = 0.0
    
    static func random(max: Double) -> Num {
        var num = Num()
        num.number = Double(lround(Double.random(in: 0...1)*max))
        return num
    }
    
    func compare(target: Num) -> Int {
        let check = target.number
        let num = number
        if (check < num){
            return 1
        }
        else if (check > num){
            return -1
        }
        else {
            return 0
        }
    }
    
    func toInt() -> Int {
        return Int(number)
    }
    
    func intString() -> String {
        "A number is \(toInt())"
    }
}
