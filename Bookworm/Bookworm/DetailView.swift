//
//  DetailView.swift
//  Bookworm
//
//  Created by Kevin Hoàng on 17.05.21.
//

import SwiftUI
import CoreData

struct DetailView: View {
    let book: Book
    
    var body: some View {
        GeometryReader { geo in
            VStack(alignment: .leading) {
                Image(book.genre ?? "Fantasy")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width)
                
                Text(book.author ?? "Unknown author")
                    .font(.title)
                Text(book.genre ?? "Unknown genre")
                    .font(.caption)
                    .foregroundColor(.secondary)
                RatingView(rating: .constant(Int(book.rating)))
                    .padding()
                Text(book.review ?? "No review")
            }
        }
        .navigationBarTitle(book.title ?? "Unknown book", displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This is a great book :D"
        return DetailView(book: book)
    }
}
