//
//  BackupView.swift
//  BackupView
//
//  Created by Patrick Fezer on 13.09.21.
//

import SwiftUI

struct ExportView: View {
    
    let option = ["Lebensmittel", "Logbuch"]
    @State private var selection = 0
    @State private var showExporter = false
    
    var fileName: String {
        var content = ""
        
        switch selection {
        case 0:
            content = "Export_Food"
        case 1:
            content = "Export_Logbook"
        default:
            break
        }
        
        return content
    }
    
    var document: Doc {
        var doc = Doc(contet: "")
        
        switch selection {
        case 0:
            doc = Doc(contet: ExportHelper.getDataAsString(key: CollectedProductOrder().saveKey))
        case 1:
            doc = Doc(contet: ExportHelper.getDataAsString(key: Cart.saveKey))
        default:
            break
        }
        
        return doc
    }
    
    var body: some View {
        Form {
            
            Section {
                Picker("Selection", selection: $selection) {
                    
                    ForEach(0..<self.option.count, id: \.self) {
                        Text(option[$0])
                    }
                    
                }
                .pickerStyle(SegmentedPickerStyle())
                

            } header: {
                Text("Auswahl")
            }
            
            Section {
                Button {
                    showExporter = true
                } label: {
                    
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Exportieren")
                    }
                    
                }
            } header: {
                Text("Exportieren")
            }
        }
        .navigationTitle(Text("Exportieren"))
        .navigationBarTitleDisplayMode(.inline)
        .fileExporter(isPresented: $showExporter, document: document, contentType: .json, defaultFilename: fileName) { result in
            
        }
    }
}

struct ExportView_Previews: PreviewProvider {
    static var previews: some View {
        ExportView()
    }
}
