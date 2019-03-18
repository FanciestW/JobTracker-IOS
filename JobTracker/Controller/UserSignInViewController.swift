//
//  userSignInViewController.swift
//  JobTracker
//
//  Created by William Lin on 3/10/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit
import FirebaseAuth

class UserSignInViewController: UIViewController {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImage.roundImage()
        self.hideKeyboardWhenTappedAround()
        
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            if auth.currentUser != nil {
                self.goToUserProfile()
            }
        }
    }
    
    @IBAction func btnLogInClick(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { [weak self] user, error in
            if (error != nil) {
                print("Login Error")
                print(error ?? "Error")
            }
            guard let strongSelf = self else { return }
            
        }
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
