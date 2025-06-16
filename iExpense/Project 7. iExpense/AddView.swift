//
//  AddView.swift
//  Project 7. iExpense
//
//  Created by Fernando Jurado on 18/9/24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss // modificador de vista para ocultar el nuevo gasto una vez le damos al botón de guardar
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = 0.0
    @State private var selectedCurrency = "EUR" // CHALLENGE: Add currencyCode in iExpense App
    let currencyCodes = ["USD", "EUR", "GBP",  "JPY", "MXN"]
    let types = ["Personal", "Business"]
    var expenses: Expenses
    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                HStack {
                TextField("Amount", value: $amount, format: .currency(code: selectedCurrency))
                .keyboardType(.decimalPad)
                    // CHALLENGE: Añado Picker para seleccionar el tipo de moneda.
                Picker("", selection: $selectedCurrency) {
                    ForEach(currencyCodes, id: \.self) {
                        Text($0)
                    }
                    }
                }
            }
            .navigationTitle("Add new expense")
            // Añado barra de herramientas con botón guardar para guardar cada uno de los gastos
            .toolbar {
                Button("Save"){
                    let item = ExpenseItem(name: name, type: type, amount: amount, currency: selectedCurrency)
                    expenses.items.append(item)
                    dismiss() // Aplico llamando a su método para ocultar la vista al guardar
                }
            }
        }
    }
}

#Preview {
    AddView(expenses: Expenses())
}
