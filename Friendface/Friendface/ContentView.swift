//
//  ContentView.swift
//  Friendface
//
//  Created by Kevin Hoàng on 18.05.21.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users) { user in
                   NavigationLink(destination: UserView(user: user)) {
                        Text(user.name)
                    }
                }
                
            }
            .onAppear(perform: fetchData)
            .navigationTitle("Friendface")
        }
    }
    func fetchData() {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            
            let decoder = JSONDecoder()
            do {
                let decoded = try decoder.decode([User].self, from: data)
                DispatchQueue.main.async {
                    self.users = decoded
                }
            }
            catch { return }
        }
        task.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
