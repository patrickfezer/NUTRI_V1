//
//  DatePickerView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 07.09.20.
//

import SwiftUI

struct DatePickerView: View {
    
    // binding vars to give out the day anad close the view -- used as a .sheet action
    @Binding var date: Date
    @Binding var showView: Bool
    @EnvironmentObject var cart: Cart
    
    var body: some View {
        
        NavigationView {
            Form {
                DatePicker("Datum auswählen", selection: $date, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                // Button to jump to today
                HStack {
                    // spacers are used to center the button
                    Spacer()
                    Button("Heute") {
                        date = Date()
                    }
                    Spacer()
                }
            }
            .navigationBarTitle(Text("Datum auswählen"), displayMode: .inline)
            
            
            // button to close the .sheet view
            .navigationBarItems(trailing:
                                    Button("Fertig") {
                                        self.showView = false
                                    }
            )
        }
    }
}

struct DatePickerView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerView(date: .constant(Date()), showView: .constant(false))
    }
}
