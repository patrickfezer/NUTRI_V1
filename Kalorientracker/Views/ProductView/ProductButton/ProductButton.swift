//
//  ProductAddButton.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 26.09.20.
//

import SwiftUI


struct ProductButton: View {
    @Binding var showView: Bool
    let symbol: String
    let color: Color
    
    var body: some View {
        
        VStack {
            Spacer()
            HStack {
                Spacer()

                
                Button(action: {
                    self.showView = true
                }, label: {
                    Image(systemName: symbol)
                        .resizable()
                        .frame(width: 25, height: 25, alignment: .center)
                        .padding(15)
                        .foregroundColor(.white)
                        .background(color)
                        .clipShape(Circle())
                        
                    
                })
                    .padding(.trailing, 20)
                    .padding(.bottom, 20)
                    .buttonStyle(ScaleButtonStyle())
            }
            
        }
    }
}

struct ProductButton_Previews: PreviewProvider {
    static var previews: some View {
        ProductButton(showView: .constant(false), symbol: "plus", color: Color.blue)
    }
}
