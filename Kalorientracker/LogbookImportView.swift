//
//  LogbookImportView.swift
//  LogbookImportView
//
//  Created by Patrick Fezer on 14.09.21.
//

import SwiftUI

struct LogbookImportView: View {
    @State private var showImportView = false
    @EnvironmentObject var cart: Cart
    var body: some View {
        Form {
            Section(header: Text("Logbuch"), content: {
                Button {
                        
                    print("Import Logbook Button pressed")
                    showImportView.toggle()
                        
                } label: {
                    HStack {
                        Image(systemName: "square.and.arrow.down")
                        Text("Logbuch importieren")
                    }
                }
            })
        }
        
        
        .navigationTitle(Text("Logbuch"))
        .navigationBarTitleDisplayMode(.inline)
        
        // Food Importer
        .fileImporter(isPresented: $showImportView, allowedContentTypes: [.data], allowsMultipleSelection: false) { result in


            do {
                
                print("Food importer active")
                guard let selectedFile: URL = try result.get().first else { return }

                // Wird wegen der Sandbox benötigt
                let canAccess = selectedFile.startAccessingSecurityScopedResource()
                guard canAccess else {
                    return
                }

                let data = try! Data(contentsOf: selectedFile)

                // Zugriff beenden
                selectedFile.stopAccessingSecurityScopedResource()


                if let decoded = try? JSONDecoder().decode([Order].self, from: data) {

                    self.cart.orders.removeAll()

                    decoded.forEach { order in
                        self.cart.orders.append(order)
                    }

                    self.cart.save()
                    print(decoded)
                }

            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct LogbookImportView_Previews: PreviewProvider {
    static var previews: some View {
        LogbookImportView()
    }
}
