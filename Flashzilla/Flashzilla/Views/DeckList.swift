//
//  DeckList.swift
//  Flashzilla
//
//  Created by Kevin Hoàng on 30.05.21.
//

import SwiftUI

struct DeckList: View {
    @EnvironmentObject var decks: Decks
    
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(decks.decks) { deck in
                    NavigationLink(destination: CardList(deck: deck)) {
                        Text(deck.name)
                    }
                }
                .onDelete(perform: remove)
            }
            .navigationBarTitle("Flashzilla")
            .navigationBarItems(trailing: EditButton())
            
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    Spacer()
                    Text("\(self.decks.decks.count) Decks")
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
            
            .sheet(isPresented: $showingSheet) {
                AddDeckView()
                    .environmentObject(decks)
            }
        }
    }
    
    func remove(at offsets: IndexSet) {
        self.decks.decks.remove(atOffsets: offsets)
    }
}

struct DeckList_Previews: PreviewProvider {
    
    static var previews: some View {
        DeckList()
    }
}
