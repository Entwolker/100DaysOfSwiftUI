//
//  RatingView.swift
//  Bookworm
//
//  Created by Kevin Hoàng on 17.05.21.
//

import SwiftUI

struct RatingView: View {
    @Binding var rating: Int
    var label = ""
    
    var maxRating = 5
    
    var offImage : Image?
    var onImage =  Image(systemName: "star.fill")
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            ForEach(1..<maxRating + 1) { number in
                self.image(for: number)
                    .foregroundColor(number > self.rating ? self.offColor :  self.onColor)
                    .onTapGesture {
                        self.rating = number
                    }
            }
        }
    }
    
    func image(for number: Int) -> Image {
        if number > rating {
            return offImage ?? onImage
        } else {
            return onImage
        }
    }
}

struct RatingView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RatingView(rating: .constant(4))
                .previewLayout(.sizeThatFits)
        }
    }
}
