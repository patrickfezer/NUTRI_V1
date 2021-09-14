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
    let dev = false
    
    let url = "https://testflight.apple.com/join/SBQywh44"
    
    
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
                
                Section(header: Text("Speichermanagement")) {
                    ResetListView()
                }
                
                Section(header: Text("Backup")) {
                    ExportListView()
                    ImportListView()
                }
                
                Section {
                    Link(destination: URL(string: url)!) {
                        
                        HStack {
                            
                            Image(systemName: "ant.circle")
                            Text("Teilnahme am TestFlight Betaprogramm")
                            Spacer()
                        }
                        
                    }
                } header: {
                    Text("Betaprogramm")
                } footer: {
                    Text("© Patrick Fezer")
                }


                
                if dev {
                    Section(header: Text("Test")) {
                        TestListView()
                    }
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
