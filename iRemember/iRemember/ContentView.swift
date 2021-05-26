//
//  ContentView.swift
//  iRemember
//
//  Created by Kevin Hoàng on 25.05.21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    var body: some View {
        TabView {
            PeopleList()
                .tabItem {
                    Label("Persons", systemImage: "person.fill")
                }
            
            PeopleMap()
                .tabItem {
                    Label("Map", systemImage: "map.fill")
                }
        }
        
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
