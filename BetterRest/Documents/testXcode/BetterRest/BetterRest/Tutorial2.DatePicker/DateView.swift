//
//  DateView.swift
//  BetterRest
//
//  Created by Fernando Jurado on 26/7/24.
//

import SwiftUI

struct DateView: View {
    @State private var wakeUp = Date.now
    var body: some View {
        // En SwiftUI, un DatePicker es un control que permite a los usuarios seleccionar una fecha y una hora. Este control es muy útil para formularios, calendarios y cualquier otra funcionalidad donde se necesite capturar una fecha y hora específica.1. Trabajamos con un DatePicker y un texto donde nos pide introducir una fecha.
       //DatePicker("Please enter a date", selection: $wakeUp)
        //2. Trabajamos mostrando el mismo resultado pero sin asignarle un texto por defecto, provocando esto, que el selector de fecha y hora se muestren en el lado derecho de la pantalla. Para evitar esto y que quede en el centro utilizaremos el modificador .labelsHidden(). Y si solo quisieramos mostrar horas y minutos y no fecha dentro de DatePicker con displaycComponent podríamos.
        //DatePicker("",selection: $wakeUp, displayedComponents: .hourAndMinute)
            //.labelsHidden()
        
        // También podemos no disponer de las fechas anteriores al día actual manejando el rango con in: Date.now...
        
        DatePicker("Please enter a date", selection: $wakeUp, in: Date.now...)
    }
    // Creamos una funcion para mostrar las fechas que queremos y no mostrar todas:
    func exampleDates() {
        // En este caso creamos una constante llamada tomorrow a la que le decimos que la fecha es la actual(Date.now) y le añadimos un metodo(.addingTimeInterval) para añadir o restar una cantidad de tiempo especifico a un objeto, en este caso la cantidad de segundos en un día
        let tomorrow = Date.now.addingTimeInterval(86400)
        let range = Date.now...tomorrow
    }
}

#Preview {
    DateView()
}
