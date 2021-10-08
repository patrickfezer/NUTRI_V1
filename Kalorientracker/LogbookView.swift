//
//  TodayView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 27.08.20.
//


import SwiftUI

struct LogbookView: View {
    
    
    @EnvironmentObject var cart: Cart
    @State private var showLogbookCopySheet = false
    @State private var editMode = EditMode.inactive
    @State private var showDateView = false
    @State private var deleteAllEntries = false
    @State private var ordersToDelete:[Order] = []
    
    
    func isCartEmptyFor(_ date: String) -> Bool {
        
        var temp = true
        for index in 0..<cart.orders.count {
            
            if cart.orders[index].date == date {
                temp = false
                break
            }
        }
        
        
        
        return temp
    }
    
    var body: some View {
        
        // convertes the date from the DateView to a string
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let dateString = formatter.string(from: cart.date)
        
        var copyLoogbook = [Order]()
        
        // check if one section is empty
        func showMeal(_ meal: String) -> Bool {
            var temp = false
            
            for index in 0 ..< cart.orders.count {
                if cart.orders[index].date == dateString && cart.orders[index].meal == meal {
                    temp = true
                    break
                }
            }
            
            return temp
        }
        
        // return is needed that code above will be executed
        return NavigationView {
        
            ZStack {
                
                List {
            
                    Section(header: Text("Logbuch kopieren")) {
                        
                        Button("Logbuch kopieren") {
                            
                            
                            for index in 0..<cart.orders.count {
                                
                                if cart.orders[index].date == dateString {
                                    copyLoogbook.append(cart.orders[index])
                                }
                            }
                            
                            self.showLogbookCopySheet = true
                            
                        }
                        .sheet(isPresented: $showLogbookCopySheet, content: {
                            LogbookCopyView(showView: $showLogbookCopySheet, order: copyLoogbook).environmentObject(cart)
                        })
                        .disabled(isCartEmptyFor(dateString))
                    }
                    
                    // show sorted meals
                    ForEach(AmountView.categorie, id: \.self) {  meal in
                        if showMeal(meal) {
                            LogbookProductSectionView(cart: cart, category: meal, date: dateString)
                        }
                    }
                }
                    
                .listStyle(GroupedListStyle())
                .navigationBarTitle(Text("Logbuch"), displayMode: .inline)
                .navigationBarItems(leading: DatePickerButtonView(date: $cart.date, showDatePicker: $showDateView).environmentObject(cart), trailing: EditButton().disabled(isCartEmptyFor(dateString)))
                .environment(\.editMode, $editMode)
                .onAppear(perform: {
                    editMode = .inactive
                    var stored = 0
                    for index in 0..<cart.orders.count {
                        stored = index
                    }
                    
                    print("Einträge: \(stored)")
            })
                
                if editMode.isEditing {
                    ProductButton(showView: $deleteAllEntries, symbol: "trash", color: Color.red)
                        .actionSheet(isPresented: $deleteAllEntries, content: {
                            ActionSheet(title: Text("Alle Einträge löschen"), message: Text("Alle Einträge im Logbuch für das ausgewählte Datum werden unwiederruflich gelöscht."), buttons:
                                            [
                                                .destructive(Text("Löschen"), action: {
                                                    
                                                    // Thread-Priorisierung
                                                    DispatchQueue.main.async {

                                                        
                                                        self.cart.orders.forEach { order in
                                                            if order.date == dateString {
                                                                self.cart.remove(order: order)
                                                            }
                                                        }
                                                    }
                                                    // Disable edit mode
                                                    editMode = .inactive
                                                    
                                                }),
                                                
                                                // Button to cancel
                                                .cancel()
                                            ])
                        })
                        .animation(.default)
                }
            }
        }
        
        // MARK: Testing to sort the array
        .onAppear {
            // Sort the array
            self.cart.orders.sort {
                $0.date < $1.date
            }
            
        }
    }
    
}

struct LogbookView_Previews: PreviewProvider {
    static var previews: some View {
        LogbookView().environmentObject(Cart())
        .environment(\.locale, .init(identifier: "de"))
    }
}
