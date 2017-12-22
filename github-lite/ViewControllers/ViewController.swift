//
//  ViewController.swift
//  github-lite
//
//  Created by Issarapong Poesua on 12/22/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.observeToken()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func observeToken() {
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(didReceiveNotificationHandler(_:)),
                         name: NSNotification.Name(rawValue: "personalTokenDidChange"),
                         object: nil)
    }

    @objc func didReceiveNotificationHandler(_ notification: Notification) {
        
    }

}
