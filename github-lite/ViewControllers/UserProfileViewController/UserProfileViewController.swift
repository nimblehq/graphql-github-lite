//
//  UserProfileViewController.swift
//  github-lite
//
//  Created by Issarapong Poesua on 11/17/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import Apollo
import AlamofireImage

class UserProfileViewController: UIViewController {

    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var fullNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserData()
    }
    
    func setUserInfoToViewController(user: UserQuery.Data.Viewer) {
        self.fullNameLabel.text = user.name
        self.usernameLabel.text = user.login
        self.profileImageView.af_setImage(withURL: URL(string: user.avatarUrl)!)
    }


    func getUserData() {
        guard let apollo = ApolloManager.shared.apolloClient else { return }
        apollo.fetch(query: UserQuery()) { [weak self] (result, error) in
            if let result = result, let data = result.data {
                self?.setUserInfoToViewController(user: data.viewer)
            }
        }
    }
}
    

