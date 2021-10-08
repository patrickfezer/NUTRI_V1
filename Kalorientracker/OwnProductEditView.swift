//
//  OwnProductEditView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 22.09.20.
//

import SwiftUI

struct OwnProductEditView: View {
    @EnvironmentObject var ownProduct: OwnProductConfiguration
    @Binding var showView: Bool
    @Binding var updateProduct: Product
    @State private var productName = ""
    @State private var manufacturer = ""
    @State private var kcal = ""
    @State private var protein = ""
    @State private var carbs = ""
    @State private var sugar = ""
    @State private var roughage = ""
    @State private var fat = ""
    @State private var saturated = ""
    @State private var leucin = ""
    @State private var salt = ""
    @State private var chosedCategory = ProductAmountInputView.category.firstIndex(of: "Sonstiges")!
    @State private var chosedCategoryAsString = ""
    @State private var blockRefresh = false
    
    let id: UUID
    
    var body: some View {
        
        NavigationView {
            
            ProductAmountInputView(productName: $productName, manufacturer: $manufacturer, kcal: $kcal, protein: $protein, carbs: $carbs, sugar: $sugar, roughage: $roughage, fat: $fat, saturated: $saturated, leucin: $leucin, salt: $salt, chosedCategory: $chosedCategory).environmentObject(ownProduct)
                
                .onAppear(perform: {
                    
                    if !blockRefresh {
                        blockRefresh = true
                        
                        ownProduct.products.forEach { productCollection in

                            // Check product fo needed id
                            if productCollection.product.id == id {
                                productName = productCollection.product.name
                                manufacturer = productCollection.product.manufacturer
                                kcal = productCollection.product.kcal
                                fat = productCollection.product.fat
                                saturated = productCollection.product.saturated
                                carbs = productCollection.product.carbs
                                roughage = productCollection.product.roughage
                                sugar = productCollection.product.sugar
                                protein = productCollection.product.protein
                                leucin = productCollection.product.leucin
                                salt = productCollection.product.salt
                                chosedCategoryAsString = productCollection.category
                                chosedCategory = ProductAmountInputView.category.firstIndex(of: chosedCategoryAsString) ?? ProductAmountInputView.category.count - 1
                            }
                        }
                    }
            })
            .navigationBarTitle(Text("Bearbeiten"), displayMode: .inline)
            .navigationBarItems(leading: Button("Abbrechen") {
                self.showView = false
            }, trailing: Button("Fertig") {
                self.showView = false
                
                // update productvalues that changes will directly show in the detail view of the product
                updateProduct.kcal = kcal
                updateProduct.fat = fat
                updateProduct.saturated = saturated
                updateProduct.carbs = carbs
                updateProduct.roughage = roughage
                updateProduct.sugar = sugar
                updateProduct.protein = protein
                updateProduct.leucin = leucin
                updateProduct.salt = salt
                
                // changes product values and save
                for index in 0..<ownProduct.products.count {
                    if ownProduct.products[index].product.id == id {
                        ownProduct.products[index].product.name = productName
                        ownProduct.products[index].product.manufacturer = manufacturer
                        ownProduct.products[index].product.kcal = String.validDouble(kcal)
                        ownProduct.products[index].product.fat = String.validDouble(fat)
                        ownProduct.products[index].product.saturated = String.validDouble(saturated)
                        ownProduct.products[index].product.carbs = String.validDouble(carbs)
                        ownProduct.products[index].product.roughage = String.validDouble(roughage)
                        ownProduct.products[index].product.sugar = String.validDouble(sugar)
                        ownProduct.products[index].product.protein = String.validDouble(protein)
                        ownProduct.products[index].product.leucin = String.validDouble(leucin)
                        ownProduct.products[index].product.salt = String.validDouble(salt)
                        ownProduct.products[index].category = ProductAmountInputView.category[chosedCategory]
                        
                        // save changes to product
                        ownProduct.save()
                        break
                    }
                    
                }
                
            })
        }
    }
}

#if DEBUG
struct OwnProductEditView_Previews: PreviewProvider {
    static var previews: some View {
        OwnProductEditView(showView: .constant(true), updateProduct: .constant(Product.exampleProduct), id: UUID()).environmentObject(OwnProductConfiguration())
    }
}
#endif
