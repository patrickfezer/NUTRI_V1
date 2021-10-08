//
//  AmountView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 28.08.20.
//

import SwiftUI


struct AmountView: View {
    
    @EnvironmentObject var cart: Cart
    
    @State private var textInput = ""
    @State private var orderFinished = false
    @State private var showText = false
    @State private var textFieldIsEdeting = false
    @State private var convertedText: Double = 0
    @State private var chosedCategorie = 0
    
    @Binding var showAmountView: Bool
    
    // array with possible categories
    static let categorie = ["Mahlzeit 1", "Mahlzeit 2", "Mahlzeit 3", "Mahlzeit 4", "Mahlzeit 5", "Mahlzeit 6", "Mahlzeit 7", "Mahlzeit 8", "Mahlzeit 9", "Mahlzeit 10", "Mahlzeit 11", "Mahlzeit 12"]
    
    var product: Product
    
    var body: some View {
        
        // Date in EU standart
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let dateString = formatter.string(from: cart.date)
        
        // return the main view
        return NavigationView {
            
                Form {
                    Section(header: Text("Mengenangabe")) {
                        
                        // input for the amount
                        AmountInputView(textInput: $textInput, TextfieldIsEdeting: $textFieldIsEdeting)
                    }
                    
                    // selct cateroy and date
                    Section(header: Text("Kategorie & Datum")) {
                        
                        // picker to choose the catergory
                        Picker("Kategorie", selection: $chosedCategorie) {
                            ForEach(0 ..< AmountView.categorie.count) {
                                Text(AmountView.categorie[$0])
                            }
                            
                        }
                        
                        // DatePicker for choosing the date
                        DatePickerListView(date: $cart.date)
                        
                    }
                    
                    // nutrition facts in realtime
                    productNutritionCollectionView(product: product, modifier:
                                                    Double(String.convertToDouble(textInput))!)
                }
                
                // using primary foregroundcolor to prevent layout bug.
                .foregroundColor(.primary)
                .navigationBarTitle(Text("Mengenauswahl"), displayMode: .inline)
            
                // navigationbar items to finish or cancel the order
                .navigationBarItems(leading: Button("Abbrechen") {
                    self.showAmountView = false
                    
                }
                .foregroundColor(.blue), trailing: Button("Hinzufügen") {
                    
                    self.showAmountView = false
                    orderFinished = true
                    
                    // definition of the order
                    let order = Order(product: product, modifier: Double(String.validDouble(textInput))!, meal: AmountView.categorie[chosedCategorie], date: dateString)
                    
                    // add order to cart
                    cart.add(order: order)
                    
                    // removing the text input
                    textInput = ""

                    // hide the keyboard
                    hideKeyboard()

                    // console output for debugging
                    print("Value modifier: " + String.convertToDouble(textInput))

                    print("order finished: \(orderFinished)")

                    print(dateString)
                }
                
                // does not work automatically in this view.
                .foregroundColor((textFieldIsEdeting || textInput == "") ? Color.secondary : Color.blue)
                
                // Button is disabled
                .disabled(textInput == "" || textFieldIsEdeting))
        }
    }
}

#if DEBUG
struct AmountView_Previews: PreviewProvider {
    
    static var previews: some View {
        AmountView(showAmountView: .constant(false), product: Product.exampleProduct).environmentObject(Cart())
                .environment(\.colorScheme, .dark)
    }
}
#endif
