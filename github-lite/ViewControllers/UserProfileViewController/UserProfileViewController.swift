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
import SVProgressHUD

class UserProfileViewController: UIViewController {

    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var usernameLabel: UILabel!
    @IBOutlet private weak var fullNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clear()
        self.observeToken()
        if (GitHubManager.shared.appManager.personalToken.isEmpty) {
            showLoginModal()
        } else {
            getUserData()

        }
    }
    
    @IBAction func logOut(_ sender: UIBarButtonItem) {
        GitHubManager.shared.appManager.personalToken = ""
        clear()
    }
    
    private func setUserInfoToViewController(user: CurrentUserQuery.Data.Viewer) {
        self.fullNameLabel.text = user.name
        self.usernameLabel.text = user.login
        self.profileImageView.af_setImage(withURL: URL(string: user.avatarUrl)!)
    }


    private func getUserData() {
        SVProgressHUD.show()
        guard let apollo = ApolloManager.shared.apolloClient else { return }
        apollo.fetch(query: CurrentUserQuery()) { [weak self] (result, error) in
            if (error != nil) {
                SVProgressHUD.dismiss()
                SVProgressHUD.showError(withStatus: error!.localizedDescription)
            }
            
            if let result = result, let data = result.data {
                self?.setUserInfoToViewController(user: data.viewer)
                SVProgressHUD.dismiss()
            }
        }
    }
    
    private func clear() {
        self.profileImageView.image = nil
        self.usernameLabel.text = nil
        self.fullNameLabel.text = nil
    }
    
    @objc func didReceiveNotificationHandler(_ notification: Notification) {
        // MARK: From notification
        
        guard let token = notification.userInfo!["token"] as? String else { return }
        
        if (token.isEmpty) {
            showLoginModal()
        }
    }
    
    func showLoginModal() {
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let gitHubAuthenicationNavigationController = storyBoard.instantiateViewController(withIdentifier: "GitHubAuthenicationNavigationController")
        
        let gitHubWebViewController = gitHubAuthenicationNavigationController.childViewControllers.first as! GitHubAuthenicationViewController
        
        gitHubWebViewController.didReceiveToken = { [weak self] _ in
            self?.getUserData()
        }
        gitHubWebViewController.modalPresentationStyle = .currentContext
        self.present(gitHubAuthenicationNavigationController, animated: true)
    }
    
    func observeToken() {
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(didReceiveNotificationHandler(_:)),
                         name: NSNotification.Name(rawValue: "personalTokenDidChange"),
                         object: nil)
    }
}
    

