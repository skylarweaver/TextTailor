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


class MessengerViewController: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource, MFMessageComposeViewControllerDelegate {
    var group  : SwiftAddressBookGroup?
    var placeHolderText = "Placeholder Text...Use .fn for first name & .ln for last name"
    var persons : [SwiftAddressBookPerson] = []
    var tempGroup : [SwiftAddressBookPerson]?
    var messagesDictArray: [[String:[Int]]] = []
    var recievedMessageText = ""

    
    @IBOutlet var messageInput: UITextView!
    @IBOutlet var tableView: UITableView!

    // Create a MessageComposer
    let messageComposer = MessageComposer()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        messageInput.delegate = self
        if self.tempGroup != nil{
            self.title = "Message Custom Group"
        }
        else{
            self.title = "Message " + self.group!.name!
        }
        if self.recievedMessageText != ""{
            self.messageInput.text = recievedMessageText
        }
    }
    
    /// Force the text in a UITextView to always center itself.
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        let textView = object as! UITextView
        var topCorrect = (textView.bounds.size.height - textView.contentSize.height * textView.zoomScale) / 2
        topCorrect = topCorrect < 0.0 ? 0.0 : topCorrect;
        textView.contentInset.top = 0.0 //topCorrect
    }
    
    @IBAction func SendButton2(sender: AnyObject) {
        if self.tempGroup != nil{
            self.persons = self.tempGroup!
        }
        else{
            self.persons = self.group!.allMembers!
        }
        sendNextMessage()
    }

    
    func sendNextMessage(){
        if self.persons.count != 0{
            let person : SwiftAddressBookPerson = persons.last!
            if (messageComposer.canSendText()) {
                let formattedText = formatText(messageInput.text, person: person);
                messageComposer.textMessageBody = formattedText
                messageComposer.textMessageRecipients = person.phoneNumbers!.filter { $0.id == 0 }[0].value
                
                // Obtain a configured MFMessageComposeViewController
                let messageComposeVC = messageComposer.configuredMessageComposeViewController()
                messageComposeVC.messageComposeDelegate = self
                
                // Present the configured MFMessageComposeViewController instance
                // Note that the dismissal of the VC will be handled by the messageComposer instance,
                // since it implements the appropriate delegate call-back
                presentViewController(messageComposeVC, animated: true, completion: nil)
                self.persons.popLast()
            } else {
                // Let the user know if his/her device isn't able to send text messages
                let errorAlert = UIAlertView(title: "Cannot Send Text Message", message: "Your device is not able to send text messages.", delegate: self, cancelButtonTitle: "OK")
                errorAlert.show()
            }
        }else{
            let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)
            var recipients : [SwiftAddressBookPerson] = []
            if self.tempGroup != nil{
                recipients = self.tempGroup!
            }
            else{
                recipients = self.group!.allMembers!
            }
            let message = Message(messageText: messageInput.text, recipients: recipients, timestamp: timestamp )
            saveData(message)
            
            tabBarController?.selectedIndex = 1

            
            let groupsViewController = self.storyboard?.instantiateViewControllerWithIdentifier("groupsViewController") as? GroupsViewController
            self.navigationController?.pushViewController(groupsViewController!, animated: true)
            
            tabBarController?.selectedIndex = 0

            return
        }
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)
        if result.rawValue == MessageComposeResultCancelled.rawValue || result.rawValue == MessageComposeResultFailed.rawValue{
            self.persons = []
            return
        }else{
            sendNextMessage()
        }
    }

    
    func formatText(textInput: String, person: SwiftAddressBookPerson) -> String{
        let result1 = textInput.stringByReplacingOccurrencesOfString("%nickname", withString: (person.nickname != nil ? person.nickname!.capitalizedString : (person.firstName != nil ? person.firstName!.capitalizedString : "")));
        let result2 = result1.stringByReplacingOccurrencesOfString("%lastname", withString: (person.lastName  != nil ? person.lastName!.capitalizedString : ""));
        let result3 = result2.stringByReplacingOccurrencesOfString("%firstname", withString: (person.firstName != nil ? person.firstName!.capitalizedString : ""));
        let result4 = result3.stringByReplacingOccurrencesOfString(".firstname", withString: (person.firstName != nil ? person.firstName!.capitalizedString : ""));
        let result5 = result4.stringByReplacingOccurrencesOfString(".lastname", withString: (person.lastName != nil ? person.lastName!.capitalizedString : ""));
        let result6 = result5.stringByReplacingOccurrencesOfString(".fn", withString: (person.firstName != nil ? person.firstName!.capitalizedString : ""));
        let result7 = result6.stringByReplacingOccurrencesOfString(".ln", withString: (person.lastName != nil ? person.lastName!.capitalizedString : ""));
        let finalResult = result7.stringByReplacingOccurrencesOfString("%fullname", withString: (person.compositeName != nil ? person.compositeName!.capitalizedString : ""));
        return finalResult
    }
    
    
    // MARK: - DataSaving Stuff
    
    func saveData(message : Message) {
        let defaults = NSUserDefaults.standardUserDefaults()
        if defaults.objectForKey("SavedMessages") != nil{
            self.messagesDictArray = defaults.objectForKey("SavedMessages") as! [[String:[Int]]]
        }
        else{
            self.messagesDictArray = []
        }
        var recipientRecordIDs :[Int] = []
        message.recipients.map({recipientRecordIDs += [$0.recordID]})
        self.messagesDictArray = [[message.messageText : recipientRecordIDs]] + self.messagesDictArray
        defaults.setObject(self.messagesDictArray, forKey: "SavedMessages")
        defaults.synchronize()
    }
    
    
    // MARK: - tableView Stuff
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.tempGroup != nil{
            print("NUM SECTIONS")
            return self.tempGroup!.count == 0 ? 1 : self.tempGroup!.count
        }
        else{
            return self.group!.allMembers!.count == 0 ? 1 : self.group!.allMembers!.count
        }

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        return
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("recipientCellMessages", forIndexPath: indexPath) as! RecipientCellViewMessages
        
        if self.tempGroup != nil{
            return populateCell(cell, recipients: self.tempGroup!, indexPath: indexPath)
        }
        else{
            return populateCell(cell, recipients: self.group!.allMembers!, indexPath: indexPath)
        }
    }
    
    func populateCell(cell: RecipientCellViewMessages, recipients: [SwiftAddressBookPerson], indexPath: NSIndexPath) -> UITableViewCell{
        if recipients.count > 0{
            let firstName = recipients[indexPath.row].firstName != nil ?  recipients[indexPath.row].firstName : ""
            let lastName = recipients[indexPath.row].lastName != nil ? recipients[indexPath.row].lastName : ""
            let fullName = firstName! + " " + lastName!
            cell.recipient.text = fullName
            if recipients[indexPath.row].phoneNumbers != nil{
                let phoneNumber = recipients[indexPath.row].phoneNumbers!.filter { $0.id == 0 }[0].value
                cell.phoneNumber.text = phoneNumber
            }
            else{
                cell.phoneNumber.text = "No Mobile Number"
            }
        }
        else{
            
            cell.recipient.text = "NO NAME"
            cell.phoneNumber.text = "NO PHONE"
        }
        return cell
    }
    
    
    // MARK: - TextViewStuff
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        self.view.endEditing(true)
        messageInput.resignFirstResponder()
        return false
    }
    
    
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