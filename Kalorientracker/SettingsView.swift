//
//  SettingsView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 27.08.20.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var input = "0"
    @EnvironmentObject var cart: Cart
    @State private var show = false
    
    
    var body: some View {
        
        NavigationView {
            List {
                Section(header: Text("Dashboard")) {
                    DestinationAmountListView().environmentObject(cart)
                }

                Section(header: Text("Support & Feedback")) {
                    ContactListView()
                }

                Section(header: Text("Informationen")) {
                    InformationListView() 
                }
                
                Section(header: Text("Zurücksetzen")) {
                    ResetListView()
                }
            }
            .listStyle(GroupedListStyle())
            .navigationTitle(Text("Einstellungen"))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView().environmentObject(Cart())
    }
}
