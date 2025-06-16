//
//  ContentView.swift
//  Project 8.MoonShot
//
//  Created by Fernando Jurado on 4/10/24.
//

import SwiftUI
// CHALLENGE 3: For a tough challenge, add a toolbar item to ContentView that toggles between showing missions as a grid and as a list.struct ContentView: View {
struct ContentView: View {
    
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    // Añado el estado para mostrar cuadricula(true) o lista (false)
    @State private var showingGrid = true
    var body: some View {
        NavigationView {
            // Utilizo group para agrupar varias vistas juntas sin afectar el diseño
            Group {
                if showingGrid {
                    GridLayout(missions: missions,astronauts: astronauts)
                } else {
                    ListLayout(missions: missions,astronauts: astronauts)
                }
            }
            // Añado barra de herramientas para poder elegir entro modo lista o modo cuadricula
            .toolbar {
                // Añado item en la barra superior derecha
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingGrid.toggle()
                    } label: {
                        Label( showingGrid ? "List View" : "Grid View", systemImage: showingGrid ? "list.dash" : "square.grid.2x2")
                    }
                    .foregroundStyle(.white)
                }
            }
            .navigationTitle("MoonShot")
        }
        .preferredColorScheme(.dark) // Para mostrar de manera predefinida el modo oscuro, y asi poder ver el titulo utilizamos el modificador .preferred
    }
  
}
#Preview {
    ContentView()
}

