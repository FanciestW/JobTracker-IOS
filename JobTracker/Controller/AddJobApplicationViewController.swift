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

class AddJobApplicationViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var jobTitleTextField: UITextField!
    @IBOutlet weak var companyTextField: UITextField!
    @IBOutlet weak var appliedDateTextField: UITextField!
    @IBOutlet weak var jobLocationTextField: UITextField!
    @IBOutlet weak var jobAppStatusTextField: UITextField!
    @IBOutlet weak var jobNoteTextView: UITextView!
    @IBOutlet weak var jobTypeSegControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jobTypeSegControl.layer.cornerRadius = 4.0
        jobNoteTextView.layer.cornerRadius = 4.0
        self.hideKeyboardWhenTappedAround()
        loadJobApplicationValues()
        addInputAccessoryForTextFields(textFields: [jobTitleTextField, companyTextField, appliedDateTextField, jobLocationTextField, jobAppStatusTextField], dismissable: true, previousNextable: true)
        let statusPicker = UIPickerView()
        statusPicker.delegate = self
        jobAppStatusTextField.inputView = statusPicker
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        saveJobApplicationValues()
    }
    
    @IBAction func btnAddJobApplicationClick(_ sender: Any) {
        if (!checkInputFields()) {
            return
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let jobApplicationEntity = NSEntityDescription.entity(forEntityName: "JobApplication", in: context)
        let newJobApplication = NSManagedObject(entity: jobApplicationEntity!, insertInto: context)
        let jobType: String
        switch jobTypeSegControl.selectedSegmentIndex {
            case 0:
                jobType = "Full Time"
                break
            case 1:
                jobType = "Part Time"
                break
            case 2:
                jobType = "Internship"
                break;
            case 3:
                jobType = "Contract"
            default:
                jobType = ""
        }
        newJobApplication.setValue(jobTitleTextField.text, forKey: "jobTitle")
        newJobApplication.setValue(companyTextField.text, forKey: "jobCompany")
        newJobApplication.setValue(appliedDateTextField.text, forKey: "jobAppliedDate")
        newJobApplication.setValue(jobType, forKey: "jobType")
        newJobApplication.setValue(jobLocationTextField.text, forKey: "jobLocation")
        newJobApplication.setValue(jobAppStatusTextField.text, forKey: "jobAppStatus")
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
    
    func checkInputFields() -> Bool {
        var fieldsCheck = true
        if (jobTitleTextField.text == "") {
            jobTitleTextField.layer.cornerRadius = 4.0
            jobTitleTextField.layer.borderColor = UIColor.red.cgColor
            jobTitleTextField.layer.borderWidth = 2.0
            fieldsCheck = fieldsCheck && false
        }
        if (companyTextField.text == "") {
            companyTextField.layer.cornerRadius = 4.0
            companyTextField.layer.borderColor = UIColor.red.cgColor
            companyTextField.layer.borderWidth = 2.0
            fieldsCheck = fieldsCheck && false
        }
        if (appliedDateTextField.text == "") {
            appliedDateTextField.layer.cornerRadius = 4.0
            appliedDateTextField.layer.borderColor = UIColor.red.cgColor
            appliedDateTextField.layer.borderWidth = 2.0
            fieldsCheck = fieldsCheck && false
        }
        if (jobLocationTextField.text == "") {
            jobLocationTextField.layer.cornerRadius = 4.0
            jobLocationTextField.layer.borderColor = UIColor.red.cgColor
            jobLocationTextField.layer.borderWidth = 2.0
            fieldsCheck = fieldsCheck && false
        }
        if (jobAppStatusTextField.text == "") {
            jobAppStatusTextField.layer.cornerRadius = 4.0
            jobAppStatusTextField.layer.borderColor = UIColor.red.cgColor
            jobAppStatusTextField.layer.borderWidth = 2.0
            fieldsCheck = fieldsCheck && false
        }
        return fieldsCheck
    }
    
    @IBAction func textFieldEditingDidBegin(_ sender: Any) {
        (sender as! UITextField).layer.borderWidth = 0.0
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
    
    let appStatusData = [String](arrayLiteral: "Interested", "Applied", "Interviewing", "Rejected", "Job Offered")
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return appStatusData.count
    }
    
    func pickerView( _ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return appStatusData[row]
    }
    
    func pickerView( _ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        jobAppStatusTextField.text = appStatusData[row]
    }
    
    @IBAction func btnClearFieldsClicked(_ sender: Any) {
        let confirmation = UIAlertController(title: "Clear All Fields?", message: "This cannot be undone.", preferredStyle: UIAlertController.Style.alert)
        
        confirmation.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in self.clearJobApplicationField()
        }))
        
        confirmation.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            // Ignore and do nothing
        }))
        
        present(confirmation, animated: true, completion: nil)
    }
    
    func clearJobApplicationField() {
        self.jobTitleTextField.text = ""
        self.companyTextField.text = ""
        self.appliedDateTextField.text = ""
        self.jobTypeSegControl.selectedSegmentIndex = 0;
        self.jobLocationTextField.text = ""
        self.jobAppStatusTextField.text = ""
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
            jobTypeSegControl.selectedSegmentIndex = saveJobType as? Int ?? 0
        } else {
            UserDefaults.standard.set(jobTypeSegControl.selectedSegmentIndex, forKey: "saveJobType")
        }
        
        if let saveJobLocation = UserDefaults.standard.value(forKey: "saveJobLocation") {
            jobLocationTextField.text = saveJobLocation as? String ?? ""
        } else {
            UserDefaults.standard.set(jobLocationTextField.text, forKey: "saveJobLocation")
        }
        
        if let saveJobAppStatus = UserDefaults.standard.value(forKey: "saveJobAppStatus") {
            jobAppStatusTextField.text = saveJobAppStatus as? String ?? ""
        } else {
            UserDefaults.standard.set(jobLocationTextField.text, forKey: "saveJobAppStatus")
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
        UserDefaults.standard.set(jobTypeSegControl.selectedSegmentIndex, forKey: "saveJobType")
        UserDefaults.standard.set(jobLocationTextField.text, forKey: "saveJobLocation")
        UserDefaults.standard.set(jobAppStatusTextField.text, forKey: "saveJobAppStatus")
        UserDefaults.standard.set(jobNoteTextView.text, forKey: "saveJobNote")
    }

}
