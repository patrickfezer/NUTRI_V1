//
//  productNutritionsViews.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 29.08.20.
//

import SwiftUI

struct productNutritionCollectionView: View {
    let product: Product
    let modifier: Double
    
    func amountConverter(product: String) -> String {
        return String(format: "%.1f", Double(product)! / 100 * modifier)
    }
    
    var body: some View {
        Section(header: Text("Nährwerte für \(modifier, specifier: "%.1f")g")) {
            // Kalorien
            productNutritionView(nutritionName: "Kalorien", nutritionAmount: amountConverter(product: product.kcal), nutritionUnit: "kcal")
            
            // carbs
            productNutritionView(nutritionName: "Kohlenhydrate", nutritionAmount: amountConverter(product: product.carbs), nutritionUnit: "g")
            
            // protein
            productNutritionView(nutritionName: "Protein", nutritionAmount: amountConverter(product: product.protein), nutritionUnit: "g")
            
            // fat
            productNutritionView(nutritionName: "Fett", nutritionAmount: amountConverter(product: product.fat), nutritionUnit: "g")
            
            // saturated
            productNutritionView(nutritionName: "Gesättigte Fettsäuren", nutritionAmount: amountConverter(product: product.saturated), nutritionUnit: "g")
            
            // roughage
            productNutritionView(nutritionName: "Ballaststoffe", nutritionAmount: amountConverter(product: product.roughage), nutritionUnit: "g")
            
            // sugar
            productNutritionView(nutritionName: "Zucker", nutritionAmount: amountConverter(product: product.sugar), nutritionUnit: "g")
        }
        // Header is lowercased
        .textCase(nil)
    }
}

struct productNutritionCollectionView_Previews: PreviewProvider {
    static var previews: some View {
        productNutritionCollectionView(product: Product.exampleProduct, modifier: 100)
    }
}
