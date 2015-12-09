//
//  Contact.swift
//  FinalProject
//
//  Created by Skylar Weaver on 12/5/15.
//  Copyright (c) 2015 Skylar Weaver. All rights reserved.
//

import Foundation
import UIKit
import AddressBook

class Contact {
    var firstName: String!
    var lastName: String!
    var phoneNumber: String!
    var imageData: NSData!
    
    var description : String {
        return firstName + " " + lastName
    }
    
    init(firstName: String, lastName: String, phoneNumber: String, imageName: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.phoneNumber = phoneNumber
        self.imageData = UIImageJPEGRepresentation(UIImage(named: imageName)!, 0.7)
    }
}