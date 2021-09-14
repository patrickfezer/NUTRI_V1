//
//  ImportListView.swift
//  ImportListView
//
//  Created by Patrick Fezer on 13.09.21.
//

import SwiftUI

struct ImportListView: View {
    var body: some View {
//        NavigationLink("Importieren", destination: ImportView())
        
        NavigationLink(destination: ImportView()) {
            HStack {
                Text("Importieren")
                Spacer()
                BetaSignView(text: "Beta")
            }
        }
    }
}

struct ImportListView_Previews: PreviewProvider {
    static var previews: some View {
        ImportListView()
    }
}
