//
//  ProductDetail.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 27.08.20.
//

import SwiftUI

struct ProductDetailView: View {
    
    @State private var showAmountView = false
    let product: Product
    
    var body: some View {
        VStack {
            // placeholder Image
            Image(product.fullImage)
                .clipShape(Circle())
                .padding(.top, 5)
            Spacer()
            
            Form {
                productNutritionCollectionView(product: product, modifier: 100)
            }
        }
        
        // Titel for Navigation bar
        .navigationBarTitle(Text(product.name), displayMode: .inline)
        
        // Button to go to amount view
        .navigationBarItems(trailing: Button(action: {
            self.showAmountView = true
        }, label: {
            Image(systemName: "plus.circle")
                .padding(.leading, 20)
        }).sheet(isPresented: $showAmountView, content: {
            AmountView(product: product)
        }))
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: Product.exampleProduct)
    }
}
