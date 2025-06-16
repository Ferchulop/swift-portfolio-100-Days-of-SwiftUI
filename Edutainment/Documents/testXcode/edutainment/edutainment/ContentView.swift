import SwiftUI

// Añado una struct para almacenar cada multiplicacion y su respuesta con el protocolo Identifiable para hacer única cada propiedad
struct Question: Identifiable {
    let id = UUID() // Cómo el objetivo era solo mostrar pregunta por pregunta le añado un ID único
    let text: String
    let answer: Int
    var userAnswer: Int? = nil // Almacenará la respuesta del usuario
    var showAnswer: Bool = false // Controlará si se debe mostrar la respuesta correcta
}

struct ContentView: View {
    @State private var selectedTable = 2
    @State private var numberofQuestions = [5, 10, 20]
    @State private var indexQuestion = 0
    @State private var questions: [Question] = []
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var gameOver = false
    @State private var countQuestion = 0

    var body: some View {
            NavigationStack {
                Form {
                VStack {
                    Text("Which multiplication table would you like to choose?")
                    Stepper(" Table of: \(selectedTable)", value: $selectedTable, in: 2...12)
                    
                    Text("Please, select number of questions: ")
                    Picker(selection: $indexQuestion, label: Text("")) {
                        ForEach(0..<numberofQuestions.count, id: \.self) { index in
                            Text("\(numberofQuestions[index])")
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    
                    Button("Start Game") {
                        startGame()
                    }
                    .frame(width: 100, height: 30)
                    .background {
                        LinearGradient(colors: [.blue,.purple], startPoint: .top, endPoint: .bottom)
                    }
                    .foregroundStyle(.white)
                    .clipShape(.capsule)
                    .padding()
                }
                
                Section(header: Text("Questions : ").foregroundStyle(.white)) {
                    ForEach($questions) { $question in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(question.text)
                                TextField("User answer", value: $question.userAnswer, format: .number)
                                    .keyboardType(.numberPad)
                                
                                if question.showAnswer {
                                    Text("Answer: \(question.answer)")
                                        .foregroundStyle(.gray)
                                        .font(.subheadline)
                                }
                            }
                            
                            
                            Button("Check") {
                                checkAnswer(for: question)
                                question.showAnswer.toggle()
                            }
                            .frame(width: 60, height: 40)
                            .background(.green)
                            .foregroundStyle(.white)
                            .clipShape(.capsule)
                        }
                      
                    }
                  
                }
               
               
            }
                
            .alert(scoreTitle, isPresented: $showingScore) {
                Button("Continue", action: {})
            } message: {
                Text("Your score is: \(score)")
            }
            .alert("Game Over", isPresented: $gameOver) {
                Button("OK", action: restartGame)
            } message: {
                Text("Your final score is: \(score)")
            }
            .background {
                LinearGradient(colors: [.blue,.purple], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
            }
            .scrollContentBackground(.hidden) // Modificador que permite añadir background en el Form
            .navigationTitle("Edutainment")
            }
        }
    // Funcion para  crear una lista aleatoria de preguntas basandose en el numero que se  desee
    func generateQuestions(_ countQuestion: Int, for table: Int) {
        questions = [] // Inicializo la lista vacía
        for _ in 1...countQuestion {
            let multiplicand = Int.random(in: 1...12) // Genera un número aleatorio entre 1 y 12
            let questionText = "How much is: \(table) x \(multiplicand)?"
            let correctAnswer = table * multiplicand
            // append añade un nuevo elemento al final de una array, en este caso la pregunta
            questions.append(Question(text: questionText, answer: correctAnswer))
        }
    }
    // Funcion para inciar la cantidad de preguntas donde controlo con un condicional  que este dentro del rango válido
    func startGame() {
        if indexQuestion >= 0 && indexQuestion < numberofQuestions.count {
            generateQuestions(numberofQuestions[indexQuestion], for: selectedTable)
            countQuestion = 0
            score = 0
            gameOver = false
        } else {
            print("Error: indexQuestion \(indexQuestion) is out of range.")
        }
    }
    // Funcion para sumar o restar si la respuesta ha sido acertada
    func checkAnswer(for question: Question) {
        if let userAnswer = question.userAnswer {
            if userAnswer == question.answer {
                score += 1
            } else {
                score -= 1
            }
        }
        countQuestion += 1
        
        if countQuestion == numberofQuestions[indexQuestion] {
            
            gameOver = true
        } else {
            showingScore = true
        }
    }
    // Funcion para resetear el juego
    func restartGame() {
        countQuestion = 0
        score = 0
        startGame()
    }
}

#Preview {
    ContentView()
}

