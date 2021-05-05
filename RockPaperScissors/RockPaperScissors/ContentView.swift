//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Kevin Hoàng on 05.05.21.
//

import SwiftUI

struct ContentView: View {
    
    let moves = ["Rock", "Paper", "Scissors"]
    @State private var shouldWin = Bool.random()
    @State private var playerMove = 0
    @State private var botMove = 0
    @State private var playerScore = 0
    @State private var botScore = 0
    @State private var round = 1
    @State private var gameEnd = false
    
    var playerWon: Bool! {
        return playerScore > botScore
    }
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    ForEach(0..<moves.count) { move in
                        Button(
                            action: {moveMade(move)}
                        )
                        {
                            VStack {
                                Image(moves[move])
                                Text((moves[move]))
                            }                                    .foregroundColor(.primary)
                            
                        }
                        .padding()
                    }
                }
                HStack {
                    VStack {
                        Text("You")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        //Text(moves[playerMove])
                        Image(moves[playerMove])
                            .foregroundColor(.primary)
                        
                    }
                    .padding()
                    VStack {
                        Text("VS")
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                    VStack {
                        Text("Bot")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        //Text(moves[botMove])
                        Image(moves[botMove])
                            .foregroundColor(.primary)
                        
                    }
                    .padding()
                }
                HStack {
                    Spacer()
                    Text("\(playerScore)")
                    Text("Round \(round)")
                    Text("\(botScore)")
                    Spacer()
                }
                .font(.title)
            }
            
            .alert(isPresented: $gameEnd) {
                Alert(title: Text(playerWon == true ? "You won🏆" : "You lost❌"), dismissButton: .default(Text("Play again")) {
                    endGame()
                })
            }
            .navigationTitle("Rock paper scissors")
        }
    }
    
    func moveMade(_ move: Int) {
        if round > 8 {
            chooseWinner(move)
            gameEnd = true
        }
        else {
            chooseWinner(move)
        }
    }
    
    func chooseWinner(_ move: Int) {
        if shouldWin == true {
            botMove = loose(loose: move)
            playerScore += 1
        }
        else {
            botMove = counterMove(counter: move)
            botScore += 1
        }
        playerMove = move
        shouldWin = Bool.random()
        round += 1
    }
    
    
    func endGame() {
        round = 1
        playerScore = 0
        botScore = 0
    }
    
    func counterMove(counter move: Int) -> Int {
        switch move {
        case 0: return 1
        case 1: return 2
        default: return 0
        }
    }
    
    func loose(loose move: Int) -> Int {
        switch move {
        case 0: return 2
        case 1: return 0
        default: return 1
        }
    }
    
    func draw(draw move: Int) -> Int {
        return move
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
