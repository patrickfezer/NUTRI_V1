//
//  AppData.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 19.10.20.
//

import SwiftUI

class AppData: ObservableObject {
    @Published var firstStart = Bool()
    let saveKey = "firstStart"
    
    func saveValue() {
        firstStart = false
        if let encoded = try? JSONEncoder().encode(firstStart) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    init() {
        if let firstStartOfApp = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode(Bool.self, from: firstStartOfApp) {
                firstStart = decoded
            }
        } else {
            firstStart = true
        }
    }
}
