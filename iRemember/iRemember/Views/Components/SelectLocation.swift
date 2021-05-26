//
//  SelectLocation.swift
//  iRemember
//
//  Created by Kevin Hoàng on 25.05.21.
//

import MapKit
import SwiftUI

struct SelectLocation: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @Binding var centerCoordinate: CLLocationCoordinate2D
    
    var body: some View {
        
        return ZStack {
            MapView(centerCoordinate: $centerCoordinate)
                .edgesIgnoringSafeArea(.all)
            
            Circle()
                .fill(Color.gray)
                .frame(width: 30)
                .opacity(0.3)
            
        }
        .navigationBarTitle("Select location", displayMode: .inline)
        .navigationBarItems(trailing: Button("Done") {
            self.presentationMode.wrappedValue.dismiss()
        })
        
    }
}

struct SelectLocation_Previews: PreviewProvider {
    static var previews: some View {
        SelectLocation(centerCoordinate: .constant(MKPointAnnotation.example.coordinate))
    }
}
