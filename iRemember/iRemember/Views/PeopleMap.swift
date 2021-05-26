//
//  PeopleMap.swift
//  iRemember
//
//  Created by Kevin Hoàng on 25.05.21.
//

import MapKit
import SwiftUI

struct PeopleMap: View {
            
    var body: some View {
        VStack {
            MapView(centerCoordinate: .constant(MKPointAnnotation.example.coordinate))
        }
    }

}

struct PeopleMap_Previews: PreviewProvider {
    static var previews: some View {
        PeopleMap()
    }
}
