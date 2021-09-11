//
//  ProductAmountInputView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 23.09.20.
//

import SwiftUI

struct ProductAmountInputView: View {
    @Binding var productName: String
    @Binding var manufacturer: String
    @Binding var kcal: String
    @Binding var protein: String
    @Binding var carbs: String
    @Binding var sugar: String
    @Binding var roughage: String
    @Binding var fat: String
    @Binding var saturated: String
    @Binding var leucin: String
    @Binding var salt: String
    @Binding var chosedCategory: Int
    // Catergory selection
    
    static let category = ["Fleisch", "Teigwaren", "Backwaren", "Weizenprodukte", "Obst und Gemüse", "Öle und Fett", "Supplements", "Süßwaren", "Getränke", "Soßen","Gerichte", "Gewürze", "Sonstiges", "Fisch", "Nüsse", "Vegetarisch", "Vegan"].sorted(by: {
        $0 < $1
    })
    
    var body: some View {
        Form {
            
            Section(header: Text("Nährwerte für 100g eingeben")) {
                Group {
                    TextField("Hersteller", text: $manufacturer)
                    TextField("Produktname (erforderlich)", text: $productName)
                }
                Group {

                    ProductConfigurationAmountInputView(nutritionName: "Kalorien", amountInput: $kcal)
                    ProductConfigurationAmountInputView(nutritionName: "Fett", amountInput: $fat)
                    ProductConfigurationAmountInputView(nutritionName: "Gesättigte Fettsäuren", amountInput: $saturated)
                    ProductConfigurationAmountInputView(nutritionName: "Kohlenhydrate", amountInput: $carbs)
                    ProductConfigurationAmountInputView(nutritionName: "Ballaststoffe", amountInput: $roughage)
                    ProductConfigurationAmountInputView(nutritionName: "Zucker", amountInput: $sugar)
                    ProductConfigurationAmountInputView(nutritionName: "Protein", amountInput: $protein)
                    ProductConfigurationAmountInputView(nutritionName: "L-Leucin", amountInput: $leucin)
                    ProductConfigurationAmountInputView(nutritionName: "Salz", amountInput: $salt)

                    Picker("Kategorie", selection: $chosedCategory) {
                        ForEach(0 ..< ProductAmountInputView.category.count) {
                            Text(ProductAmountInputView.category[$0])
                        }
                    }
                }
            }.textCase(nil)
        }
    }
}

struct ProductAmountInputView_Previews: PreviewProvider {
    static var previews: some View {
        ProductAmountInputView(productName: .constant(""), manufacturer: .constant(""), kcal: .constant(""), protein: .constant(""), carbs: .constant(""), sugar: .constant(""), roughage: .constant(""), fat: .constant(""), saturated: .constant(""), leucin: .constant(""), salt: .constant(""), chosedCategory: .constant(0))
    }
}
