//
//  LabelView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 27.08.20.
//

import SwiftUI

struct LabelView: View {
    
    let text: String
    let backgroundColor: Color
    
    var body: some View {
        Text(text)
            .font(.system(size: 10))
            .padding(2)
            .background(backgroundColor)
            .opacity(0.8)
            .foregroundColor(.white)
            .cornerRadius(5)
    }
}

struct LabelView_Previews: PreviewProvider {
    static var previews: some View {
        LabelView(text: "Protein", backgroundColor: .green)
    }
}
