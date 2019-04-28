//
//  JobAppDetailViewController.swift
//  JobTracker
//
//  Created by William Lin on 4/22/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit
import CoreData

class JobAppDetailViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIGestureRecognizerDelegate {

    var savedApp: SavedApplication?
    let jobTypes = ["Full Time", "Part Time", "Internship", "Contract"]

    @IBOutlet weak var jobTitleText: UITextField!
    @IBOutlet weak var jobCompanyText: UITextField!
    @IBOutlet weak var appliedDateText: UITextField!
    @IBOutlet weak var jobTypeSegControl: UISegmentedControl!
    @IBOutlet weak var jobLocationText: UITextField!
    @IBOutlet weak var jobAppStatusText: UITextField!
    @IBOutlet weak var jobNoteTextView: UITextView!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet var swipeDownGesture: UISwipeGestureRecognizer!
    
    var backButton: UIBarButtonItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        swipeDownGesture.delegate = self
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
            case "Part Time":
                jobTypeSegControl.selectedSegmentIndex = 1
            case "Internship":
                jobTypeSegControl.selectedSegmentIndex = 2
            case "Contract":
                jobTypeSegControl.selectedSegmentIndex = 3
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

    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        self.dismissKeyboard()
        return true
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
        self.updateButton.isHidden = false
        jobTitleText.isUserInteractionEnabled = true
        jobCompanyText.isUserInteractionEnabled = true
        appliedDateText.isUserInteractionEnabled = true
        jobTypeSegControl.isUserInteractionEnabled = true
        jobLocationText.isUserInteractionEnabled = true
        jobAppStatusText.isUserInteractionEnabled = true
        jobNoteTextView.isUserInteractionEnabled = true
        jobNoteTextView.isEditable = true
        updateButton.isUserInteractionEnabled = true
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
        jobTitleText.isUserInteractionEnabled = false
        jobCompanyText.isUserInteractionEnabled = false
        appliedDateText.isUserInteractionEnabled = false
        jobTypeSegControl.isUserInteractionEnabled = false
        jobLocationText.isUserInteractionEnabled = false
        jobAppStatusText.isUserInteractionEnabled = false
        jobNoteTextView.isUserInteractionEnabled = false
        jobNoteTextView.isEditable = false
        updateButton.isUserInteractionEnabled = false
        self.updateButton.isHidden = true
    }

    @IBAction func updateJobApp(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        let managedContext = appDelegate.persistentContainer.viewContext

        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "JobApplication")
        fetchRequest.predicate = NSPredicate(format: "jobapplication == %@", (savedApp?.objectId)!)

        let jobApplication = managedContext.object(with: (savedApp?.objectId)!)
        jobApplication.setValue(jobTitleText.text, forKey: "jobTitle")
        jobApplication.setValue(jobCompanyText.text, forKey: "jobCompany")
        jobApplication.setValue(appliedDateText.text, forKey: "jobAppliedDate")
        jobApplication.setValue(jobTypes[jobTypeSegControl.selectedSegmentIndex], forKey: "jobType")
        jobApplication.setValue(jobLocationText.text, forKey: "jobLocation")
        jobApplication.setValue(jobAppStatusText.text, forKey: "jobAppStatus")
        jobApplication.setValue(jobNoteTextView.text, forKey: "jobNote")
        disableEditMode()
        let alert = UIAlertController(title: "Job Updated", message: nil, preferredStyle: .alert)
        let okAlertAction = UIAlertAction(title: "Dismiss", style: UIAlertAction.Style.default)
        alert.addAction(okAlertAction)
        self.present(alert, animated: true, completion: nil)
        // Delay the dismissal by 2 seconds
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)})
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

    let appStatusData = [String](arrayLiteral: "Interested", "Applied", "Interviewing", "Rejected", "Job Offered", "Offer Accepted", "Offer Declined")

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
