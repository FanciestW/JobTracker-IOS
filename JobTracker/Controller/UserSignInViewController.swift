//
//  userSignInViewController.swift
//  JobTracker
//
//  Created by William Lin on 3/10/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit

class UserSignInViewController: UIViewController {
    
    @IBOutlet weak var logoImage: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logoImage.roundImage()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func btnLogInClick(_ sender: Any) {
        
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
