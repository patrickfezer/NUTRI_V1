//
//  KalorientrackerApp.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 27.08.20.
//

import SwiftUI

@main
struct KalorientrackerApp: App {
    @EnvironmentObject var appData: AppData
    var body: some Scene {
        
        WindowGroup {
            
            StartScreen()
                .environmentObject(Cart())
                .environmentObject(AppData())
                .environmentObject(CollectedProductOrder())
                // set up language
//                .environment(\.locale, Locale(identifier: "de"))
        }
    }
}

struct KalorientrackerApp_Previews: PreviewProvider {

    
    static var previews: some View {
        StartScreen()
            .environmentObject(Cart())
            .environmentObject(AppData())
            .environmentObject(CollectedProductOrder())
    }
}
