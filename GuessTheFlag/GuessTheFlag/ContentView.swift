//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Kevin Hoàng on 04.05.21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle  = ""
    
    var body: some View {
        ZStack {
            Color.green.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                VStack {
                    Text("Tap the flag of")
                    Text(countries[correctAnswer])
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                .foregroundColor(.white)
                .padding()
                
                ForEach(0..<3) {number in
                    Button(action: {
                        self.flagTapped(number)
                    }) {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 2)
                    }
                }
                Spacer()
            }
            .padding(.top, 25.0)
            
            .alert(isPresented: $showingScore) {
                Alert(title: Text(scoreTitle), dismissButton: .default(Text("Play again")) {
                    askQuestion()
                })
            }
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct✅"
        } else {
            scoreTitle = "Wrong🔴"
        }
        
        showingScore = true
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
