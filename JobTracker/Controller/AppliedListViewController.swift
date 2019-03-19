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
    
}

class AppliedListTableViewController: UITableViewController {
    
    var jobApplicationsData: [String] = ["Test1", "Test2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getJobApplications()
    }
    
    func getJobApplications() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "JobApplication")
        request.returnsObjectsAsFaults = false
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                jobApplicationsData.append(data.value(forKey: "jobTitle") as! String)
            }
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
        return jobApplicationsData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "jobApplicationCell", for: indexPath) as! JobApplicationViewCell
        
        // Configure the cell...
        cell.jobApplicationLabel.text = jobApplicationsData[indexPath.row]
        
        return cell
    }
}
