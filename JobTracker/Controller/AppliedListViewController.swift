//
//  AppliedListViewController.swift
//  JobTracker
//
//  Created by William Lin on 2/28/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit
import CoreData

class JobApplicationViewCell: UITableViewCell {
    
    @IBOutlet weak var jobApplicationLabel: UILabel!
    @IBOutlet weak var jobApplicationCompanyLabel: UILabel!
    @IBOutlet weak var jobApplicationLocation: UILabel!
}

class AppliedListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var appliedTableView: UITableView!

    var savedJobAppList: [SavedApplication] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        appliedTableView.dataSource = self
        appliedTableView.delegate = self
        appliedTableView.refreshControl = UIRefreshControl()
        appliedTableView.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        appliedTableView.refreshControl!.addTarget(self, action: #selector(refreshJobs(_:)), for: .valueChanged)
        appliedTableView.addSubview(appliedTableView.refreshControl!) // not required when using UITableViewController
    }

    override func viewWillAppear(_ animated: Bool) {
        getJobApplications()
    }

    @objc func refreshJobs(_ refreshControl: UIRefreshControl) {
        getJobApplications()
        appliedTableView.refreshControl!.endRefreshing()
    }

    func getJobApplications() {
        savedJobAppList.removeAll()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "JobApplication")
        request.returnsObjectsAsFaults = false

        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let savedJobApp = SavedApplication(
                    title: data.value(forKey: "jobTitle") as? String ?? "",
                    company: data.value(forKey: "jobCompany") as? String ?? "",
                    jobType: data.value(forKey: "jobType") as? String ?? "",
                    loc: data.value(forKey: "jobLocation") as? String ?? "",
                    date: data.value(forKey: "jobAppliedDate") as? String ?? "",
                    status: data.value(forKey: "jobAppStatus") as? String ?? "",
                    note: data.value(forKey: "jobNote") as? String ?? ""
                )
                savedJobApp.objectId = data.objectID
                savedJobAppList.append(savedJobApp)
            }
            appliedTableView.reloadData()
        } catch {
            print("Error in getting data")
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return savedJobAppList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobApplicationCell", for: indexPath) as! JobApplicationViewCell

        // Configure the cell...
        cell.jobApplicationLabel.text = savedJobAppList[indexPath.row].title
        cell.jobApplicationCompanyLabel.text = savedJobAppList[indexPath.row].company
        cell.jobApplicationLocation.text = savedJobAppList[indexPath.row].location
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController = UIStoryboard.init(name: "AppliedList", bundle: Bundle.main).instantiateViewController(withIdentifier: "jobAppDetailViewController") as? JobAppDetailViewController
        viewController?.savedApp = savedJobAppList[indexPath.row]
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
