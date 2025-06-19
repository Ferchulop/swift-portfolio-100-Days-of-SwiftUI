//
//  User.swift
//  Project16.TreasureMoment
//
//  Created by Fernando Jurado on 26/1/25.
//
import SwiftData
import Foundation
import SwiftUI

@Model
class User {
    var id = UUID()
    var name: String
    @Attribute(.externalStorage) var imageData: Data? // Indica que la imagen se guardará fuera de la base de datos principal 
    
    init(id: UUID = UUID(), name: String, imageData: Data) {
        self.id = id
        self.name = name
        self.imageData = imageData
    }
    
    
    static let example: User = {
        // Cargar una imagen desde el sistema y convertirla a Data
        if let image = UIImage(named: "profile_picture"),
           let imageData = image.jpegData(compressionQuality: 1.0) {
            return User(name: "Fernando", imageData: imageData)
        } else {
            // Si no se encuentra la imagen, crea un usuario con imageData
            let placeholderImage = UIImage(systemName: "person.circle")!
            let placeholderData = placeholderImage.jpegData(compressionQuality: 1.0)!
            return User(name: "Fernando", imageData: placeholderData )
        }
    }()
    
}

