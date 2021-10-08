//
//  LogbookExportView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 15.09.21.
//

import SwiftUI

struct LogbookExportView: View {
    @State private var showLoogbookExportView = false
    @State private var logbookData = Doc(contet: ExportHelper.getDataAsString(key: Cart.saveKey))
    
    var body: some View {
        Form {
            Section {
                Button {
                    print("Export Food Button pressed")
                    showLoogbookExportView.toggle()
                    
                } label: {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Logbuch exportieren")
                    }
                }
            } header: {
                Text("Logbuch")
            }

        }
        .navigationTitle(Text("Logbuch"))
        .navigationBarTitleDisplayMode(.inline)
        .fileExporter(isPresented: $showLoogbookExportView, document: logbookData, contentType: .json, defaultFilename: "Export_Logbook") { result in

        }
    }
}

struct LogbookExportView_Previews: PreviewProvider {
    static var previews: some View {
        LogbookExportView()
    }
}
