//
//  LocationFetcher.swift
//  Project16.TreasureMoment
//
//  Created by Fernando Jurado on 28/1/25.
//

import Foundation
import CoreLocation
/// - Nota: Ha requerido de permisos en: TARGETS -> INFO -> PRIVACY: Location When in Use Usage Description
class LocationFetcher: NSObject, CLLocationManagerDelegate {
    let manager = CLLocationManager() // Obtiene la localización
    var lastKnownLocation: CLLocationCoordinate2D? // Guarda las coordenadas de la última ubicación conocida del dispositivo

    // MARK: -Inicialización
    override init() {
        super.init()
        manager.delegate = self
    }
/// Solicita permisos de ubicación al usuario y actualiza la ubicación
    func start() {
        manager.requestWhenInUseAuthorization() // Solicita permiso a la app para usar la ubicación cuando esta en uso
        manager.startUpdatingLocation() // Rastrea la ubicacion del usuario
    }
/// Método que se ejecuta al actualizar la ubicación del usuario
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        lastKnownLocation = locations.first?.coordinate // Guarda la primera ubicación obtenida como la última ubicación conocida del usuario
    }
}
