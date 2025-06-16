//
//  Astronaut.swift
//  Project 8.MoonShot
//
//  Created by Fernando Jurado on 6/10/24.
//

import Foundation
// Se define el modelo del astronauta
struct Astronaut: Codable, Identifiable {
    let id: String
    let name: String
    let description: String
}
