//
//  Project12_FriendFaceApp.swift
//  Project12.FriendFace
//
//  Created by Fernando Jurado on 30/11/24.
//
import SwiftData
import SwiftUI

@main
struct Project12_FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
