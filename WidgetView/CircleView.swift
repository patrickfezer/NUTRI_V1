//
//  CircleView.swift
//  NUTRI
//
//  Created by Patrick Fezer on 26.10.21.
//

import SwiftUI

struct CircleView: View {
    
    @AppStorage("destinationAmounts", store: UserDefaults(suiteName: "group.com.fezer.Kalorientracker")) var destinationAmounts = Data()
    @AppStorage("currentAmounts", store: UserDefaults(suiteName: "group.com.fezer.Kalorientracker")) var currentAmounts = Data()
    
    let progressLength: CGFloat
    
    // Sicherstellen, dass die progressLength immer größer oder gleich Null ist
    var progressLengthConverted: CGFloat {

        var temp: CGFloat = 0
        
        if progressLength.isNaN {
            temp = 0
        } else {
            temp = progressLength
        }
        return temp
    }
    
    let circleSize: CGFloat = 120
    
    
    var body: some View {
        ZStack {
            
            Text(String(format: "%.0f", 100*progressLengthConverted) + "%")
                .font(.system(size: 30, weight: .semibold, design: .default))
                
            Circle()
                .stroke(lineWidth: 15)
                .frame(width: circleSize, height: circleSize, alignment: .center)
                .opacity(0.75)
                .foregroundColor(.secondary)
            
            Circle()
                .rotation(Angle(degrees: 270))
                .trim(from: 0, to: progressLengthConverted)
                .stroke(style: StrokeStyle(lineWidth: 15, lineCap: .round))
                .frame(width: circleSize, height: circleSize, alignment: .center)
                .foregroundColor(.blue)
        }
    }
}

struct CircleView_Previews: PreviewProvider {
    static var previews: some View {
        CircleView(progressLength: 0.73)
    }
}
