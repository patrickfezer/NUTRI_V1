//
//  AppTabView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 27.08.20.
//

import SwiftUI

struct AppTabView: View {
    
    @State private var currentTab = 0
//    @EnvironmentObject var ownProduct: OwnProductConfiguration
//    @EnvironmentObject var cart: Cart
     
    var body: some View {
        
        
        TabView(selection: $currentTab) {
            DashboardView()
                .tabItem {
                    Image(systemName: "chart.bar.xaxis")
                    Text("Dashboard")
                }.tag(0)


            LogbookView()
                .tabItem {
                    Image(systemName: "book.closed")
                    Text("Logbuch")
                }.tag(1)


            OwnProductsView()
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
                    Text("Lebensmittel")
                }.tag(2)

            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Einstellungen")
                }.tag(3)
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    
    static var previews: some View {
        AppTabView()
            .environmentObject(Cart())
            .environmentObject(OwnProductConfiguration())
    }
}
