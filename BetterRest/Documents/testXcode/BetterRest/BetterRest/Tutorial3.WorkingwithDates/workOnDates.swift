//
//  workOnDates.swift
//  BetterRest
//
//  Created by Fernando Jurado on 27/7/24.
//

import SwiftUI

struct workOnDates: View {
    var body: some View {
        // Podemos trabajar con la fecha y mostrar la vista de la siguiente manera asignando lo que queremos ver
        //Text(Date.now, format: .dateTime.hour().minute())
        
        // Text(Date.now, format: .dateTime.day().month().year())
        // Y esta sería la ultima forma lo más resumida posible, con una vista de la hora más abreviada con .shortened
        Text(Date.now.formatted(date: .long, time: .shortened))
    }
    func exampleDates() {
        //var components = DateComponents()
        //components.hour = 0
        //components.minute = 0
        //let date = Calendar.current.date(from: components) ?? .now
        // Creamos la constante llamada components y con .dateComponents que es un metodo para seleccionar especificamente lo que queremos de la fecha añadimos horas y minutos actuales
        let components = Calendar.current.dateComponents([.hour,.minute], from: .now)
        let hour = components.hour ?? 0
        let minute = components.minute ?? 0
    }
}

#Preview {
    workOnDates()
}
