//
//  OwnProductFilteredListView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 19.09.20.
//

import SwiftUI

struct ProductFilteredListView: View {
    let showProduct: Bool
    let filter: String
    @Environment (\.editMode) private var editMode
    @StateObject var ownProduct: CollectedProductOrder
    
    func deleteProducts(at offsets: IndexSet) {
        ownProduct.products.remove(atOffsets: offsets)
        ownProduct.save()
    }
    
    func move(from source: IndexSet, to destination: Int) {
        ownProduct.products.move(fromOffsets: source, toOffset: destination)
        ownProduct.save()
    }
    
    var body: some View {
        
        if showProduct {
            Section(header: Text(filter)) {
                ForEach(ownProduct.products) { ownProduct in
                    if ownProduct.category == filter {
                        ProductListView(product: ownProduct.product)
                    }
                }
                
//                .deleteDisabled(!editMode!.wrappedValue.isEditing)
                
                .onDelete(perform: { indexSet in
                    deleteProducts(at: indexSet)
                })
                
                
                .onMove(perform: { indices, newOffset in
                    move(from: indices, to: newOffset)
                })
                
                }
            }
        }
    }


struct ProductFilteredListView_Previews: PreviewProvider {
    static var previews: some View {
        ProductFilteredListView(showProduct: true, filter: "Fleisch", ownProduct: CollectedProductOrder())
            .environmentObject(CollectedProductOrder())
    }
}
