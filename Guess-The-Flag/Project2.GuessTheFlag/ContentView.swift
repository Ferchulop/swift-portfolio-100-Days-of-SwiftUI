//
//  ContentView.swift
//  Project2.GuessTheFlag
//
//  Created by Fernando Jurado on 13/7/24.
//

import SwiftUI
struct FlagImage: View {
    
    var imageName: String
    
    var body:  some View {
       Image(imageName)
            .clipShape(.capsule)
            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
    }
}

struct ContentView: View {
    
    @State private var animationAmount  = [0.0, 0.0, 0.0]
    // Creo posteriormente un @State de countries y correctAnswer para poder controlar los cambios de estado que se piden en la func askQuestion.
    @State private var countries = ["Estonia","France","Germany","Ireland","Italy","Nigeria","Poland","Spain","UK","Ukraine","US"].shuffled()// Le añado .shuffled() que se encarga de aleatorizar el orden, pero mantiene el original dentro de memoria
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var showingScore = false
    @State private var eightQuestions = false // Añado @State para verificar si el valor es true o false y poder compararlo en flagTapped()
    @State private var countQuestion = 0 // Añado @State para contar el nº de preguntas
    @State private var scoreTitle = ""
    @State private var selectedFlag: Int? // CHALLENGE: Reescalar bandera no elegida
    @State private var score = 0//CHALLENGE: Añado @State para almacenar resultado.
    // Added accesibility for the description of the flags
    let labels = [
        "Estonia": "Three horizontal stripes: blue on top, black in the middle, and white on the bottom.",
        "France": "Three vertical stripes: blue on the left, white in the middle, and red on the right.",
        "Germany": "Three horizontal stripes: black on top, red in the middle, and yellow on the bottom.",
        "Ireland": "Three vertical stripes: green on the left, white in the middle, and orange on the right.",
        "Italy": "Three vertical stripes: green on the left, white in the middle, and red on the right.",
        "Nigeria": "Three vertical stripes: green on the sides (left and right) and white in the middle.",
        "Poland": "Two horizontal stripes: white on top and red on the bottom.",
        "Spain": "Three horizontal stripes: red on the top and bottom, yellow in the middle with the coat of arms on the left side of the yellow stripe.",
        "UK": "The Union Jack combines the crosses of St George (red on white), St Andrew (white on blue), and St Patrick (red on white) in a design of diagonal and horizontal lines.",
        "Ukraine": "Two horizontal stripes: blue on top and yellow on the bottom.",
        "US": "Thirteen horizontal stripes alternating red and white, with a blue rectangle in the top left corner containing fifty white stars."
    ]
    var body: some View {
        // Para que el color blanco de la bandera este sobre un fondo que sea notable envolvemos todo el body en un ZStack y le damos un fondo de color azul. Cogiendo toooda la pantalla del dispositivo con el modifier .ignoresSafeArea()
        ZStack {
            //Elimino el fondo creado anteriormente(LinearGradient) y creo uno nuevo llamado RadialGradient.Con dos localizaciones distintas. Y colores custom.
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)], center: .top, startRadius: 200, endRadius: 700)
            
            //LinearGradient(colors: [.blue,.black], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
            // Añado un titulo dentro de mi nueva vista añadida VStack {
            VStack {
                Text("Guess the flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white )
                
                VStack(spacing:15) {
                    
                    // Añado una vista vertical, y en mi texto le añado [correctAnswer] para mostrar una posicion en el array de countries de forma aleatoria.
                    VStack {
                        
                        // Para que el texto se vea mejor sobre el fondo azul le damos un contorno a la fuente en blanco, que posteriormente, al rediseñar la app.Lo quitamos para que predomine el negro en los nombres de countries.Pero en "Tap the flag of" lo cambiamos por un color secundario.El cual adapta un color azulado como el fondo. TIP: con environment overrides en Dynamic Type podría visualizar como respeta el tamaño de la fuente en la interfaz
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                        // Cambiamos la fuente de tamaño
                            .font(.largeTitle.weight(.semibold))
                    }
                    // Con un bucle ForEach recorro las 3 posiciones y luego en Image las muestro por el orden del Array
                    ForEach(0..<3) { number in
                        Button {
                            // Añado la función flagTapped cofigurada más abajo para controlar si la selección de la bandera es correcta o incorrecta
                            withAnimation(.spring(duration: 1, bounce: 0.5)) {
                                flagTapped(number)
                                animationAmount[number] += 360
                            }
                            
                            // la imagen accede a una posicion de entre 0 hasta 2 del array de countries, en este caso mostrando la posicion 0: Estonia, la 1: Francia y asi sucesivamente...
                        }label: {
                            // Sustituyo Image por FlagImage: Project 3.Replace the Image view used for flags with a new FlagImage() view that renders one flag image using the specific set of modifiers we had.
                            FlagImage(imageName: countries[number])
                                .rotation3DEffect(.degrees(animationAmount[number]),axis: (x: 0, y: 1, z: 0))
                                .scaleEffect(selectedFlag == nil || selectedFlag == number ?  1 : 0.75) // Modificador para reescalar la bandera no elegida.
                            //Image(countries[number])
                            //.clipShape(.capsule) // Modifico la vista de la imagen para verla con forma de capsula
                            //.shadow(radius: 10) // Le añado sombra al contorno de las banderas
                        }
                        // Added accesibility
                        .accessibilityLabel(labels[countries[number], default: "Uknown flag"])
                        
                    }
                    
                    .frame(maxWidth: .infinity)// Controlo tamaño y posición
                    .padding(.vertical,20) // Controlo la separacion
                    .background(.regularMaterial) // Le doy aspecto de material vidrio al fondo
                    .clipShape(.rect(cornerRadius: 20)) // Fondo redondeado y sus esquinas con 20 puntos
                    Spacer()// Añado espacios para rediseñar la app
                    Spacer()
                    Text("Score: \(score)")
                        .foregroundStyle(.white)
                        .font(.title.bold())
                    Spacer()
                }
                .padding() // Con el padding consigo crear un efecto ovalado entre el color azul y el color rojo
            }
            // Utilizo el modificador de alerta para mostrar un pop - up cada vez que se presiona en una bandera incorrecta o correcta. Llamo a scoreTitle y hago un Binding State de showingscore para mostrar el resultado. Junto su boton y su accion de la funcion askQuestion para que pregunte una y otra vez al presionar el botón.
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: askQuestion)
                    .opacity(0.25)
            }message: {
                Text("Your score is: \(score)")
            }
            .alert("Game Over",isPresented: $eightQuestions) {
                Button("Restart", action: reset)
                    .opacity(0.25)
            } message: {
                Text("Your final score is: \(score)")
            }
        }
        // Creo función para añadir funcionalidad al botón y comparar cuando number sea igual a una de las posiciones del array correctAnswer para que muestre un scoreTitle correcto y si no lo es que muestre un incorrecto. Finalmente llamo a showingScore = true para que muestre la visualizacion de la alerta que mas adelante configuraremos.
        
    }
        func flagTapped(_ number: Int) {
            selectedFlag = number // Añado mi variable con la que reescalo la bandera NO elegida.
            if number == correctAnswer {
                scoreTitle = "Correct"
                //CHALLENGE: Actualizo y almaceno variable si el valor es correcto +1
                score += 1
            } else {
                //CHALLENGE: Actualizo el resultado erróneo para que me diga cual es la bandera que he seleccionado mal.LLamando al parametro de mi funcion
                scoreTitle = "Wrong, that's the flag of: \(countries[number]) "
                //CHALLENGE: Actualizo y almaceno variable si el valor es incorrecto -1
                score -= 1
            }
            
            correctAnswer = Int.random(in: 0...2)
            // Modifico variable showingScore = true por countQuestion = 1 para que sume el contador de las preguntas con las preguntas del desafío, el cual manejare después para que sea hasta 8:
            countQuestion += 1
            //CHALLENGE: controlo con condicional if la cantidad de preguntas.
            if countQuestion == 8 {
                eightQuestions = true
            } else  {
                showingScore = true
            }
            //Reestablezco la animacion cada vez que intento adivinar la bandera
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    selectedFlag = nil
                    animationAmount = [0.0, 0.0, 0.0]
                }
            }
        }
        
        func askQuestion() {
            // Modifico el orden de shuffle el cual no conserva su valor original en memoria.
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
        // CHALLENGE: Funcion que resetea el resultado final a 0.
        
        func reset() {
            score = 0
            countQuestion = 0
            askQuestion()
        }
    }

    
    #Preview {
        ContentView()
    }

