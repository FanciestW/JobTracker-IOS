//
//  JobAppDetailViewController.swift
//  JobTracker
//
//  Created by William Lin on 4/22/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit

class JobAppDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    var savedApp: SavedApplication? = nil
    
    @IBOutlet weak var jobTitleText: UITextField!
    @IBOutlet weak var jobCompanyText: UITextField!
    @IBOutlet weak var appliedDateText: UITextField!
    @IBOutlet weak var jobTypeSegControl: UISegmentedControl!
    @IBOutlet weak var jobLocationText: UITextField!
    @IBOutlet weak var jobAppStatusText: UITextField!
    @IBOutlet weak var jobNoteTextView: UITextView!
    
    var backButton: UIBarButtonItem? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        jobTypeSegControl.layer.cornerRadius = 4
        jobNoteTextView.layer.cornerRadius = 4.0
        self.hideKeyboardWhenTappedAround()
        addInputAccessoryForTextFields(textFields: [jobTitleText, jobCompanyText, appliedDateText, jobLocationText, jobAppStatusText], dismissable: true, previousNextable: true)
        let statusPicker = UIPickerView()
        statusPicker.delegate = self
        jobAppStatusText.inputView = statusPicker
        jobTitleText.text = savedApp!.title
        jobCompanyText.text = savedApp!.company
        appliedDateText.text = DateFormatter.localizedString(from: (savedApp?.appliedDate)!, dateStyle: DateFormatter.Style.long, timeStyle: DateFormatter.Style.none)
        switch savedApp!.jobType {
        case "Full Time":
            jobTypeSegControl.selectedSegmentIndex = 0
            break
        case "Part Time":
            jobTypeSegControl.selectedSegmentIndex = 1
            break
        case "Internship":
            jobTypeSegControl.selectedSegmentIndex = 2
            break
        case "Contract":
            jobTypeSegControl.selectedSegmentIndex = 3
            break
        default:
            jobTypeSegControl.selectedSegmentIndex = 0
        }
        jobLocationText.text = savedApp!.location
        jobAppStatusText.text = savedApp!.appStatus
        jobNoteTextView.text = savedApp!.note
        
        let editButton = UIBarButtonItem.init(
            title: "Edit",
            style: .done,
            target: self,
            action: #selector(editButtonAction(sender:))
        )
        self.navigationItem.rightBarButtonItem = editButton
    }
    
    @objc func editButtonAction(sender: UIBarButtonItem) {
        enableEditMode()
    }
    
    func enableEditMode() {
        let cancelButton = UIBarButtonItem.init(
            title: "Cancel",
            style: .plain,
            target: self,
            action: #selector(cancelButtonAction(sender:))
        )
        self.navigationItem.rightBarButtonItem = cancelButton
        jobTitleText.isUserInteractionEnabled = true
        jobCompanyText.isUserInteractionEnabled = true
        appliedDateText.isUserInteractionEnabled = true
        jobTypeSegControl.isUserInteractionEnabled = true
        jobLocationText.isUserInteractionEnabled = true
        jobAppStatusText.isUserInteractionEnabled = true
        jobNoteTextView.isUserInteractionEnabled = true
    }
    
    @objc func cancelButtonAction(sender: UIBarButtonItem) {
        disableEditMode()
    }
    
    func disableEditMode() {
        let editButton = UIBarButtonItem.init(
            title: "Edit",
            style: .done,
            target: self,
            action: #selector(editButtonAction(sender:))
        )
        self.navigationItem.rightBarButtonItem = editButton
    }
    
    @IBAction func appliedDateEditDidBegin(_ sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(updateDateField), for: UIControl.Event.valueChanged)
    }
    
    @objc func updateDateField() {
        let picker:UIDatePicker = self.appliedDateText.inputView as! UIDatePicker
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = DateFormatter.Style.full
        let strDate = dateFormatter.string(from: picker.date)
        self.appliedDateText.text = strDate
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
        jobAppStatusText.text = appStatusData[row]
    }

}
