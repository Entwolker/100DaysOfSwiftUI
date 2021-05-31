//
//  Deck.swift
//  Flashzilla
//
//  Created by Kevin Hoàng on 30.05.21.
//

import SwiftUI
import Foundation

class Decks: ObservableObject, Codable {
    @Published var decks: [Deck]! {
        didSet {
            saveData()
        }
    }
    
    enum CodingKeys: CodingKey {
        case decks
    }
    
    init() {
        loadData()
    }
    
    required init(from decoder: Decoder) throws {
        let container = try? decoder.container(keyedBy: CodingKeys.self)
        decks = try container?.decode([Deck].self, forKey: .decks)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(decks, forKey: .decks)
    }
    
    func loadData() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedDecks")
        
        do {
            let data = try Data(contentsOf: filename)
            self.decks = try JSONDecoder().decode([Deck].self, from: data)
        } catch {
            self.decks = [Deck]()
        }
    }
    
    func saveData() {
        let filename = getDocumentsDirectory().appendingPathComponent("SavedDecks")
        
        do {
            let data = try JSONEncoder().encode(self.decks)
            try data.write(to: filename, options: .atomicWrite)
        } catch {
            print("Failed to encode decks: \(error.localizedDescription)")
        }
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
}

struct Deck: Codable, Identifiable {
    var id = UUID()
    var name: String
    var cards: [Card]
}
