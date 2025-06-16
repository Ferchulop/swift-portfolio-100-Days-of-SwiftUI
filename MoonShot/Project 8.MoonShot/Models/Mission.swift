//
//  Mission.swift
//  Project 8.MoonShot
//
//  Created by Fernando Jurado on 6/10/24.
//

import Foundation
// Se define el modelo de la misión
struct Mission: Codable, Identifiable {
    struct CrewRole: Codable {
        let name: String
        let role: String
        
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
        
    }
    var image: String {
        "apollo \(id)"
    }
    var formattedLaunchDate: String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
