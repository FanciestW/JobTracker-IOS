//
//  AppliedListViewController.swift
//  JobTracker
//
//  Created by William Lin on 2/28/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit
import CoreData

class AppliedListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        super.loadView()
        
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

class JobApplicationViewCell: UITableViewCell {
    @IBOutlet weak var jobApplicationLabel: UILabel!
    @IBOutlet weak var jobApplicationCompanyLabel: UILabel!
}

class AppliedListTableViewController: UITableViewController {
    
    var jobApplicationsTitle: [String] = []
    var jobApplicationsCompany: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl = UIRefreshControl()
        self.refreshControl!.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refreshControl!.addTarget(self, action: #selector(refreshJobs(_:)), for: .valueChanged)
        tableView.addSubview(self.refreshControl!) // not required when using UITableViewController
        getJobApplications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getJobApplications()
    }
    
    @objc func refreshJobs(_ refreshControl: UIRefreshControl) {
        getJobApplications()
        refreshControl.endRefreshing()
    }
    
    func getJobApplications() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "JobApplication")
        request.returnsObjectsAsFaults = false
        
        do {
            var newJobApplicationsList: [String] = []
            var newJobApplicationsCompany: [String] = []
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                newJobApplicationsList.append(data.value(forKey: "jobTitle") as! String)
                newJobApplicationsCompany.append(data.value(forKey: "jobCompany") as! String)
            }
            self.jobApplicationsTitle = newJobApplicationsList
            self.jobApplicationsCompany = newJobApplicationsCompany
            self.tableView.reloadData()
        } catch {
            print("Error in getting data")
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return jobApplicationsTitle.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobApplicationCell", for: indexPath) as! JobApplicationViewCell
        
        // Configure the cell...
        cell.jobApplicationLabel.text = jobApplicationsTitle[indexPath.row]
        cell.jobApplicationCompanyLabel.text = jobApplicationsCompany[indexPath.row]
        return cell
    }
}
