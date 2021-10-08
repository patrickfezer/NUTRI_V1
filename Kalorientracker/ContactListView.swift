//
//  ContactListVIew.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 09.09.20.
//

import SwiftUI

struct ContactListView: View {
    var body: some View {
        
        NavigationLink {
            ContactView()
        } label: {
            LabelIconView(icon: "envelope.fill", iconColor: .white, backgroundColor: .blue, text: "Kontakt")
        }

        
//        NavigationLink("Kontakt", destination: ContactView())
    }
}

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactListView()
    }
}
