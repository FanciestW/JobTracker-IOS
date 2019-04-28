//
//  JobListing.swift
//  JobTracker
//
//  Created by William Lin on 4/14/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit
import Foundation

class JobListing: NSObject {
    var jobTitle: String = ""
    var jobType: String = ""
    var jobCompany: String = ""
    var jobCompanyUrl: String = ""
    var jobUrl: String = ""
    var jobLocation: String = ""
    var jobDescription: String = ""

    init(jsonDict: NSDictionary) {
        self.jobTitle = jsonDict["title"] as? String ?? ""
        self.jobType = jsonDict["type"] as? String ?? ""
        self.jobCompany = jsonDict["company"] as? String ?? ""
        self.jobCompanyUrl = jsonDict["company_url"] as? String ?? ""
        self.jobUrl = jsonDict["url"] as? String ?? ""
        self.jobLocation = jsonDict["location"] as? String ?? ""
        self.jobDescription = jsonDict["description"] as? String ?? ""
    }
}
