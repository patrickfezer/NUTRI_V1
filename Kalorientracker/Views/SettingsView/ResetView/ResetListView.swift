//
//  ResetListView.swift
//  ResetListView
//
//  Created by Patrick Fezer on 28.08.21.
//

import SwiftUI

struct ResetListView: View {
    var body: some View {
        
        NavigationLink {
            ResetView()
        } label: {
            LabelIconView(icon: "internaldrive.fill", iconColor: .white, backgroundColor: .blue, text: Text("storageManagement"))
        }


//        NavigationLink("Speichermanagement", destination: ResetView())
    }
}

struct ResetListView_Previews: PreviewProvider {
    static var previews: some View {
        ResetListView()
    }
}
