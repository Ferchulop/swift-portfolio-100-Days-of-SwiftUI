//
//  GridLayout.swift
//  Project 8.MoonShot
//
//  Created by Fernando Jurado on 15/10/24.
//

import SwiftUI

struct GridLayout: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    var body: some View {
            ScrollView {
                LazyVGrid(columns: columns) {
                    ForEach(missions) { mission in
                        NavigationLink {
                            MissionView(mission: mission,astronauts: astronauts)
                        }label: {
                            VStack {
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100, height: 100)
                                    .padding()
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                    
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                            }
                            // Creo la personalizacion de la card
                            .clipShape(.rect(cornerRadius: 10))
                            .overlay (
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.lightBackground)
                                
                            )
                        }
                        
                    }
                }
                // Añado un espacio horizontal y desde abajo respecto a las demas cards
                .padding([.horizontal,.bottom])
            }
    
            .background(.darkBackground)
           
        }
}
        

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    GridLayout(missions: missions, astronauts: astronauts)
        .preferredColorScheme(.dark)
}

