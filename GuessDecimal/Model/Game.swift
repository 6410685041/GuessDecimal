//
//  Game.swift
//  GuessDecimal
//
//  Created by นางสาวชลิศา ธรรมราช on 19/1/2567 BE.
//

import Foundation

struct Game {
    let start = Num()
    var target = Num.random()
    var isEnd = false
    var count = 0
    
    mutating func check(guess: Num) -> String {
        let diff = guess.compare(target: target)
        count += 1
        if ( diff == 1 ){
            return "Too Upper"
        }
        else if ( diff == -1 ){
            return "Too lower"
        }
        else {
            isEnd = true
            return "Right number"
        }
    }
    
    mutating func startNewGame() {
        count = 0
        isEnd = false
        target = Num.random()
    }
}
