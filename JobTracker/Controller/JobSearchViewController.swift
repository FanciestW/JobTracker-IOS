//
//  JobSearchViewController.swift
//  JobTracker
//
//  Created by William Lin on 2/28/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit
import Alamofire

class JobSearchViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var titleTextfield: UITextField!
    @IBOutlet weak var locationTextfield: UITextField!
    @IBOutlet var edgePanGesture: UIScreenEdgePanGestureRecognizer!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchLoadingIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        edgePanGesture.delegate = self
        // Do any additional setup after loading the view.
    }

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        onSearchPress(edgePanGesture)
        return true
    }

    @IBAction func onSearchPress(_ sender: Any) {
        searchLoadingIndicator.startAnimating()
        var jobTitle: String = self.titleTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        var location: String = self.locationTextfield.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        jobTitle = jobTitle.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        location = location.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        let requestUrl: String = "https://jobs.github.com/positions.json?description=\(jobTitle)&location=\(location)"
        Alamofire.request(requestUrl).responseJSON { response in
            var jobList: [JobListing] = []
            if let json = response.result.value {
                for result in json as! NSArray {
                    jobList.append(JobListing(jsonDict: result as! NSDictionary))
                }
            }
            let viewController = UIStoryboard.init(name: "JobSearch", bundle: Bundle.main).instantiateViewController(withIdentifier: "searchResultsViewController") as? SearchResultsViewController
            viewController?.searchQuery = requestUrl
            viewController?.searchResults = jobList
            self.navigationController?.pushViewController(viewController!, animated: true)
            self.searchLoadingIndicator.stopAnimating()
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
