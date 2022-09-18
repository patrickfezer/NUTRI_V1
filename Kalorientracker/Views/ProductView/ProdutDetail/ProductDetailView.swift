//
//  ProductDetail.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 27.08.20.
//

import SwiftUI

struct ProductDetailView: View {

    @EnvironmentObject var cart: Cart
    @EnvironmentObject var ownProduct: CollectedProductOrder
    @State private var showAmountView = false
    @State private var showEditView = false
    @State var product: Product
    
    var body: some View {
        
        ZStack {
            Form {
                productNutritionCollectionView(product: product, modifier: 100)
            }
            // Titel for Navigation bar
            .navigationBarTitle(Text(product.name), displayMode: .inline)
            
            .navigationBarItems(trailing: Button("Bearbeiten") {
                self.showEditView = true
                
            }).sheet(isPresented: $showEditView, content: {
                ProductEditView(showView: $showEditView, originalProduct: $product, id: product.id)
                    .environmentObject(ownProduct)
            })
            ProductButton(showView: $showAmountView, symbol: "doc.badge.plus", color: Color.blue)
                
                .sheet(isPresented: $showAmountView, content: {
                AmountView(showAmountView: $showAmountView, product: product).environmentObject(cart)
        })
        }
    }

}

#if DEBUG
struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        
        
        Group {
            NavigationView {
                ProductDetailView(product: Product.exampleProduct).environmentObject(Cart())
                    .environment(\.colorScheme, .dark)
            }
            
            NavigationView {
                ProductDetailView(product: Product.exampleProduct).environmentObject(Cart())
                    .environment(\.colorScheme, .light)
            }
        }
    }
}
#endif
