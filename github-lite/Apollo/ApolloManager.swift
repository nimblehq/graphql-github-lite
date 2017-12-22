//
//  ApolloManager.swift
//  github-lite
//
//  Created by Issarapong Poesua on 11/17/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import Apollo

class ApolloManager: NSObject {

    var apolloClient: ApolloClient!
    
    static var shared = ApolloManager()
    let configuration = URLSessionConfiguration.default

    override init() {
        super.init()
        self.observeDidReceiveNotification()
        let token = GitHubManager.shared.appManager.personalToken
        let endPoint = URL(string: "https://api.github.com/graphql")!
        self.configuration.httpAdditionalHeaders = ["Authorization": "bearer \(token)"]
        self.apolloClient = ApolloClient(networkTransport: HTTPNetworkTransport(url: endPoint, configuration: configuration))
    }
    
    func observeDidReceiveNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(setNewToken(_:)), name: Notification.Name(rawValue: "didReceiveGitHubToken"), object: nil)
    }
    
    @objc func setNewToken(_ notification: Notification) {
        guard let token = notification.userInfo!["token"] as? String else { return }
        self.configuration.httpAdditionalHeaders = ["Authorization": "bearer \(token)"];
    }
}
