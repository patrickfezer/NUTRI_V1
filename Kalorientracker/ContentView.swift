//
//  ContentView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 27.08.20.
//

import SwiftUI

struct ContentView: View {
    
    // decoding jason file
    let catalog = Bundle.main.decode([Category].self, from: "Catalog.json")
    
    // searchBar var for text string
    @State private var searchText = ""
    
    var body: some View {
        NavigationView {
            
            // Vstack for list and other objects
            VStack {
                
                // SearchBarView
                SearchBarView(searchText: $searchText) // 2-way binding for search text
                
//                SearchBar(text: $searchText)
                
                // list with all products in sctions
                List {
                    ForEach(self.catalog) { section in

                        
                        // Section for products
                        Section(header: Text(section.name)) {
                            
                            // All products in sections
                            // Filtered alphabetical and filters for searchText
                            ForEach(section.products.sorted(by: {
                                $0.name < $1.name
                            }).filter({
                                self.searchText.isEmpty ? true : $0.name.lowercased().contains(self.searchText.lowercased())
                            })) { product in
                                ProductListView(product: product)
                                    // Padding for top and bottom
                                    .padding(.bottom, 3)
                                    .padding(.top, 3)
                            }
                        }
                    }
                }
                
                // list style
                .listStyle(InsetGroupedListStyle())
            }
            // titel for navigationbar
            .navigationTitle("Lebensmittel")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
