//
//  ProductConfigurationView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 16.09.20.
//

import SwiftUI

struct ProductConfigurationView: View {
    @State private var productName = ""
    @State private var manufacturer = ""
    @State private var kcal = ""
    @State private var protein = ""
    @State private var carbs = ""
    @State private var sugar = ""
    @State private var roughage = ""
    @State private var fat = ""
    @State private var saturated = ""
    @State private var leucin = ""
    @State private var salt = ""
    @Binding var showSheet: Bool
    @EnvironmentObject var ownProduct: OwnProductConfiguration
    let saveKey = "ownProducts"
    
    
    @State private var chosedCategory = ProductAmountInputView.category.firstIndex(of: "Sonstiges")!
    
    var body: some View {
        NavigationView() {
            
            ProductAmountInputView(productName: $productName, manufacturer: $manufacturer, kcal: $kcal, protein: $protein, carbs: $carbs, sugar: $sugar, roughage: $roughage, fat: $fat, saturated: $saturated, leucin: $leucin, salt: $salt, chosedCategory: $chosedCategory)
            
            .navigationBarTitle("Konfiguration", displayMode: .inline)
            .navigationBarItems(leading: Button("Abbrechen") {
                self.showSheet = false
            }, trailing: Button("Fertig") {
                
                ownProduct.add(order: OwnProductOrder(product: Product(id: UUID(), name: productName, manufacturer: manufacturer.trimTrailingWhitespaces(), kcal: String.validDouble(kcal), protein: String.validDouble(protein), carbs: String.validDouble(carbs), sugar: String.validDouble(sugar), roughage: String.validDouble(roughage), fat: String.validDouble(fat), saturated: String.validDouble(saturated), leucin: String.validDouble(leucin), salt: String.validDouble(salt)), category: ProductAmountInputView.category[self.chosedCategory]))

                ownProduct.save()
                
                self.showSheet = false
            }.disabled(productName == ""))
        }
    }
}

struct ProductConfigurationView_Previews: PreviewProvider {
    static var previews: some View {
        ProductConfigurationView(showSheet: .constant(true)).environmentObject(OwnProductConfiguration())
    }
}
