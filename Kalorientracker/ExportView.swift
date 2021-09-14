//
//  BackupView.swift
//  BackupView
//
//  Created by Patrick Fezer on 13.09.21.
//

import SwiftUI

struct ExportView: View {
    @State private var showFoodExporter = false
    
    func getData(saveKey: String) {
        
        guard let data = UserDefaults.standard.data(forKey: saveKey) else {
            return
        }
        
        
        let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        
  
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)

    }
    



    var body: some View {
        Form {
            
            Section(header: Text("Lebensmittel")) {
                Button {
                    print("Export Food Button pressed")
                     getData(saveKey: OwnProductConfiguration().saveKey)
                    
                } label: {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Lebensmittel exportieren")
                    }
                }
            }
            
            Section(header: Text("Logbuch")) {
                Button {
                    print("Export Logbook Button pressed")
                    getData(saveKey: Cart.saveKey)
                } label: {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Logbuch exportieren")
                    }
                }
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
