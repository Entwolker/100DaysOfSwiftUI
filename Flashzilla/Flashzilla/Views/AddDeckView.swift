//
//  AddDeckView.swift
//  Flashzilla
//
//  Created by Kevin Hoàng on 30.05.21.
//

import SwiftUI

struct AddDeckView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @EnvironmentObject var decks: Decks
    
    @State private var name = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of the Deck", text: $name)
                }
                
                Section {
                    Button("Save Deck") {
                        
                        let deck = Deck(name: name, cards: [])
                        
                        self.decks.decks.append(deck)
                        self.presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Add Deck")
            .navigationBarItems(trailing: Button("Cancel") {
                self.presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

struct AddDeckView_Previews: PreviewProvider {
    static var previews: some View {
        AddDeckView()
    }
}
