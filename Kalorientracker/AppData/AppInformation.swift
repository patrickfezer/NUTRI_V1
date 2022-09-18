//
//  AppInformation.swift
//  AppInformation
//
//  Created by Patrick Fezer on 12.09.21.
//

import Foundation
import SwiftUI

class AppInformation
{
    public static let appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
    public static let buildVersion = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
    public static let systemVersion = UIDevice.current.systemName + ": " + UIDevice.current.systemVersion
    public static let devive = UIDevice.current.modelName
}
