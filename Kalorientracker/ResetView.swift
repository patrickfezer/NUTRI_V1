//
//  ResetView.swift
//  ResetView
//
//  Created by Patrick Fezer on 28.08.21.
//

import SwiftUI

struct ResetView: View {
    
    // MARK: Variables
    @AppStorage(ResetView.saveKeyentrySelection) private var entrySelection = 0
    @AppStorage(ResetView.saveKeyAutoDelete) private var autoDelete = false
    @State private var deleteText = ""
    @State private var showConfirmationView = false
    @EnvironmentObject var cart: Cart
    @EnvironmentObject var productCollection: OwnProductConfiguration
    
    
    static let saveKeyAutoDelete = "keyAutoDelete"
    static let saveKeyentrySelection = "keyEntrySelection"
    
    let entrySelectionString = ["30 Einträge", "60 Einträge", "90 Einträge", "120 Einträge", "360 Einträge", "Alle löschen"]

    var deletePickerText: String {
        var dt = ""

        switch entrySelection {
        case 5:
            dt = "Löschen"
        default:
            dt = "Behalten"
        }
        
        return dt
    }
    
    static func entriesToRemove() -> Int {
        var entries = 0
        
        switch ResetView().entrySelection {
        case 0:
            entries = 30
        case 1:
            entries = 60
        case 2:
            entries = 90
        case 3:
            entries = 120
        case 4:
            entries = 365
        default:
            break
        }
        
        return entries
    }

    var body: some View {
        Form {
            
            Section {
                HStack {
                    Text("Einträge Lebensmittel: ")
                    Spacer()
                    Text("\(self.productCollection.products.count)")
                    
                }
            } header: {
                Text("Lebensmittel")
            }
            
            Section(header: Text("Logbucheinträge")) {
                
                HStack {
                    Text("Logbucheinträge: ")
                    Spacer()
                    Text("\(self.cart.orders.count)")
                }
                
                
                Picker(deletePickerText, selection: $entrySelection) {
                            
                    ForEach(0..<entrySelectionString.count) {
                        Text(entrySelectionString[$0])
                    }
                }
                .pickerStyle(DefaultPickerStyle())
                
                Text(deleteText)
                
                Toggle(isOn: $autoDelete) {
                    Text("Automatisch löschen")
                }
                .onChange(of: autoDelete) { value in
                    showConfirmationView = value
                }
                

                    Button("Löschen") {
                        showConfirmationView = true
                    }
                    .foregroundColor(autoDelete ? .secondary : .red)
                    .disabled(autoDelete)
                
            }
            

        }
        .navigationBarTitle(Text("Speichermanagement"), displayMode: .inline)
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
        .actionSheet(isPresented: $showConfirmationView) {
            ActionSheet(title: Text("Löschen"), message: Text("Die ausgewählten Daten werden unwiederruflich gelöscht."), buttons: [.destructive(Text("Löschen"), action: {

                DispatchQueue.main.async {
                    
                    self.cart.removeOldOrders()
                    
                }
                
                UserDefaults.standard.set(autoDelete, forKey: ResetView.saveKeyAutoDelete)
            }), .cancel({
                // Der Toggel wird auf den letzten Wert zurück gesetzt, falls abgebrochen wird
                autoDelete = false
            })
            ])
        }
        .onChange(of: self.entrySelection) { change in
            self.cart.removeOldOrders()
        }
    }
}

struct ResetView_Previews: PreviewProvider {
    static var previews: some View {
        ResetView()
            .environmentObject(Cart())
            .environmentObject(OwnProductConfiguration())
    }
}


