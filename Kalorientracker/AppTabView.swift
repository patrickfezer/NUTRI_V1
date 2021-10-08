//
//  AppTabView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 27.08.20.
//

import SwiftUI
import WidgetKit

struct AppTabView: View {
    
    @State private var currentTab = 0
    @EnvironmentObject var cart: Cart
    @AppStorage(ResetView.saveKeyAutoDelete) private var autoDeleteOldEntries = false
//    let autoDeleteOldEntries = UserDefaults.standard.bool(forKey: ResetView.saveKeyAutoDelete)
    
    
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
        } .onChange(of: self.cart.orders.count) { change in
            if autoDeleteOldEntries {
                self.cart.removeOldOrders()
            }
            
            // Widget daten nach einer Änderung neu laden
            WidgetCenter.shared.reloadAllTimelines()
            print(change)
        }
        
        .onChange(of: self.cart.date) { newValue in
            WidgetCenter.shared.reloadAllTimelines()
            print(newValue)
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
