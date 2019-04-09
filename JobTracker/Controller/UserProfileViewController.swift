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
    
    override func viewWillAppear(_ animated: Bool) {
        if Auth.auth().currentUser == nil {
            goToNewJobView()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        emailLabel.text = Auth.auth().currentUser?.email ?? "None"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func showSignInUpView() {
        let signInUpViewController = storyboard?.instantiateViewController(withIdentifier: "SignInUpNavView") as! UINavigationController
        DispatchQueue.main.async {
            self.present(signInUpViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func logOutButtonOnClick(_ sender: Any) {
        try! Auth.auth().signOut()
        showSignInUpView()
    }
    
    func goToNewJobView() {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let mainTabView: UITabBarController = mainStoryboard.instantiateViewController(withIdentifier: "mainTabBarController") as! UITabBarController
        mainTabView.selectedIndex = 2 // Show the new job application tab.
        self.present(mainTabView, animated: false, completion: nil)
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
