//
//  CheckoutView.swift
//  Project10. CupcakeCorner
//
//  Created by Fernando Jurado on 9/11/24.
//

import SwiftUI

struct CheckoutView: View {
    var order: Order
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var showingError = false
    @State private var errorMessage = ""
    
    var body: some View {
        ScrollView {
            VStack {
                // Carga y muestra imagen de cupcakes desde una URL de forma asíncrona
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()
                        .accessibilityHidden(true)
                }placeholder: {
                    ProgressView() // Muestra imagen de indicador de carga mientras la imagen se descarga para su visualización
                        .accessibilityHidden(true)
                }
                .frame(height: 233)
                
                Text("Your total cost is: \(order.cost,format: .currency(code:"EUR"))")
                
                Button("Place Order") {
                    Task { // LLama a la tarea asíncrona
                        await placeOrder() // Se ejecuta la función y espera a completar su tarea. Await suspende esta ejecución hasta que la func termine su tarea(enviar pedido y recibir respuesta del servidor)
                    }
                }
                .padding()
                .buttonStyle(.borderedProminent)
            }
            .accessibilityElement()
            .accessibilityLabel("Your order costs \(order.cost,format: .currency(code:"EUR"))")
            
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)// Controlo el efecto rebote de ScrollView
        // Alerta para confirmación pedido
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") { }
            
        } message: {
            Text(confirmationMessage)
        }
        // Alerta para conexión internet
        .alert("Error", isPresented: $showingError) {
            Button("OK") { }
            
        } message: {
            Text(errorMessage)
        }
    }
    // Función para realizar el pedido de forma asíncrona
    func placeOrder() async {
        // Se codifica la orden en formato JSON, manejando su error en caso de fallo
        guard let encoded = try? JSONEncoder().encode(order) else {
            
            print("Failed to encode order")
            return
        }
        // Se define la URL del servidor donde se enviará la orden
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST" // Se envían los datos al servidor para procesarlos con el método POST
        do {
            // Con await la ejecución se suspende en el servidor hasta que upload completa la operación
            let (data, _) = try await URLSession.shared.upload(for: request, from: encoded) // Si los datos son recibidos sin errores se decodifica la respuesta en un objeto de "Order"
            let decodedOrder = try JSONDecoder().decode(Order.self, from: data)
            confirmationMessage = "Order placed successfully: \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on the way!" // Se actualiza el mensaje de confirmación y se muestra la alerta del pedido completado
            showingConfirmation = true
            
        } catch {
            print("Check out failed: \(error.localizedDescription)")
            // CHALLENGE 2:
            errorMessage = "Please check your internet connection and try again. "
            showingError = true
        }
        
        
    }
}

#Preview {
    CheckoutView(order: Order())
}
