//
//  SignUpViewController.swift
//  JobTracker
//
//  Created by William Lin on 3/10/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit
import FirebaseAuth

class UserSignUpViewController: UIViewController {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var retypePasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            if auth.currentUser != nil {
                self.goToUserProfile()
            }
        }
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
        let userProfileView = storyboard?.instantiateViewController(withIdentifier: "UserProfileView")
        present(userProfileView!, animated: true, completion: nil)
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
