//
//  DetailView.swift
//  iRemember
//
//  Created by Kevin Hoàng on 25.05.21.
//

import CoreData
import SwiftUI

struct DetailView: View {
    
    let person: Person
        
    var body: some View {
        VStack {
            CircleImage(image: Image.fromData(person.picture!))
        }
        navigationBarTitle("Details", displayMode: .inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    static let uiImage = UIImage(named: "avatar-placeholder")

    
    static var previews: some View {
        
        let person = Person(context: self.moc)
        person.name = "John Appleseed"
        person.email = "appleseed@apple.com"
        person.event = "WWDC '19"
        person.latitude = 37.33182
        person.longitude = -122.03118
        person.picture = uiImage?.jpegData(compressionQuality: 0.8)
        
        return DetailView(person: person)
    }
}
