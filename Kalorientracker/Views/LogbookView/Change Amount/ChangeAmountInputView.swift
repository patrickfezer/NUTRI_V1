//
//  ChangeAmountINputView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 07.09.20.
//

import SwiftUI

struct ChangeAmountInputView: View {
    @Binding var textInput: String
    @Binding var showFinishButton: Bool
    @EnvironmentObject var cart: Cart
    var modifier: Double
    
    var body: some View {
        HStack {
            TextField("Menge in g eingeben", text: $textInput) { isEdeting in
                showFinishButton = true
            } onCommit: {
                print("Commit")
            }
            .keyboardType(.decimalPad)
            
            if showFinishButton {
                Button("Fertig") {
                    self.hideKeyboard()
                    showFinishButton = false

                }
            }
        }
    }
}

struct ChangeAmountInputView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeAmountInputView(textInput: .constant(""), showFinishButton: .constant(true), modifier: 100)
        
    }
}
