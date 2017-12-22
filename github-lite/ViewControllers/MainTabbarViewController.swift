//
//  MainTabbarViewController.swift
//  github-lite
//
//  Created by Issarapong Poesua on 11/17/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class MainTabbarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (GitHubManager.shared.appManager.personalToken.isEmpty) {
            let userProfileNavigationController = self.viewControllers?.last as? UINavigationController
            self.selectedViewController = userProfileNavigationController
        } else {
            let userProfileNavigationController = self.viewControllers?.first as? UINavigationController
            self.selectedViewController = userProfileNavigationController
        }
        

    }
}
