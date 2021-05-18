//
//  EmojiRatingView.swift
//  Bookworm
//
//  Created by Kevin Hoàng on 17.05.21.
//

import SwiftUI

struct EmojiRatingView: View {
    let raiting: Int16
    
    var body: some View {
        switch raiting {
        case 1:
            return Text("💩")
        case 2:
            return Text("👎")
        case 3:
            return Text("☝️")
        case 4:
            return Text("👍")
        default:
            return Text("👌")
        }
    }
}

struct EmojiRatingView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiRatingView(raiting: 4)
            .previewLayout(.sizeThatFits)
    }
}
