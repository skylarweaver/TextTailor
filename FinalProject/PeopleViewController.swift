//
//  PeopleViewController.swift
//  FinalProject
//
//  Created by Skylar Weaver on 12/2/15.
//  Copyright (c) 2015 Skylar Weaver. All rights reserved.
//

import UIKit
import AddressBook
import SwiftAddressBook

class PeopleViewController: UITableViewController {
    
    var groups : [SwiftAddressBookGroup]? = []
    var people : [SwiftAddressBookPerson]? = []
    var group  : SwiftAddressBookGroup?


    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.group?.name
        tableView.rowHeight = 44
        tableView.allowsSelection = false;
        swiftAddressBook?.requestAccessWithCompletion { (b :Bool, _ :CFError?) -> Void in if b {
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
            }
        }
        println("Group 1: ");
        println(self.group);
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "messengerViewSegue" {
            let messengerView = segue.destinationViewController as! MessengerViewController
//            let row = tableView.indexPathForSelectedRow()!.row
            messengerView.group = self.group
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - TableView
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.group == nil || self.group!.allMembers == nil) ? 1 : self.group!.allMembers!.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("personCell", forIndexPath: indexPath) as! PersonCellView
        if (self.group != nil)  && (self.group!.allMembers != nil) && (self.group!.allMembers!.count != 0){
            // Configure the cell...
            cell.personName.text = self.group!.allMembers![indexPath.row].compositeName
//          cell.personPhoneNumber.text = self.group!.allMembers![indexPath.row].phoneNumbers[0]
            cell.personPhoneNumber.text = "EMPTYYY"
            println("Phone Numbers:")
            println(self.group!.allMembers![indexPath.row].phoneNumbers)
            println("END");
        }
        else {
            cell.personName.text = "Group is empty";
            cell.personPhoneNumber.text = "EMPTYYY"
        }
        return cell
    }
    
//    func promptForAddressBookRequestAccess(petButton: UIButton) {
//        var err: Unmanaged<CFError>? = nil
//        
//        ABAddressBookRequestAccessWithCompletion(addressBookRef) {
//            (granted: Bool, error: CFError!) in
//            dispatch_async(dispatch_get_main_queue()) {
//                if !granted {
//                    self.displayCantAddContactAlert()
//                } else {
//                    println("Just authorized")
//                }
//            }
//        }
//    }
    
    func openSettings() {
        let url = NSURL(string: UIApplicationOpenSettingsURLString)
        UIApplication.sharedApplication().openURL(url!)
    }
    
//    func displayCantAddContactAlert() {
//        let cantAddContactAlert = UIAlertController(title: "Cannot Add Contact",
//            message: "You must give the app permission to add the contact first.",
//            preferredStyle: .Alert)
//        cantAddContactAlert.addAction(UIAlertAction(title: "Change Settings",
//            style: .Default,
//            handler: { action in
//                self.openSettings()
//        }))
//        cantAddContactAlert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
//        presentViewController(cantAddContactAlert, animated: true, completion: nil)
//    }
    
    
    
    // MARK: - Actions
    
//    @IBAction func tappedAddPetToContacts(petButton: UIButton) {
//        let authorizationStatus = ABAddressBookGetAuthorizationStatus()
//        
//        switch authorizationStatus {
//        case .Denied, .Restricted:
//            //1
//            println("Denied")
//            displayCantAddContactAlert()
//        case .Authorized:
//            //2
//            println("Authorized")
//            //            addPetToContacts(petButton)
//        case .NotDetermined:
//            //3
//            println("Not Determined")
//            promptForAddressBookRequestAccess(petButton)
//        }
//    }
    
    //    swiftAddressBook?.requestAccessWithCompletion({ (success, error) -> Void in
    //    if success {
    //    //do something with swiftAddressBook
    //    }
    //    else {
    //    //no success. Optionally evaluate error
    //    }
    //    })
}

