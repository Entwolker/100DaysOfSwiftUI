//
//  Card.swift
//  Flashzilla
//
//  Created by Kevin Hoàng on 30.05.21.
//

import Foundation

struct Card: Codable, Comparable, Identifiable {
    var id = UUID()
    var prompt: String
    var answer: String
    var score: Int = 0
    
    static func < (lhs: Card, rhs: Card) -> Bool {
        return lhs.score < rhs.score
    }

    
    static var example: Card {
        Card(prompt: "Whats the capital of Germany?", answer: "Berlin", score: 0)
    }
}
