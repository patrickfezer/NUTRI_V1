//
//  DestinationAmountTraining.swift
//  NUTRI
//
//  Created by Patrick Fezer on 29.11.21.
//

import Foundation
import SwiftUI
import WidgetKit

class destinationValues: Codable {

    var kcal: String
    var carbs: String
    var fat: String
    var protein: String
    var saturated: String
    var roughage: String
    var sugar: String
    var leucin: String
    var salt: String
    
    // Alle Werte mit Standard belegen
    init() {
        kcal = ""
        carbs = ""
        fat = ""
        protein = ""
        saturated = ""
        roughage = ""
        sugar = ""
        leucin = ""
        salt = ""
    }
}
 

class destinationAmountWithTraining {
    private let saveKeyDestinationValues = "saveKeyDestinationValues"
    var entries:[String : destinationValues] = [:] // Default mit leeren Dictionary initialisieren
    var resetValueEntries = [DestinationAmountView.categories[0]:destinationValues(), DestinationAmountView.categories[1]:destinationValues(), DestinationAmountView.categories[2]:destinationValues()]
    
    // User Defaults
    func save() {
        if let encoded = try? JSONEncoder().encode(entries) {
            UserDefaults.standard.set(encoded, forKey: self.saveKeyDestinationValues)
        }
    }
    
    func removeAllValues() {
        entries = resetValueEntries
        save()
    }
    
    init() {
        
        if let data = UserDefaults.standard.data(forKey: self.saveKeyDestinationValues) {
            if let decoded = try? JSONDecoder().decode([String : destinationValues].self, from: data) {
                entries = decoded
                print("Erfolgreich decoded")
            }
        } else {
            // Mit Standardwerten belegen
            entries = resetValueEntries
            print("Entries for destination amount initialized with default values")
        }
    }
}
