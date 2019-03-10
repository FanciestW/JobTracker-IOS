//
//  Extensions.swift
//  JobTracker
//
//  Created by William Lin on 3/2/19.
//  Copyright © 2019 William Lin. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func roundImage() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
    
}

// UIViewController Extension to hide keyboard when clicked outside of focused textbox.
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
