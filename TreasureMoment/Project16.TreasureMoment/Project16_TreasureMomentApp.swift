//
//  Project16_TreasureMomentApp.swift
//  Project16.TreasureMoment
//
//  Created by Fernando Jurado on 24/1/25.
//
import SwiftData
import SwiftUI

@main
struct Project16_TreasureMomentApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
