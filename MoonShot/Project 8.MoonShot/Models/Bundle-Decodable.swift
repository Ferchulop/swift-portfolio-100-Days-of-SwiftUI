//
//  Bundle-Decodable.swift
//  Project 8.MoonShot
//
//  Created by Fernando Jurado on 6/10/24.
//

import Foundation
// Extension de Bundle para decodificar archivos JSON
extension Bundle {
    // Con el fin de reusar el código de una manera más eficiente hago uso de swift generic aplicando un metodo generico diciendole que es de tipo Codable: <T: Codable> donde "T" puede ser cualquier otra variable que yo elija
    func decode<T: Codable> (_ file: String) -> T {
        // Tratamos de encontrar el archivo
        guard let url = self.url(forResource: file, withExtension: nil)
                
        else {
            // Si no se ha localizado lanzamos un error, fatalError
            fatalError("Failed to locate \(file) from bundle.")
        }
        // Tratamos de cargar el archivo JSON
        guard let data = try? Data(contentsOf: url)
                // Si no se ha podido cargar lanzamos un error, fatalError
        else {
            fatalError("Failed to load \(file) from bundle.")
        }
        // Tratatamos de decodificar el archivo JSON
        let decoder = JSONDecoder()
        // Formateo la fecha para visualizarla de la siguiente manera: "y-MM-dd"
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
    
        
        // 1. Sustituyo esta linea por el bloque do catch -> 2
        /*
         // Intentamos decodificar el archivo
         guard let loaded = try? decoder.decode([String: Astronaut].self, from: data)
         
         else {
         // Si no ha sido posible decodificar volvemos a lanzar un error, fatalError
         fatalError("Failed to decode \(file) from bundle.")
         }
         
         return loaded*/
        
        // 2. Manejaremos con un bloque do catch todos los posibles errores
        
        do {
            // Intenta decodificar los datos JSON en un diccionario de astronaut usando el decodificador, si tiene exito la decodificacion devuelve el resultado
            // Aplico el method generic y lo sustityo por [String: Astronaut] diciendo que mi variable es T.self
            return try decoder.decode(T.self, from: data)
            // Captura el error si alguna clave JSON falta durante la decodificacion
        } catch  DecodingError.keyNotFound(let key, let context) {
            //Muestra su nombre y el contexto del error
            fatalError("Failed to decode\(file) from bundle due to missing key '\(key.stringValue)' - \(context.debugDescription)")
            //Captura el error si el tipo de dato JSON no coincide con el tipo esperado
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch  - \(context.debugDescription)")
            // Captura el error si un valor esperado en el JSON no se encuentra
        } catch DecodingError.valueNotFound(let type, let context) {
            // Muestra el tipo de valor que falta
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value - \(context.debugDescription)")
            // Captura el error si los datos JSON estan corruptos o mal estructurados
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON. ")
            
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
        
        
        
    }
    
}
