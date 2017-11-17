//
//  GitHubAuthenicationViewController.swift
//  github-lite
//
//  Created by Issarapong Poesua on 11/16/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import WebKit
import Alamofire
import SwiftyJSON

class GitHubAuthenicationViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var closeBarButtonItem: UIBarButtonItem!
    
    var appManager = GitHubManager.shared.appManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        closeBarButtonItem.tintColor = .red
        webView.load(URLRequest(url: GitHubManager.shared.appManager.url))
        webView.navigationDelegate = self
        
    }
    
    @IBAction func closeBarButtonItem(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getUserToken(from code: String, completion: ((String)->())? = nil) {
        
        let params: Parameters = [
            "client_id": appManager.gitHubClientID,
            "client_secret": appManager.gitHubClientSecret,
            "code": code
        ]
        let header: HTTPHeaders = ["Accept": "application/json"]
        let url = "https://github.com/login/oauth/access_token"
        
        Alamofire.request(url, method: .post, parameters: params, encoding: URLEncoding.default, headers: header).responseJSON() { [weak self] in
            if let responseValue = $0.result.value {
                let json = JSON(responseValue)
                let token = json["access_token"].stringValue
                GitHubManager.shared.appManager.personalToken = token
                self?.dismiss(animated: true, completion: nil)
                completion?(token)
            }
        }

    }

}

extension GitHubAuthenicationViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url, url.scheme == "github-lite" {
            if let code = url["code"] {
                getUserToken(from: code)
            }
        }
        decisionHandler(.allow)
    }
}




