//
//  RollDiceApp.swift
//  RollDice
//
//  Created by Fernando Jurado on 17/6/25.
//
import SwiftData
import SwiftUI

@main
struct RollDiceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                
        }
        .modelContainer(for: RollResults.self)
    }
}
