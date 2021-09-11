//
//  InformationListVIew.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 05.09.20.
//

import SwiftUI

struct InformationListView: View {
    var body: some View {
        NavigationLink("Informationen", destination: InformationView())
    }
}

struct InformationListView_Previews: PreviewProvider {
    static var previews: some View {
        InformationListView()
    }
}
