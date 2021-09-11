//
//  CircleView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 10.09.20.
//

import SwiftUI

struct CircleView: View {
    // keep order -- !IMPORTANT!
    @AppStorage("destinationAmounts", store: UserDefaults(suiteName: "group.com.fezer.Kalorientracker"))
    var destinationAmounts = Data()
    @AppStorage("currentAmounts", store: UserDefaults(suiteName: "group.com.fezer.Kalorientracker"))
    var currentAmounts = Data()
    // keep order -- !IMPORTANT!
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView()
    }
}
