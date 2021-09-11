//
//  DestinationAmountListView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 04.09.20.
//

import SwiftUI

struct DestinationAmountListView: View {
    
    @EnvironmentObject var cart: Cart
    
    var body: some View {
        NavigationLink("Zielwerte einstellen", destination: DestinationAmountView().environmentObject(cart))
    }
}

struct DestinationAmountListView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            DestinationAmountListView().environmentObject(Cart())
        }
    }
}
