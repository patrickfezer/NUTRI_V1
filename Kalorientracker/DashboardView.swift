//
//  DashboardView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 27.08.20.
//

import SwiftUI

struct DashboardView: View {
    
    @EnvironmentObject var cart: Cart
    @State private var showDateView = false
    
    // MARK: AppData
    @AppStorage("destinationAmounts", store: UserDefaults(suiteName: "group.com.fezer.Kalorientracker"))
    var destinationAmounts: Data = Data()
    @AppStorage("currentAmounts", store: UserDefaults(suiteName: "group.com.fezer.Kalorientracker"))
    var currentAmounts: Data = Data()

    
    var body: some View {
        
        // current values as dictionary
        let currentValues = getCurrentAmounts()
        
        // destination amounts for widget
        let destinationAmountsForWidget = ["kcal" : cart.destinationKcal, "protein" : cart.destinationProtein, "carbs" : cart.destinationCarbs, "fat" : cart.destinationFat, "saturated" : cart.destinationSaturated, "roughage" : cart.destinationRoughage, "sugar" : cart.destinationSugar, "leucin" : cart.destinationLeucin, "salt" : cart.destinationSalt]
        
        
        saveCurrentAmounts(value: getCurrentAmounts())
        saveDestinationAmounts(value: destinationAmountsForWidget)
        
        
        
        // MARK: NavigationView
        return NavigationView {
            
            List {
                Section(header: Text("Tageswerte")) {
                    
                    if cart.destinationKcal != "" && cart.destinationKcal != "0" {
                        BarView(title: "Kalorien", color: .blue, destinationAmount: CGFloat(Double(cart.destinationKcal.replacingOccurrences(of: ",", with: ".")) ?? 0), currentAmount: CGFloat(currentValues["kcal"]!), showUnit: false)
                    }
                    
                    if cart.destinationFat != "" && cart.destinationFat != "0" {
                        BarView(title: "Fett", color: .red, destinationAmount: CGFloat(Double(cart.destinationFat.replacingOccurrences(of: ",", with: ".")) ?? 0), currentAmount: CGFloat(currentValues["fat"]!), showUnit: true)
                    }
                    
                    if cart.destinationSaturated != "" && cart.destinationSaturated != "0" {
                        BarView(title: "Ges. Fetts.", color: .red, destinationAmount: CGFloat(Double(cart.destinationSaturated.replacingOccurrences(of: ",", with: ".")) ?? 0), currentAmount: CGFloat(currentValues["saturated"]!), showUnit: true)
                    }
                    
                    if cart.destinationCarbs != "" && cart.destinationCarbs != "0" {
                        BarView(title: "Carbs", color: .orange, destinationAmount: CGFloat(Double(cart.destinationCarbs.replacingOccurrences(of: ",", with: ".")) ?? 0), currentAmount: CGFloat(currentValues["carbs"]!), showUnit: true)
                    }
                    
                    if cart.destinationRoughage != "" && cart.destinationRoughage != "0" {
                        BarView(title: "Ballastst.", color: .orange, destinationAmount: CGFloat(Double(cart.destinationRoughage.replacingOccurrences(of: ",", with: ".")) ?? 0), currentAmount: CGFloat(currentValues["roughage"]!), showUnit: true)
                    }
                    
                    if cart.destinationSugar != "" && cart.destinationSugar != "0" {
                        BarView(title: "Zucker", color: .orange, destinationAmount: CGFloat(Double(cart.destinationSugar.replacingOccurrences(of: ",", with: ".")) ?? 0), currentAmount: CGFloat(currentValues["sugar"]!), showUnit: true)
                    }
                    
                    if cart.destinationProtein != "" && cart.destinationProtein != "0" {
                        BarView(title: "Protein", color: .green, destinationAmount: CGFloat(Double(cart.destinationProtein.replacingOccurrences(of: ",", with: ".")) ?? 0), currentAmount: CGFloat(currentValues["protein"]!), showUnit: true)
                    }
                    
                    if cart.destinationLeucin != "" && cart.destinationLeucin != "0" {
                        BarView(title: "L-Leucin", color: .green, destinationAmount: CGFloat(Double(cart.destinationLeucin.replacingOccurrences(of: ",", with: ".")) ?? 0), currentAmount: CGFloat(currentValues["leucin"]!), showUnit: true)
                    }
                    
                    if cart.destinationSalt != "" && cart.destinationSalt != "0" {
                        BarView(title: "Salz", color: Color("saltColor"), destinationAmount: CGFloat(Double(cart.destinationSalt.replacingOccurrences(of: ",", with: ".")) ?? 0), currentAmount: CGFloat(currentValues["salt"]!), showUnit: true)
                    }
                }
                
                
                
           }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(Text("Dashboard"), displayMode: .inline)
            .navigationBarItems(leading: DatePickerButtonView(date: $cart.date, showDatePicker: $showDateView).environmentObject(cart))
        }
    }
    
    // MARK: Functions
    
    // get current amounts
    func getCurrentAmounts() -> [String : Double] {
        
        // date as string
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let dateString = formatter.string(from: cart.date)
        
        var currentAmountKcal: Double = 0
        var currentAmountProtein: Double = 0
        var currentAmountCarbs: Double = 0
        var currentAmountFat: Double = 0
        var currentAmountSaturated: Double = 0
        var currentAmountRoughage: Double = 0
        var currentAmountSugar: Double = 0
        var currentAmountLeucin: Double = 0
        var currentAmountSalt: Double = 0
        
        for index in 0..<cart.orders.count {
            if cart.orders[index].date == dateString {
                
                // modifier for
                let modifier = Double(cart.orders[index].modifier)
                
                currentAmountKcal += (Double(cart.orders[index].product.kcal) ?? 0) / 100 * modifier
                
                currentAmountProtein += (Double(cart.orders[index].product.protein) ?? 0) / 100 * modifier
                
                currentAmountCarbs += (Double(cart.orders[index].product.carbs) ?? 0) / 100 * modifier
                
                currentAmountFat += (Double(cart.orders[index].product.fat) ?? 0) / 100 * modifier
                
                currentAmountSaturated += (Double(cart.orders[index].product.saturated) ?? 0) / 100 * modifier
                
                currentAmountRoughage += (Double(cart.orders[index].product.roughage) ?? 0) / 100 * modifier
                
                currentAmountSugar += (Double(cart.orders[index].product.sugar) ?? 0) / 100 * modifier
                
                currentAmountLeucin += (Double(cart.orders[index].product.leucin) ?? 0) / 100 * modifier
                
                currentAmountSalt += (Double(cart.orders[index].product.salt) ?? 0) / 100 * modifier
            }
        }
        
        return ["kcal" : currentAmountKcal, "protein" : currentAmountProtein, "carbs" : currentAmountCarbs, "fat" : currentAmountFat, "saturated" : currentAmountSaturated, "roughage" : currentAmountRoughage, "sugar" : currentAmountSugar, "leucin" : currentAmountLeucin, "salt" : currentAmountSalt]
    }
    
    // save current amounts to the user defaults to use in widget
    func saveCurrentAmounts(value: [String : Double]) {
        guard let currentAmounts = try? JSONEncoder().encode(value) else {
            return
        }
        self.currentAmounts = currentAmounts
        print("saved current amonts: \(currentAmounts)")
    }
    
    // save destination amounts in user defaults to use in widget
    func saveDestinationAmounts(value : [String : String]) {
        guard let destinationAmounts = try? JSONEncoder().encode(value) else {
            return
        }
        self.destinationAmounts = destinationAmounts
        print("saved destination amounts: \(destinationAmounts)")
    }
    
}

// MARK: Preview
struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DashboardView().environmentObject(Cart())
                .environment(\.colorScheme, .dark)
            
            DashboardView().environmentObject(Cart())
                .environment(\.colorScheme, .light)
            
        }
    }
}
