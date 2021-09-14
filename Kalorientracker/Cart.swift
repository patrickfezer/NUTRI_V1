//
//  Cart.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 27.08.20.
//

import Foundation


// order
struct Order: Equatable, Identifiable, Codable {
    var id = UUID()
    var product: Product
    var modifier: Double
    var meal: String
    var date: String
}

// cart
class Cart: ObservableObject {

    // vars to save the destination amount
    @Published var orders = [Order]()
    @Published var date = Date()
    @Published var destinationKcal = String()
    @Published var destinationCarbs = String()
    @Published var destinationFat = String()
    @Published var destinationProtein = String()
    @Published var destinationSaturated = String()
    @Published var destinationRoughage = String()
    @Published var destinationSugar = String()
    @Published var destinationLeucin = String()
    @Published var destinationSalt = String()
    
    // Date Formatter
    private var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.locale = Locale(identifier: "de_DE")
        df.dateFormat = "dd.MM.yyyy"
        
        return df
    }
    
    // saveKeys for the UserDefaults
    static let saveKey = "SavedData"
    let saveKeyKcal = "kcal"
    let saveKeyCarbs = "carbs"
    let saveKeyFat = "fat"
    let saveKeyProtein = "protein"
    let saveKeySaturated = "saturated"
    let saveKeyRoughage = "roughage"
    let saveKeySugar = "sugar"
    let saveKeyLLeucin = "l-leucin"
    let saveKeySalt = "salt"
    static let savedAmountKey = "SavedAmound"
    
    
    // MARK: Class Initializer
    init() {
        
        // User Defaults for Kcal
        if let kcal = UserDefaults.standard.data(forKey: saveKeyKcal) {
            if let decoded = try? JSONDecoder().decode(String.self, from: kcal) {
                self.destinationKcal = decoded
            }
        } else {
            destinationKcal = ""
        }
        
        // User Defaults for Carbs
        if let carbs = UserDefaults.standard.data(forKey: saveKeyCarbs) {
            if let decoded = try? JSONDecoder().decode(String.self, from: carbs) {
                self.destinationCarbs = decoded
            }
        } else {
            destinationCarbs = ""
        }
        
        // User Defaults for Fat
        if let fat = UserDefaults.standard.data(forKey: saveKeyFat) {
            if let decoded = try? JSONDecoder().decode(String.self, from: fat) {
                self.destinationFat = decoded
            }
        } else {
            destinationFat = ""
        }
        
        // User Defaults for Protein
        if let protein = UserDefaults.standard.data(forKey: saveKeyProtein) {
            if let decoded = try? JSONDecoder().decode(String.self, from: protein) {
                self.destinationProtein = decoded
            }
        } else {
            destinationProtein = ""
        }
        
        // User Defaults saturated
        if let saturated = UserDefaults.standard.data(forKey: saveKeySaturated) {
            if let decoded = try? JSONDecoder().decode(String.self, from: saturated) {
                self.destinationSaturated = decoded
            }
        } else {
            destinationSaturated = ""
        }
        
        // User Defaults sugar
        if let sugar = UserDefaults.standard.data(forKey: saveKeySugar) {
            if let decoded = try? JSONDecoder().decode(String.self, from: sugar) {
                self.destinationSugar = decoded
            }
        } else {
            destinationSugar = ""
        }
        
        // User Defaults saturated
        if let saturated = UserDefaults.standard.data(forKey: saveKeySaturated) {
            if let decoded = try? JSONDecoder().decode(String.self, from: saturated) {
                self.destinationSaturated = decoded
            }
        } else {
            destinationSaturated = ""
        }
        
        // User Defaults roughage
        if let roughage = UserDefaults.standard.data(forKey: saveKeyRoughage) {
            if let decoded = try? JSONDecoder().decode(String.self, from: roughage) {
                self.destinationRoughage = decoded
            }
        } else {
            destinationRoughage = ""
        }
        
        // User Defaults leucin
        if let lleucin = UserDefaults.standard.data(forKey: saveKeyLLeucin) {
            if let decoded = try? JSONDecoder().decode(String.self, from: lleucin) {
                self.destinationLeucin = decoded
            }
        } else {
            destinationLeucin = ""
        }
        
        // User Defaults leucin
        if let salt = UserDefaults.standard.data(forKey: saveKeySalt) {
            if let decoded = try? JSONDecoder().decode(String.self, from: salt) {
                self.destinationSalt = decoded
            }
        } else {
            destinationSalt = ""
        }
        
        // User Defaults for order
        if let data = UserDefaults.standard.data(forKey: Self.saveKey) {
            if let decoded = try? JSONDecoder().decode([Order].self, from: data) {
                self.orders = decoded
            }
        } else {
            self.orders = []
        }
        
        
        
    }
    
   // MARK: save a product value to the user defaults
    func saveProductValue(product: String, saveKey: String) {
        if let encoded = try? JSONEncoder().encode(product) {
            UserDefaults.standard.set(encoded, forKey: saveKey)
            print("saved")
        }
    }
    
    // delete all destination values
    func deleteAllProductValues() {
        destinationKcal = ""
        destinationCarbs = ""
        destinationFat = ""
        destinationProtein = ""
        destinationSaturated = ""
        destinationRoughage = ""
        destinationSugar = ""
        destinationLeucin = ""
        destinationSalt = ""
        saveProductValues()
    }
    
    // save destionation amounts
    func saveProductValues() {
        
        // save Kcal
        destinationKcal = String.validDouble(destinationKcal)
        saveProductValue(product: destinationKcal, saveKey: saveKeyKcal)
        
        
        // save fat
        destinationFat = String.validDouble(destinationFat)
        saveProductValue(product:  destinationFat, saveKey:  saveKeyFat)
        
        // save saturated
        destinationSaturated = String.validDouble(destinationSaturated)
        saveProductValue(product:  destinationSaturated, saveKey:  saveKeySaturated)
        
        // save carbs
        destinationCarbs = String.validDouble(destinationCarbs)
        saveProductValue(product:  destinationCarbs, saveKey:  saveKeyCarbs)
        
        // save roughage
        destinationRoughage = String.validDouble(destinationRoughage)
        saveProductValue(product:  destinationRoughage, saveKey:  saveKeyRoughage)
        
        // save sugar
        destinationSugar = String.validDouble(destinationSugar)
        saveProductValue(product:  destinationSugar, saveKey:  saveKeySugar)
        
        // save protein
        destinationProtein = String.validDouble(destinationProtein)
        saveProductValue(product:  destinationProtein, saveKey:  saveKeyProtein)
        
        // save leucin
        destinationLeucin = String.validDouble(destinationLeucin)
        saveProductValue(product: destinationLeucin, saveKey: saveKeyLLeucin)
        
        // save salt
        destinationSalt = String.validDouble(destinationSalt)
        saveProductValue(product: destinationSalt, saveKey: saveKeySalt)
    }
    
    // save order to the user defaults
    func save() {
        if let encoded = try? JSONEncoder().encode(self.orders) {
            UserDefaults.standard.set(encoded, forKey: Self.saveKey)
        }
    }
    
    // add to order
    func add(order: Order) {
        self.orders.append(order)
        save()
        print("product added to cart and saved")
    }
    
    // remove from order -- not really used because of the IndexSet
    func remove(order: Order) {

        if let index = orders.firstIndex(of: order) {
            orders.remove(at: index)
            save()
        }
    }
    
    func sortArray() {
        orders.sort {
            dateFormatter.date(from: $0.date)! < dateFormatter.date(from: $1.date)!
        }
    }
    
}
