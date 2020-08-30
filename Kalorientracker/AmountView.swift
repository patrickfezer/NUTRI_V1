//
//  AmountView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 28.08.20.
//

import SwiftUI

struct AmountView: View {
    
    @State private var textInput = ""
    @State private var orderFinished = false
    let product: Product
        
    func StringDoubleConverter(text: String) -> String {
            return String(format: "%.2f", Double(textInput.replacingOccurrences(of: ",", with: ".")) ?? 0)
        }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Mengenangabe")) {
                    
                    // input for the amount
                    AmountInputView(textInput: $textInput)
                    if !orderFinished {
                        Button("Hinzufügen", action: {
                            orderFinished = true
                            hideKeyboard()
                        })
                        .disabled(textInput == "")
                        .animation(.default)
                    } else {
                        Text("Wurde zum Logbuch hinzugefügt")
                            .foregroundColor(.blue)
                    }
                }
                productNutritionCollectionView(product: product, modifier: Double(StringDoubleConverter(text: textInput))!)

            }
        }
    }
}

struct AmountView_Previews: PreviewProvider {
    static var previews: some View {
        AmountView(product: Product.exampleProduct)
    }
}
