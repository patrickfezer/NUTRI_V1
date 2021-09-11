//
//  DestinationAmuntInputView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 04.09.20.
//

import SwiftUI

struct DestinationAmountInputView: View {
    
    let productName: String
    @Binding var textValue: String
    @Binding var isEdeting: Bool
    
    var body: some View {
        
        var inputName: String {
            if productName == "Kalorien" {
                return "Kcal angeben"
            } else {
                return "Zielmenge in g eingeben."
            }
        }
        
        return HStack {
            Text(productName)
            
            TextField(inputName, text: $textValue, onEditingChanged: { edeting in
                self.isEdeting = true
            }, onCommit: {
                print("onCommit")
            })
            .keyboardType(.decimalPad)
            .padding(2)
            .padding(.trailing, 10)
            .multilineTextAlignment(.trailing)
                
        }
    }
}

struct DestinationAmountInputView_Previews: PreviewProvider {
    static var previews: some View {
        DestinationAmountInputView(productName: "Protein", textValue: .constant(""), isEdeting: .constant(false))

    }
}
