//
//  SearchBar.swift
//  iRemember
//
//  Created by Kevin Hoàng on 25.05.21.
//

import SwiftUI

struct SearchBar: UIViewRepresentable {
    
    @Binding var text: String
    
    class Coordinator: NSObject, UISearchBarDelegate {
        @Binding var text: String
        
        init(_ text: Binding<String>) {
            self._text = text
        }
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(self.$text)
    }
    
    func makeUIView(context: Context) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        
        searchBar.delegate = context.coordinator
        searchBar.searchBarStyle = .minimal
        
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: Context) {
        uiView.text = text
    }
    
}
