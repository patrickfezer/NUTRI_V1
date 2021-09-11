//
//  ProductConfigurationAmountInputView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 16.09.20.
//

import SwiftUI

struct ProductConfigurationAmountInputView: View {
    let nutritionName: String
    @Binding var amountInput: String
    
    var body: some View {
        HStack {
            TextField(nutritionName, text: $amountInput)
            .keyboardType(.decimalPad)
        }
    }
}

struct ProductConfigurationAmountInputView_Previews: PreviewProvider {
    static var previews: some View {
        ProductConfigurationAmountInputView(nutritionName: "Protein", amountInput: .constant(""))
    }
}
