//
//  MainTabBarViewController.swift
//  JobTracker
//
//  Created by William Lin on 4/8/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit
import FirebaseAuth

class MainTabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }

    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController is UserProfileViewController {
            if Auth.auth().currentUser == nil {
                let signInUpViewController = UIStoryboard(name: "UserProfile", bundle: nil).instantiateViewController(withIdentifier: "SignInUpNavView") as! UINavigationController
                DispatchQueue.main.async {
                    self.present(signInUpViewController, animated: true, completion: nil)
                }
                return false
            } else {
                return true
            }
        } else {
            return true
        }
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
