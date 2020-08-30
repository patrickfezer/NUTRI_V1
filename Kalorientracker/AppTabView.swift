//
//  AppTabView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 27.08.20.
//

import SwiftUI

struct AppTabView: View {
    var body: some View {
        TabView {
            DashboardView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Dashboard")
                }
            
            LogbookView()
                .tabItem {
                    Image(systemName: "tray.full.fill")
                    Text("Logbuch")
                }
            
            
            ContentView()
                .tabItem {
                    Image(systemName: "book")
                    Text("Lebensmittel")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Einstellungen")
                }
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static let cart = Cart(date: Date())
    
    static var previews: some View {
        AppTabView().environmentObject(cart)
    }
}
