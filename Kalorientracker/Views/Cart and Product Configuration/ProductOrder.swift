//
//  OwnProductConfiguration.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 16.09.20.
//

import Foundation


struct ProductOrder: Identifiable, Codable {
    var id = UUID()
    var product: Product
    var category: String
}

class CollectedProductOrder: ObservableObject {
    
    @Published var products = [ProductOrder]()
    public let saveKey = "ownProduct"
    
    func add(order: ProductOrder) {
        
        self.products.append(order)
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(self.products) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
        }
    }
    
    init() {
        if let data = UserDefaults.standard.data(forKey: saveKey) {
            if let decoded = try? JSONDecoder().decode([ProductOrder].self, from: data) {
                self.products = decoded
            } else {
                self.products = []
            }
        }
        
        
    }
}
