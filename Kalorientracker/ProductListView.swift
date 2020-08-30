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
                Image(product.previewImage)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.black, lineWidth: 1))
                    .shadow(radius: 2)
                    .padding(.trailing, 2)
                
                Group {
                    VStack(alignment: .leading) {
                        Text(product.name)
                            .font(.headline)
                        
                        HStack {
                            
                            // check for protein
                            if Double(product.protein)! >= 15 {
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
                            if Double(product.carbs)! >= 60 {
                                LabelView(text: "Viel Kohlenhydr.", backgroundColor: .yellow)
                            } else {
                                LabelView(text: "Wenig Kohlenhydr.", backgroundColor: .purple)
                            }

                        }
                    }
                }
                .padding(.leading, 10)
            }
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
