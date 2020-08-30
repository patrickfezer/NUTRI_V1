//
//  AmountInputView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 29.08.20.
//

import SwiftUI

struct AmountInputView: View {
    @Binding var textInput: String
    @State private var showFinishedButton = false
    
    var body: some View {
        HStack {
            HStack {
                TextField("Menge in g eingeben", text: $textInput, onEditingChanged: { isEdeting in
                    self.showFinishedButton = true
                }, onCommit: {
                print("OnCommit")
                })
                // keyboardType for Textfield
                .keyboardType(.decimalPad)

                // IMPORTANT: SWIFTUI BUG!! If added to a list, the hole list will be selected as a button, therefore, this button will always be pressed by pressing the finsihed Button
                
//                // Clear Button
//                Button(action: {
//                    self.textInput = ""
//                }) {
//                    Image(systemName: "xmark.circle.fill").opacity(textInput == "" ? 0 : 1).foregroundColor(Color.secondary)
//                }
            }
            
            if showFinishedButton {
                Button("Fertig", action: {
                    self.hideKeyboard()
                    self.showFinishedButton = false
                }).foregroundColor(Color(.systemBlue))
            }
        }
    }
}

struct AmountInputView_Previews: PreviewProvider {
    static var previews: some View {
        AmountInputView(textInput: .constant(""))
    }
}
