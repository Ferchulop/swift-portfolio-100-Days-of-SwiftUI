//
//  Book.swift
//  Project11.Bookworm
//
//  Created by Fernando Jurado on 20/11/24.
//

import Foundation
import SwiftData

// @Model para que la clase sea reconocida por SwiftData y poder almacenar, consultar y gestionar datos automaticamente en una base de datos
@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    var date: Date // CHALLENGE 3:
    
   // Inicializador para configurar las propiedades de la clase libro
    init(title: String, author: String, genre: String, review: String, rating: Int, date: Date) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        self.date = date
    }
    
}
