//
//  LogbookCopyView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 18.09.20.
//

import SwiftUI

struct LogbookCopyView: View {
    
    @State private var date = Date()
    @Binding var showView: Bool
    @EnvironmentObject var cart: Cart
    var order: [Order]
    
    var body: some View {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        let dateString = formatter.string(from: date)
        let dateStringCart = formatter.string(from: cart.date)
        
        return NavigationView {
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
            .navigationBarTitle("Logbuch kopieren", displayMode: .inline)
            .navigationBarItems(leading: Button("Abbrechen") {
                self.showView = false
            }, trailing: Button("Speichern") {
                self.showView = false
                cart.date = self.date
                for index in 0 ..< order.count {
                    
                    self.cart.add(order: Order(product: order[index].product, modifier: order[index].modifier, meal: order[index].meal, date: dateString))
                }
                
            // comparing strings of the date because normal date has diffences in seconds.
            }.disabled(dateStringCart == dateString))
        }
    }
}

#if DEBUG
struct LogbookCopyView_Previews: PreviewProvider {
    static var previews: some View {
        LogbookCopyView(showView: .constant(false), order: [Order(product: Product.exampleProduct, modifier: 12, meal: "Mahlzeit 1", date: "20.10.1997")]).environmentObject(Cart())
    }
}
#endif
