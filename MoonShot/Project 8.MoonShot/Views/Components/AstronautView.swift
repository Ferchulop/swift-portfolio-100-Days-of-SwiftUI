//
//  AstronautView.swift
//  Project 8.MoonShot
//
//  Created by Fernando Jurado on 14/10/24.
//

import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    var body: some View {
        ScrollView {
            VStack {
                Image(astronaut.id)
                    .resizable()
                    .scaledToFit()
                Text(astronaut.description)
                    .padding()
                
                
                
            }
            
        }
        .background(.darkBackground)
        .navigationTitle(astronaut.name)
        .navigationBarTitleDisplayMode(.inline)
        
    }
}

#Preview {
    let astronauts:[String: Astronaut] = Bundle.main.decode("astronauts.json")
    return  AstronautView(astronaut : astronauts["aldrin"]!)
        .preferredColorScheme(.dark)
}
