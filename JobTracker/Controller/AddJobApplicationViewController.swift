//
//  AddJobApplicationViewController.swift
//  JobTracker
//
//  Created by William Lin on 2/27/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit
import CoreData
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
        addInputAccessoryForTextFields(textFields: [jobTitleTextField, companyTextField, appliedDateTextField, jobTypeTextField, jobLocationTextField], dismissable: true, previousNextable: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        saveJobApplicationValues()
    }
    
    @IBAction func btnAddJobApplicationClick(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let jobApplicationEntity = NSEntityDescription.entity(forEntityName: "JobApplication", in: context)
        let newJobApplication = NSManagedObject(entity: jobApplicationEntity!, insertInto: context)
        newJobApplication.setValue(jobTitleTextField.text, forKey: "jobTitle")
        newJobApplication.setValue(companyTextField.text, forKey: "jobCompany")
        newJobApplication.setValue(appliedDateTextField.text, forKey: "jobAppliedDate")
        newJobApplication.setValue(jobTypeTextField.text, forKey: "jobType")
        newJobApplication.setValue(jobLocationTextField.text, forKey: "jobLocation")
        newJobApplication.setValue(jobNoteTextView.text, forKey: "jobNote")
        let alert = UIAlertController(title: "Job Saved", message: nil, preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default)
        alert.addAction(okAlertAction)
        do {
            try context.save()
            self.present(alert, animated: true, completion: nil)
            // Delay the dismissal by 2 seconds
            Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)})
            clearJobApplicationField()
        } catch {
            print("Failed to save to DB")
            alert.title = "Job Failed to Save"
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func appliedDateEditDidBegin(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(updateDateField), for: UIControl.Event.valueChanged)
    }
    
    @objc func updateDateField() {
        let picker:UIDatePicker = self.appliedDateTextField.inputView as! UIDatePicker
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.full
        
        let strDate = dateFormatter.string(from: picker.date)
        self.appliedDateTextField.text = strDate
    }
    
    
    @IBAction func btnClearFieldsClicked(_ sender: Any) {
        let refreshAlert = UIAlertController(title: "Clear All Fields?", message: "This cannot be undone.", preferredStyle: UIAlertController.Style.alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            self.jobTitleTextField.text = ""
            self.companyTextField.text = ""
            self.appliedDateTextField.text = ""
            self.jobTypeTextField.text = ""
            self.jobLocationTextField.text = ""
            self.jobNoteTextView.text = ""
        }))
        
        refreshAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            // Ignore and do nothing
        }))
        
        present(refreshAlert, animated: true, completion: nil)
        
    }
    
    func clearJobApplicationField() {
        self.jobTitleTextField.text = ""
        self.companyTextField.text = ""
        self.appliedDateTextField.text = ""
        self.jobTypeTextField.text = ""
        self.jobLocationTextField.text = ""
        self.jobNoteTextView.text = ""
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
