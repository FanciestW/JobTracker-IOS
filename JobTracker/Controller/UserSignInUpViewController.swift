//
//  UserSignInUpViewController.swift
//  JobTracker
//
//  Created by William Lin on 3/2/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit

class UserSignInUpViewController: UIViewController {

    @IBOutlet weak var LogoImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        LogoImage.roundImage()
        print("Got into UserSignInUpViewController")
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
