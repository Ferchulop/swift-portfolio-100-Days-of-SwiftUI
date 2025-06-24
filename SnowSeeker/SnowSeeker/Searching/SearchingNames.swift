//
//  SearchingNames.swift
//  SnowSeeker
//
//  Created by Fernando Jurado on 20/6/25.
//

import SwiftUI

struct SearchingNames: View {
    @State private var searchText = ""
    let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]
    
    var filteredNames: [String] {
        
        if searchText.isEmpty {
            allNames
        } else {
            allNames.filter { name in
                // localiza los nombres ignorando mayus, minusc, como contains() pero más inteligente
                name.localizedStandardContains(searchText)
                
            }
            
        }
    }
    
    var body: some View {
        NavigationStack {
            // Muestra los resultados en una lista y puedes buscarlos  
            List(filteredNames, id: \.self) { name in
                Text(name)
            }
            // Modificador que aplica de forma nativa una barra de búsqueda
                    .searchable(text: $searchText, prompt: "Look for something")
                    .navigationTitle("Searching")
            }
    }
}

#Preview {
    SearchingNames()
}
