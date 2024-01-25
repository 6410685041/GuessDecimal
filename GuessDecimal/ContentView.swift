//
//  ContentView.swift
//  GuessDecimal
//
//  Created by นางสาวชลิศา ธรรมราช on 19/1/2567 BE.
//

import SwiftUI

struct ContentView: View {
    @State var game = Game()
    @State var guess = Num()
    @State var sliderValue: Double = 0
    @State var showCount = false
    @State var start = false
    @State var comment = "let's start"
    @State var text: String = ""
    @State var max: Double = 100.0
    
    var body: some View {
        
        VStack {
            Text("Guessing Number")
                .font(.title)
            if game.isNotStart {
                Text("Please select range that you want to challenge")
                TextField("Number", text: $text)
                Button("Start Game") {
                    let theText = text ?? ""
                    max = Double(theText) ?? 100.0
                    game.startGame(max: max)
                }
            }
            else {
                Text(comment)
                    .font(.caption)
                Text(guess.intString())
                
                NumberSlider(value: $guess.number, maxRange: max)
                Button("guess"){
                    comment = game.check(guess: guess)
                    showCount = game.isEnd
                }
                
            }
            
        }
    
        .alert(isPresented: $showCount){
            Alert(
                title: Text("Your round of guessing"),
                message: Text(String(game.count)),
                dismissButton: .default(Text("OK")) {
                    guess = Num()
                    game.startNewGame()
                }
            )
        }
        .padding()
    }
}

struct NumberSlider: View {
    @Binding var value: Double
    var maxRange: Double

    init(value: Binding<Double>, maxRange: Double) {
        self._value = value
        self.maxRange = maxRange
    }

    var body: some View {
        HStack {
            Text("0")
            Slider(
                value: $value,
                in: 1...maxRange,
                step: 1
            )
            Text("\(maxRange)") // Display the maximum value
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
