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
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "messengerViewSegue" {
            let messengerView = segue.destinationViewController as! MessengerViewController
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
            let firstName = self.group!.allMembersWithSortOrdering(SwiftAddressBookOrdering.firstName)![indexPath.row].firstName != nil ?  self.group!.allMembersWithSortOrdering(SwiftAddressBookOrdering.firstName)![indexPath.row].firstName : ""
            let lastName = self.group!.allMembersWithSortOrdering(SwiftAddressBookOrdering.firstName)![indexPath.row].lastName != nil ? self.group!.allMembersWithSortOrdering(SwiftAddressBookOrdering.firstName)![indexPath.row].lastName: ""
            let fullName = firstName! + " " + lastName!
            cell.personName.text = fullName
            if self.group!.allMembers![indexPath.row].phoneNumbers != nil{
                let phoneNumber = self.group!.allMembers![indexPath.row].phoneNumbers!.filter { $0.id == 0 }[0].value
                cell.personPhoneNumber.text = phoneNumber //!= nil ? phoneNumber : "No Mobile Phone Number"
            }
            else{
                cell.personPhoneNumber.text = "No Mobile Number"
            }
        }
        else {
            cell.personName.text = "Group is empty";
            cell.personPhoneNumber.text = "EMPTYYY"
        }
        return cell
    }
    
    
    func openSettings() {
        let url = NSURL(string: UIApplicationOpenSettingsURLString)
        UIApplication.sharedApplication().openURL(url!)
    }

}

