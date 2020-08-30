//
//  KalorientrackerApp.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 27.08.20.
//

import SwiftUI

@main
struct KalorientrackerApp: App {
    
    var body: some Scene {
        WindowGroup {
            AppTabView()
        }
    }
}

struct KalorientrackerApp_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
