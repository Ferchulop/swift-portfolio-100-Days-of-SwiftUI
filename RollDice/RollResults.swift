//
//  RollResults.swift
//  RollDice
//
//  Created by Fernando Jurado on 18/6/25.
//

import SwiftData
import Foundation

@Model

class RollResults {
    
    var date: Date
    var numberOfDice: Int
    var total: Int
    
    init(date: Date, numberOfDice: Int, total: Int) {
        self.date = date
        self.numberOfDice = numberOfDice
        self.total = total
    }
    
   
}
extension RollResults {
    static func previewSample(date: Date, numberOfDice: Int, total: Int) -> RollResults {
        let result = RollResults(date: date, numberOfDice: numberOfDice, total: total)
        return result
    }

    static var previewData: [RollResults] {
        [
            .previewSample(date: .now, numberOfDice: 2, total: 7),
            .previewSample(date: .now.addingTimeInterval(-3600), numberOfDice: 4, total: 13)
        ]
    }
}
