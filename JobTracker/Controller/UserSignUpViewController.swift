//
//  SignUpViewController.swift
//  JobTracker
//
//  Created by William Lin on 3/10/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit
import FirebaseAuth

class UserSignUpViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var retypePasswordTextField: UITextField!
    @IBOutlet var swipeDownGesture: UISwipeGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeDownGesture.delegate = self
        self.hideKeyboardWhenTappedAround()
        
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            if auth.currentUser != nil {
                self.goToUserProfile()
            }
        }
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        self.navigationController?.dismiss(animated: true, completion: nil)
        return true
    }
    
    @IBAction func btnSignUpClick(_ sender: Any) {
        if !checkFields() {
            return;
        }
        let email: String = emailTextField.text!
        let passwd: String = passwordTextField.text!
        Auth.auth().createUser(withEmail: email, password: passwd, completion: { user, error in
            // Handle any errors.
        })
    }
    
    func checkFields() -> Bool {
        return true
        // TODO::Update to check fields.
    }
    
    func goToUserProfile() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabView: UITabBarController = mainStoryboard.instantiateViewController(withIdentifier: "mainTabBarController") as! UITabBarController
        mainTabView.selectedIndex = 3 // Show the user profile tab.
        self.present(mainTabView, animated: true, completion: nil)
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
