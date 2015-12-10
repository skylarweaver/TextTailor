//
//  tempGroupViewController.swift
//  FinalProject
//
//  Created by Skylar Weaver on 12/9/15.
//  Copyright © 2015 Skylar Weaver. All rights reserved.
//

import UIKit
import SwiftAddressBook

class TempGroupViewController: UITableViewController {
    
    var people : [SwiftAddressBookPerson]? = []
    var tempGroup :[SwiftAddressBookPerson] = []
    let alphabetSections = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    
    override
    func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 44
        self.title = "Custom Group"
        swiftAddressBook?.requestAccessWithCompletion { (b :Bool, _ :CFError?) -> Void in if b {
            let sources = swiftAddressBook?.allSources as [SwiftAddressBookSource]?
            if let srcs = sources{
                for source in srcs
                {
                    self.people = swiftAddressBook?.allPeopleInSourceWithSortOrdering(source, ordering: SwiftAddressBookOrdering.firstName)!.filter({ p in p.phoneNumbers != nil}).filter({ pe in pe.firstName != nil})
//                    self.people = self.people!.filter({ person in person.phoneNumbers!.filter({ $0.id == 0 })[0].value != nil})
                }
            }
            dispatch_async(dispatch_get_main_queue(), {
                self.tableView.reloadData()
            })
            }
        }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "messengerTempGroupViewSegue" {
            let messengerView = segue.destinationViewController as! MessengerViewController
            //            let row = tableView.indexPathForSelectedRow()!.row
            messengerView.tempGroup = self.tempGroup
        }
    }
    
    
    // MARK: - TableView
    
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return alphabetSections.count;
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.people == nil ? 1 : self.people!.count
        return (self.people?.filter({ person in person.firstName!.lowercaseString.characters.first == Character(alphabetSections[section])}).count)!
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return alphabetSections[section].uppercaseString
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return self.alphabetSections.map({$0.uppercaseString})
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var sectionPeople = self.people!.filter({ person in person.firstName!.lowercaseString.characters.first == Character(alphabetSections[indexPath.section])})
        let cell = tableView.dequeueReusableCellWithIdentifier("customGroupCellView", forIndexPath: indexPath) as! CustomGroupCellView
        if self.people != nil{
            // Configure the cell...
            let firstName = sectionPeople[indexPath.row].firstName != nil ?  sectionPeople[indexPath.row].firstName : ""
            let lastName = sectionPeople[indexPath.row].lastName != nil ? sectionPeople[indexPath.row].lastName : ""
            let fullName = firstName! + " " + lastName!
            cell.personName.text = fullName
//            cell.personPhoneNumber.text = self.people![indexPath.row].phoneNumbers!.filter { $0.id == 0 }[0].value
        }
        else {
            cell.personName.text = "You have no friends :(";
        }
        
        cell.selected = false
        if tempGroup.contains(sectionPeople[indexPath.row]){
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            print("IN TRUE HERE")
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryType.None
            print("IN FALSE HERE")
        }
        
        return cell
    }
    
        override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
        {
            let cell = tableView.cellForRowAtIndexPath(indexPath)
    
            if cell!.selected
            {
                cell!.selected = false
//                if cell!.accessoryType == UITableViewCellAccessoryType.None
                if !tempGroup.contains(self.people![indexPath.row]){
                    print("IN TRUE")
                    print(tempGroup)
                    tempGroup += [self.people![indexPath.row]]
    //                cell!.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
                else{
                    print("IN FALSE")
                    print(tempGroup)
                    let index = tempGroup.indexOf(self.people![indexPath.row])
                    tempGroup.removeAtIndex(index!)
    //                tempGroup += [self.people![indexPath.row]]
    //                cell!.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            //avoid reloading the entire table due to innefficient algorithm populating the table
            self.tableView.beginUpdates()
            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic) //try other animations
            self.tableView.endUpdates()
//            self.tableView.reloadData()
        }
    
    
    func openSettings() {
        let url = NSURL(string: UIApplicationOpenSettingsURLString)
        UIApplication.sharedApplication().openURL(url!)
    }
    
    
    
    
    
    // MARK: - Actions
    
}

