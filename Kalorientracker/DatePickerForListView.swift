//
//  DatePickerForListView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 07.09.20.
//

import SwiftUI


// This is another Date view without a navigation Bar -- it's only used with a navigationLink in list views
struct DatePickerForListView: View {
    
    // Binding var to give out the Date
    @Binding var date: Date
    
    var body: some View {
        NavigationView {
            Form {
                DatePicker("Datum auswählen", selection: $date, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                // Button to jump to today
                HStack {
                    Spacer()
                    Button("Heute") {
                        date = Date()
                    }
                    .foregroundColor(.blue)
                    Spacer()
                }
            }
            .navigationBarHidden(true)
        }
    }
}

struct DatePickerForListView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerForListView(date: .constant(Date()))
    }
}
