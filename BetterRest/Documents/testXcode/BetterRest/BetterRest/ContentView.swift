//
//  ContentView.swift
//  BetterRest
//
//  Created by Fernando Jurado on 26/7/24.
//
import CoreML // Importamos libreria CoreML para poder trabajar con la clase MLModelConfiguration
import SwiftUI

struct ContentView: View {
    // Para añadir una hora que aparezca por defecto creamos una variable defaultWakeTime
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var alertTitle = ""
    @State private var alertMessagge = ""
    @State private var showingAlert = false
    // Al indicar a wakeUp que por defecto queremos que la propiedad se inicialice con defaultWakeTime dará error al compilar, por lo que nos forzará a crear nuestra var de forma estatica para remediar esto. Esto pasa por que Xcode no sabe en que orden ejecutar estas propiedades si no le indicamos que es una static var, ya que queremos que estos valores sean compartidos:
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? .now
    }
    
    var body: some View {
        // Creamos un navigationstack con 1 datepicker para mostrar en este caso solo horas y minutos y un stepper para contar la cantidad de cafés ingeridos.
        NavigationStack {
            // Sustituyo mi vista VStack { por un Form para darle una mejor apariencia, y meto cada Text,DatePicker y Stepper con su vista VStack con un espaciado y un modificador par alinear a la izquierda el texto { :
            Form{
                VStack(alignment: .center, spacing: 5) {
                    Text("⏰ When do you want to wake up?")
                        .font(.headline)
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("🦦 Desired amount of sleep")
                        .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                VStack(alignment: .leading, spacing: 0) {
                    Text("☕️ Daily coffee intake")
                        .font(.headline)
                    // Para solucionar el problema de que siempre utilice cups en plural y se ajuste a la cantidad de tazas podria utilizar un ternary operator: coffeAmount == 1 ?? "1 cup" : "\(coffeAmount) cups" ó podría hacer lo siguiente para reducir líneas de código con inflect.
                    //Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount, in: 1...10)
                    // CHAllENGE: Add a Picker to generate a new view
                    Picker("Cups of coffee: ", selection: $coffeeAmount) {
                        ForEach(1...10, id: \.self) { number in
                            Text("\(number) cup\(number > 1 ? "s": "" ) of coffee")
                        }
                        
                    }
                }
                VStack {
                    Text("Your ideal bedtime is: ")
                        .font(.headline)
                    
                    Text(calculateBedtime())
                        .font(.headline)
                }
                // centro el contenido del Vstack
                .frame(maxWidth: .infinity)
                
            }// añadimos un titulo y una barra de herramientas a la vista, en este caso le añadimos un boton, el cual realizara lo que programemos en la funcion calculateBedtime
            .navigationTitle("BetterRest")
            //.toolbar {
            // Button("Calculate", action: calculateBedtime)
        }
        //.alert(alertTitle, isPresented: $showingAlert) {
        //Button("OK"){}
    }//message: {
    //Text(alertMessagge)
    
    //}
    //}
    // }
    // CHALLENGE: Change the user interface so that it always shows their recommended bedtime using a nice and large font. You should be able to remove the “Calculate” button entirely.
    //func calculateBedtime() {
    // Añado un retorno de String para poder incluir la funcion en el Text(calculateBedTime())
    func calculateBedtime() -> String {
        // En un try catch almacenamos todos los posibles errores, SleepCalculator es el modelo Core ML que utilizamos para predecir la mejor hora para acostarse
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            // Se calcula el número total de segundos que representan la hora y los minutos especificados en components. Esto es útil cuando necesitas realizar cálculos con tiempo de manera uniforme, ya que los segundos son una unidad de tiempo más manejable para cálculos y comparaciones que horas y minutos por separado.
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            // Con components que es una propiedad instanciada de dateComponents representamos hora y minuto.Si no tiene un valor asignado con ?? nil coalesing asignamos 0, y pasamos la horas a segundos, lo que sería 1 hora 3600 segundos. Al igual con los minutos que los pasamos a segundos.
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction =  try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            // Calcular la hora ideal para acostarse restando la cantidad de sueño predicha de la hora de despertar
            let sleeptTime = wakeUp - prediction.actualSleep
            //alertTitle = "Your ideal bedtime is..."
            // la propiedad sleepTime, la cual hemos creado la formateamos, para que, omita el mostrar, año, mes y día y solo nos muestre la hora y de una forma corta, omitiendo los segundos en el digital.
            //alertMessagge = sleeptTime.formatted(date: .omitted, time: .shortened)
            return sleeptTime.formatted(date: .omitted, time: .shortened)
        } catch {
            return "Error calculating bedtime"
            //alertTitle = "Error"
            // alertMessagge = "Sorry there was a problem calculating your bedtime"
            
        }
        // Mostramos el mensaje de alerta con la hora ideal para dormir, después de pulsar en calculate
        //showingAlert = true
        
    }
    
}
#Preview {
    ContentView()
}
