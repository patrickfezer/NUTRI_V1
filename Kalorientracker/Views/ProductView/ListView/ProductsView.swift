//
//  OwnProductsView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 16.09.20.
//

import SwiftUI

struct ProductsView: View {
    @EnvironmentObject var ownProduct: CollectedProductOrder
    @Environment(\.isSearching) private var isSearching
    @State private var showConfigurationView = false
    @State private var editMode = EditMode.inactive
    var searchText: String
    let saveKey = "ownProducts"
    
    func checkForFilterKey(filterKey: String) -> Bool {
        var temp = false
        for index in 0 ..< ownProduct.products.count {
            if ownProduct.products[index].category == filterKey {
                temp = true
                break
            }
        }
        return temp
    }
    
    var body: some View {

        return NavigationView {
            ZStack {
                    List() {
                        // show products with categories if searchtext is empty
                        if searchText.isEmpty {
                            ForEach(ProductAmountInputView.category, id: \.self) { category in
                                ProductFilteredListView(showProduct: checkForFilterKey(filterKey: category), filter: category, editButtonState: editMode, ownProduct: ownProduct)
                            }
                            
                        } else if !searchText.isEmpty {
                            
                            ForEach(ownProduct.products.sorted(by: {
                                $0.product.productName < $1.product.productName
                            }).filter({
                                searchText.isEmpty || $0.product.productName.localizedCaseInsensitiveContains(searchText)
                            })) { ownProduct in
                                ProductListView(product: ownProduct.product)
                            }
                        }
                    }
                    .listStyle(GroupedListStyle())
                    .navigationBarTitle("Lebensmittel", displayMode: .automatic)
                    .navigationBarItems(trailing: EditButton().disabled(ownProduct.products.isEmpty))
                    .environment(\.editMode, $editMode)
               
                if !editMode.isEditing && !isSearching {
                    ProductButton(showView: $showConfigurationView, symbol: "plus", color: Color.blue).sheet(isPresented: $showConfigurationView, content: {
                        ProductConfigurationView(showSheet: $showConfigurationView)
                            .environmentObject(ownProduct)
                    })
                }
            }
            
//             Turn of edit mode when searchbar is avtive
            .onChange(of: searchText.isEmpty) { searchBar in
                if searchBar {
                    editMode = .inactive

                }
            }
        }
    }
}

struct OwnProductsView_Previews: PreviewProvider {
    static var previews: some View {
        ProductsView(searchText: "")
            .environmentObject(CollectedProductOrder())
    }
}
