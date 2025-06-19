//
//  SwiftUIView.swift
//  BetterRest
//
//  Created by Fernando Jurado on 26/7/24.
//

import SwiftUI
//En SwiftUI, un Stepper es un control que permite incrementar o decrementar un valor numérico. Se utiliza comúnmente en situaciones donde el usuario necesita ajustar un valor dentro de un rango específico, como seleccionar una cantidad, ajustar una configuración de volumen, etc.Con .formatted() eliminamos decimales innecesarios en nuestra propiedad, le asignamos un value haciendo binding state de la propiedad que tenemos, le damos un rango de incremento y decremento con in: y con step: le decimos cuando queremos que incremente o decremente. Cada 0.10,0.15,0.20
struct StepperView: View {
    @State private var sleepAmount = 8.0
    var body: some View {
        Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...15, step: 0.25)
    }
}


#Preview {
    StepperView()
}
