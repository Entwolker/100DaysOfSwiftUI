//
//  UserModel.swift
//  Friendface
//
//  Created by Kevin Hoàng on 18.05.21.
//

import Foundation

struct User: Codable, Identifiable {
    let id = UUID()
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: String
    let tags: [String]
    let friends: [Friend]
}

struct Friend: Codable, Identifiable {
    let id = UUID()
    let name: String
}
