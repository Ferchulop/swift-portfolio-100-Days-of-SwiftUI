//
//  DetailPhotoView.swift
//  Project16.TreasureMoment
//
//  Created by Fernando Jurado on 26/1/25.
//
import SwiftUI
import MapKit

struct DetailPhotoView: View {
    let user: User
    let locationFetcher = LocationFetcher()
    let startPosition = MapCameraPosition.region(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 40.4165 , longitude: -3.70256), span: MKCoordinateSpan(latitudeDelta: 6, longitudeDelta: 6)))
    @State private var userLocation: CLLocationCoordinate2D?
    var body: some View {
        NavigationStack {
            MapReader { proxy in
                VStack(spacing: 0) {
                    if let photo = user.imageData, let uiImage = UIImage(data: photo) {
                        Image(uiImage:uiImage)
                            .resizable()
                            .scaledToFit()
                        Map(initialPosition: startPosition) {
                            if let userLocation = locationFetcher.lastKnownLocation {
                                Annotation(user.name, coordinate: userLocation) {
                                    if let photo = user.imageData, let uiImage = UIImage(data: photo) {
                                        Image(uiImage:uiImage)
                                            .resizable()
                                            .scaledToFit()
                                            .clipShape(.rect(cornerRadius: 10))
                                            .padding()
                                            .shadow(radius: 5)
                                    }
                                }
                                
                            }
                        }
                        
                    }
                    
                    
                }
               
            }
            
        }
        // Añado barra de herramientas dónde rastrea la posición y después muestra la última ubicación conocida  por pantalla
        .toolbar {
            ToolbarItemGroup(placement:.secondaryAction) {
                Button("Start Tracking Location") {
                    locationFetcher.start()
                }
                Button("Read Location") {
                    if let location = locationFetcher.lastKnownLocation {
                        print("Your location is \(location)")
                    } else {
                        print("Your location is unknown")
                    }
                    
                }
            }
        }
        
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

#Preview {
    DetailPhotoView(user: .example)
}
