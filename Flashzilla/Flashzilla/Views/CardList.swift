//
//  CardList.swift
//  Flashzilla
//
//  Created by Kevin Hoàng on 30.05.21.
//

import SwiftUI

struct CardList: View {
    
    @State var deck: Deck
    
    @State private var showingSheet = false
    
    var body: some View {
        List(deck.cards) { card in
            Text(card.answer)
        }
        .navigationBarTitle(deck.name, displayMode: .inline)
        .navigationBarItems(trailing: EditButton())
        
        .toolbar {
            ToolbarItemGroup(placement: .bottomBar) {
                Spacer()
                Text("\(self.deck.cards.count) Cards")
                    .foregroundColor(.secondary)
                    .font(.caption)
                Spacer()
                Button(action: {
                    self.showingSheet = true
                }) {
                    Image(systemName: "plus")
                }
            }
        }
        
        .sheet(isPresented: $showingSheet, onDismiss: {
            print(self.deck.cards)
        }) {
            AddCardView(deck: self.deck)
        }
    }
}

struct CardList_Previews: PreviewProvider {
    static var previews: some View {
        CardList(deck: Deck(name: "Capitals", cards: [Card](repeating: Card.example, count: 10)))
    }
}
