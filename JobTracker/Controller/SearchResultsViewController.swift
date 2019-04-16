//
//  SearchResultsViewController.swift
//  JobTracker
//
//  Created by William Lin on 4/15/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit

class SearchResultsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var resultsTableView: UITableView!
    var jobListings: [String] = ["Test", "Test1", "Test2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Search Results"
        resultsTableView.dataSource = self
        resultsTableView.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobListingCell", for: indexPath)
        cell.textLabel?.text = jobListings[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobListings.count
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
