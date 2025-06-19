//
//  ResultsView.swift
//  RollDice
//
//  Created by Fernando Jurado on 18/6/25.
//
import SwiftData
import SwiftUI

struct ResultsView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \RollResults.date, order: .reverse) var results: [RollResults]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(results) { result in
                    VStack(alignment: .leading) {
                        Text("🕑 \(result.date.formatted(date: .abbreviated, time: .shortened))")
                        Text("🎲  Dice: \(result.numberOfDice) Total: \(result.total) ")
                            .font(.headline)
                        
                        
                    }
                    
                }
                .onDelete(perform: deleteItems)
                
                
                
            }
            .navigationTitle("Results")
        }
        
    }
    func deleteItems(at offsets: IndexSet) {
        for offset in offsets {
            let itemToDelete = results[offset]
            modelContext.delete(itemToDelete)
        }
        do {
            try modelContext.save()  // Guarda los cambios
        } catch {
            print("Error al eliminar: \(error)")
        }
    }
}



#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: RollResults.self, configurations: config)
    
    // Insertamos datos de prueba en memoria
    let context = container.mainContext
    context.insert(RollResults(date: .now, numberOfDice: 3, total: 12))
    context.insert(RollResults(date: .now.addingTimeInterval(-3600), numberOfDice: 2, total: 7))
    
    return ResultsView()
        .modelContainer(container)
    
    
}
