//
//  ContactView.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 09.09.20.
//

import SwiftUI
import UIKit
import MessageUI

struct ContactView: View {
    @State private var showSupportSheet = false
    @State private var showFeedbackSheet = false
    @State private var showMailAlertView = false
    let mailAlert = Alert(title: Text("Apple Mail nicht gefunden."), message: Text("Zum Verwenden dieser Funktion muss die standard Mail-App von Apple installiert & konfiguriert sein."), dismissButton: .default(Text("Ok")))
    let appInformationString = "\n\n________________\nVersion: \(AppInformation.appVersion + " (\(AppInformation.buildVersion))")\nDevice: \(AppInformation.devive)\n \(AppInformation.systemVersion)"
    
    // needed for MailView
    @State private var result: Result<MFMailComposeResult, Error>? = nil
    
    var body: some View {
        List {
            
            // support section
            Section(header: Text("Support")) {
                
                // show support mail sheet
                Button(action: {
                    if MFMailComposeViewController.canSendMail() == true {
                        self.showSupportSheet = true
                    } else {
                        showMailAlertView = true
                    }
                    
                }, label: {
                    HStack {
                        LabelIconView(icon: "questionmark.circle", iconColor: .white, backgroundColor: .blue, text: "Support")
                    }
                    
                    // support mail sheet declaration
                }).sheet(isPresented: self.$showSupportSheet, content: {
                    MailView(result: $result, newSubject: "Support", newMsgBody: appInformationString, mailAddress: "support@fezerapps.com")
                })
                .foregroundColor(.primary)
                .alert(isPresented: $showMailAlertView, content: {
                    mailAlert
                })
            }
            
            // feedback section
            Section(header: Text("Feedback")) {
                
                // show feedback mail sheet
                Button(action: {
                    if MFMailComposeViewController.canSendMail() == true {
                        self.showFeedbackSheet = true
                    } else {
                        showMailAlertView = true
                    }
                    
                }, label: {
//                    HStack {
//                        Image(systemName: "envelope")
//                        Text("Feedback")
//                    }
                    
                    LabelIconView(icon: "exclamationmark.circle", iconColor: .white, backgroundColor: .blue, text: "Feedback")
                   
                    // feedback mail sheet declaration
                }).sheet(isPresented: self.$showFeedbackSheet, content: {
                    MailView(result: $result, newSubject: "Feedback", newMsgBody: appInformationString, mailAddress: "feedback@fezerapps.com")
                })
                .foregroundColor(.primary)
                .alert(isPresented: $showMailAlertView, content: {
                    mailAlert
                })
            }
        }
        .listStyle(GroupedListStyle())
        // title navigationbar
        .navigationBarTitle(Text("Support & Feedback"), displayMode: .inline)
    }
}

struct ContactView_Previews: PreviewProvider {
    static var previews: some View {
        ContactView()
            .environment(\.colorScheme, .dark)
    }
}
