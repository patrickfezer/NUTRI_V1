//
//  productNutritionsViews.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 29.08.20.
//

import SwiftUI

struct productNutritionCollectionView: View {
    
    @EnvironmentObject var cart: Cart
    @EnvironmentObject var ownProduct: OwnProductConfiguration
    
    let product: Product
    let modifier: Double
    
    func amountConverter(product: String) -> String {
        
        // optional value is used to show the fault if there is one in json catalog
        return String(format: "%.2f", Double(product.replacingOccurrences(of: ",", with: ".").replacingOccurrences(of: " ", with: ""))! / 100 * modifier)
    }
    
    var body: some View {
        Section(header: Text("Nährwerte für \(String(format: "%.1f", modifier))g")) {
            // Kalorien
            productNutritionView(nutritionName: "Kalorien", nutritionAmount: amountConverter(product: product.kcal), nutritionUnit: "kcal")
            
            // fat
            productNutritionView(nutritionName: "Fett", nutritionAmount: amountConverter(product: product.fat), nutritionUnit: "g")
            
            // saturated
            productNutritionView(nutritionName: "Gesättigte Fettsäuren", nutritionAmount: amountConverter(product: product.saturated), nutritionUnit: "g")
            
            // carbs
            productNutritionView(nutritionName: "Kohlenhydrate", nutritionAmount: amountConverter(product: product.carbs), nutritionUnit: "g")
            
            // roughage
            productNutritionView(nutritionName: "Ballaststoffe", nutritionAmount: amountConverter(product: product.roughage), nutritionUnit: "g")
            
            // sugar
            productNutritionView(nutritionName: "Zucker", nutritionAmount: amountConverter(product: product.sugar), nutritionUnit: "g")
            
            // protein
            productNutritionView(nutritionName: "Protein", nutritionAmount: amountConverter(product: product.protein), nutritionUnit: "g")
    
            // leucin
            productNutritionView(nutritionName: "L-Leucin", nutritionAmount: amountConverter(product: product.leucin), nutritionUnit: "g")
            
            // salt
            productNutritionView(nutritionName: "Salz", nutritionAmount: amountConverter(product: product.salt), nutritionUnit: "g")
        }
        
        // Header is lowercased
        .textCase(nil)
    }
}

#if DEBUG
struct productNutritionCollectionView_Previews: PreviewProvider {
    
    static let cart = Cart()
    
    static var previews: some View {
        productNutritionCollectionView(product: Product.exampleProduct, modifier: 100).environmentObject(cart)
    }
}
#endif
