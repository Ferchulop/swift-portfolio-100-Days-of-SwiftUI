//
//  DiceView.swift
//  RollDice
//
//  Created by Fernando Jurado on 17/6/25.
//

import SwiftUI

struct DiceView: View {
    var value: Int
    var rotation: Double
    var body: some View {
        Image(systemName: "die.face.\(value).fill")
            .resizable()
            .frame(maxWidth: 100, maxHeight: 100)
            .aspectRatio(1, contentMode: .fit)
            .rotation3DEffect(.degrees(rotation), axis: (x: 1, y: 0, z: 0))
            
    }
}


#Preview {
    DiceView(value: 1, rotation: 0)
}
