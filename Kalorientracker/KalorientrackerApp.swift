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
    let saveKey = "firstStart"
    var body: some Scene {
        
        WindowGroup {
            
            StartScreen()
                .environmentObject(Cart())
                .environmentObject(AppData())
                .environmentObject(OwnProductConfiguration())
        }
    }
}

struct KalorientrackerApp_Previews: PreviewProvider {

    
    static var previews: some View {
        Text("Hello, World!")
            .environmentObject(Cart())
            .environmentObject(OwnProductConfiguration())
    }
}

