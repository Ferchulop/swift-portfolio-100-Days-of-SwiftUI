//
//  Project11_BookwormApp.swift
//  Project11.Bookworm
//
//  Created by Fernando Jurado on 19/11/24.
//
import SwiftData
import SwiftUI

@main
struct Project11_BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)// Configuro el entorno con modelcontainer para usar swiftData y asegurar que la clase book este disponible para la persistencia y gestión de datos de la app
    }
}
