//
//  ContentView.swift
//  Bookworm
//
//  Created by Kevin Hoàng on 17.05.21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity: Book.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Book.title, ascending: true), NSSortDescriptor(keyPath: \Book.author, ascending: true)]) var books: FetchedResults<Book>
    
    @State private var showingaddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(books, id: \.self) { book in
                    NavigationLink(destination: DetailView(book: book)) {
                        EmojiRatingView(raiting: book.rating ?? 3)
                            .font(.largeTitle)
                        VStack {
                            Text(book.title ?? "Unknown title")
                                .font(.headline)
                            Text(book.author ?? "Unknown author")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationTitle("Bookworm")
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button(action: {
                self.showingaddScreen = true
            }) {
                Image(systemName: "plus")
            })
        }
        .sheet(isPresented: $showingaddScreen) {
            AddBookView().environment(\.managedObjectContext, moc)
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            moc.delete(book)
        }
        try? moc.save()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
