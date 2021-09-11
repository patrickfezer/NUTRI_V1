//
//  OwnProductsView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 16.09.20.
//

import SwiftUI

struct OwnProductsView: View {

    @StateObject private var searchBar = SearchBar()
    @EnvironmentObject var ownProduct: OwnProductConfiguration
    @State private var showConfigurationView = false
    @State private var editMode = EditMode.inactive
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
                    if !searchBar.searchController.isActive || searchBar.text == "" {
                        ForEach(ProductAmountInputView.category, id: \.self) { category in
                            OwnProductFilteredListView(showProduct: checkForFilterKey(filterKey: category), filter: category, editButtonState: editMode, ownProduct: ownProduct)
                        }
                    
                    } else if searchBar.searchController.isActive && searchBar.text != "" {
                        ForEach(ownProduct.products.sorted(by: {
                            $0.product.productName < $1.product.productName
                        }).filter({
                            searchBar.text.isEmpty || $0.product.productName.localizedStandardContains(searchBar.text)
                        })) { ownProduct in
                            ProductListView(product: ownProduct.product)
                        }
                    }
                }
                .add(searchBar)
//                .id(UUID())
                .listStyle(GroupedListStyle())
                .navigationBarTitle("Lebensmittel", displayMode: .automatic)
                .navigationBarItems(trailing: EditButton().disabled(ownProduct.products.isEmpty))
                .environment(\.editMode, $editMode)
                if !searchBar.searchController.isActive && !editMode.isEditing {
                    ProductButton(showView: $showConfigurationView, symbol: "plus", color: Color.blue).sheet(isPresented: $showConfigurationView, content: {
                        ProductConfigurationView(showSheet: $showConfigurationView)
                            .environmentObject(ownProduct)
                    })
                }
            }
        }
    }
}

struct OwnProductsView_Previews: PreviewProvider {
    static var previews: some View {
        OwnProductsView()
    }
}
