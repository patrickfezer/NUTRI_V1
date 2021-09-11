//
//  LogbookProductListView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 01.09.20.
//

import SwiftUI

struct LogbookProductListView: View {
    
    var product: Product
    var modifier: Double
    var id: UUID

    
    var body: some View {
        
        // taking the modifier using id of product
        NavigationLink(destination: LogbookProductDetailView(product: product, id: id)) {
            HStack {
                Text(product.name)
                Spacer()
                let kcalConverted = Double(product.kcal)! / 100 * modifier
                Text(String(format: "%.1f", kcalConverted) + " kcal")
            }
            .id(UUID())
            .frame(width: nil, height: 30, alignment: .center)
            .animation(.default)
        }
    }
}

#if DEBUG
struct LogbookProductListView_Previews: PreviewProvider {
    static var previews: some View {
        LogbookProductListView(product: Product.exampleProduct, modifier: 100, id: UUID())
    }
}
#endif
