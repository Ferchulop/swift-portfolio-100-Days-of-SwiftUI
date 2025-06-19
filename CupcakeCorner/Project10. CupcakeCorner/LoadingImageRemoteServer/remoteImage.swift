
//
//  remoteImage.swift
//  Project10. CupcakeCorner
//
//  Created by Fernando Jurado on 7/11/24.
//

import SwiftUI

struct remoteImage: View {
    var body: some View {
        // con AsyncImage, cargamos una imagen de forma remota, y le damos un valor de x3 para redimensionar la escala. Pero hay 2 formas más de diseñar esto:
        //1º
        /*AsyncImage(url: URL(string:"https://hws.dev/img/logo.png"), scale: 3)*/
        
        // 2º
        /*AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
            image
                .resizable()
                .scaledToFit()
        } placeholder: {
            Color.red o //ProgressView()
        }
        .frame(width: 200, height: 200)*/
        
            // 3º
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { phase in
        if let image = phase.image {
                image
                    .resizable()
                    .scaledToFit()
        } else if phase.error != nil {
            Text("There was an error loading the image.")
        } else {
            ProgressView()
        }
            
            
        }
        .frame(width: 200, height: 200)
        
        }
        
    }


#Preview {
    remoteImage()
}
