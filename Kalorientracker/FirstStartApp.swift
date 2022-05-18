//
//  FirstStartApp.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 29.09.20.
//

import SwiftUI
import WidgetKit

struct FirstStartApp: View {
    @EnvironmentObject var cart: Cart
    @EnvironmentObject var appData: AppData
    @State private var showFinishButton = false
    @Binding var showView: Bool
    
    var body: some View {
        NavigationView {
            DestinationAmountView()
        }
    }
}

struct FirstStartApp_Previews: PreviewProvider {
    static var previews: some View {
        FirstStartApp(showView: .constant(false))
            .environmentObject(Cart())
            .environmentObject(AppData())
    }
}
