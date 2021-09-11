//
//  BarView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 02.09.20.
//

import SwiftUI

struct BarView: View {
    
    let title: String
    let color: Color
    let destinationAmount: CGFloat
    let currentAmount: CGFloat
    let showUnit: Bool
    
    var body: some View {
        
        
        let chartLength: CGFloat = 200
        
        var unit: String {
            if showUnit {
                return "g"
            } else {
                return ""
            }
        }
        
        var progressLenght = (currentAmount / destinationAmount) * chartLength
        
        let progressInPercent = (currentAmount / destinationAmount) * 100
        
        if progressLenght > chartLength {
            progressLenght = chartLength
        }
        
        let currentAmountAsString = String(format: "%.1f", currentAmount)
        let destinationAmoungAsString = String(format: "%.1f", destinationAmount)
        
        
        
        return HStack {
            
            Text(title + ":")
                .foregroundColor(.primary)
            
            Spacer()
            
            Text(String(format: "%.0f", progressInPercent) + " %")

            ZStack(alignment: .center) {
                ZStack(alignment: .leading) {
                    RoundedShape().frame(width: chartLength, height: 25)
                        .foregroundColor(.secondary)
                    RoundedShape().frame(width: progressLenght, height: 25)
                        .foregroundColor(color)
                }
                
                Text("\(currentAmountAsString + unit) / \(destinationAmoungAsString + unit)")
                    .font(.system(size: 11))
                    .foregroundColor(.black)
            }


        }
        .padding(.bottom, 10)
        .padding(.top, 10)

    }
}


struct BarView_Previews: PreviewProvider {
    static var previews: some View {
//        Form {
            BarView(title: "Kalorien", color: .blue, destinationAmount: 400, currentAmount: 20, showUnit: false)
                .environment(\.colorScheme, .light)
//        }
    }
}
