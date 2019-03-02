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
