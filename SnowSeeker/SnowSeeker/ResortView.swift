//
//  WelcomeView.swift
//  SnowSeeker
//
//  Created by Fernando Jurado on 22/6/25.
//

import SwiftUI

struct ResortView: View {
    let resort: Resort
    // Detecta si el dispositivo está en modo compacto(Por ej: iPhone en vertical)
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.dynamicTypeSize) var dynamicTypeSize
    @Environment(Favorites.self) var favorites
    @State private var showingFacility = false
    @State private var selectedFacility: Facility?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 0) {
                Image(decorative: resort.id)
                    .resizable()
                    .scaledToFit()
                HStack {
                    // Si el espacio horizontal es compacto y el texto es grande, se apilan verticalmente
                    if horizontalSizeClass == .compact && dynamicTypeSize > .large  {
                        VStack(spacing: 10) { ResortDetailsView(resort: resort) }
                        VStack(spacing: 10) { SkiDetailsView(resort: resort) }
                    } else {
                        // De lo contrario si hay espacio suficiente se apila en horizontal 
                        ResortDetailsView(resort: resort)
                        SkiDetailsView(resort: resort)
                    }
                    
                }
                .padding(.vertical)
                .background(.primary.opacity(0.1))
                .dynamicTypeSize(...DynamicTypeSize.xxxLarge) // modificador de vista que limita los tamaños de texto dinámico que puede usar esa vista
                Group {
                    Text(resort.description)
                        .padding(.vertical)
                    Text("Facilities")
                        .font(.headline)
                       
                    HStack {
                        ForEach(resort.facilityTypes) { facility in
                            Button {
                                selectedFacility = facility
                                showingFacility = true
                            } label: {
                                facility.icon
                                    .font(.title)
                            }
                        }
                    }
                    
                }
                .padding(.horizontal)
                 
                Button(favorites.contains(resort) ? "Remove from Favorites" : "Add to Favorites") {
                    if favorites.contains(resort) {
                        favorites.remove(resort)
                    } else {
                        favorites.add(resort)
                    }
                    
                }
                .buttonStyle(.borderedProminent)
                .padding()
            }
        }
        .navigationTitle("\(resort.name), \(resort.country)")
        .navigationBarTitleDisplayMode(.inline)
        // Mostrar alertas con las facilidades de las pistas
        .alert(selectedFacility?.name ?? "More information", isPresented: $showingFacility, presenting: selectedFacility) { _ in
        }message: { facility in
            Text(facility.description)
        }
    }
}

#Preview {
    ResortView(resort: .example)
        .environment(Favorites())
}
