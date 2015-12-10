//
//  tempGroupViewController.swift
//  FinalProject
//
//  Created by Skylar Weaver on 12/9/15.
//  Copyright © 2015 Skylar Weaver. All rights reserved.
//

import UIKit
import SwiftAddressBook

class TempGroupViewController: UITableViewController, UISearchDisplayDelegate {
    
    var people : [SwiftAddressBookPerson]? = []
    var tempGroup :[SwiftAddressBookPerson] = []
    let alphabetSections = ["a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"]
    var filteredContacts : [SwiftAddressBookPerson] = []

    
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
        }
        else {
            cell.personName.text = "You have no friends :(";
        }
        
        cell.selected = false
        if tempGroup.contains(sectionPeople[indexPath.row]){
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
        }
        else{
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
        
        return cell
    }
    
        override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
        {
            var sectionPeople = self.people!.filter({ person in person.firstName!.lowercaseString.characters.first == Character(alphabetSections[indexPath.section])})
            let cell = tableView.cellForRowAtIndexPath(indexPath)
            if cell!.selected
            
            {
                cell!.selected = false
                if !tempGroup.contains(sectionPeople[indexPath.row]){
                    tempGroup += [sectionPeople[indexPath.row]]
                }
                else{
                    let index = tempGroup.indexOf(sectionPeople[indexPath.row])
                    tempGroup.removeAtIndex(index!)
                    
                }
            }
            self.tableView.beginUpdates()
            self.tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
            self.tableView.endUpdates()
        }
    
    
    func openSettings() {
        let url = NSURL(string: UIApplicationOpenSettingsURLString)
        UIApplication.sharedApplication().openURL(url!)
    }
    
//    func filterContentForSearchText(searchText: String) {
//        // Filter the array using the filter method
//        self.filteredCandies = self.candies.filter({( candy: Candy) -> Bool in
//            let categoryMatch = (scope == "All") || (candy.category == scope)
//            let stringMatch = candy.name.rangeOfString(searchText)
//            return categoryMatch && (stringMatch != nil)
//        })
//    }
//    
    
    
    // MARK: - Actions
    
}

