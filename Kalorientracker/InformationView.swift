//
//  InformationView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 05.09.20.
//

import SwiftUI

struct InformationView: View {
    
    var body: some View {
        List {
            Section(header: Text("App Informationen"), footer: Text("© Patrick Fezer")) {
                HStack {
                    Text("Version:")
                    Spacer()
                    Text(KalorientrackerApp.appVersion + " (\(KalorientrackerApp.buildVersion))")
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle("Infos", displayMode: .inline)
        
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            InformationView()
        }
    }
}
