//
//  VibratingPhone.swift
//  Project10. CupcakeCorner
//
//  Created by Fernando Jurado on 8/11/24.
//

import CoreHaptics // Añado framework para poder usar Haptic Effects y generar vibraciones
import SwiftUI

struct VibratingPhone: View {
    @State private var counter = 0 // Propiedad para contar las veces que se pulsa el boton(eliminada)
    @State private var engine: CHHapticEngine? // Propiedad para almacenar los patrones de vibración
    var body: some View {
        // Al pulsar el boton llamo a la función complexSuccess
        Button("Tap count", action: complexSuccess)
        // Al aparecer la vista por primera vez llamo a prepareHaptics que inicializará el motor: CHHapticEngine
            .onAppear(perform: prepareHaptics)
    }
    func prepareHaptics() {
        // Verifico si el dispositivo soporta hápticos
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        do {
            // Creo la instancia de CHHapticEngine y la asigno a engine
            engine = try CHHapticEngine()
            // Inicia el motor para reproducir patrones de vibración
            try engine?.start()
        } catch {
            // Capturo el error si lo hay
            print("There was an error creating the engine: \(error.localizedDescription)")
        }
    }
    // Funcion para crear un patrón de vibración totalmente customizado
    func complexSuccess() {
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        // Se crea el array vacío para almacenar todos los eventos de vibración
        var events = [CHHapticEvent]()
      // Estos eventos aumentarán en intensidad y nitidez la vibración
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0) // Cada evento será reproducido en el momento
            events.append(event)
        }
        // Estos eventos disminuirán en intensidad y nitidez la vibración
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1-i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1-i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i) // Cada evento será reproducido un poco más tarde que el ej anterior
            events.append(event)
        }
        
        do {
            let pattern = try CHHapticPattern(events: events, parameters: []) // Se crea un patrón de Haptics usando la lista de eventos previamente creada
            let player = try engine?.makePlayer(with: pattern) // Reproducirá en el dispositivo el patrón con .makePlayer
            try player?.start(atTime: 0) // Se inicia la reproduccion del patron al momento
        } catch {
            print("Failed to play patter: \(error.localizedDescription).")
        }
        
        
        
    }
}

#Preview {
    VibratingPhone()
}

