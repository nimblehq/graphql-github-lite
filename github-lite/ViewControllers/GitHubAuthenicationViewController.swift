//
//  GitHubAuthenicationViewController.swift
//  github-lite
//
//  Created by Issarapong Poesua on 11/16/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import SafariServices

class GitHubAuthenicationViewController: SFSafariViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self

    }
    

}

extension GitHubAuthenicationViewController: SFSafariViewControllerDelegate {

    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    

    
}
