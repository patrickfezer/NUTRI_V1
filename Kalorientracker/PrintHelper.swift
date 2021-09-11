//
//  PrintHelper.swift
//  Shopping
//
//  Created by Patrick Fezer on 25.08.20.
//  Copyright © 2020 Patrick Fezer. All rights reserved.
//

import SwiftUI

// print helper using a view because normal one is not always able to use
extension View {
    func Print(_ vars: Any...) -> some View {
        for v in vars { print(v) }
        return EmptyView()
    }
}
