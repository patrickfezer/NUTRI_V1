//
//  BetaSignView.swift
//  BetaSignView
//
//  Created by Patrick Fezer on 14.09.21.
//

import SwiftUI

struct BetaSignView: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.system(size: 10))
            .textCase(.uppercase)
            .foregroundColor(.white)
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .padding(.bottom, 5)
            .padding(.top, 5)
            .background(Color.gray)
            .cornerRadius(15)
    }
}

struct BetaSignView_Previews: PreviewProvider {
    static var previews: some View {
        BetaSignView(text: "Beta")
    }
}
