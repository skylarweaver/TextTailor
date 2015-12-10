//
//  FirstViewController.swift
//  FinalProject
//
//  Created by Skylar Weaver on 12/2/15.
//  Copyright (c) 2015 Skylar Weaver. All rights reserved.
//

import UIKit
import SwiftAddressBook

class MessagesViewController: UITableViewController {
    var messagesDict : [[String : [Int]]] = []
    
    @IBAction func deleteAll(sender: AnyObject) {
        //Use to delete all current messages
        for key in NSUserDefaults.standardUserDefaults().dictionaryRepresentation().keys {
            NSUserDefaults.standardUserDefaults().removeObjectForKey(key)
        }
        let messagesData = NSUserDefaults.standardUserDefaults()
        messagesData.synchronize()
        if (messagesData.objectForKey("SavedMessages"))  != nil{
            self.messagesDict = messagesData.objectForKey("SavedMessages") as! [[String:[Int]]]
        }
        else{
            self.messagesDict = []
        }
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swiftAddressBook?.requestAccessWithCompletion { (b :Bool, _ :CFError?) -> Void in if b {
            let sources = swiftAddressBook?.allSources
            for source in sources! {
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
        }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        let messagesData = NSUserDefaults.standardUserDefaults()
        messagesData.synchronize()
        if (messagesData.objectForKey("SavedMessages"))  != nil{
            self.messagesDict = messagesData.objectForKey("SavedMessages") as! [[String:[Int]]]
        }
        else{
            self.messagesDict = []
        }
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "messageDetailSegue" {
            let messageDetail = segue.destinationViewController as! MessageDetailViewController
            let row = tableView.indexPathForSelectedRow!.row
            let recipients = (Array(self.messagesDict[row].values.map({$0}))[0])
            var recipientsObjects : [SwiftAddressBookPerson?] = []
            for recipient in recipients{
                if swiftAddressBook?.personWithRecordId(Int32(recipient)) != nil{
                    recipientsObjects += [swiftAddressBook!.personWithRecordId(Int32(recipient))]
                }
            }

            messageDetail.recipients = recipientsObjects
            messageDetail.message = self.messagesDict[row].keys.first!;

        }
    }
    
    
    // MARK: - TableView
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messagesDict.count == 0 ? 0 : messagesDict.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("messageCell", forIndexPath: indexPath) as! MessageCellView
        if self.messagesDict.count > 0{
            // Configure the cell...
            let recipientString = findRecipientNames(self.messagesDict, indexPath: indexPath)
            cell.recipient.text = recipientString
            cell.message.text = self.messagesDict[indexPath.row].keys.first;
//            cell.date.text = "TBD"
        }
        else {
            cell.recipient.text = "You have not sent any messages yet";
            cell.message.text = "";
        }
        return cell
}
    
    func findRecipientNames(messagesDict : [[String:[Int]]], indexPath : NSIndexPath) -> String{
        let recipientsArray = (Array(self.messagesDict[indexPath.row].values.map({$0}))[0])
        var recipientString : String = ""
        print("RECIPIENTS")
        print(recipientsArray)
        for index in 0..<recipientsArray.count{
            print(recipientsArray[index])
            let firstName = swiftAddressBook?.personWithRecordId(Int32(recipientsArray[index]))!.firstName != nil ?  swiftAddressBook?.personWithRecordId(Int32(recipientsArray[index]))!.firstName : ""
            let lastName = swiftAddressBook?.personWithRecordId(Int32(recipientsArray[index]))!.lastName != nil ? swiftAddressBook?.personWithRecordId(Int32(recipientsArray[index]))!.lastName: ""
            var fullName = firstName! + " " + lastName!
            if (index != recipientsArray.count - 1) {
                fullName += ", "
            }
            recipientString = recipientString + fullName
        }
        return recipientString
    }
}
