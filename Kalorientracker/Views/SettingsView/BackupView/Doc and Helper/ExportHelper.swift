//
//  ExportHelper.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 15.09.21.
//

import Foundation

class ExportHelper {
    static func getDataAsString(key: String) -> String {
        var temp = ""
        
        if let data = UserDefaults.standard.data(forKey: key) {
            temp = String(decoding: data, as: UTF8.self)
        }
        
        return temp
    }
}




