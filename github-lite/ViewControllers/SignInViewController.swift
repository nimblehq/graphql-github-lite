//
//  SignInViewController.swift
//  github-lite
//
//  Created by Issarapong Poesua on 11/16/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import SafariServices

class SignInViewController: UIViewController {
    
    var gitHubManager = GitHubManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    @IBAction func signInWithGitHub(_ sender: UIButton) {
        
        let url = gitHubManager.appManager.url
        let safariViewController = GitHubAuthenicationViewController(url: url)
        safariViewController.modalPresentationStyle = .currentContext
        present(safariViewController, animated: true, completion: nil)
        
    }
    
    
}
