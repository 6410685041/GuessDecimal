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
    @State var comment = "let's start"
    
    var body: some View {
        VStack {
            Text("Guessing Number")
                .font(.title)
            Text(comment)
                .font(.caption)
            Text(guess.intString())
            
            NumberSlider(value: $guess.number)
        }
        Button("guess"){
            comment = game.check(guess: guess)
            showCount = game.isEnd
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
    var body: some View {
        HStack{
            Text("0")
            Slider(
                value: $value,
                in: 1...100,
                step: 1
            )
            Text("100")
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
