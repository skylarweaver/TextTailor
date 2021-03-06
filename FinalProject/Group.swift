//
//  Group.swift
//  FinalProject
//
//  Created by Skylar Weaver on 12/2/15.
//  Copyright (c) 2015 Skylar Weaver. All rights reserved.
//

import Foundation
import UIKit
import AddressBook
import SwiftAddressBook

class Group {
    var groupName: String!
    var groupSize: Int!
    var people : [SwiftAddressBookPerson]? = []
    
    init(groupName: String) {
        self.groupName = groupName
    }
}
