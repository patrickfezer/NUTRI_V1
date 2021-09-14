//
//  InformationView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 05.09.20.
//

import SwiftUI

struct InformationView: View {
    
    @State private var tabBar = UITabBar()
    
    let url = "https://www.fezerapps.com/nutri-datenschutzerklaerung/"
    
    var body: some View {
        List {
            
            // App information
            Section {
                HStack { 
                    Text("Version:")
                    Spacer()
                    Text(AppInformation.appVersion + " (\(AppInformation.buildVersion))")
                }
            } header: {
                Text("App Informationen")
            }

            // Datenschutz
            Section {
                
                Link(destination: URL(string: url)!) {
                    HStack {
                        Image(systemName: "hand.raised.fill")
                        Text("Datenschutzerklärung")
                    }
                }
                
//                NavigationLink {
//                    WebView(url: url)
//                        .navigationTitle(Text("Datenschutzerklärung"))
//                        .onAppear {
//                            self.tabBar.isHidden = true
//                        }
//                        .onDisappear {
//                            self.tabBar.isHidden = false
//                        }
//                } label: {
//                    HStack {
//                        Image(systemName: "hand.raised.fill")
//                        Text("Datenschutzerklärung")
//                    }
//                }

                
            } header: {
                Text("Datenschutz")
            }

        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Infos", displayMode: .inline)
        .listStyle(InsetGroupedListStyle())
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InformationView()
        }
    }
}
