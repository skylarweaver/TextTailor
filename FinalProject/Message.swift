

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
    
    init(messageText: String, recipients: [SwiftAddressBookPerson], timestamp : String) {
        self.messageText = messageText
        self.recipients = recipients
        self.timestamp = timestamp
        super.init()
    }
}

