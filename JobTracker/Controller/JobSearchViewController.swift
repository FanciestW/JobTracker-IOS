//
//  JobSearchViewController.swift
//  JobTracker
//
//  Created by William Lin on 2/28/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit
import Alamofire

class JobSearchViewController: UIViewController {
    
    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var locationTextfield: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSearchPress(_ sender: Any) {
        let jobTitle: String = self.titleTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let location: String = self.locationTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let requestUrl: String = "https://jobs.github.com/positions.json?description=\(jobTitle.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)&location=\(location.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!)"
        Alamofire.request(requestUrl).responseJSON { response in
            var jobList: [JobListing] = []
            if let json = response.result.value {
                for result in json as! NSArray {
                    jobList.append(JobListing(jsonDict: result as! NSDictionary))
                }
            }
            let vc = UIStoryboard.init(name: "JobSearch", bundle: Bundle.main).instantiateViewController(withIdentifier: "searchResultsViewController") as? SearchResultsViewController
            vc?.searchQuery = requestUrl
            vc?.searchResults = jobList
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
