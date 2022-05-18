//
//  ImportDataView.swift
//  NUTRI
//
//  Created by Patrick Fezer on 27.10.21.
//

import SwiftUI

struct ImportView: View {
    @State private var showImportView = false
    @State private var successfullImport = false
    @State private var showAlert = false
    @State private var kindOfImportedData = ""
    @EnvironmentObject var ownProduct: CollectedProductOrder
    @EnvironmentObject var cart: Cart
    
    var alert: Alert {
        
        var tempAlert: Alert
        
        switch successfullImport {
        case true:
            tempAlert = Alert(title: Text("\(kindOfImportedData) wurde erfolgreich importiert"), message: nil, dismissButton: .default(Text("OK")))
        case false:
            tempAlert = Alert(title: Text("Falsche Datei"), message: Text("Die ausgewählte Datei ist nicht kompatibel."), dismissButton: .default(Text("OK")))
        }
        
        return tempAlert
    }
    
    var body: some View {
        Form {
            Section {
                Button {
                    showImportView.toggle()
                } label: {
                    HStack {
                        Image(systemName: "square.and.arrow.down")
                        Text("Daten importieren")
                    }
                }
                
            } header: {
                Text("Daten importieren")
            }
            
            Text("In diesem Bereich kannst du deine exportieren Lebensmittel und Logbücher importieren.\nDu kannst immer nur ein File auswählen.")
                .font(.system(size: 16))
        }
        .navigationTitle(Text("Importieren"))
        .navigationBarTitleDisplayMode(.inline)
        .fileImporter(isPresented: $showImportView, allowedContentTypes: [.json], allowsMultipleSelection: false) { result in
            do {
                
                // Reset Data
                kindOfImportedData = "";
                successfullImport = false
                
                // Get File URL
                guard let selectedFile: URL = try result.get().first else { return }
                
                // Wird wegen Sandbox benötigt
                let canAccess = selectedFile.startAccessingSecurityScopedResource()
                guard canAccess else {
                    return
                }
                
                
                // Try to get Data
                let data = try! Data(contentsOf: selectedFile)

                // Zugriff beenden
                selectedFile.stopAccessingSecurityScopedResource()
                
                
                // Try importing Food
                if !successfullImport {
                    if let decoded = try? JSONDecoder().decode([ProductOrder].self, from: data) {

                        successfullImport = true
                        
                        kindOfImportedData = "Lebensmittel"
                        
                        self.ownProduct.products.removeAll()

                        decoded.forEach { product in
                            self.ownProduct.add(order: product)
                        }

                        self.ownProduct.save()
                        print("Successfully imported foods")
                    } else {
                        print("Fehler Logbuch")
                    }
                }
                
                
                // Try importing Logbook
                if !successfullImport {
                    if let decoded = try? JSONDecoder().decode([Order].self, from: data) {
                        
                        successfullImport = true
                        
                        kindOfImportedData = "Logbuch"
                        
                        self.cart.orders.removeAll()

                        decoded.forEach { order in
                            self.cart.orders.append(order)
                        }

                        self.cart.save()
                        
                        print("Successfully imported logbook")
                    } else {
                        print("Fehler Lebensmittel")
                    }
                }
                
                // Show alert
                showAlert = true
                
            } catch {
                print(error.localizedDescription)
            }
        }
        .alert(isPresented: $showAlert) {
            alert
        }
    }
}

struct ImportView_Previews: PreviewProvider {
    static var previews: some View {
        ImportView()
    }
}
