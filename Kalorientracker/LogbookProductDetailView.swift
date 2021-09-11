//
//  LogbookProductDetailView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 01.09.20.
//

import SwiftUI

struct LogbookProductDetailView: View {
    
    @EnvironmentObject var cart: Cart
    var product: Product
    var id: UUID
    @State private var showChangeAmountView = false
    
    // products applyed modifier
    var productModifier: Double {
        
        var temp: Double = 0
        
        for index in 0..<cart.orders.count {
            
            if cart.orders[index].id == id {
                temp = cart.orders[index].modifier
                cart.save()
                break
            }
            
        }
        
        return temp
    }
    
    var body: some View {
        ZStack {
            Form {
                productNutritionCollectionView(product: product, modifier: productModifier)
                }
            
            ProductButton(showView: $showChangeAmountView, symbol: "pencil", color: Color.blue).sheet(isPresented: $showChangeAmountView, content: {
                ChangeAmountView(product: product, id: id, showView: $showChangeAmountView).environmentObject(cart)
        })
                // Navigation bar is automatically gernerated because this view is called using navigation link
            .navigationBarTitle(Text(product.name), displayMode: .inline)
        }
    }
    
    
}

#if DEBUG
struct LogbookProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LogbookProductDetailView(product: Product.exampleProduct, id: UUID()).environmentObject(Cart())
        }
    }
}
#endif
