

//
//  DestinationAmuntInputView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 04.09.20.
//

import SwiftUI

struct DestinationAmountInputView: View {

    let productName: Text
    @Binding var textValue: String
    @Binding var isEdeting: Bool

    var body: some View {

        var inputName: String {
            if productName == Text("calories") {
                return "Kcal"
            } else {
                return "Type in amount in g."
            }
        }

        return HStack {

            productName

            
            TextField.init(inputName, text: $textValue, onEditingChanged: { edeting in
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
        DestinationAmountInputView(productName: Text("protein"), textValue: .constant(""), isEdeting: .constant(false))

    }
}
