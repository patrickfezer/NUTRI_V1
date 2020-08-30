//
//  TodayView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 27.08.20.
//

import SwiftUI

struct LogbookView: View {
    
    @State private var date = Date()
    
    var body: some View {
        NavigationView {
            Form {
            }
            .navigationBarTitle(Text("Logbuch"), displayMode: .automatic)
            .navigationBarItems(trailing: DateView(date: $date))
        }
    }
}

struct LogbookView_Previews: PreviewProvider {
    static var previews: some View {
        LogbookView()
    }
}
