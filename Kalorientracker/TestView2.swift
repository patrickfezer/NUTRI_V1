//
//  TestView2.swift
//  TestView2
//
//  Created by Patrick Fezer on 14.09.21.
//

import SwiftUI

struct TestView2: View {
    @State private var b1 = false
    @State private var b2 = false
    @State private var arrayS: [String] = []
    
    var body: some View {
        List {
            Button {
                b1.toggle()
                
            } label: {
                HStack {
                    Image(systemName: "square.and.arrow.down")
                    Text("Import 1")
                }
            }
            
            Button {
                b2.toggle()
                
            } label: {
                HStack {
                    Image(systemName: "square.and.arrow.down")
                    Text("Import 2")
                }
            }
        }
        .navigationTitle("TestView")
        .navigationBarTitleDisplayMode(.inline)
        .fileImporter(isPresented: $b1, allowedContentTypes: [.data], allowsMultipleSelection: false) { result in


            do {
                
                guard let selectedFile: URL = try result.get().first else { return }

                // Wird wegen der Sandbox benötigt
                let canAccess = selectedFile.startAccessingSecurityScopedResource()
                guard canAccess else {
                    return
                }

                let data = try! Data(contentsOf: selectedFile)

                // Zugriff beenden
                selectedFile.stopAccessingSecurityScopedResource()


                if let decoded = try? JSONDecoder().decode([String].self, from: data) {

                    arrayS.removeAll()

                    decoded.forEach { s in
                        arrayS.append(s)
                    }

                    print(decoded)
                }

            } catch {
                print(error.localizedDescription)
            }
        }
        
        .fileImporter(isPresented: $b2, allowedContentTypes: [.data], allowsMultipleSelection: false) { result in


            do {
                
                guard let selectedFile: URL = try result.get().first else { return }

                // Wird wegen der Sandbox benötigt
                let canAccess = selectedFile.startAccessingSecurityScopedResource()
                guard canAccess else {
                    return
                }

                let data = try! Data(contentsOf: selectedFile)

                // Zugriff beenden
                selectedFile.stopAccessingSecurityScopedResource()


                if let decoded = try? JSONDecoder().decode([String].self, from: data) {

                    arrayS.removeAll()

                    decoded.forEach { s in
                        arrayS.append(s)
                    }

                    print(decoded)
                }

            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

struct TestView2_Previews: PreviewProvider {
    static var previews: some View {
        TestView2()
    }
}
