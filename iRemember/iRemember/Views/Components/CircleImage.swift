//
//  CircleImage.swift
//  iRemember
//
//  Created by Kevin Hoàng on 25.05.21.
//

import SwiftUI

struct CircleImage: View {
    var image: Image
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * 0.7, height: geo.size.height * 0.7)
                        .clipShape(Circle())
                        .overlay(
                            Circle().stroke(Color.secondary, lineWidth: 5)
                        )
                        .shadow(radius: 10)
                    Spacer()
                }
                Spacer()
            }
        }
    }
}

struct CircleImage_Previews: PreviewProvider {
    
    
    static var previews: some View {
        return CircleImage(image: Image("avatar-placeholder"))
    }
}
