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
        if ( diff == 1 ){
            count += 1
            return "The correct one is lower"
        }
        else if ( diff == -1 ){
            count += 1
            return "The correct is higher"
        }
        else {
            isEnd = true
            return "You have select right number!"
        }
    }
    
    mutating func startNewGame() {
        count = 0
        isEnd = false
        target = Num.random()
    }
}
