//
//  asyncWaitSession.swift
//  Project10. CupcakeCorner
//
//  Created by Fernando Jurado on 7/11/24.
//

import SwiftUI
// Defino el struct para posteriormente decodificar la respuesta de la API, le digo que sea Codable para poder convertir la respuesta en objetos de Travis Scott
struct Response: Codable {
    var results: [Result]
}
// Defino el struct Result para representar cada elemento de la lista que posteriormente creo
struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}
struct asyncWaitSession: View {
    // Uso @State para almacenar cada uno de los resultados obtenidos de la API
    @State private  var results = [Result] ()
    
    var body: some View {
        List(results, id: \.trackId) { item in
            VStack(alignment: .leading) {
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
                
            }
        }
        // Ejecuto la tarea asíncrona para cargar los datos cuando la vista se muestre
        .task {
            await loadData() // Solicito los datos llamando a mi funcion
        }
    }
    // Esta funcion asíncrona se encarga de llamar a la API de Itunes
func loadData() async {
    
    // Me aseguro de que la URL sea valida, si no lanzo un error por consola.
    guard let  url = URL(string: "https://itunes.apple.com/search?term=travis+scott&entity=song") else {
        print("Invalid URL")
        return
    }
    // Uso bloque do catch para intentar solicitar los datos a la URL de forma asíncrona
    do {
        // Realizo la solicitud a la API y recibo los datos
        let(data,_) = try await URLSession.shared.data(from: url)
        // Decodifico el JSON en una instancia de Response y asigno estos resultados posteriormente  decodificados a la propiedad results
        if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
            results = decodedResponse.results
        }
        
        
    } catch {
        print("Invalid data")
        
        
    }
        
    }
    
}

#Preview {
    asyncWaitSession()
}

