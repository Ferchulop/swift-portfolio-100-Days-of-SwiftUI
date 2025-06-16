//
//  ContentView.swift
//  Project 7. iExpense
//
//  Created by Fernando Jurado on 15/9/24.
//

import SwiftUI

// 1. Creo struct ExpenseItem para almacenar todas sus propiedades
// 2. Con el fin de hacer cada uno de los valores de gastos unicos añado a mi struct el protocolo Identifiable junto a un id con un identificador único universal UUID()
struct ExpenseItem: Identifiable,Codable {
    var id = UUID()  // Identificador único
    let name: String
    let type: String
    let amount: Double
    let currency: String // Añado currency para poder ver y actualizar el gasto con la moneda elegida en ContentView, iterando item con item.currency
}
// Añado protocolo @observable y instancio en la propiedad items un Array ExpenseItem, con @Observable facilito el poder observar sus cambios y actualizar automaticamente la vista cuando el contenido cambie
@Observable
class Expenses {
    var items = [ExpenseItem]() {
        // con encoded me encargo de cargar los archivos en la app.
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
    }
    // Creamos un inicializador y con decodedItems guardamos todos los archivos en la app.
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        // Me aseguro de que si no hay datos, inicializo un array vacío
        items = []
    }
}

struct ContentView: View {
    // declaro variable expenses que contiene instancia de Expenses
    @State private var expenses = Expenses()
    @State private var showAddExpense = false
    //@State private var selectedCurrency: String = "EUR"
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    // Añado vista horizontal para visualizar el tipo, cantidad y nombre.
                    HStack {
                        VStack(alignment: .leading) {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        // Añado item.currency para poder actualizar la vista del gasto con la moneda seleccionada en la vista de gastos.
                        Text(item.amount, format: .currency(code: item.currency))
                        //Añado estilo para poner color si es < 10 rojo, si es <100 azul y si es >100 verde
                            .foregroundStyle(item.amount < 10 ? .red: (item.amount < 100 ? .blue: .green))
                    }
                    
                }
                .onDelete(perform: deleteItems)
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button("Add Expense", systemImage: "plus") {
                    
                    showAddExpense = true
                    /*let expense = ExpenseItem(
                     name: "Test", type: "Personal", amount: 5)
                     expenses.items.append(expense)*/ //Sustituimos este codigo por un booleano a true que muestre el gasto añadido
                }
                
            }
            // Añado modificador de vista para que al pulsar el botón cambie la vista y añado su propiedad
            .sheet(isPresented: $showAddExpense) {
                AddView(expenses: expenses)
            }
            
        }
        
    }
    // Función para borrar cada una de las filas de la lista
    func deleteItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
