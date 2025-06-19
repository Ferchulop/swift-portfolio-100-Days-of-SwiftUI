//
//  Friend.swift
//  Project12.FriendFace
//
//  Created by Fernando Jurado on 30/11/24.
//
import SwiftData
import Foundation
@Model
class Friends: Codable {
    var id: UUID
    var name: String
    
    enum CodingKeys: CodingKey {
        case id
        case name
    }
    
    init (id: UUID, name: String) {
        self.id = id
        self.name = name
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
    }
}
