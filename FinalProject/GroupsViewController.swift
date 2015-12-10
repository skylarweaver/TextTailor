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
//        print("Groups 1: ", terminator: "");
//        print(self.groups, terminator: "");
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "peopleViewSegue" {
        let peopleView = segue.destinationViewController as! PeopleViewController
        let row = tableView.indexPathForSelectedRow!.row
        peopleView.group = self.groups![row]
        }
    }

    
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
            cell.groupSizeLabel.text = String(groups![indexPath.row].allMembers!.count);
        }
        else {
            cell.groupLabel.text = "No groups created";
        }
        return cell
    }
    

    func openSettings() {
        let url = NSURL(string: UIApplicationOpenSettingsURLString)
        UIApplication.sharedApplication().openURL(url!)
    }
    

    
    
    
    // MARK: - Actions
    
}

