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
            Spacer()
                .frame(height: 70)
            
            VStack{
                Text("Guessing Number")
                    //.font(.title)
                    .foregroundColor(Color(UIColor(hex: "#C26068")))
                    .font(.system(size: 55))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
            }
                .padding(.horizontal, 30)
                .padding(.vertical, 10)
                .background(Color(UIColor(hex: "#F9E7E5")))
                .cornerRadius(25)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(style: StrokeStyle(lineWidth: 3, dash: [10]))
                        .foregroundColor(Color(UIColor(hex: "#C26068")))
                )
            
            Spacer()
                .frame(height: 70)
            
            if game.isNotStart {
                Text("Please select range that you want to challenge")
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor(hex: "#C26068")))
                    .multilineTextAlignment(.center)
                    //.padding()
                TextField("Number", text: $text)
                    .frame(width: 200.0, height: 40.0)
                    .multilineTextAlignment(.center)
                    .border(Color.gray, width: 2)
                Button("Start Game") {
                    max = Double(text) ?? 100.0
                    game.startGame(max: max)
                }
                    .padding(7.0)
                    .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.92))
                    .cornerRadius(7)
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
                    .padding(7.0)
                    .padding(.horizontal, 10.0)
                    .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.92))
                    .cornerRadius(7)
            }
            
            Spacer()
        }
        .padding()
        .background(Color(UIColor(hex: "#F8C0A5")))
        
        .alert(isPresented: $showCount){
            Alert(
                title: Text("Correct!"),
                message: Text("Your round of guessing: \(game.count)"),
                dismissButton: .default(Text("OK")) {
                    guess = Num()
                    game.startNewGame()
                }
            )
        }
        
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
                in: 0...maxRange,
                step: 1
            )
            Text("\(Int(maxRange))") // Display the maximum value
        }
    }
    
}

// Extension to convert hex code to UIColor
extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
