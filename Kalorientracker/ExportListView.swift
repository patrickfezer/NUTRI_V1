//
//  BackupListView.swift
//  BackupListView
//
//  Created by Patrick Fezer on 13.09.21.
//

import SwiftUI

struct ExportListView: View {
    var body: some View {
//        NavigationLink("Exportieren", destination: ExportView())
        
        NavigationLink {
            ExportView()
        } label: {
            LabelIconView(icon: "square.and.arrow.up", iconColor: .white, backgroundColor: .green, text: Text("export"))
        }
        
//        NavigationLink(destination: ExportView()) {
//            HStack {
//                Text("Exportieren")
//                Spacer()
//                BetaSignView(text: "Beta")
//            }
//        }
    }
}

struct ExportListView_Previews: PreviewProvider {
    static var previews: some View {
        ExportListView()
    }
}
