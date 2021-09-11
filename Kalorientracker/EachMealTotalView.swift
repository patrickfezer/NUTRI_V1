//
//  EachMealTotalView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 07.09.20.
//

import SwiftUI

struct EachMealTotalView: View {
    
    @EnvironmentObject var cart: Cart
    var filter: String
    var date: String

    var totalValues: [String : Double] {
    
        
        var values : [String : Double] = ["kcal" : 0, "fat" : 0, "saturated" : 0, "carbs" : 0, "roughage" : 0, "sugar" : 0, "protein" : 0, "leucin" : 0, "salt" : 0]
        
        
        for index  in 0..<cart.orders.count {
            if cart.orders[index].meal == filter && cart.orders[index].date == date {
                
                let modifier = Double(cart.orders[index].modifier)
                
                values["kcal"]! += Double(cart.orders[index].product.kcal)! / 100 * modifier
                
                values["fat"]! += Double(cart.orders[index].product.fat)! / 100 * modifier
                
                values["saturated"]! += Double(cart.orders[index].product.saturated)! / 100 * modifier
                
                values["carbs"]! += Double(cart.orders[index].product.carbs)! / 100 * modifier
                
                values["roughage"]! += Double(cart.orders[index].product.roughage)! / 100 * modifier
                
                values["sugar"]! += Double(cart.orders[index].product.sugar)! / 100 * modifier
                
                values["protein"]! += Double(cart.orders[index].product.protein)! / 100 * modifier
                
                values["leucin"]! += Double(cart.orders[index].product.leucin)! / 100 * modifier
                
                values["salt"]! += Double(cart.orders[index].product.salt)! / 100 * modifier
            }
        }
        
        return values
    }


    var body: some View {
        
        
        Form {
            // kcal
            EachMealTotalAmountView(category: "Kalorien", amount: totalValues["kcal"]!, showUnit: false)
            
            // fat
            EachMealTotalAmountView(category: "Fett", amount: totalValues["fat"]!, showUnit: true)
            
            // saturated
            EachMealTotalAmountView(category: "Gesättigte Fettsäuren", amount: totalValues["saturated"]!, showUnit: true)
            
            // carbs
            EachMealTotalAmountView(category: "Kohlenhydrate", amount: totalValues["carbs"]!, showUnit: true)
            
            // roughage
            EachMealTotalAmountView(category: "Ballaststoffe", amount: totalValues["roughage"]!, showUnit: true)
            
            // sugar
            EachMealTotalAmountView(category: "Zucker", amount: totalValues["sugar"]!, showUnit: true)
            
            // protein
            EachMealTotalAmountView(category: "Protein", amount: totalValues["protein"]!, showUnit: true)
            
            // L-Leucin
            EachMealTotalAmountView(category: "L-Leucin", amount: totalValues["leucin"]!, showUnit: true)
            
            // salt
            EachMealTotalAmountView(category: "Salz", amount: totalValues["salt"]!, showUnit: true)
            
        }
        .navigationBarTitle("Gesammtübersicht" + " " + filter, displayMode: .inline)
    }
}

struct EachMealTotalView_Previews: PreviewProvider {
    static var previews: some View {
        EachMealTotalView(filter: "Mahlzeit 1", date: "20.10.1997").environmentObject(Cart())
    }
}
