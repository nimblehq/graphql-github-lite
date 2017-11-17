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

    let apolloClient: ApolloClient!
    
    static var shared = ApolloManager()
    var configuration = URLSessionConfiguration.default

    override init() {
        let endPoint = URL(string: "https://api.github.com/graphql")!
        self.configuration.httpAdditionalHeaders = ["Authorization": "bearer \(GitHubManager.shared.appManager.personalToken)"]
        self.apolloClient = ApolloClient(networkTransport: HTTPNetworkTransport(url: endPoint, configuration: configuration))
    }
    
}
