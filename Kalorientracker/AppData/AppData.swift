//
//  AppData.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 19.10.20.
//

import SwiftUI

class AppData: ObservableObject {
    
    @Published var appsFirstStart: Bool
//    @Published var colorMode: ColorScheme
//    @Published var language: String = "en"
    private let saveKey: String = "firstStart"
    
    static public let devMode = false
    
    
    func saveValue() {
        appsFirstStart = true
        UserDefaults.standard.set(appsFirstStart, forKey: saveKey)
    }
    
    
    init() {
        appsFirstStart = UserDefaults.standard.bool(forKey: saveKey) // Default = false
    }
}
