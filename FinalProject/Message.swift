

//
//  Message.swift
//  FinalProject
//
//  Created by Skylar Weaver on 12/2/15.
//  Copyright (c) 2015 Skylar Weaver. All rights reserved.
//

import Foundation
import SwiftAddressBook


class Message: NSObject{ //, NSCoding {
    var messageText = ""
    var recipients : [SwiftAddressBookPerson] = []
    var timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .ShortStyle)


//    convenience init(name: String) {
//        self.init(messageText: messageText, recipients: recipients)
//    }
    
    init(messageText: String, recipients: [SwiftAddressBookPerson], timestamp : String) {
        self.messageText = messageText
        self.recipients = recipients
        self.timestamp = timestamp
        super.init()
    }

//    required init(coder aDecoder: NSCoder) {
//        messageText = aDecoder.decodeObjectForKey("MessageText") as! String
//        recipients = aDecoder.decodeObjectForKey("Recipients") as! [SwiftAddressBookPerson]
//        timestamp = aDecoder.decodeObjectForKey("Timestamp") as! String
//        super.init()
//    }
//    
//    func encodeWithCoder(aCoder: NSCoder) {
//        aCoder.encodeObject(messageText, forKey: "MessageText")
//        aCoder.encodeObject(recipients, forKey: "Recipients")
//        aCoder.encodeObject(timestamp, forKey: "Timestamp")
//    }
    



}

