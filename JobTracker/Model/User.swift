//
//  User.swift
//  JobTracker
//
//  Created by William Lin on 3/9/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit

class User: NSObject {
    var firstName: String
    var lastName: String
    var email: String
    var dateOfBirth: Date
    
    init(fName:String, lName:String, email:String, dob:Date) {
        self.firstName = fName
        self.lastName = lName
        self.email = email
        self.dateOfBirth = dob
    }
    
    func getFullName() -> String {
        return "\(self.firstName) \(self.lastName)"
    }
}
