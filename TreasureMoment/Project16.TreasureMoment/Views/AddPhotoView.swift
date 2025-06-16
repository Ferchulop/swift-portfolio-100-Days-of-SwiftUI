//
//  AddPhotoView.swift
//  Project16.TreasureMoment
//
//  Created by Fernando Jurado on 26/1/25.
//
import PhotosUI
import SwiftData
import SwiftUI

struct AddPhotoView: View {
    // @Environment(\.modelContext) permite insertar y guardar datos en la bbdd, gestiona la persistencia de datos en User
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var selectedItems: PhotosPickerItem?
    @State private var userName: String = ""
    @State private var image: Data?
    @State private var noPhotoAlert = false
    var body: some View {
        NavigationStack {
            VStack {
                PhotosPicker(selection: $selectedItems, matching: .images, photoLibrary: .shared(), label: {
                    if let image, let uImage =  UIImage(data: image) {
                        Image(uiImage: uImage)
                            .resizable()
                            .scaledToFit()
                    } else {
                        ContentUnavailableView("No picture", systemImage: "photo.badge.plus", description: Text( "Tap to import a photo"))
                    }
                        
                    
                })
             
                // Carga la imagen de forma asíncrona
                .task(id: selectedItems) {
                    if let data = try? await selectedItems?.loadTransferable(type: Data.self) {
                        image = data
                        if userName.isEmpty {
                            noPhotoAlert = true
                        }
                    }
                }
                TextField("Name:", text: $userName)
                    .keyboardType(.default)
                    .foregroundStyle(.primary)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.gray.opacity(0.2))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
                
            }
            .alert("Name your photo", isPresented: $noPhotoAlert) {
                Button("OK", role: .cancel) { }
                    
            } message: {
                Text("You must enter a name for your photo!")
                
            }
            .navigationTitle("Add Photo")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Button("Save") {
                        savePhoto()
                    }
                    .disabled(image == nil || userName.isEmpty) // Deshabilito boton y textfield si no cumple los requisitos
                }
                
                ToolbarItem(placement: .topBarLeading ) {
                    Button("Cancel") {
                        dismiss()
                        
                    }
                    .foregroundStyle(.red)
                    
                }
            }
            
        }
      
    }
    // Metodo para guardar la foto 
    func savePhoto() {
        guard let image else { return }
        let newUser = User(name: userName, imageData: image)
        context.insert(newUser)
        do {
            try context.save()
            dismiss()
        }  catch {
                print("Failed to save photo: \(error.localizedDescription)")
            }
            
    }
    
}
    #Preview {
        AddPhotoView()
    }

