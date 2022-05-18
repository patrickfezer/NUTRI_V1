//
//  BarForWidgetVIew.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 10.09.20.
//

import SwiftUI

struct BarForWidgetView: View {
    let title: String
    let color: Color
    let destinationAmount: CGFloat
    let currentAmount: CGFloat
    let showUnit: Bool
    
    var body: some View {
        
        
        let chartLength: CGFloat = 150
        
        var unit: String {
            if showUnit {
                return "g"
            } else {
                return ""
            }
        }
        
        
        var progressLenght: CGFloat {
            var temp = (currentAmount / destinationAmount) * chartLength
            
            if temp > chartLength {
                temp = chartLength
            }
            
            if destinationAmount != 0 {
                return temp
            } else {
                return 0
            }
        }
        
        var progressInPercent: CGFloat {
            
            let temp = (currentAmount / destinationAmount) * 100
            
            if destinationAmount != 0 {
                return temp
            } else {
                return 0
            }
        }
        
        
        let currentAmountAsString = String(format: "%.1f", currentAmount)
        let destinationAmoungAsString = String(format: "%.1f", destinationAmount)
        
        
        
        return HStack {
            
            Text(title + ":")
                .foregroundColor(.primary)
            
            Spacer()
            
            Text(String(format: "%.0f", progressInPercent) + " %")
                .foregroundColor(.primary)

            ZStack(alignment: .center) {
                ZStack(alignment: .leading) {
                    RoundedShape().frame(width: chartLength, height: 25)
                        .opacity(0.75)
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

struct BarForWidgetView_Previews: PreviewProvider {
    static var previews: some View {
        BarForWidgetView(title: "Kalorien", color: .blue, destinationAmount: 400, currentAmount: 20, showUnit: false)
            .preferredColorScheme(.dark)
            .background(Color("WidgetBackground"))
    }
}
