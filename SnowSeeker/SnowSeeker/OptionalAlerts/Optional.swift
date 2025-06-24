//
//  Optional.swift
//  SnowSeeker
//
//  Created by Fernando Jurado on 20/6/25.
//

import SwiftUI

struct User: Identifiable {
    
    var id = "Taylor Swift"
}

struct Optional: View {
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false
    var body: some View {
        Button("Tap Me") {
            selectedUser = User()
            isShowingUser = false
        }
        // Se mostrará la mitad de la tarjeta  
        .sheet(item: $selectedUser)  { user in
        Text(user.id)
                .presentationDetents([.medium,.large])
    }
        
    }
}

#Preview {
    Optional()
}
