//
//  TestListView.swift
//  TestListView
//
//  Created by Patrick Fezer on 13.09.21.
//

import SwiftUI

struct TestListView: View {
    
    let title: String
    var body: some View {
        NavigationLink(title, destination: TestView2())
    }
}

struct TestListView_Previews: PreviewProvider {
    static var previews: some View {
        TestListView(title: "dev")
    }
}
