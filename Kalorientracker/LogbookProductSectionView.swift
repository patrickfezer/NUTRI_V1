//
//  LogbookProductSectionView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 02.09.20.
//

import SwiftUI

struct LogbookProductSectionView: View {
    
    @StateObject var cart: Cart
    let category: String
    let date: String
    
    
    // Delete Products from cart
    func deleteProducts(at offsets: IndexSet) {
        cart.orders.remove(atOffsets: offsets)
        cart.save()
    }
    
    func move(from source: IndexSet, to destination: Int) {
        
        cart.orders.move(fromOffsets: source, toOffset: destination)
        cart.save()
    }
    
    
    
    var body: some View {
        
        
        Section(header: Text(category)) {
            

            ForEach(cart.orders) { order in
                if order.meal == category && order.date == date {
                    LogbookProductListView(product: order.product, modifier: order.modifier, id: order.id)
                }
            }
            // delet a product
            .onDelete(perform: { indexSet in
                deleteProducts(at: indexSet)
            })
            .onMove(perform: { indices, newOffset in
                move(from: indices, to: newOffset)
            })
            EachMealTotalListView(filter: category, date: date)
                .foregroundColor(.blue)
        }
        .textCase(nil)
        
    }
}

struct LogbookProductSectionView_Previews: PreviewProvider {
    static var previews: some View {
        LogbookProductSectionView(cart: Cart(), category: "Mahlzeit 1", date: "20.10.1997")
        
    }
}
