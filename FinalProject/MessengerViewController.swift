//
//  MessengerViewController.swift
//  FinalProject
//
//  Created by Skylar Weaver on 12/7/15.
//  Copyright (c) 2015 Skylar Weaver. All rights reserved.
//

import UIKit
import SwiftAddressBook


class MessengerViewController: UIViewController, UITextViewDelegate {
    var group  : SwiftAddressBookGroup?
    var placeHolderText = "Placeholder Text..."
    @IBOutlet var messageInput: UITextView!

    // Create a MessageComposer
    let messageComposer = MessageComposer()

    override func viewDidLoad() {
        super.viewDidLoad()
        messageInput.delegate = self
        self.title = "Message to " + self.group!.name!
    }
    
    @IBAction func sendTextMessageButtonTapped(sender: UIButton) {
        // Make sure the device can send text messages
        if (messageComposer.canSendText()) {
            //loop through each person in group to send message to each
            for person in self.group!.allMembers!{
                var formattedText = formatText(messageInput.text, person: person);
                messageComposer.textMessageBody = formattedText
                messageComposer.textMessageRecipients = person.phoneNumbers["Mobile"]
                messageComposer.recipientName = "TEST"
                // Obtain a configured MFMessageComposeViewController
                let messageComposeVC = messageComposer.configuredMessageComposeViewController()
                
                // Present the configured MFMessageComposeViewController instance
                // Note that the dismissal of the VC will be handled by the messageComposer instance,
                // since it implements the appropriate delegate call-back
                presentViewController(messageComposeVC, animated: true, completion: nil)
            }
        } else {
            // Let the user know if his/her device isn't able to send text messages
            let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
            errorAlert.show()
        }
    }
    
    func formatText(textInput: String, person: SwiftAddressBookPerson) -> String{
        let result1 = textInput.lowercaseString.stringByReplacingOccurrencesOfString("%nickname", withString: (person.nickname != nil ? person.nickname : person.firstName)!);
        let result2 = result1.lowercaseString.stringByReplacingOccurrencesOfString("%lastname", withString: person.lastName!);
        let result3 = result2.lowercaseString.stringByReplacingOccurrencesOfString("%firstname", withString: person.firstName!);
        let finalResult = result3.lowercaseString.stringByReplacingOccurrencesOfString("%fullname", withString: person.compositeName!);
        return finalResult
    }
    
    // MARK: - TextViewStuff
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        
        self.messageInput.textColor = UIColor.blackColor()
        
        if(self.messageInput.text == placeHolderText) {
            self.messageInput.text = ""
        }
        
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if(messageInput.text == "") {
            self.messageInput.text = placeHolderText
            self.messageInput.textColor = UIColor.lightGrayColor()
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        if (messageInput.text == "") {
            self.messageInput.text = placeHolderText
            self.messageInput.textColor = UIColor.lightGrayColor()
        } else {
            self.messageInput.text = messageInput.text
            self.messageInput.textColor = UIColor.blackColor()
        }
    }
}