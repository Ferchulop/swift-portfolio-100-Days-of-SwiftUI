//
//  Color-Theme.swift
//  Project 8.MoonShot
//
//  Created by Fernando Jurado on 7/10/24.
//

import SwiftUI

// ShapeStyle es la funcionalidad del protocolo, que describe los estilos aplicables a formas geometricas, como colores, gradientes...where Self == Color significa que esta extensión solo se aplica cuando el tipo que implementa el protocolo  ShapeStyle es Color 
extension ShapeStyle where Self == Color {
    
    static var darkBackground: Color {
        Color(red: 0.1, green: 0.1, blue: 0.2)
        
    }
    
    static var lightBackground: Color {
        Color(red: 0.2, green: 0.2, blue: 0.3)
    }
    
}
