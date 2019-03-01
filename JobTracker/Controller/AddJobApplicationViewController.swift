//
//  AddJobApplicationViewController.swift
//  JobTracker
//
//  Created by William Lin on 2/27/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit
import Firebase

class AddJobApplicationViewController: UIViewController {

    @IBOutlet weak var jobTitleTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var appliedDateTextField: UITextField!
    @IBOutlet weak var jobTypeTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view.
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

// UIViewController Extension to hide keyboard when clicked outside of focused textbox.
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
