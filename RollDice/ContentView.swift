//
//  ContentView.swift
//  RollDice
//
//  Created by Fernando Jurado on 17/6/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
            TabView  {
                Tab("Play Dice", systemImage: "gamecontroller.fill") {
                    RollPlayView()
                }
                Tab("Results", systemImage: "list.bullet.clipboard.fill") {
                    ResultsView()
                    
                }
                
            }
            
        }
      
    }

#Preview {
    ContentView()
            .modelContainer(for: RollResults.self)
    
}
