//
//  DateView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 30.08.20.
//

import SwiftUI

struct DateView: View {
    
    // Date settings
    @Binding var date: Date
    
    static var taskDateFormat: DateFormatter {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            return formatter
        }
    
    var body: some View {
        HStack {
            
            // decrease date
            Button(action: {
                date.addTimeInterval(-86400)
            }, label: {
                Image(systemName: "lessthan.circle")
            })
            
            .padding(.trailing, 5)
            .padding(.leading, 20)

            // reset date and show date
            Button("\(date, formatter: Self.taskDateFormat)", action: {
                // reset Date to today
                date = Date()
            })
//            Text(date, formatter: Self.taskDateFormat)
            
            Button(action: {
                date.addTimeInterval(86400)
            }, label: {
                Image(systemName: "greaterthan.circle")
            })
            .padding(.leading, 5)
            .padding(.trailing, 20)
        }
        
        // color for HStack
        .foregroundColor(.blue)
        .font(.system(size: 20))
    }
}

struct DateView_Previews: PreviewProvider {
    static var previews: some View {
        DateView(date: .constant(Date()))
    }
}
