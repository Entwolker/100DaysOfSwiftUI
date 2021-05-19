//
//  UserView.swift
//  Friendface
//
//  Created by Kevin Hoàng on 18.05.21.
//

import SwiftUI

struct UserView: View {
    let user: User
    @State private var users = [User]()
    
    
    var body: some View {
        GeometryReader { geo in
            List {
                Section(header: Text("About")) {
                    HStack {
                        Text("Name:")
                            .font(.headline)
                            .frame(width: geo.size.width / 4)

                        
                        HStack {
                            Text(user.name)

                            if user.isActive == true {
                                Text("🟢")
                                    .font(.caption)
                            }
                        }
                    }
                    HStack {
                        Text("Age:")
                            .font(.headline)
                            .frame(width: geo.size.width / 4)

                        Text("\(user.age)")
                    }
                    HStack {
                        Text("E-Mail:")
                            .font(.headline)
                            .frame(width: geo.size.width / 4)
       
                        Text(user.email)
                    }
                    HStack {
                        Text("Address:")
                            .font(.headline)
                            .frame(width: geo.size.width / 4)

                        Text(user.address)
                    }
                    HStack {
                        Text("Company:")
                            .font(.headline)
                            .frame(width: geo.size.width / 4)

                        Text(user.company)
                    }
                    HStack(alignment: .top) {
                        Text("Info")
                            .font(.headline)
                            .frame(width: geo.size.width / 4)

                        Text(user.about)
                    }
                    HStack {
                        
                        Text("Registered:")
                            .font(.headline)
                            .frame(width: geo.size.width / 4)
                 
                        Text(user.registered)
                    }
                }
            }
            
            //            Section(header: Text("Friends")) {
            //                ForEach(user.friends) { friend in
            //                    NavigationLink(destination: UserView(user: getUser(from: friend) ?? User(isActive: true, name: "John Appleseed", age: 40, company: "Apple", email: "appleseed@apple.com", address: "One Apple Park Way, Cupertino, CA 95014", about: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.", registered: "29th June, 2007", tags: ["appler", "nature", "male"], friends: []))) {
            //                        Text(friend.name)
            //                            .font(.headline)
            //                    }
            //                }
            //            }
            .navigationBarTitle("Details", displayMode: .inline)
        }
    }
    
    //    func getUser(from friend: Friend) -> User? {
    //        for i in self.user.friends {
    //            if let friend = self.user.friends.first(where: {i.id == $0.id}) {
    //                for j in self.users{
    //                    if let user = self.users.first(where: {j.id == $0.id}) {
    //                        return user
    //                    }
    //                }
    //            }
    //        }
    //        return nil
    //    }
    //
    //    func fetchData() {
    //        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else { return }
    //        let task = URLSession.shared.dataTask(with: url) { data, response, error in
    //            guard let data = data, error == nil else { return }
    //
    //            let decoder = JSONDecoder()
    //            do {
    //                let decoded = try decoder.decode([User].self, from: data)
    //                DispatchQueue.main.async {
    //                    self.users = decoded
    //                }
    //            }
    //            catch { return }
    //        }
    //        task.resume()
    //    }
    
    
    struct UserView_Previews: PreviewProvider {
        static let friend = Friend(name: "Hawkins Patel")
        static let friend2 = Friend(name: "Jewel Sexton")
        static let friend3 = Friend(name: "Berger Robertson")
        static let user = User(isActive: true, name: "John Appleseed", age: 40, company: "Apple", email: "appleseed@apple.com", address: "One Apple Park Way, Cupertino, CA 95014", about: "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.", registered: "29th June, 2007", tags: ["appler", "nature", "male"], friends: [friend, friend2, friend3])
        static var previews: some View {
            UserView(user: user)
        }
    }
}
