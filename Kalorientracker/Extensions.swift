//
//  Extensions.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 29.08.20.
//

import SwiftUI

// For Textfield in Searchbar. hideKeyboard is also possible
extension UIApplication {
    func endEditing(_ force: Bool) {
        self.windows
            .filter{$0.isKeyWindow}
            .first?
            .endEditing(force)
    }
}

// Used for Amount view
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}


extension String {
    
    static func replaceDotWithComma(_ input: String) -> String {
        return input.replacingOccurrences(of: ".", with: ",")
    }
    
    static func validDouble(_ input: String) -> String {
         var temp = ""
     
         if input == "" || Double(input.replacingOccurrences(of: ",", with: ".")) == nil {
             temp = "0"
         } else {
             temp = input.replacingOccurrences(of: ",", with: ".")
         }
 
         return temp
     }
    
    func trimTrailingWhitespaces() -> String {
            return self.replacingOccurrences(of: "\\s+$", with: "", options: .regularExpression)
        }
    
    // replacing "," to "." to be compatible with Double
    static func convertToDouble(_ input: String) -> String {
            return String(format: "%.2f", Double(input.replacingOccurrences(of: ",", with: ".")) ?? 0)
        }

}


extension UIDevice {
    var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else {
                return identifier
            }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
}
