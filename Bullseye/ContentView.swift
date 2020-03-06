//
//  ContentView.swift
//  Bullseye
//
//  Created by Troy Arnold on 3/3/20.
//  Copyright © 2020 Troy Arnold. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State var alertIsVisible: Bool = false
    @State var infoAlertIsVisible: Bool = false
    @State var gameIsOver: Bool = false
    @State var sliderValue: Double = 50.0
    @State var target: Int = Int.random(in: 1...100)
    @State var score : Int = 0
    @State var round : Int = 1
    
    let sliderColor = Color(red: 39/255, green: 176/255, blue: 98/255)
    let startOverButtonColor = Color(red: 176/255, green: 39/255, blue: 39/255)
    let infoButtonColor = Color(red: 39/255, green: 50/255, blue: 176/255)
    
    struct LabelStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
            .foregroundColor(Color.white)
            .font(Font.custom("Arial MT", size: 20))
            .modifier(Shadow())
        }
    }
    
    struct ValueStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .foregroundColor(Color.yellow)
                .font(Font.custom("Arial MT", size: 20))
                .modifier(Shadow())
        }
    }
    
    struct Shadow: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .shadow(color: .black, radius: 5, x: 2, y: 2)
        }
    }
    
    struct buttonLargeTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold", size: 18))
                .foregroundColor(Color.black)
        }
    }
    
    struct buttonSmallTextStyle: ViewModifier {
        func body(content: Content) -> some View {
            return content
                .font(Font.custom("Arial Rounded MT Bold", size: 12))
                .foregroundColor(Color.black)

        }
    }

    
    var body: some View {
        VStack {
            Spacer()
            // Target row
           HStack {
            Text("The bullseye is:").modifier(LabelStyle())
            Text("\(target)").modifier(LabelStyle())
                }
            Spacer()
            // Slider row
            HStack {
                Text("1").modifier(LabelStyle())
                Slider(value: $sliderValue, in: 1...100)
                Text("100").modifier(LabelStyle())
            }
            .accentColor(sliderColor)
            .navigationBarTitle("")

            .navigationBarHidden(true)

            // Button Row
            Spacer()
            Button(action: {
                self.alertIsVisible = true
                self.score += self.pointsForCurrentRound()
            }) {
                Text("Hit Me").modifier(buttonLargeTextStyle())
            }
                .background(Image("Button")).modifier(Shadow())

            .alert(isPresented: $alertIsVisible) { () -> Alert in
                let roundedValue = sliderValueRounded()
                if self.round == 5 {
                    return Alert(title: Text("Game Over"), message: Text("Your score was \(score)."), dismissButton: .default(Text("Play Again")) {
                    self.startOver()
                    })
                } else {
                return Alert(title: Text(alertTitle()), message: Text("The slider's value is \(roundedValue). \n" + "You scored \(pointsForCurrentRound()) points!"), dismissButton: .default(Text("Play Again")){
                    self.changeTarget()
                    self.round += 1
                    })}
            }
            Spacer()
            // Score Row
            HStack {
                Button(action: {
                    self.startOver()
                    self.changeTarget()
                }) {
                    HStack {
                    Image("StartOverIcon")
                    Text("Start Over").modifier(buttonSmallTextStyle())
                }
                .accentColor(startOverButtonColor)
                }
                .background(Image("Button")).modifier(Shadow())

                Spacer()
                Text("Score:").modifier(LabelStyle())
                Text("\(score)").modifier(ValueStyle())
                Spacer()
                Text("Round").modifier(LabelStyle())
                Text("\(round)/5").modifier(ValueStyle())
                Spacer()
                NavigationLink(destination: aboutView()) {
                    HStack{
                    Image("InfoIcon")
                    Text("Info").modifier(buttonSmallTextStyle())
                    }
                }
                    .accentColor(infoButtonColor)
                    .background(Image("Button")).modifier(Shadow())
                
            }
            .padding(.bottom, 20)
        }
        .background(Image("Background"), alignment: .center)
    }
    
    func sliderValueRounded() -> Int {
        return Int(sliderValue.rounded())
    }
    func pointsForCurrentRound() -> Int {
        
        return Int(sliderValue) > target ? 100 - (Int(sliderValue) - target) : 100 - (target - Int(sliderValue))
    }
    func startOver() {
        score = 0
        round = 1
        sliderValue = 50
        changeTarget()
    }
    func changeTarget() {
        self.target = Int.random(in: 1...100)
    }
    
    func alertTitle() -> String {
        
        let title: String
        
        if abs(self.target - Int(self.sliderValue.rounded())) == 0 {
            title = "BULLSEYE"
        } else if abs(self.target - Int(self.sliderValue.rounded())) <= 5 {
            title = "Nice Shot"
        } else if abs(self.target - Int(self.sliderValue.rounded())) <= 10 {
            title = "Pretty Good"
        } else if abs(self.target - Int(self.sliderValue.rounded())) <= 20 {
            title = "You Can Do Better"
        } else {
            title = "Not Your Best Shot"
        }
        return title
    }

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().previewLayout(.fixed(width: 896, height: 414))
    }
}
    
}
