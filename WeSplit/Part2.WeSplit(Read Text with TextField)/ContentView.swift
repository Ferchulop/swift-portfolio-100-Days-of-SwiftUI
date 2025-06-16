//
//  ContentView.swift
//  Part2.WeSplit(Read Text with TextField)
//
//  Created by Fernando Jurado on 9/7/24.
//

import SwiftUI

struct ContentView: View {
    // Crearemos 3 properties @State para manejar estas propiedades en nuestro formulario:
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    //Al lanzar el simulador, y escribir con numeros la cantidad. El teclado siempre se mantiene visible, no desaparece. Para solucionar esto crearemos un nuevo estado: @FocusState para manejar la entrada de datos con el teclado en la interfaz UI
    @FocusState private var amountIsFocused: Bool
    // Creamos una constante para asignar unos porcentajes fijos de propina.CHALLENGE: Cambio la posibilidad de porcentajes fijos a muchas mas posibilidades desde el 0 hasta el 100%
    let tipPercentages = 0..<101
    // Creamos una computed propertie para saber la cantidad total junto a propina que costará la comida.
    var totalAmount: Double {
    let tipSelection1 = Double(tipPercentage)
    let tipValue1 = checkAmount / 100 * tipSelection1
    let totalAmountPerson = checkAmount + tipValue1
        return totalAmountPerson
    }
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        // Convertimos el porcentaje en decimal para poder sumarlo en la cantidad total(type conversion o type casting)
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal =  checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        
        return amountPerPerson
    }
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    // En nuestro TextField, almacenamos la cantidad, la cual tiene que ser con un value. El cual utilizaremos un Binding State para asignar su cantidad, con el .format le diremos que hablamos de divisa, moneda.Con Locale.current que queremos asignar la moneda local, en este caso el €. Con un nil coalesing en .currency le decimos que lea cual es la moneda local y si no hay una asignada por defecto que asigne el $ americano "USD
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    //Añado modificador de teclado numerico predeterminado para que al introducir la cantidad por teclado salga automaticamente los numeros.
                        .keyboardType(.decimalPad)
                    // Añadimos modificador para manejar la posibilidad de ocultar el teclado cada vez que introducimos un numero en el teclado del simulador de nuestra App
                        .focused($amountIsFocused)
                    // Añado un picker, lista de opciones para ver el numero de personas entre las que repartir la cantidad de la cuenta o simplemente que han asistido
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100){
                            Text("\($0) people")
                        }
                    }
                    // Este modificador lo que hará es que nos desplace a otra vista para visualizar todas las opciones posibles que tenemos de cantidad de gente, siempre y cuando este dentro de nuestro NavigationStack {, ya que de forma predeterminada nos lanza la lista en una misma vista
                    .pickerStyle(.navigationLink)
                    
                }
                
                // Para evitar que quede mal respecto al diseño o de forma visual. En vez de poner el texto de que es el porcentaje, dentro de su recuadro blanco; lo pondremos como parametro de section ( por que se vería unicamente todas las posibilidades de porcentaje sin añadir un texto) ya que al poner el modificador (.segmented) tapa la opción del texto en Picker "Tip Percentage" lo pondremos como parametro en nuestra seccion, a continuacion de esta. Para que se visualice como en " 2º plano". De forma predeterminada este texto saldrá en MAYÚSC
                Section("How much do you want to leave?") {
                    //Creamos otra seccion con la cantidad de propina en porcentaje que deja el cliente. Volvemos a utilizar Binding State para llamar a tipPercentage y con un id: y \.self le damos una identificacion unica, añadiendole que el tipo de formato es en porcentaje (.percent)
                    Picker("Tip Percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text("\($0)%")
                        }
                    }// Añado un modificador a mi lista (Picker) para mostrarlo de forma segmentada(.segmented)CHALLENGE: Cambio el pickerStyle() a .navigationLink para visualizarlo en otra pantalla. Con la posibilidad de mostrar un rango del 0 al 100
                    .pickerStyle(.navigationLink)
                }//Challenge: Add a header to the third section, saying “Amount per person”
                Section("Amount per Person") {
                    //Cambiamos en el texto lo inicial que era checkAmount y lo cambiamos por la computed propertie creada y calculada totalPerPerson
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    
                }
                //CHALLENGE: Add another section showing the total amount for the check – i.e., the original amount plus tip value, without dividing by the number of people.
                Section {
                        Text(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    // Go back to project 1 and use a conditional modifier to change the total amount text view to red if the user selects a 0% tip.Añado conditional modifier para controlar si el % de tip es 0 salga en rojo
                        .foregroundStyle(tipPercentage < 1 ? .red: .primary)
                    }
                   
                }
                
                
            }
            //Añado el título de la App con el siguiente modificador en NavigationStack
            .navigationTitle("WeSplit")
            // Añadimos un boton de "Done", (realizado) para verificar cuando hemos introducido la cantidad en la barra de herramientas. Y lo controlaremos con un condicional. Al presionar en "Done" nuestro teclado desaparecerá
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }


#Preview {
    ContentView()
}
