//
//  Order.swift
//  Project10. CupcakeCorner
//
//  Created by Fernando Jurado on 9/11/24.
//
import Foundation


// CHALLENGE 3: For a more challenging task, try updating the Order class so it saves data such as the user's delivery address to UserDefaults. This takes a little thinking, because @AppStorage won't work here, and you'll find getters and setters cause problems with Codable support. Can you find a middle ground?
struct UserInformation: Codable {
     var name = ""
     var streetAddress = ""
     var city = ""
     var zip = ""
}
@Observable
class Order: Codable {
    // Mapeo los resultados de las propiedades para que el servidor los interprete correctamente
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _userInformation = "userInformation"
        /*case _name = "name"
        case _streetAddress = "streetAddress"
        case _city = "city"
        case _zip = "zip"*/
    }
    
    static let types = ["Chocolate", "Vanilla", "Strawberry", "Blueberry",]
    
    var type = 0
    var quantity  = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
        
    }
    
    var extraFrosting = false
    
    var addSprinkles = false
    
    var userInformation: UserInformation {
        didSet {
            if let encoded = try? JSONEncoder().encode(userInformation) {
                UserDefaults.standard.set(encoded, forKey: "userInformation")
            }
        }
    }
   init() {
        if let userAddress = UserDefaults.standard.data(forKey: "userInformation") {
           if let decodedInfo = try? JSONDecoder().decode(UserInformation.self, from: userAddress) {
                userInformation = decodedInfo
               return
            }
       }
       userInformation = UserInformation()
    }
    
    
    // Añado una propiedad con condicional para manejar la posibilidad de un campo vacío en la vista de pago
    
    //CHALLENGE 1: Our address fields are currently considered valid if they contain anything, even if it’s just only whitespace. Improve the validation to make sure a string of pure whitespace is invalid.
    var hasValidAddress: Bool {
        if  userInformation.name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || userInformation.streetAddress.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || userInformation.city.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || userInformation.zip.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        return true
    }
    // Añado propiedad para manejar el coste de los ingredientes extra y su coste añadido dependiendo de su elección
    var cost: Decimal {
        
        var cost = Decimal(quantity) * 2
        
        cost += Decimal(type) / 2
        
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        return cost
        
        
    }
}
