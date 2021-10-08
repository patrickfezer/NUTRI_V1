//
//  ImportView.swift
//  ImportView
//
//  Created by Patrick Fezer on 13.09.21.
//

import SwiftUI

struct ImportView: View {
    @EnvironmentObject var cart: Cart
    @EnvironmentObject var ownProduct: OwnProductConfiguration
    @State private var showImportViewFood = false
    @State private var showImportViewLogbook = false
    
    var body: some View {
        Form {
            Section(header: Text("Lebensmittel"), content: {
                
                NavigationLink("Lebensmittel Importieren", destination: FoodImportView())
            })
            
            Section(header: Text("Logbuch"), content: {
                
                NavigationLink("Logbuch importeiren", destination: LogbookImportView())
            })
        }
        
        // NavigationBar settings
        .navigationTitle(Text("Importeiren"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ImportView_Previews: PreviewProvider {
    static var previews: some View {
        ImportView()
    }
}
