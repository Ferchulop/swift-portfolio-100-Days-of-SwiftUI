//
//  ContentView.swift
//  Project4.Milestone
//
//  Created by Fernando Jurado on 19/7/24.
//

import SwiftUI

struct ContentView: View {
    @State private var currentChoice = ""
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var countQuestion = 0
    @State private var tenQuestions = false
    
    let movements = ["✊", "🖐️", "✌️"]
    var body: some View {
        ZStack {
            RadialGradient(colors: [.yellow,.black], center:.top, startRadius: 200, endRadius: 600)
                .ignoresSafeArea()
            
            VStack {
                Text("You need to: ")
                    .font(.largeTitle)
                
                
                VStack {
                    Text("\(shouldWin ? "Win" : "Lose" )")
                        .font(.title)
                        .foregroundStyle(.white)
                        .padding()
                        .background(.black)
                        .cornerRadius(40)
                    Text(currentChoice)
                        .font(.system(size: 150)) // Ajusta el tamaño del emoji
                        .shadow(radius: 15)
                        .onAppear() { // métodos
                            updatedChoice() // Genera un nuevo movimiento aleatorio cuando aparece el Text
                        }.onTapGesture {
                            updatedChoice() // Genera un nuevo movimiento aleatorio cuando aparece el Text
                        }
                    
                    
                }
                HStack {
                    // Añado con interpolation la posicion de cada uno de los emojis, y para darles funcionalidad a estos botones añado su funcion para saber cuando pierde ó gana.
                    
                    Button("\(movements[0])"){
                        playerWinLose(movements[0])
                        
                    }
                    
                    Button("\(movements [1])") {
                        playerWinLose(movements[1])
                        
                    }
                    
                    Button("\(movements[2])") {
                        playerWinLose(movements[2])
                    }
                }
                .font(.system(size: 100))
                .padding()
                Text("Score: \(score)")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .foregroundStyle(.white)
                  
                
            }
            .alert("Game Over", isPresented: $tenQuestions) {
                Button("Restart game", action: reset)
            }message: {
                Text("Your final score is: \(score)")
            }
        }
    }
    // Función para mostar un elemento del array movements de forma aleatoria
    func updatedChoice() {
        currentChoice = movements.randomElement() ?? ""
        shouldWin.toggle()
    }
    // Función para añadir resultado cuando gana o pierde el usuario
    func playerWinLose(_ playerChoice: String) {
        if shouldWin {
            if (playerChoice == "✊" && currentChoice == "✌️") ||
                (playerChoice == "✌️" && currentChoice == "🖐️") ||
                (playerChoice == "🖐️" && currentChoice == "✊") {
                score += 1
            } else {
                score -= 1
            }
        } else {
            if (playerChoice == "✌️" && currentChoice == "✊") ||
                (playerChoice == "🖐️" && currentChoice == "✌️") ||
                (playerChoice == "✊" && currentChoice == "🖐️") {
                score += 1
            } else {
                score -= 1
            }
            
        }
        countQuestion += 1
        
        if countQuestion == 10 {
            tenQuestions = true
        } else {
            updatedChoice()
        }
    }
    // Funcion para resetear resultados a 0
    func reset() {
        score = 0
        countQuestion = 0
        updatedChoice()
        
    }
}

#Preview {
    ContentView()
}
