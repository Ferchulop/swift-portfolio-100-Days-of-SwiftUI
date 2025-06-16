//
//  AddressView.swift
//  Project10. CupcakeCorner
//
//  Created by Fernando Jurado on 9/11/24.
//

import SwiftUI

struct AddressView: View {
    // Uso @Bindable para permitir que la vista se actualice automaticamente cuando los datos de un modelo cambian
    @Bindable var order: Order
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.userInformation.name)
                TextField("Address", text: $order.userInformation.streetAddress)
                TextField("City", text: $order.userInformation.city)
                TextField("Zip", text: $order.userInformation.zip)
                
            }
            Section {
                // Añado NavigationLink para ir a la vista de pago(CheckoutView)
                NavigationLink("Check Out") {
                    CheckoutView(order: order)
                }
            }
            // Si los campos de dirección estan vacíos deshabilito la opción de checkout 
            .disabled(order.hasValidAddress == false)
        }
        
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    AddressView(order: Order())
}
