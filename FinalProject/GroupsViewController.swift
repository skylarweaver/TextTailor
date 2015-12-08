//
//  SecondViewController.swift
//  FinalProject
//
//  Created by Skylar Weaver on 12/2/15.
//  Copyright (c) 2015 Skylar Weaver. All rights reserved.
//

import UIKit
import AddressBook
import SwiftAddressBook

class GroupsViewController: UITableViewController {

    let addressBookRef: ABAddressBook = ABAddressBookCreateWithOptions(nil, nil).takeRetainedValue()
    var groups : [SwiftAddressBookGroup]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 44
        swiftAddressBook?.requestAccessWithCompletion { (b :Bool, _ :CFError?) -> Void in if b {
                let sources = swiftAddressBook?.allSources
                for source in sources! {
                    let newGroups = swiftAddressBook!.allGroupsInSource(source)!
                    self.groups = self.groups! + newGroups
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }
        }
        print("Groups 1: ");
        print(self.groups);
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "peopleViewSegue" {
        let peopleView = segue.destinationViewController as! PeopleViewController
        let row = tableView.indexPathForSelectedRow()!.row
        peopleView.group = self.groups![row]
        }
    }
    
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "showDetail" {
//        let showDetail: EventDetailViewController = segue.destinationViewController as! EventDetailViewController
//        let row = tableView.indexPathForSelectedRow()!.row
//        showDetail.event = appEvents![row]
//        }
//    }
    
    // MARK: - TableView

    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups == nil ? 1 : groups!.count+0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("groupCell", forIndexPath: indexPath) as! GroupCellView
        if groups != nil{
            // Configure the cell...
            cell.groupLabel.text = groups![indexPath.row].name
            cell.groupSizeLabel.text = String(100);
            //            cell.groupLabel.text = String(groups?.count);
        }
        else {
            cell.groupLabel.text = "No groups created";
        }
        print("Groups");
        print(groups);
        return cell
    }
    
    func promptForAddressBookRequestAccess(petButton: UIButton) {
        var err: Unmanaged<CFError>? = nil
        
        ABAddressBookRequestAccessWithCompletion(addressBookRef) {
            (granted: Bool, error: CFError!) in
            dispatch_async(dispatch_get_main_queue()) {
                if !granted {
                    self.displayCantAddContactAlert()
                } else {
                    println("Just authorized")
                }
            }
        }
    }

    func openSettings() {
        let url = NSURL(string: UIApplicationOpenSettingsURLString)
        UIApplication.sharedApplication().openURL(url!)
    }
    
    func displayCantAddContactAlert() {
        let cantAddContactAlert = UIAlertController(title: "Cannot Add Contact",
            message: "You must give the app permission to add the contact first.",
            preferredStyle: .Alert)
        cantAddContactAlert.addAction(UIAlertAction(title: "Change Settings",
            style: .Default,
            handler: { action in
                self.openSettings()
        }))
        cantAddContactAlert.addAction(UIAlertAction(title: "OK", style: .Cancel, handler: nil))
        presentViewController(cantAddContactAlert, animated: true, completion: nil)
    }
    
    
    
    // MARK: - Actions
    
    @IBAction func tappedAddPetToContacts(petButton: UIButton) {
        let authorizationStatus = ABAddressBookGetAuthorizationStatus()
        
        switch authorizationStatus {
        case .Denied, .Restricted:
            //1
            println("Denied")
            displayCantAddContactAlert()
        case .Authorized:
            //2
            println("Authorized")
//            addPetToContacts(petButton)
        case .NotDetermined:
            //3
            println("Not Determined")
            promptForAddressBookRequestAccess(petButton)
        }
    }
    
//    swiftAddressBook?.requestAccessWithCompletion({ (success, error) -> Void in
//    if success {
//    //do something with swiftAddressBook
//    }
//    else {
//    //no success. Optionally evaluate error
//    }
//    })
}

