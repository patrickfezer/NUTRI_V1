//
//  EachMealTotalListVIew.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 07.09.20.
//

import SwiftUI

struct EachMealTotalListView: View {
    
    var filter: String
    var date: String
    
    var body: some View {
        NavigationLink("Gesamtübersicht" + " " + filter, destination: EachMealTotalView(filter: filter, date: date))
    }
}

struct EachMealTotalListView_Previews: PreviewProvider {
    static var previews: some View {
        EachMealTotalListView(filter: "Mahlzeit 1", date: "20.10.1997")
    }
}
