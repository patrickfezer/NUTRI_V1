//
//  ChangeAmountView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 07.09.20.
//

import SwiftUI

struct ChangeAmountView: View {
    // product and id var
    var product: Product
    var id : UUID

    // binding vars
    @Binding var showView: Bool
    
    // State vars
    @State private var textInput = ""
    @State private var showFinishButton = false
    @State private var blockRefresh = false
    @State private var chosedCategorie = 0
    
    @EnvironmentObject var cart: Cart
    
    var body: some View {
        
        // products applyed modifier
        var modifier: Double {
            
            var temp: Double = 0
            
            for index in 0..<cart.orders.count {
                
                if cart.orders[index].id == id {
                    temp = cart.orders[index].modifier
                    break
                }
                
            }
            
            return temp
        }
        
        // products applied categorie
        var chosedProductCategorie: Int {
            
            // temp vars
            var tempString = ""
            var tempDouble = 0
            
            // looking which meal is selected
            for index in 0 ..< cart.orders.count {
                if cart.orders[index].id == id {
                    tempString = cart.orders[index].meal
                    break
                }
            }
            
            // check for chosed category
            for index in 0 ..< AmountView.categorie.count {
                if tempString == AmountView.categorie[index] {
                    tempDouble = index
                    break
                }
            }
            
            // give back value
            return tempDouble
        }
        
        // date
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let dateString = formatter.string(from: cart.date)
        
        // view
        return NavigationView {
            Form {
                
                // change amount
                Section(header: Text("Menge ändern")) {
                    
                    // change the modifier
                    ChangeAmountInputView(textInput: $textInput, showFinishButton: $showFinishButton, modifier: modifier)

                }
                
                
                // change categorie and date
                Section(header: Text("Kategorie & Datum")) {
                    Picker("Kategorie", selection: $chosedCategorie) {
                        
                        ForEach(0 ..< AmountView.categorie.count) {
                            Text(AmountView.categorie[$0])
                            
                        }
                    }
                    
                    // DatePicker
                    DatePickerListView(date: $cart.date)
                }
                
                productNutritionCollectionView(product: product, modifier: Double(String.convertToDouble(textInput)) ?? modifier)
                
            }
            // title of the navigationbar
            .navigationBarTitle(Text("Mengenangabe"), displayMode: .inline)
            
            // Button to close the view
            .navigationBarItems(
                leading: Button("Abbrechen") {
                self.hideKeyboard()
                self.showView = false
            },
            
            trailing: Button("Fertig") {
                self.hideKeyboard()
                self.showView = false
                for index in 0..<cart.orders.count {
                    if cart.orders[index].id == self.id {
                        cart.orders[index].modifier = Double(String.validDouble(textInput))!
                        cart.orders[index].date = dateString
                        cart.orders[index].meal = AmountView.categorie[chosedCategorie]
                        cart.save()
                        break
                        }
                    }
                }
            .disabled(showFinishButton))
            
            // assignement of values when view appears
            .onAppear(perform: {
                
                if !blockRefresh {
                    blockRefresh = true
                    self.chosedCategorie = chosedProductCategorie
                    self.textInput = String(format: "%.1f", modifier)
                }
            })
        }
    }
}

#if DEBUG
struct ChangeAmountView_Previews: PreviewProvider {
    static var previews: some View {

        ChangeAmountView(product: Product.exampleProduct, id: UUID(), showView: .constant(false)).environmentObject(Cart())
            .environment(\.colorScheme, .dark)
    }
}
#endif
