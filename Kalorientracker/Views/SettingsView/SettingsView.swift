//
//  SettingsView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 27.08.20.
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject var cart: Cart
    @EnvironmentObject var appData: AppData
    @State private var showAlert = false

    let url = "https://testflight.apple.com/join/SBQywh44"
    
    var body: some View {
        
        NavigationView {
            List {
                Section(header: Text("dashboard")) {
                    DestinationAmountListView()
                        .environmentObject(cart)
                }

                Section(header: Text("contact")) {
                    ContactListView()
                }

                Section(header: Text("information")) {
                    InformationListView() 
                }
                
                Section(header: Text("storageManagement")) {
                    ResetListView()
                }
                
                Section(header: Text("Backup")) {
                    ImportListView()
                    ExportListView()
                }
                
                Section {
                    Link(destination: URL(string: url)!) {
                        
                        HStack {
                            
                            LabelIconView(icon: "ant.fill", iconColor: .white, backgroundColor: .blue, text: Text("TestFlightParticipation"))
                        }
                        
                    }
                } header: {
                    Text("Betaprogramm")
                } footer: {
                    Text("© Patrick Fezer")
                }


                
                if AppData.devMode {
                    Section(header: Text("Dev Settings")) {
                        Button("dev") {
                            appData.appsFirstStart = false
                        }
                    }
                }
                
                
            }
            .listStyle(GroupedListStyle())
            .navigationTitle(Text("settings"))
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(Cart())
            .environment(\.colorScheme, .dark)
    }
}
