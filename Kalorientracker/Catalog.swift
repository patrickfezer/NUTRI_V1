//
//  catalog.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 27.08.20.
//

import SwiftUI

struct Category: Codable, Identifiable {
    var id: UUID
    var name: String
    var products: [Product]
}

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
    
    var fullImage: String {
        name.replacingOccurrences(of: " ", with: "").lowercased()
    }
    
    var previewImage: String {
        "\(fullImage)_preview"
    }
    
    #if DEBUG
    static let exampleProduct = Product(id: UUID(), name: "Rumpsteak", manufacturer: "", kcal: "130", protein: "22.4", carbs: "0", sugar: "0", roughage: "0", fat: "4.5", saturated: "3")
    #endif
}


struct Catalog: View {
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}


struct Catalog_Previews: PreviewProvider {
    static var previews: some View {
        Catalog()
    }
}
