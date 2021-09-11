//
//  Functions.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 22.09.20.
//

import Foundation

struct Functions {
    static func replaceCommaFrom(_ input: String) -> String {
         var temp = ""
         
         if input == "" || Double(input) == nil {
             temp = "0"
         } else {
             temp = input.replacingOccurrences(of: ",", with: ".")
         }
         
         return temp
     }
}
