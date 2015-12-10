//
//  SecondViewController.swift
//  FinalProject
//
//  Created by Skylar Weaver on 12/2/15.
//  Copyright (c) 2015 Skylar Weaver. All rights reserved.
//

import UIKit
import SwiftAddressBook

class GroupsViewController: UITableViewController {

    var groups : [SwiftAddressBookGroup]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 44
        swiftAddressBook?.requestAccessWithCompletion { (b :Bool, _ :CFError?) -> Void in if b {
                let sources = swiftAddressBook?.allSources
                for source in sources! {
                    let newGroups = swiftAddressBook!.allGroupsInSource(source)!
                    self.groups = self.groups! + newGroups
                    print("ACCESS ALLOWED")
                    print(self.groups)
                    print(newGroups)
                }
                dispatch_async(dispatch_get_main_queue(), {
                    self.tableView.reloadData()
                })
            }
        }
        print("GROUPS")
        print(self.groups!.count);
        
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
        return self.groups == nil ? 1 : self.groups!.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("groupCell", forIndexPath: indexPath) as! GroupCellView
        if self.groups != nil{
            if self.groups!.count > 0{
                // Configure the cell...
                print("BEFORE ERROR")
                print(self.groups)
                            cell.groupLabel.text = groups![indexPath.row].name
                if self.groups![indexPath.row].allMembers != nil{
                    cell.groupSizeLabel.text = String(self.groups![indexPath.row].allMembers!.count);
                }
                else{
                    cell.groupSizeLabel.text = "Empty Group"
                    cell.contactsLabel.text = ""
                }
            }
        }
        else {
            cell.groupLabel.text = "No groups created";
        }
        return cell
    }
    

//    func openSettings() {
//        let url = NSURL(string: UIApplicationOpenSettingsURLString)
//        UIApplication.sharedApplication().openURL(url!)
//    }
    

    
    
    
    // MARK: - Actions
    
}

