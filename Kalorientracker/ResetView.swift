//
//  ResetView.swift
//  ResetView
//
//  Created by Patrick Fezer on 28.08.21.
//

import SwiftUI

struct ResetView: View {
    
    // MARK: Variables
    @State private var entrySelection = 0
    @State private var deleteText = ""
    @State private var showConfirmationView = false
    @EnvironmentObject var cart: Cart
    
    
    let entrySelectionString = ["30 Einträge", "60 Einträge", "90 Einträge", "120 Einträge", "360 Einträge", "Alle"]
    
    // MARK: Functions
    func removeAllData() {
        cart.orders.removeAll()
    }
    
    func removeLastEntries(_ entries: Int) {
        
        self.cart.sortArray()
            
        // Keep the last selected entries
        if (self.cart.orders.count - entries) >= 0 {
            self.cart.orders.removeSubrange(0...self.cart.orders.count - entries)
        }
            
        // save changes
        self.cart.save()
    }
    
    var body: some View {
        Form {
            
            Section(header: Text("Logbucheinträge Löschen")) {
                
                
                Text(deleteText)
                
                Picker("Logbucheinträge", selection: $entrySelection) {
                    ForEach(0..<entrySelectionString.count) {
                        Text(entrySelectionString[$0])
                    }
                }
                .pickerStyle(DefaultPickerStyle())
                
                Button("Löschen") {
                    
                    showConfirmationView = true
                    
                    
                }
                .foregroundColor(.red)
                
                .actionSheet(isPresented: $showConfirmationView) {
                    ActionSheet(title: Text("Löschen"), message: Text("Die ausgewählten Daten werden unwiederruflich gelöscht."), buttons: [.destructive(Text("Löschen"), action: {
                        
                        DispatchQueue.main.async {
                            switch entrySelection {
                            case 0:
                                removeLastEntries(30)
                            case 1:
                                removeLastEntries(60)
                            case 2:
                                removeLastEntries(90)
                            case 3:
                                removeLastEntries(120)
                            case 4:
                                removeLastEntries(360)
                            case 5:
                                removeAllData()
                            default:
                                break
                            }
                        }
                        

                    }), .cancel()
                    ])
                }
            }
        }
        .navigationBarTitle(Text("Zurücksetzen"), displayMode: .inline)
        .onAppear(perform: {
            switch entrySelection {
            case 0:
                deleteText = "Die letzten \(entrySelectionString[0]) werden behalten."
            case 1:
                deleteText = "Die letzten \(entrySelectionString[1]) werden behalten."
            case 2:
                deleteText = "Die letzten \(entrySelectionString[2]) werden behalten."
            case 3:
                deleteText = "Die letzten \(entrySelectionString[3]) werden behalten."
            case 4:
                deleteText = "Die letzten \(entrySelectionString[4]) werden behalten."
            case 5:
                deleteText = "Alle Einträge werden gelöscht."
            default:
                deleteText = "Keine Auswahl."
            }
        })
    }
}

struct ResetView_Previews: PreviewProvider {
    static var previews: some View {
        ResetView()
    }
}


