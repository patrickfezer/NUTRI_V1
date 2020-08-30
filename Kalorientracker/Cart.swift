//
//  Cart.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 27.08.20.
//

import Foundation

struct Order: Equatable, Identifiable, Codable {
    var id = UUID()
    var product: Product
    var quantity: Int
}


class Cart: ObservableObject {
    @Published var orders = [Order]()
    var date: Date
    
    init(date: Date) {
        self.date = date
    }
    
    // add to order
    func add(order: Order) {
        self.orders.append(order)
    }
    
    // remove from order
    func remove(order: Order) {
        if let index = orders.firstIndex(of: order) {
            orders.remove(at: index)
        }
    }
    
}
