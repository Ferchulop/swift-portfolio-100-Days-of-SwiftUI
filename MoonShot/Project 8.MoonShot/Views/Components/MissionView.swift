//
//  MissionView.swift
//  Project 8.MoonShot
//
//  Created by Fernando Jurado on 7/10/24.
//

import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
        
    }
    
    // Para poder mostrar, imagen, nombre y descripcion le asignamos la constante mission.
    let mission: Mission
    let crew: [CrewMember]
    var body: some View {
        // Lo anido en un ScrollView para poder visualizar toda la vista
        ScrollView {
            // Muestro imagen
            VStack {
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal) { width, axis in
                        width * 0.6
                        
                    }
                // CHALLENGE: You might choose to format this differently given that more space is available, but it’s down to you
                Text(mission.launchDate?.formatted(date: .complete,time: .omitted) ?? "N/A")
                
                VStack(alignment: .leading) {
                        DividerView()
                    // Muestro titulo y descripcion
                    VStack(alignment: .leading) {
                        Text("Mission Highlights")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        Text(mission.description)
                        // Añado una forma, que representa un rectangulo con una altura de 2 puntos
                        DividerView()
                        // Añado titulo a los astronautas
                        Text("Crew")
                            .font(.title.bold())
                            .padding(.bottom, 5)
                        
                    }
                    
                    .padding(.horizontal)
                    
                }
                .padding(.horizontal)
                //CHALLENGE: Extract one or two pieces of view code into their own new SwiftUI views – the horizontal scroll view in MissionView is a great candidate, but if you followed my styling then you could also move the Rectangle dividers out too.
                
                // Llamo a mi vista ScrollView
                CrewScrollView(crew: crew)
                
            }
            .padding(.bottom)
            
            
        }
        .navigationTitle(mission.displayName)
        .navigationBarTitleDisplayMode(.inline) // Controlo como mostrar el titulo en la barra de navegacion
        .background(.darkBackground)
        
    }
    
    init(mission: Mission, astronauts:[String: Astronaut]) {
        self.mission = mission
        self.crew = mission.crew.map { member in
            if let astronaut = astronauts [member.name ] {
                return CrewMember (role: member.role, astronaut: astronaut)
                
            } else {
                fatalError("No astronaut found for \(member.name)")
            }
            
        }
        
        
    }
}
// Para mostrar la previsualizacion: 1. Cargamos los datos desde el archivo missions.json llamando al metodo decode, y con el Array Mission se espera que nos muestre la lista de objetos tipo Misssion.2. En este caso retornamos la primera mision del array y le damos la preferencia de que utilice el modo oscuro en esta vista.
#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return MissionView(mission: missions [0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
