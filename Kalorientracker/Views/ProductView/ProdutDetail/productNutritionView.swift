//
//  productNutritionView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 28.08.20.
//

import SwiftUI

struct productNutritionView: View {
    
    @EnvironmentObject var cart: Cart
    
    // nutriton facts
    let nutritionName: String
    let nutritionAmount: String
    let nutritionUnit: String
    
    // layout
    var body: some View {
        HStack {
            Text("\(nutritionName): ")
            Spacer()
            Text(nutritionAmount + " " + nutritionUnit)
        }
    }
}

#if DEBUG
struct productNutritionView_Previews: PreviewProvider {
    
    static let cart = Cart()
    
    static var previews: some View {
        productNutritionView(nutritionName: "Kalorien", nutritionAmount: Product.exampleProduct.kcal, nutritionUnit: "kcal").environmentObject(cart)
    }
}
#endif
