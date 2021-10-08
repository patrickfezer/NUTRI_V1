//
//  StartScreen.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 30.09.20.
//

import SwiftUI



struct StartScreen: View {
    @EnvironmentObject var cart: Cart
    @EnvironmentObject var appData: AppData
    @EnvironmentObject var ownProduct: OwnProductConfiguration
    var body: some View {
        
        if !appData.appsFirstStart {
            FirstStartApp(showView: $appData.appsFirstStart)
                .environmentObject(cart)
                .environmentObject(appData)
        } else {
            AppTabView()
                .environmentObject(cart)
                .environmentObject(ownProduct)
        }
    }
}

struct StartScreen_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
            .environmentObject(Cart())
            .environmentObject(OwnProductConfiguration())
            .environmentObject(AppData())
    }
}
