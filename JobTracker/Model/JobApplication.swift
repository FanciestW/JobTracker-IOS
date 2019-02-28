//
//  JobApplication.swift
//  JobTracker
//
//  Created by William Lin on 2/27/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit

class JobApplication {
    var jobTitle:String
    var company:String
    var appliedDate:Date
    
    init(title:String, company:String, appliedDate:Date) {
        self.jobTitle = title
        self.company = company
        self.appliedDate = appliedDate
    }
}
