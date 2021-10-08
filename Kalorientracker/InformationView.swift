//
//  InformationView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 05.09.20.
//

import SwiftUI

struct InformationView: View {
    
    @State private var showWebView = false
    
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
                Button {
                    showWebView.toggle()
                } label: {
                    
                    LabelIconView(icon: "hand.raised.fill", iconColor: .white, backgroundColor: .blue, text: "Datenschutzerklärung")
//                    HStack {
//                        Image(systemName: "hand.raised.fill")
//                        Text("Datenschutzerklärung")
//                    }
                }
            } header: {
                Text("Datenschutz")
            }

        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Infos", displayMode: .inline)
        .listStyle(InsetGroupedListStyle())
        .sheet(isPresented: $showWebView) {
            showWebView = false
        } content: {
            
            
            if #available(iOS 15.0, *) {
                NavigationView {
                    WebView(url: url)
                        .navigationTitle(Text("Datenschutzerklärung"))
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarItems(trailing: Button(action: {
                            showWebView = false
                        }, label: {
                            Image(systemName: "x.circle.fill")
                                .foregroundColor(.secondary)
                        }))
                }.interactiveDismissDisabled(true) // Only available in iOS 15 or later
            } else {
                // iOS 14
                NavigationView {
                    WebView(url: url)
                        .navigationTitle(Text("Datenschutzerklärung"))
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarItems(trailing: Button(action: {
                            showWebView = false
                        }, label: {
                            Image(systemName: "x.circle.fill")
                                .foregroundColor(.secondary)
                        }))
                }
            }
            
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InformationView()
        }
    }
}
