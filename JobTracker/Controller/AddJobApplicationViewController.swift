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
    @IBOutlet weak var jobLocationTextField: UITextField!
    @IBOutlet weak var jobNoteTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        loadJobApplicationValues()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        saveJobApplicationValues()
    }
    
    @IBAction func btnClearFieldsClicked(_ sender: Any) {
        jobTitleTextField.text = ""
        companyTextField.text = ""
        appliedDateTextField.text = ""
        jobTypeTextField.text = ""
        jobLocationTextField.text = ""
        jobNoteTextView.text = ""
    }
    
    func loadJobApplicationValues() {
        // Load existing values
        if let saveJobTitle = UserDefaults.standard.value(forKey: "saveJobTitle") {
            jobTitleTextField.text = saveJobTitle as? String ?? ""
        } else {
            UserDefaults.standard.set(jobTitleTextField.text, forKey: "saveJobTitle")
        }
        
        if let saveCompany = UserDefaults.standard.value(forKey: "saveJobCompany") {
            companyTextField.text = saveCompany as? String ?? ""
        } else {
            UserDefaults.standard.set(companyTextField.text, forKey: "saveJobCompany")
        }
        
        if let saveAppliedDate = UserDefaults.standard.value(forKey: "saveJobAppliedDate") {
            appliedDateTextField.text = saveAppliedDate as? String ?? ""
        } else {
            UserDefaults.standard.set(appliedDateTextField.text, forKey: "saveJobAppliedDate")
        }
        
        if let saveJobType = UserDefaults.standard.value(forKey: "saveJobType") {
            jobTypeTextField.text = saveJobType as? String ?? ""
        } else {
            UserDefaults.standard.set(jobTypeTextField.text, forKey: "saveJobType")
        }
        
        if let saveJobLocation = UserDefaults.standard.value(forKey: "saveJobLocation") {
            jobLocationTextField.text = saveJobLocation as? String ?? ""
        } else {
            UserDefaults.standard.set(jobLocationTextField.text, forKey: "saveJobLocation")
        }
        
        if let saveJobNote = UserDefaults.standard.value(forKey: "saveJobNote") {
            jobNoteTextView.text = saveJobNote as? String ?? ""
        } else {
            UserDefaults.standard.set(jobNoteTextView.text, forKey: "saveJobNote")
        }
    }
    
    func saveJobApplicationValues() {
        UserDefaults.standard.set(jobTitleTextField.text, forKey: "saveJobTitle")
        UserDefaults.standard.set(companyTextField.text, forKey: "saveJobCompany")
        UserDefaults.standard.set(appliedDateTextField.text, forKey: "saveJobAppliedDate")
        UserDefaults.standard.set(jobTypeTextField.text, forKey: "saveJobType")
        UserDefaults.standard.set(jobLocationTextField.text, forKey: "saveJobLocation")
        UserDefaults.standard.set(jobNoteTextView.text, forKey: "saveJobNote")
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
