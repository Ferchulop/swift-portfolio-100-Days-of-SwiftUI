//
//  ContentView.swift
//  Project10. CupcakeCorner1
//
//  Created by Fernando Jurado on 9/11/24.
//

import SwiftUI

struct ContentView: View {
    // Se crea un @State para la clase Order que he instanciado con valores predeterminados, lo que permite que se cambie automaticamente esta propiedad
    @State private var order = Order()
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.type) {
                        ForEach(Order.types.indices, id: \.self) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cakes:  \(order.quantity)", value: $order.quantity, in: 3...20 )
                }
                // Seccion para activar o desactivar las solicitudes especiales
                Section {
                    Toggle("Any special requests?", isOn: $order.specialRequestEnabled)
                    // Si specialRequestEnabled esta habilitado muestro las opciones de glaseado y espolvoreado
                    if order.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.extraFrosting)
                        Toggle("Add extra sprinkles", isOn: $order.addSprinkles)
                    }
                }
                Section {
                    // Añado NavigationLink para ir a la vista AddresView donde esta toda la info personal del cliente
                    NavigationLink("Delivery details") {
                        AddressView(order: order)
                    }
                }
                
            }
            .navigationTitle("Cupcake Corner")
            
        }
    }
}

#Preview {
    ContentView()
}
