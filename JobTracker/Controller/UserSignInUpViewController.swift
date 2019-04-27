//
//  UserSignInUpViewController.swift
//  JobTracker
//
//  Created by William Lin on 3/2/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit
import FirebaseAuth

class UserSignInUpViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var LogoImage: UIImageView!
    @IBOutlet var edgeSwipeDownGesture: UISwipeGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LogoImage.roundImage()
        edgeSwipeDownGesture.delegate = self
    }
    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        cancelSignInUp(gestureRecognizer)
        return true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if Auth.auth().currentUser != nil {
            self.performSegue(withIdentifier: "UserAlreadyLoggedIn", sender: nil)
        }
    }
    
    @IBAction func cancelSignInUp(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
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
