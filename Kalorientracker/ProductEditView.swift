//
//  OwnProductEditView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 22.09.20.
//
import SwiftUI

struct ProductEditView: View {
    @EnvironmentObject var productOrder: CollectedProductOrder
    @Binding var showView: Bool
    @Binding var originalProduct: Product
    @State private var product = Product.emtptyProduct
    @State private var categoryIndex = ProductAmountInputView.category.firstIndex(of: "Sonstiges")!
    @State private var blockRefresh = false


    let id: UUID

    var body: some View {

        NavigationView {

            ProductAmountInputView(productName: $product.name, manufacturer: $product.manufacturer, kcal: $product.kcal, protein: $product.protein, carbs: $product.carbs, sugar: $product.sugar, roughage: $product.roughage, fat: $product.fat, saturated: $product.saturated, leucin: $product.leucin, salt: $product.salt, chosedCategory: $categoryIndex).environmentObject(productOrder)

            
                .onAppear(perform: {

                    if !blockRefresh {
                        
                        DispatchQueue.main.async {
                            product = originalProduct
                            productOrder.products.forEach { searchedProduct in
                                if searchedProduct.product.id == product.id {
                                    categoryIndex = ProductAmountInputView.category.firstIndex(of: searchedProduct.category)!
                                }
                            }
                        }
                        
                        
                        blockRefresh = true
                    }
            })
            
            .navigationBarTitle(Text("Bearbeiten"), displayMode: .inline)
            .navigationBarItems(leading: Button("Abbrechen") {
                self.showView = false
            }, trailing: Button("Fertig") {
                
                // View ausblenden
                self.showView = false
                
                // Producktwerte validieren
                product.kcal = String.validDouble(product.kcal)
                product.fat = String.validDouble(product.fat)
                product.saturated = String.validDouble(product.saturated)
                product.carbs = String.validDouble(product.carbs)
                product.roughage = String.validDouble(product.roughage)
                product.sugar = String.validDouble(product.sugar)
                product.protein = String.validDouble(product.protein)
                product.leucin = String.validDouble(product.leucin)
                product.salt = String.validDouble(product.salt)
                
                originalProduct = product

                // Verschieben in Hintergrundprozess
                DispatchQueue.main.async {
                    for index in 0..<self.productOrder.products.count {
                        if productOrder.products[index].product.id == product.id {
                            productOrder.products[index].product = product
                            productOrder.products[index].category = ProductAmountInputView.category[categoryIndex]
                            productOrder.save()
                            break
                        }
                    }
                }
            })
        }
    }
}

#if DEBUG
struct ProductEditView_Previews: PreviewProvider {
    static var previews: some View {
        ProductEditView(showView: .constant(true), originalProduct: .constant(Product.exampleProduct), id: UUID()).environmentObject(CollectedProductOrder())
    }
}
#endif
