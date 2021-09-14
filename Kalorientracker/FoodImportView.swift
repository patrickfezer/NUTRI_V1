//
//  FoodImportView.swift
//  FoodImportView
//
//  Created by Patrick Fezer on 14.09.21.
//

import SwiftUI

struct FoodImportView: View {
    @State private var showImportView = false
    @EnvironmentObject var ownProduct: OwnProductConfiguration
    var body: some View {
        Form {
            Section(header: Text("Lebensmittel"), content: {
                Button {
                        
                    print("Import Food Button pressed")
                    showImportView.toggle()
                        
                } label: {
                    HStack {
                        Image(systemName: "square.and.arrow.down")
                        Text("Lebensmittel importieren")
                    }
                }
            })
        }
        
        
        .navigationTitle(Text("Lebensmittel"))
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


                if let decoded = try? JSONDecoder().decode([OwnProductOrder].self, from: data) {

                    ownProduct.products.removeAll()

                    decoded.forEach { product in
                        ownProduct.add(order: product)
                    }

                    ownProduct.save()
                    print(decoded)
                }

            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct FoodImportView_Previews: PreviewProvider {
    static var previews: some View {
        FoodImportView()
    }
}
