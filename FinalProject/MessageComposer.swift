//
//  MessageComposer.swift
//  FinalProject
//
//  Created by Skylar Weaver on 12/7/15.
//  Copyright (c) 2015 Skylar Weaver. All rights reserved.
//

import Foundation
import MessageUI



class MessageComposer: NSObject{//, MFMessageComposeViewControllerDelegate {
    
    var textMessageRecipients: String? // for pre-populating the recipients list (optional, depending on your needs)
    var textMessageBody: String?
    var recipientName: String?
    // A wrapper function to indicate whether or not a text message can be sent from the user's device
    func canSendText() -> Bool {
        return MFMessageComposeViewController.canSendText()
    }
    
    // Configures and returns a MFMessageComposeViewController instance
    func configuredMessageComposeViewController() -> MFMessageComposeViewController {
        let messageComposeVC = MFMessageComposeViewController()
        if let recipient = textMessageRecipients{
            messageComposeVC.recipients = [recipient]
        }
        if let body = textMessageBody{
            messageComposeVC.body = body
        }
        return messageComposeVC
    }
    
}