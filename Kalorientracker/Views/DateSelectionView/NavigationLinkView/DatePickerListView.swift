//
//  DatePickerListView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 07.09.20.
//

import SwiftUI

struct DatePickerListView: View {
    
    // binding var to give date to the DatePickerView
    @Binding var date: Date
    
    var body: some View {
        
        // in NavigationLink, showView is not needed
        NavigationLink("Datum auswählen", destination: DatePickerForListView(date: $date))
        
    }
}

struct DatePickerListView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerListView(date: .constant(Date()))
    }
}
