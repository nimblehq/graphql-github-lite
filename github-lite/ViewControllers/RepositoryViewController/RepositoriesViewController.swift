//
//  RepositoriesViewController.swift
//  github-lite
//
//  Created by Issarapong Poesua on 11/17/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit
import SVProgressHUD

class RepositoriesViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var repositories: [GetCurrentUserRepositoriesQuery.Data.Viewer.Repository.Edge] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentUserRepository()
    }
    
    func getCurrentUserRepository() {
        SVProgressHUD.show(withStatus: "Getting Repositories")
        ApolloManager.shared.apolloClient.fetch(query: GetCurrentUserRepositoriesQuery()) { [weak self] (result, error) in
            SVProgressHUD.dismiss()
            if let repositories = result?.data?.viewer.repositories.edges {
                self?.repositories = repositories as! [GetCurrentUserRepositoriesQuery.Data.Viewer.Repository.Edge]
                self?.tableView.reloadData()
            }
        }
    }
}

extension RepositoriesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = repositories[indexPath.item].node?.name
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return repositories.count
    }
    
}
