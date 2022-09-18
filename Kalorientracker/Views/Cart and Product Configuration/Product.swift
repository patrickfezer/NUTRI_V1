//
//  catalog.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 27.08.20.
//

import Foundation

// product definition
struct Product: Codable, Identifiable, Equatable {
    var id: UUID
    var name: String
    var manufacturer: String
    var kcal: String
    var protein: String
    var carbs: String
    var sugar: String
    var roughage: String
    var fat: String
    var saturated: String
    var leucin: String
    var salt: String
    
    // product name is made of manufacturer name + product name
    var productName: String {
        
        var temp = ""
        
        if manufacturer != "" {
            temp = manufacturer + " " + name
        } else {
            temp = name
        }
        
        return temp
    }
    
    // image name for the detail view -- using 400x400px
    var fullImage: String {
        let productName = manufacturer + name
        
        return productName.replacingOccurrences(of: " ", with: "").lowercased()
    }
    
    // image name for the list view -- using 120x120px
    var previewImage: String {
        
        return fullImage + "_preview"
    }
    
    static let emtptyProduct = Product(id: UUID(), name: "", manufacturer: "", kcal: "", protein: "", carbs: "", sugar: "", roughage: "", fat: "", saturated: "", leucin: "", salt: "")
    
    
    // example product for debugging the app -- all views for Debugging preview need to be in if debug statement
    #if DEBUG
    static let exampleProduct = Product(id: UUID(), name: "Rumpsteak", manufacturer: "", kcal: "130", protein: "22.4", carbs: "0", sugar: "0", roughage: "0", fat: "4.5", saturated: "3", leucin: "1.5", salt: "0.6")
    #endif
}
