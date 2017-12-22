//
//  GitHubAppManager.swift
//  github-lite
//
//  Created by Issarapong Poesua on 11/16/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import WebKit

class GitHubAppManager: NSObject {

    var gitHubClientID: String { return  "feed9477814eac3651e8" }
    var gitHubClientSecret: String { return "0841a05dd3145d41109908f318289242be87776e"}
    private var gitHubRedirectedURLString: String { return "" }
    private var scope: String { return "" }
    private var state: String { return "" }
    var loginName: String? {
        set {
            print("set login name:", newValue!)
            UserDefaults.standard.set(newValue, forKey: "loginName") }
        get {
            let loginName = UserDefaults.standard.object(forKey: "loginName") as? String ?? ""
            print("get login name", loginName)
            return loginName
        }
    }
    
    func logOut() {
        personalToken = ""
        URLCache.shared.removeAllCachedResponses()
    }
    var personalToken: String {
        set {
            print("set PersonalToken:", newValue)
            UserDefaults.standard.set(newValue, forKey: "personalToken")
            NotificationCenter.default.post(name: Notification.Name(rawValue: "personalTokenDidChange"),
                                            object: nil,
                                            userInfo: ["token" : newValue])
        }
        get {
            let personalToken = UserDefaults.standard.object(forKey: "personalToken") as? String ?? ""
            print("get PersonalToken:", personalToken)
            return personalToken
        }
    }
    
    private var urlString: String {
        return "https://github.com/login/oauth/authorize?&client_id=\(gitHubClientID)&redirect_uri=\(gitHubRedirectedURLString)&scope=\(scope)&state=\(state)&allow_signup=true" }

    var url: URL { return URL(string: urlString)! }
}
        

