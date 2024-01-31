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
            
            if game.isNotStart {
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
                    .frame(height: 40)
                
                Text("Please select range that you want to challenge")
                    .fontWeight(.bold)
                    .foregroundColor(Color(UIColor(hex: "#C26068")))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal,50)
                TextField("Number", text: $text)
                    .frame(width: 200.0, height: 40.0)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color(UIColor(hex: "#C26068")))
                    .fontWeight(.bold)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(style: StrokeStyle(lineWidth: 3))
                            .foregroundColor(Color(UIColor(hex: "#C26068")))
                    )
                    .background(RoundedRectangle(cornerRadius: 25).foregroundColor(.white))
                Button("Start Game") {
                    max = Double(text) ?? 100.0
                    game.startGame(max: max)
                }
                    .padding(7.0)
                    .background(Color(UIColor(hex: "#C26068")))
                    .cornerRadius(7)
                    .foregroundColor(Color.white)
                    .fontWeight(.bold)
            }
            else {
                Spacer()
                    .frame(height: 70)
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(UIColor(hex: "#F8C0A5")))
                        .frame(width: 1000, height: 1000)
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color.white)
                        .frame(width: 327, height: 500)
                        .overlay(
                            VStack{
                                Text(game.RoundNumber())
                                    .fontWeight(.bold)
                                    .foregroundColor(Color(UIColor(hex: "#C26068")))
                                    .font(.system(size: 40))
                                    .multilineTextAlignment(.center)
                                Text(comment)
                                    .font(.system(size: 15))
                                
                                Spacer().frame(height: 40)
                                
                                Text(guess.intString())
                                    .font(.system(size: 20))
                                    .foregroundColor(Color(UIColor(hex: "#C26068")))
                                    .fontWeight(.bold)
                                    .padding(.bottom, 0)
                                
                                NumberSlider(value: $guess.number, maxRange: max)
                                Button("guess"){
                                    comment = game.check(guess: guess)
                                    showCount = game.isEnd
                                }
                                    .padding(7.0)
                                    .padding(.horizontal, 10.0)
                                    .background(Color(UIColor(hex: "#C26068")))
                                    .cornerRadius(7)
                                    .foregroundColor(Color.white)
                                    .fontWeight(.bold)
                                Button("restart"){
                                    guess = Num()
                                    game.startNewGame()
                                }
                                    .padding(7.0)
                                    .padding(.horizontal, 10.0)
                                    .background(Color(UIColor(hex: "#C26068")))
                                    .cornerRadius(7)
                                    .foregroundColor(Color.white)
                                    .fontWeight(.bold)
                            }
                        )
                    VStack{
                        Spacer()
                            .frame(height: 180)
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color.white)
                            .frame(width: 260, height: 160)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(style: StrokeStyle(lineWidth: 3, dash: [10]))
                                    .foregroundColor(Color(UIColor(hex: "#C26068")))
                            )
                        Spacer()
                    }
                    VStack{
                        Spacer()
                            .frame(height: 180)
                        Spacer().frame(height: 5)
                        RoundedRectangle(cornerRadius: 30)
                            .fill(Color(UIColor(hex: "#F9E7E5")))
                            .frame(width: 250, height: 150)
                            .overlay(
                                VStack{
                                    Text("Guessing Number")
                                    //.font(.title)
                                        .foregroundColor(Color(UIColor(hex: "#C26068")))
                                        .font(.system(size: 45))
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.center)
                                }
                            )
                        Spacer()
                    }
                }
                //padding(.vertical, 5)
            }
            
            Spacer()
        }
        .padding(.horizontal,20)
        .background(Color(UIColor(hex: "#F8C0A5")))
        .frame(width: 500)
        
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
            Text("0").foregroundColor(Color(UIColor(hex: "#C26068"))).fontWeight(.bold)
            Slider(
                value: $value,
                in: 0...maxRange,
                step: 1
            )
                .frame(width: 220)
                .accentColor(Color(UIColor(hex: "#C26068")))
            // Display the maximum value
            Text("\(Int(maxRange))").foregroundColor(Color(UIColor(hex: "#C26068"))).fontWeight(.bold)
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
