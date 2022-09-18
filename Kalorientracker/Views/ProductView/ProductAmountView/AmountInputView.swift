//
//  AmountInputView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 29.08.20.
//

import SwiftUI

struct AmountInputView: View {
    
    @Binding var textInput: String
    @Binding var TextfieldIsEdeting: Bool
    @State private var showFinishedButton = false
    
    var body: some View {
        
        return HStack {
            HStack {
                
                TextField.init("Menge in g eingeben", text: $textInput, onEditingChanged: { isEdeting in
                    
                    showFinishedButton = true
                    self.TextfieldIsEdeting = true
                    
                }, onCommit: {
                print("OnCommit")
                })
                // keyboardType for Textfield
                .keyboardType(.decimalPad)
            }
            
            // Finish Button
            if showFinishedButton {
                Button("Fertig") {
                    hideKeyboard()
                    showFinishedButton = false
                    TextfieldIsEdeting = false
                }
                .foregroundColor(.blue)
            }
        }
    }
}

struct AmountInputView_Previews: PreviewProvider {
    
    static let cart = Cart()
    
    static var previews: some View {
        AmountInputView(textInput: .constant(""), TextfieldIsEdeting: .constant(false))
    }
}
