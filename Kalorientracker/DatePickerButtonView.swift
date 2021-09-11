//
//  DatePickerButtonView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 07.09.20.
//

import SwiftUI

struct DatePickerButtonView: View {
    
    // datepicker as a button to open a .sheet action -- DatePickerView
    @Binding var date: Date
    @Binding var showDatePicker: Bool
    
    var body: some View {
        
        // show the current date in EU standart
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let dateString = formatter.string(from: date)
        
        // return the main view
        return
            Button(action: {
                self.showDatePicker = true
            }, label: {
                HStack {
                    Image(systemName: "calendar")
                    
                    Text(dateString)
                }
            }).sheet(isPresented: $showDatePicker, content: {
                DatePickerView(date: $date, showView: $showDatePicker)
        })

    }
}

struct DatePickerButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DatePickerButtonView(date: .constant(Date()), showDatePicker: .constant(false))
    }
}
