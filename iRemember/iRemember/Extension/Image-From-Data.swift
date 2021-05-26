//
//  Image-From-Data.swift
//  iRemember
//
//  Created by Kevin Hoàng on 25.05.21.
//

import SwiftUI

extension Image {
    static func fromData(_ data: Data) -> Image {
        
        guard let uiImage = UIImage(data: data) else {
            return Image("avatar-placeholder")
        }
        return Image(uiImage: uiImage)
    }
}

