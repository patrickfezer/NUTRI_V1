//
//  productNutritionView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 28.08.20.
//

import SwiftUI

struct productNutritionView: View {
    let nutritionName: String
    let nutritionAmount: String
    let nutritionUnit: String
    
    var body: some View {
        HStack {
            Text("\(nutritionName): ")
            Spacer()
            Text(nutritionAmount + " " + nutritionUnit)
        }
    }
}

struct productNutritionView_Previews: PreviewProvider {
    static var previews: some View {
        productNutritionView(nutritionName: "Kalorien", nutritionAmount: Product.exampleProduct.kcal, nutritionUnit: "kcal")
    }
}
