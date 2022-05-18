//
//  Doc.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 15.09.21.
//

import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct Doc: FileDocument {
    var content: String
    
    static var readableContentTypes: [UTType]{[.json]}
    
    init(contet: String) {
        self.content = contet
    }
    
    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents, let encoded = String(data: data, encoding: .utf8) else {
            throw CocoaError(.fileReadCorruptFile)
        }
        content = encoded
    }
    
    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: content.data(using: .utf8)!)
    }
    
    
}
