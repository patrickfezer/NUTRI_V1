//
//  OwnProductConfiguration.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 16.09.20.
//

import Foundation


struct OwnProductOrder: Identifiable, Codable {
    var id = UUID()
    var product: Product
    var category: String
}

class OwnProductConfiguration: ObservableObject {
    @Published var products = [OwnProductOrder]()
    let saveKey = "ownProduct"
    
    func add(order: OwnProductOrder) {
        self.products.append(order)
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(self.products) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([OwnProductOrder].self, from: data) {
                self.products = decoded
            } else {
                self.products = []
            }
        }
        
        
    }
}
