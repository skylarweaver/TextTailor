//
//  FirstViewController.swift
//  FinalProject
//
//  Created by Skylar Weaver on 12/2/15.
//  Copyright (c) 2015 Skylar Weaver. All rights reserved.
//

import UIKit
import SwiftAddressBook

class MessageDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    var recipients : [SwiftAddressBookPerson?] = []
    var message : String = ""
    
    @IBOutlet var messageField: UITextView!
    @IBOutlet var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        messageField.text = self.message
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        tabBarController?.selectedIndex = 0
        if segue.identifier == "messageDetailToMessenger" {
            let messengerView = segue.destinationViewController as! MessengerViewController
            messengerView.tempGroup = self.recipients.map({$0!})
            messengerView.recievedMessageText = self.message

        }
    }
            
    
    // MARK: - TableView
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recipients.count == 0 ? 1 : self.recipients.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        return
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("recipientCell", forIndexPath: indexPath) as! RecipientCellView
        if self.recipients.count > 0{
            let firstName = self.recipients[indexPath.row]!.firstName != nil ?  self.recipients[indexPath.row]!.firstName : ""
            let lastName = self.recipients[indexPath.row]!.lastName != nil ? self.recipients[indexPath.row]!.lastName: ""
            let fullName = firstName! + " " + lastName!
            cell.recipient.text = fullName
            if self.recipients[indexPath.row]!.phoneNumbers != nil{
                let phoneNumber = self.recipients[indexPath.row]!.phoneNumbers!.filter { $0.id == 0 }[0].value
                cell.phoneNumber.text = phoneNumber //!= nil ? phoneNumber : "No Mobile Phone Number"
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
}
