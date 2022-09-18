//
//  InformationView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 05.09.20.
//

import SwiftUI

struct ButtonLabel: View {
    var body: some View {
        Image(systemName: "xmark")
            .resizable()
            .frame(width: 12, height: 12, alignment: .center)
            .foregroundColor(.primary)
            .padding(10)
            .background(Color.secondary)
            .clipShape(Circle())
    }
}

struct InformationView: View {
    
    @State private var showWebView = false
    
    let url = "https://www.fezerapps.com/nutri-datenschutzerklaerung/"
    
    var body: some View {
        List {
            
            // App information
            Section {
                HStack {
                    Text("version")
                    Spacer()
                    Text(AppInformation.appVersion + " (\(AppInformation.buildVersion))")
                }
            } header: {
                Text("appInfo")
            }

            // Datenschutz
            Section {
                Button {
                    showWebView.toggle()
                } label: {
                    
                    LabelIconView(icon: "hand.raised.fill", iconColor: .white, backgroundColor: .blue, text: Text("privacyProtection"))
                }
            } header: {
                Text("privacy")
            }
            
            
            
            Section {
                
                Link(destination: URL(string: "https://www.fezerapps.com")!) {
                    LabelIconView(icon: "globe", iconColor: .white, backgroundColor: .blue, text: Text("webSite"))
                }

            } header: {
                Text("webSite")
            }

        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("info", displayMode: .inline)
        .listStyle(InsetGroupedListStyle())
        .sheet(isPresented: $showWebView, onDismiss: {
            showWebView = false
        }, content: {
            if #available(iOS 15.0, *) {
                NavigationView {
                    WebView(url: url)
                        .navigationTitle(Text("privacyProtection"))
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarItems(trailing: Button(action: {
                            showWebView = false
                        }, label: {
                            ButtonLabel()
    
                        }))
                }.interactiveDismissDisabled(true) // Only available in iOS 15 or later
            } else {
                // iOS 14
                NavigationView {
                    WebView(url: url)
                        .navigationTitle(Text("privacyProtection"))
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationBarItems(trailing: Button(action: {
                            showWebView = false
                        }, label: {
                            ButtonLabel()
                        }))
                }
            }
        })
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InformationView()
                .colorScheme(.dark)
        }
        
        NavigationView {
            InformationView()
        }
    }
}

struct ButtonLabel_Preview: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ButtonLabel()
        }
    }
}
