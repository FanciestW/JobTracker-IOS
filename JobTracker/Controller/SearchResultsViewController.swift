//
//  SearchResultsViewController.swift
//  JobTracker
//
//  Created by William Lin on 4/15/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit
import Alamofire 

class JobListingCell: UITableViewCell {
    @IBOutlet weak var jobTitleLabel: UILabel!
    @IBOutlet weak var jobLocationLabel: UILabel!
    @IBOutlet weak var jobCompanyLabel: UILabel!
}

class SearchResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var searchQuery: String = ""
    var searchResults: [JobListing] = []
    
    @IBOutlet weak var resultsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search Results"
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobListingCell", for: indexPath) as! JobListingCell
        cell.jobTitleLabel?.text = searchResults[indexPath.row].jobTitle
        cell.jobCompanyLabel?.text = searchResults[indexPath.row].jobCompany
        cell.jobLocationLabel?.text = searchResults[indexPath.row].jobLocation
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = UIStoryboard.init(name: "JobSearch", bundle: Bundle.main).instantiateViewController(withIdentifier: "jobListingDetailViewController") as? JobListingDetailViewController
        vc?.jobListingUrl = searchResults[indexPath.row].jobUrl;
        self.navigationController?.pushViewController(vc!, animated: true)
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
