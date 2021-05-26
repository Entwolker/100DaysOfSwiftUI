//
//  HumanList.swift
//  iRemember
//
//  Created by Kevin Hoàng on 25.05.21.
//

import SwiftUI

struct PeopleList: View {
    
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Person.entity(), sortDescriptors: []) var people: FetchedResults<Person>
    
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(people, id: \.id) { person in
                    NavigationLink(destination: DetailView(person: person)) {
                        Text(person.name ?? "?")
                    }
                }
            }
            .navigationBarTitle("iRemember")
            .navigationBarItems(trailing: Button(action: {
                self.showingAddView = true
            }) {
                Image(systemName: "plus")
            })
            
            .sheet(isPresented: $showingAddView) {
                AddView()
                    .environment(\.managedObjectContext, self.moc)
            }
        }
    }
}

struct PeopleList_Previews: PreviewProvider {
    static var previews: some View {
        PeopleList()
    }
}
