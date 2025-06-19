//
//  codingRemove.swift
//  Project10. CupcakeCorner
//
//  Created by Fernando Jurado on 7/11/24.
//

import SwiftUI
// Esta clase mapea el nombre de usuario al formato JSON usando Codable.
@Observable
class User: Codable {
    enum CodingKeys: String, CodingKey {
        case _name = "name"
    }
    var name = "Taylor"
}


struct codingRemove: View {
    var body: some View {
        Button("Encode Taylor", action: encodeTaylor)
    }
    
    func encodeTaylor() {
        let data = try! JSONEncoder().encode(User())
        let str = String(decoding: data, as: UTF8.self)
        print(str)
    }
        
    }

#Preview {
    codingRemove()
}

