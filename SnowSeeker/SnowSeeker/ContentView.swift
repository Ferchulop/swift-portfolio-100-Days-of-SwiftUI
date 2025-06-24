//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Fernando Jurado on 20/6/25.
//

import SwiftUI

struct ContentView: View {
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var searchText = ""
    
    @State private var favorites = Favorites()
    
    
    var filteredResorts: [Resort] {
        if searchText.isEmpty {
            resorts
        } else {
            resorts.filter {$0.name.localizedStandardContains(searchText)}
        }
    }
    var body: some View {
        NavigationSplitView {
            List(filteredResorts) { resort in
                NavigationLink(value: resort) {
                    HStack {
                        Image(resort.country)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 25)
                            .clipShape(.rect(cornerRadius: 5))
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(.black, lineWidth: 1)
                                
                            )
                        VStack(alignment: .leading) {
                            Text(resort.name)
                                .font(.headline)
                            Text("\(resort.runs) runs")
                                .foregroundStyle(.secondary)
                        }
                        // Añadir corazón en la lista cuando pulsas el botón "Add to favorites"
                        if favorites.contains(resort) {
                            Spacer()
                            Image(systemName: "heart.fill")
                                .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                        }
                    }
                }
            }
            .navigationTitle("Resorts")
            .navigationDestination(for: Resort.self) { resort in
                ResortView(resort: resort)
            }
            //Modificador para añadir buscador y poder filtrar las busquedas
            .searchable(text: $searchText, prompt: "Search for resorts")
        } detail: {
            Text("Welcome to SnowSeeker")
                .font(.largeTitle)
            Text("Please select a resort from the left-hand menu; swipe from the edge to show it.")
                .foregroundStyle(.secondary)

        }
        .environment(favorites)
    }
}

#Preview {
    ContentView()
}
