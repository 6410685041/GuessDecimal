//
//  Number.swift
//  GuessDecimal
//
//  Created by นางสาวชลิศา ธรรมราช on 19/1/2567 BE.
//

import Foundation

struct Num {
    var number = 50.0
    
    static func random() -> Num {
        var num = Num()
        num.number = Double.random(in: 0...100)
        return num
    }
    
    func compare(target: Num) -> Int {
        var check = lround(target.number)
        var num = lround(number)
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
    
    func intString() -> String {
        "A number is \(number)"
    }
}
