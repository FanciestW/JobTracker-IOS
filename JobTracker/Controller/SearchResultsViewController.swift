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

class SearchResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIGestureRecognizerDelegate {

    var searchQuery: String = ""
    var searchResults: [JobListing] = []

    @IBOutlet weak var resultsTableView: UITableView!
    @IBOutlet var longHoldGesture: UILongPressGestureRecognizer!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        longHoldGesture.delegate = self
        self.title = "Search Results"
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let touchPoint = gestureRecognizer.location(in: self.tableView)
        if let indexPath = self.tableView.indexPathForRow(at: touchPoint) {
            showLocationDetailView(jobLocation: searchResults[indexPath.row].jobLocation)
        }
        return true
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "jobListingCell",
            for: indexPath) as! JobListingCell
        cell.jobTitleLabel?.text = searchResults[indexPath.row].jobTitle
        cell.jobCompanyLabel?.text = searchResults[indexPath.row].jobCompany
        cell.jobLocationLabel?.text = searchResults[indexPath.row].jobLocation
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showJobDetailView(jobUrl: searchResults[indexPath.row].jobUrl)
    }
    
    func showJobDetailView(jobUrl: String) {
        let viewController = UIStoryboard.init(
            name: "JobSearch",
            bundle: Bundle.main
        ).instantiateViewController(withIdentifier: "jobListingDetailViewController") as? JobListingDetailViewController
        viewController?.jobListingUrl = jobUrl
        self.navigationController?.pushViewController(viewController!, animated: true)
    }
    
    func showLocationDetailView(jobLocation: String) {
        let viewController = UIStoryboard.init(
            name: "JobSearch",
            bundle: Bundle.main
            ).instantiateViewController(withIdentifier: "jobLocationDetailViewController") as? JobLocationViewController
        viewController?.jobLocation = jobLocation
        self.navigationController?.pushViewController(viewController!, animated: true)
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
