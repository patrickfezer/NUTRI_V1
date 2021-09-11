//
//  EachMealTotalAmountView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 07.09.20.
//

import SwiftUI

struct EachMealTotalAmountView: View {
    
    var category: String
    var amount: Double
    var showUnit: Bool
    
    var body: some View {
        HStack {
            Text(category + ":")
            Spacer()
            if showUnit {
                Text(String(format: "%.2f", amount) + " g")
            } else {
                Text(String(format: "%.2f", amount) + " kcal")
            }
        }
    }
}

struct EachMealTotalAmountView_Previews: PreviewProvider {
    static var previews: some View {
        EachMealTotalAmountView(category: "Rumpsteak" ,amount: 10.0, showUnit: true)
    }
}
