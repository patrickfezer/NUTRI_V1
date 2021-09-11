//
//  ProductListView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 27.08.20.
//

import SwiftUI

struct ProductListView: View {
    
    // var for the diffrent products
    var product: Product
    
    
    var body: some View {
        
        NavigationLink(destination: ProductDetailView(product: product)) {
            HStack {
                Group {
                    VStack(alignment: .leading) {
                        
                        // if statement is needet that no space will be placed if manufacturer is not included
                        Text(product.productName)
                            .font(.headline)

                        HStack {
                            
                            // check for protein
                            if Double(product.protein)! >= 12 {
                                LabelView(text: "Viel Protein", backgroundColor: .green)
                            } else {
                                LabelView(text: "Wenig Protein", backgroundColor: .blue)
                            }
                            
                            // check for fat
                            if Double(product.fat)! >= 10 {
                                LabelView(text: "Viel Fett", backgroundColor: .red)
                            } else {
                                LabelView(text: "Wenig Fett", backgroundColor: .orange)
                            }
                            
                            // check for carbs
                            if Double(product.carbs)! >= 30 {
                                LabelView(text: "Viel Kohlenhydrate", backgroundColor: .yellow)
                            } else {
                                LabelView(text: "Wenig Kohlenhydrate", backgroundColor: .purple)
                            }

                        }
                    }
                }
            }
            .frame(width: nil, height: 50, alignment: .center)
        }
    }
}


#if DEBUG
struct ProductListView_Previews: PreviewProvider {
    static var previews: some View {
        
        // Using the example product for the detail preview
        ProductListView(product: Product.exampleProduct)
    }
}
#endif
