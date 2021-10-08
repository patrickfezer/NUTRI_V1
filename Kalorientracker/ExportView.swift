//
//  BackupView.swift
//  BackupView
//
//  Created by Patrick Fezer on 13.09.21.
//

import SwiftUI
//import UniformTypeIdentifiers




struct ExportView: View {
    
    var body: some View {
        Form {
            
            Section {
                NavigationLink {
                    FoodExportView()
                } label: {
                    Text("Lebensmittel exportieren")
                }

            } header: {
                Text("Lebensmittel")
            }
            
            
            Section {
                NavigationLink {
                    LogbookExportView()
                } label: {
                    Text("Logbuch exportieren")
                }

            } header: {
                Text("Logbuch")
            }


        }
        .navigationTitle(Text("Exportieren"))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ExportView_Previews: PreviewProvider {
    static var previews: some View {
        ExportView()
    }
}


// Alte Funktionen
// =========================================================================================
//struct Doc: FileDocument {
//    var content: String
//    
//    static var readableContentTypes: [UTType]{[.json]}
//    
//    init(contet: String) {
//        self.content = contet
//    }
//    
//    init(configuration: ReadConfiguration) throws {
//        guard let data = configuration.file.regularFileContents, let encoded = String(data: data, encoding: .utf8) else {
//            throw CocoaError(.fileReadCorruptFile)
//        }
//        
//        content = encoded
//    }
//    
//    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
//        return FileWrapper(regularFileWithContents: content.data(using: .utf8)!)
//    }
//    
//    
//}


// =========================================================================================
//func getData(saveKey: String) {
//
//
//
//    guard let data = UserDefaults.standard.data(forKey: saveKey) else {
//        return
//    }
//
//    let encoded = String(decoding: data, as: UTF8.self)
//
//    let av = UIActivityViewController(activityItems: [encoded], applicationActivities: nil)
//
//
//    UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
//
//}
