//
//  FirstStartApp.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 29.09.20.
//

import SwiftUI

struct FirstStartApp: View {
    @EnvironmentObject var cart: Cart
    @EnvironmentObject var appData: AppData
    @State private var showFinishButton = false
    @Binding var showView: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
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
                        
                        Group {
                            Text("Hier kannst du deine persönliche Zielwerte eintragen. Diese kannst du später in den Einstellungen ändern.\nTrägst du in einem Feld keinen Wert ein, wird im Dashboard das zugehörige Balkendiagramm nicht angezeigt.").padding(2)
                            Button(action: {
                                self.hideKeyboard()
                                cart.saveProductValues()
                                showView.toggle()
                                appData.saveValue()
                            }, label: {
                                HStack {
                                    Spacer()
                                    Text("Weiter").padding(10)
                                    Spacer()
                                }
                            })
                        }
                        
                    }
                }
                
                .navigationBarTitle(Text("Einrichtung"), displayMode: .inline)
                .navigationBarItems(trailing: Button("Fertig") {
                    self.hideKeyboard()
                    showFinishButton = true
                }.disabled(!showFinishButton)
                )
            }
        }
    }
}

struct FirstStartApp_Previews: PreviewProvider {
    static var previews: some View {
        FirstStartApp(showView: .constant(false)).environmentObject(Cart())
    }
}
