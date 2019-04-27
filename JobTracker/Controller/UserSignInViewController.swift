//
//  userSignInViewController.swift
//  JobTracker
//
//  Created by William Lin on 3/10/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit
import FirebaseAuth

class UserSignInViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet var swipeDownGesture: UISwipeGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeDownGesture.delegate = self
        logoImage.roundImage()
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
