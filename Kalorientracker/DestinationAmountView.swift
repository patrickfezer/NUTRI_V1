//
//  DestinationAmountView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 04.09.20.
//

import SwiftUI
import WidgetKit

struct DestinationAmountView: View {
    @EnvironmentObject var cart: Cart
    @State private var showDeleteConfirmationView = false
    @State private var defaultValuesCommited = false
    @State private var showFinishButton = false
    
    var body: some View {
        
        List {
            Section(header: Text("Zielwerte einstellen")) {
                Group {
                    DestinationAmountInputView(productName: "Kalorien", textValue: $cart.destinationKcal, isEdeting: $showFinishButton)
                    DestinationAmountInputView(productName: "Fett", textValue: $cart.destinationFat, isEdeting: $showFinishButton)
                    DestinationAmountInputView(productName: "Gesättigte Fettsäuren", textValue: $cart.destinationSaturated, isEdeting: $showFinishButton)
                    DestinationAmountInputView(productName: "Carbs", textValue: $cart.destinationCarbs, isEdeting: $showFinishButton)
                    DestinationAmountInputView(productName: "Ballaststoffe", textValue: $cart.destinationRoughage, isEdeting: $showFinishButton)
                    DestinationAmountInputView(productName: "Zucker", textValue: $cart.destinationSugar, isEdeting: $showFinishButton)
                    DestinationAmountInputView(productName: "Protein", textValue: $cart.destinationProtein, isEdeting: $showFinishButton)
                    DestinationAmountInputView(productName: "L-Leucin", textValue: $cart.destinationLeucin, isEdeting: $showFinishButton)
                    DestinationAmountInputView(productName: "Salz", textValue: $cart.destinationSalt, isEdeting: $showFinishButton)
                }
                
                Text("Hier kannst du deine persönlichen Zielwerte eintragen. \nGibst du in einem Feld keinen Wert an, so wird im Dashboard das zugehörige Balkendiagramm nicht angezeigt.")
                    .padding(5)
                
                Button("Zurücksetzen") {
                    showDeleteConfirmationView = true
                }
                .actionSheet(isPresented: $showDeleteConfirmationView, content: {
                    ActionSheet(title: Text("Zurücksetzen"), message: Text("Alle Zielwerte werden unwiederruflich gelöscht."), buttons: [
                        .destructive(Text("Löschen"), action: {
                            cart.deleteAllProductValues()
                            
                            DispatchQueue.main.async {
                                WidgetCenter.shared.reloadAllTimelines()
                            }
                        }),
                        .cancel()
                    ])
                })
                .foregroundColor(.red)
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(Text("Zielwerte"), displayMode: .inline)
        .navigationBarItems(trailing: Button("Fertig", action: {
            self.hideKeyboard()
            self.showFinishButton = false
            cart.saveProductValues()
            WidgetCenter.shared.reloadAllTimelines()
        }).disabled(!showFinishButton)
        )
        .navigationBarBackButtonHidden(showFinishButton)
    }
}

struct DestinationAmountView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DestinationAmountView().environmentObject(Cart())
        }
    }
}
