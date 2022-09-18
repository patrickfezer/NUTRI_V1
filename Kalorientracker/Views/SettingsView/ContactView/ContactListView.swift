//
//  ContactListVIew.swift
//  Kalorientracker
//
//  Created by Patrick Fezer on 09.09.20.
//

import SwiftUI
import MessageUI

struct ContactListView: View {
    @State private var showMailSheet = false
    @State private var showMailAlert = false
    @State private var result: Result<MFMailComposeResult, Error>? = nil
    let mailAlert = Alert(title: Text("mailNotFoundWarningTitle"), message: Text("mailNotFoundWarningDescription"), dismissButton: .default(Text("Ok")))
    let appInformationString = "\n\n________________\nVersion: \(AppInformation.appVersion + " (\(AppInformation.buildVersion))")\nDevice: \(AppInformation.devive)\n \(AppInformation.systemVersion)"
    var body: some View {
        
        Button {
            if MFMailComposeViewController.canSendMail() {
                self.showMailSheet = true
            } else {
                showMailAlert = true
            }
        } label: {
            LabelIconView(icon: "envelope.fill", iconColor: .white, backgroundColor: .blue, text: Text("contact").foregroundColor(Color("DarkAndLight")))
        }
        .alert(isPresented: $showMailAlert) {
            mailAlert
        }
        .sheet(isPresented: $showMailSheet) {
            self.showMailSheet = false
        } content: {
            MailView(result: $result, newSubject: "NUTRI", newMsgBody: appInformationString, mailAddress: "info@fezerapps.com")
        }




        
//        NavigationLink {
//
//            ContactView()
//
//        } label: {
//            LabelIconView(icon: "envelope.fill", iconColor: .white, backgroundColor: .blue, text: Text("contact"))
//        }

    }
}

struct ContactListView_Previews: PreviewProvider {
    static var previews: some View {
        ContactListView()
            .preferredColorScheme(.dark)
    }
}
