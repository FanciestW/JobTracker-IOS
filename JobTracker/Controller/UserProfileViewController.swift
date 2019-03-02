//
//  UserProfileViewController.swift
//  JobTracker
//
//  Created by William Lin on 2/28/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit
import FirebaseAuth

class UserCheckViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Auth.auth().currentUser != nil {
            print("User logged in")
            showUserProfileView()
        } else {
            print("User not logged in")
            showSignInUpView()
        }
    }
    
    func showUserProfileView() {
        let userProfileViewController = storyboard?.instantiateViewController(withIdentifier: "UserProfileView") as! UserProfileViewController
        DispatchQueue.main.async {
            self.present(userProfileViewController, animated: true, completion: nil)
        }
    }
    
    func showSignInUpView() {
        let signInUpViewController = storyboard?.instantiateViewController(withIdentifier: "SignInUpView") as! UserSignInUpViewController
        DispatchQueue.main.async {
            self.present(signInUpViewController, animated: true, completion: nil)
        }
    }
    
}

class UserProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
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
