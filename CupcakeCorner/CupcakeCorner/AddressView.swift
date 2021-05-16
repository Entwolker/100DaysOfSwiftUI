//
//  AddressView.swift
//  CupcakeCorner
//
//  Created by Kevin Hoàng on 16.05.21.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var order: Order
    
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.name)
                TextField("Street Address", text: $order.streetAddress)
                TextField("City", text: $order.city)
                TextField("Zip Code", text: $order.zip)
            }
            
            Section {
                NavigationLink(
                    destination: CheckoutView(order: self.order),
                    label: {
                        Text("Checkout")
                    }
                )
            }
            .disabled(order.hasValidDeliveryDetails == false)
        }
        .navigationBarTitle("Delivery details", displayMode: .inline)
    }
}

struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(order: Order())
    }
}
