//
//  UserProfileViewController.swift
//  JobTracker
//
//  Created by William Lin on 2/28/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit
import FirebaseAuth

class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if Auth.auth().currentUser == nil {
            self.showSignInUpView()
        }
        _ = Auth.auth().addStateDidChangeListener { (auth, user) in
            if auth.currentUser == nil {
                self.showSignInUpView()
            }
        }
        
        emailLabel.text = Auth.auth().currentUser?.email ?? "None"
        
    }
    
    func showSignInUpView() {
        let signInUpViewController = storyboard?.instantiateViewController(withIdentifier: "SignInUpNavView") as! UINavigationController
        DispatchQueue.main.async {
            self.present(signInUpViewController, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logOutButtonOnClick(_ sender: Any) {
        try! Auth.auth().signOut()
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
