//
//  ObservableEnvironment.swift
//  SnowSeeker
//
//  Created by Fernando Jurado on 20/6/25.
//

import SwiftUI
// El ejemplo muestra como un objeto puede ser observado por varias vistas
@Observable

class Player {
    var name = "Anonymous"
    var highScore = 0
    
}

struct HighScoreView: View {
    // Esta línea le dice a SwiftUI: “Oye, búscame un Player en la app, por favor”
    @Environment(Player.self) var player
    
    var body: some View {
        @Bindable var player = player
        Stepper("High score: \(player.highScore)", value: $player.highScore)
    }
}

struct ObservableEnvironment: View {
    @State private var player = Player()
    var body: some View {
        VStack {
            Text("Welcome!")
            HighScoreView()
            
        }
        // Esto pasa la instancia de Player a cualquier vista descendiente, como HighScoreView, sin tener que pasarlo manualmente por cada vista
        .environment(player)
    }
}

#Preview {
    ObservableEnvironment()
}
