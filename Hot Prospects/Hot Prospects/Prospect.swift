//
//  Prospect.swift
//  Hot Prospects
//
//  Created by Kevin Hoàng on 26.05.21.
//

import SwiftUI

class Prospect: Identifiable, Codable {
    var id = UUID()
    var name = "Anonymous"
    var email = ""
    fileprivate(set) var isContacted = false
}

class Prospects: ObservableObject {
    @Published var people: [Prospect]
    
    init() {
        
        if let data = UserDefaults.standard.data(forKey: "SavedData") {
            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
                self.people = decoded
                return
            }
        }
        self.people = []
    }
    
    func saveData() {
        if let encoded = try? JSONEncoder().encode(self.people) {
            UserDefaults.standard.setValue(encoded, forKey: "SavedData")
        }
    }
    
    func toggle(_ propect: Prospect) {
        objectWillChange.send()
        propect.isContacted.toggle()
        saveData()
    }
}
