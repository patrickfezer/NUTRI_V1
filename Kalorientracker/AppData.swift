//
//  AppData.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 19.10.20.
//

import SwiftUI

class AppData: ObservableObject {
    let saveKey: String = "firstStart"
    @Published var appsFirstStart: Bool
    static var devMode = true
    
    
    
    func saveValue() {
        appsFirstStart = true
        UserDefaults.standard.set(appsFirstStart, forKey: saveKey)
    }
    
    init() {
        appsFirstStart = UserDefaults.standard.bool(forKey: saveKey)
    }
}
