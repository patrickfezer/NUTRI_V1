//
//  TestView.swift
//  TestView
//
//  Created by Patrick Fezer on 13.09.21.
//

import SwiftUI
import UniformTypeIdentifiers

struct MessageDocument: FileDocument {
    
    static var readableContentTypes: [UTType] { [.plainText] }

    var message: String

    init(message: String) {
        self.message = message
    }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents,
              let string = String(data: data, encoding: .utf8)
        else {
            throw CocoaError(.fileReadCorruptFile)
        }
        message = string
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        return FileWrapper(regularFileWithContents: message.data(using: .utf8)!)
    }
    
}



struct TestView: View {
    @State private var shareView = false
    @State private var document = MessageDocument(message: "Hello World")
    
    var body: some View {
        NavigationView {
            
            VStack {
                GroupBox {
                    TextEditor(text: $document.message)
                } label: {
                    Text("Message")
                }

                Spacer()
                
                Button {
                    shareView.toggle()
                } label: {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("export")
                    }
                }
            }
            
            
        }
        .navigationTitle("Test")
        .navigationBarTitleDisplayMode(.inline)
        .fileExporter(isPresented: $shareView, document: document, contentType: .plainText, defaultFilename: "exportetFile.JSON") { result in
            switch result {
            case .success(let url):
                print("saved to \(url)")
            default:
                break
            }

        }
        
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}

