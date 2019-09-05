//
//  UIViewController.swift
//  NoodoeAssignment
//
//  Created by Leyee.H on 2019/9/5.
//  Copyright © 2019 Leyee. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    class var storyboardID: String {
        return "\(self)"
    }
    
    static func instantiate(from: AppStoryboard) -> Self {
        return from.viewController(viewControllerClass: self)
    }
}
