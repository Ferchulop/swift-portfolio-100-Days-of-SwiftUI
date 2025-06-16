//
//  StorageText.swift
//  Project11.Bookworm
//
//  Created by Fernando Jurado on 19/11/24.
//

import SwiftUI

struct StorageText: View {
    
    @AppStorage("notes") private var notes = ""
    
    var body: some View {
        NavigationStack {
            TextField("Enter your text", text: $notes, axis: .vertical)
                .textFieldStyle(.roundedBorder)
                .navigationTitle("Notes")
                .padding()
            /*TextEditor(text: $notes)
                .navigationTitle("Notes")
                .padding()*/
        }
    }
}

#Preview {
    StorageText()
}
