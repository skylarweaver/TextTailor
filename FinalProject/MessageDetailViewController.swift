//
//  FirstViewController.swift
//  FinalProject
//
//  Created by Skylar Weaver on 12/2/15.
//  Copyright (c) 2015 Skylar Weaver. All rights reserved.
//

import UIKit
import SwiftAddressBook

class MessageDetailViewController: UIViewController{//, UITableViewDelegate, UITableViewDataSource{
//    var messagesDict : [[String : [Int]]] = []
    var recipients : [SwiftAddressBookPerson?] = []
    var message : String = ""
    
    @IBOutlet var messageField: UITextView!
//    @IBOutlet var recipientTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        tableView.rowHeight = 44
        messageField.text = self.message
        print("DETAIL PAGE");
        print(self.message);
        print(self.recipients)
        
//        swiftAddressBook?.requestAccessWithCompletion { (b :Bool, _ :CFError?) -> Void in if b {
//            let sources = swiftAddressBook?.allSources
//            for source in sources! {
//            }
//            dispatch_async(dispatch_get_main_queue(), {
////                self.tableView.reloadData()
//            })
//            }
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    //        if segue.identifier == "peopleViewSegue" {
    //            let peopleView = segue.destinationViewController as! PeopleViewController
    //            let row = tableView.indexPathForSelectedRow!.row
    //            peopleView.group = self.groups![row]
    //        }
    //    }
    
    
    // MARK: - TableView
    
    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0
//    }
//
//    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.messagesDict.count == 0 ? 1 : messagesDict.count
//    }
//    
    
//    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        return
//    }

//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCellWithIdentifier("recipientCell", forIndexPath: indexPath) as! RecipientCellView
//        if self.recipients.count > 0{
//            let firstName = self.recipients[indexPath.row]!.firstName != nil ?  self.recipients[indexPath.row]!.firstName : ""
//            let lastName = self.recipients[indexPath.row]!.lastName != nil ? self.recipients[indexPath.row]!.lastName: ""
//            let fullName = firstName! + " " + lastName!
////            cell.recipient = fullName
////            cell.message = self.message
//        }
//        return cell
//    }
//    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCellWithIdentifier("messageCell", forIndexPath: indexPath) as! MessageCellView
//        if self.messagesDict.count > 0{
//            // Configure the cell...
//            let recipientString = findRecipientNames(self.messagesDict, indexPath: indexPath)
//            cell.recipient.text = recipientString
//            cell.message.text = self.messagesDict[indexPath.row].keys.first;
//            //            cell.date.text = "TBD"
//        }
//        else {
//            cell.recipient.text = "You have not sent any messages yet";
//            cell.message.text = "";
//        }
//        return cell
//    }
    
//    func findRecipientNames(messagesDict : [[String:[Int]]], indexPath : NSIndexPath) -> String{
//        let recipients = self.messagesDict[indexPath.row].values
//        print(recipients);
//        var recipientString : String = ""
//        //        recipientString += (recipients.map({"," + (swiftAddressBook?.personWithRecordId(Int32($0[0]))!.firstName)!}))
//        print("RECIPIENTS")
//        print(recipients)
//        for recipient in recipients{
//            recipientString += (swiftAddressBook?.personWithRecordId(Int32(recipient[0]))!.firstName!)! + " "
//        }
//        return recipientString
//    }
}
