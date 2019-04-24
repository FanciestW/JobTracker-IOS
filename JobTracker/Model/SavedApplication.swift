//
//  JobApplication.swift
//  JobTracker
//
//  Created by William Lin on 4/21/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit
import CoreData

class SavedApplication: NSObject {
    
    var objectId: NSManagedObjectID?
    var title: String
    var company: String
    var jobType: String
    var location: String
    var appliedDate: Date
    var appStatus: String
    var note: String
    
    init(title:String, company:String, jobType:String, loc:String, date:String, status:String, note:String) {
        self.title = title
        self.company = company
        self.jobType = jobType
        self.location = loc
        self.appliedDate = DateFormatter().date(from: date) ?? Date()
        self.appStatus = status
        self.note = note
        
    }
    
    init(title:String, company:String, jobType:String, loc:String, date:Date, status:String, note:String) {
        self.title = title
        self.company = company
        self.jobType = jobType
        self.location = loc
        self.appliedDate = date
        self.appStatus = status
        self.note = note
    }
}
