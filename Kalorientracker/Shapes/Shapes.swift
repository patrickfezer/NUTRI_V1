//
//  Shapes.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 03.09.20.
//

import SwiftUI

// rounded shape used in the Dashboard view
struct RoundedShape: Shape {
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomRight, .topRight], cornerRadii: CGSize(width: 10, height: 10))
        return Path(path.cgPath)
    }
}
