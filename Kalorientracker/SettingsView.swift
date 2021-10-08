//
//  SettingsView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 27.08.20.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var input = "0"
    @State private var show = false
    @EnvironmentObject var cart: Cart
    @EnvironmentObject var appData: AppData

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
                    ImportListView()
                    ExportListView()
                }
                
                Section {
                    Link(destination: URL(string: url)!) {
                        
                        HStack {
                            
                            LabelIconView(icon: "ant.fill", iconColor: .white, backgroundColor: .blue, text: "Teilnahme am TestFlight Betaprogramm")
                        }
                        
                    }
                } header: {
                    Text("Betaprogramm")
                } footer: {
                    Text("© Patrick Fezer")
                }


                
                if AppData.devMode {
                    Section(header: Text("Dev Settings")) {
//                        TestListView()
                        Button("DEV BUTTON") {
                            appData.appsFirstStart = false
                        }
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
