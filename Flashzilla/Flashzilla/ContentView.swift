//
//  ContentView.swift
//  Flashzilla
//
//  Created by Kevin Hoàng on 29.05.21.
//

import SwiftUI

struct ContentView: View {
    
    var decks = Decks()
    
    var body: some View {
            DeckList()
                .environmentObject(decks)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
