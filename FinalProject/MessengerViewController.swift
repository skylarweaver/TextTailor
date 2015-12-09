//
//  MessengerViewController.swift
//  FinalProject
//
//  Created by Skylar Weaver on 12/7/15.
//  Copyright (c) 2015 Skylar Weaver. All rights reserved.
//

import UIKit
import SwiftAddressBook
import MessageUI.MFMessageComposeViewController


class MessengerViewController: UIViewController, UITextViewDelegate, MFMessageComposeViewControllerDelegate {
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
    
    /// Force the text in a UITextView to always center itself.
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        let textView = object as! UITextView
        var topCorrect = (textView.bounds.size.height - textView.contentSize.height * textView.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
        textView.contentInset.top = topCorrect
    }
    
    
    
    @IBAction func sendTextMessageButtonTapped(sender: UIButton) {
        // Make sure the device can send text messages
        if (messageComposer.canSendText()) {
            //loop through each person in group to send message to each
            print(self.group!.allMembers!)
            for person in self.group!.allMembers!{
                print("INSIDE LOOP")
                let formattedText = formatText(messageInput.text, person: person);
                messageComposer.textMessageBody = formattedText
                messageComposer.textMessageRecipients = person.phoneNumbers!.filter { $0.id == 0 }[0].value
//                messageComposer.recipientName = 
                // Obtain a configured MFMessageComposeViewController
                let messageComposeVC = messageComposer.configuredMessageComposeViewController()
                messageComposeVC.messageComposeDelegate = self
                
                // Present the configured MFMessageComposeViewController instance
                // Note that the dismissal of the VC will be handled by the messageComposer instance,
                // since it implements the appropriate delegate call-back
                presentViewController(messageComposeVC, animated: true, completion: nil)
//                sleep(1)

            }
        } else {
            // Let the user know if his/her device isn't able to send text messages
            let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
            errorAlert.show()
        }
    }
    
    func sendNextMessage(){
        
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        // do something once
    }

    
    func formatText(textInput: String, person: SwiftAddressBookPerson) -> String{
        print("IN FUNCTION")
        print(textInput)
        print(person)
        let result1 = textInput.lowercaseString.stringByReplacingOccurrencesOfString("%nickname", withString: (person.nickname != nil ? person.nickname!.capitalizedString : (person.firstName != nil ? person.lastName!.capitalizedString : "")));
        let result2 = result1.lowercaseString.stringByReplacingOccurrencesOfString("%lastname", withString: (person.lastName  != nil ? person.lastName!.capitalizedString : ""));
        let result3 = result2.lowercaseString.stringByReplacingOccurrencesOfString("%firstname", withString: (person.firstName != nil ? person.firstName!.capitalizedString : ""));
        let finalResult = result3.lowercaseString.stringByReplacingOccurrencesOfString("%fullname", withString: (person.compositeName != nil ? person.compositeName!.capitalizedString : ""));
        print(finalResult)
        return finalResult
//        return "STRING MESSAGE"
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