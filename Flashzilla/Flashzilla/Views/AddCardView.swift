//
//  AddCardView.swift
//  Flashzilla
//
//  Created by Kevin Hoàng on 31.05.21.
//

import SwiftUI

struct AddCardView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var deck: Deck
    
    @State private var promt = ""
    @State private var answer = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Prompt", text: $promt)
                    TextField("Answer", text: $answer)
                }
                Section {
                    Button("Save Card") {
                        let card = Card(prompt: self.promt, answer: self.answer)
                        
                        self.deck.cards.append(card)
                        
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Add Card")
            .navigationBarItems(trailing: Button("Cancel") {
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddCardView_Previews: PreviewProvider {
    static var previews: some View {
        AddCardView(deck: Deck(name: "Capitals", cards: [Card](repeating: Card.example, count: 10)))
    }
}
