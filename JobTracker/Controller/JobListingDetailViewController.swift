//
//  JobListingDetailViewController.swift
//  JobTracker
//
//  Created by William Lin on 4/18/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit
import WebKit

class JobListingDetailViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var webView: WKWebView!
    var selectedJob: JobListing? = nil
    var jobListingUrl = "jobs.github.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        webView.load(URLRequest(url: URL(string: jobListingUrl)!))
        // Do any additional setup after loading the view.
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
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
