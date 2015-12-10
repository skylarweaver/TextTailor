//
//  DataModel.swift
//  Final Project
//

import Foundation


class DataModel {
//    var messages : [Message]
    
//    init() {
//        loadMessages()
////        registerDefaults()
////        handleFirstTime()
//    }
//    
//    func documentsDirectory() -> String {
//        let paths: [String] = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
//        return paths[0]
//    }
//    
//    func dataFilePath() -> String {
////        NSURL.URLByAppendingPathComponent("Checklists.plist")
//        return "\(documentsDirectory())Checklists.plist"
//    }
//    
//    func saveMessages() {
//        let data = NSMutableData()
//        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
//        archiver.encodeObject(messages, forKey: "Messages")
//        archiver.finishEncoding()
//        data.writeToFile(dataFilePath(), atomically: true)
//    }
//    
//    func loadMessages() {
//        let path = dataFilePath()
//        if NSFileManager.defaultManager().fileExistsAtPath(path) {
//            if let data = NSData(contentsOfFile: path) {
//                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
//                messages = unarchiver.decodeObjectForKey("Messages") as! Message
//                unarchiver.finishDecoding()
//                
////                sortChecklists()
//            }
//        }
//    }

//    func registerDefaults() {
//        let dictionary = [ "ChecklistIndex": -1,
//            "FirstTime": true,
//            "ChecklistItemID": 0 ]
//        
//        NSUserDefaults.standardUserDefaults().registerDefaults(dictionary)
//    }
//    
//    var indexOfSelectedChecklist: Int {
//        get {
//            return NSUserDefaults.standardUserDefaults().integerForKey("ChecklistIndex")
//        }
//        set {
//            NSUserDefaults.standardUserDefaults().setInteger(newValue, forKey: "ChecklistIndex")
//        }
//    }
//    
//    func handleFirstTime() {
//        let userDefaults = NSUserDefaults.standardUserDefaults()
//        let firstTime = userDefaults.boolForKey("FirstTime")
//        if firstTime {
//            let checklist = Checklist(name: "List")
//            lists.append(checklist)
//            indexOfSelectedChecklist = 0
//            userDefaults.setBool(false, forKey: "FirstTime")
//        }
//    }
//    
////    func sortChecklists() {
////        lists.sort({ checklist1, checklist2 in return checklist1.name.localizedStandardCompare(checklist2.name) == NSComparisonResult.OrderedAscending })
////    }
//    
//    class func nextChecklistItemID() -> Int {
//        let userDefaults = NSUserDefaults.standardUserDefaults()
//        let itemID = userDefaults.integerForKey("ChecklistItemID")
//        userDefaults.setInteger(itemID + 1, forKey: "ChecklistItemID")
//        userDefaults.synchronize()
//        return itemID
//    }
}
