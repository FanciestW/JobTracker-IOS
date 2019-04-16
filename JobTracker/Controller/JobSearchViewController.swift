//
//  JobSearchViewController.swift
//  JobTracker
//
//  Created by William Lin on 2/28/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit

class JobSearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSearchPress(_ sender: Any) {
        let vc = UIStoryboard.init(name: "JobSearch", bundle: Bundle.main).instantiateViewController(withIdentifier: "searchResultsViewController") as? SearchResultsViewController
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
