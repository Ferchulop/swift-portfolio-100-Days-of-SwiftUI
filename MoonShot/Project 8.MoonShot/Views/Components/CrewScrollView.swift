//
//  CrewScrollView.swift
//  Project 8.MoonShot
//
//  Created by Fernando Jurado on 15/10/24.
//

import SwiftUI

struct CrewScrollView: View {
    let crew: [MissionView.CrewMember]
        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(crew, id: \.role) { crewMember in
                        NavigationLink {
                            AstronautView(astronaut: crewMember.astronaut)
                        } label: {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 104, height: 72)
                                    .clipShape(.capsule)
                                    .overlay(Capsule()
                                        .strokeBorder(.white,lineWidth: 1)
                                    )
                                
                                // Añado su nombre y su rol en la mision
                                VStack(alignment: .leading) {
                                    Text(crewMember.astronaut.name)
                                        .foregroundStyle(.white)
                                        .font(.headline)
                                    Text(crewMember.role)
                                        .foregroundStyle(.white,.opacity(0.2))
                                
                                    
                                }
                            }
                            .padding(.horizontal)
                        }
                        
                    }
                    
                }
            }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let crew = missions [0].crew.map { member in
        if let astronaut = astronauts [member.name] {
            return MissionView.CrewMember(role: member.role, astronaut: astronaut)
            
        }else {
            fatalError("Could not find astronaut \(member.name)")
        }
    }
         CrewScrollView(crew: crew)
        .preferredColorScheme(.dark)
    
    
}
