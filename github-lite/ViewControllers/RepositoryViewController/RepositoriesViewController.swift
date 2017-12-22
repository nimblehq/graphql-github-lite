//
//  RepositoriesViewController.swift
//  github-lite
//
//  Created by Issarapong Poesua on 11/17/2560 BE.
//  Copyright © 2560 Issarapong Poesua. All rights reserved.
//

import UIKit

class RepositoriesViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView!
    
    var repositories: [GetCurrentUserRepositoriesQuery.Data.Viewer.Repository.Edge] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentUserRepository()
    }
    
    func getCurrentUserRepository() {
        ApolloManager.shared.apolloClient.fetch(query: GetCurrentUserRepositoriesQuery()) { [weak self] (result, error) in
            self?.tableView.reloadData()

            if let repositories = result?.data?.viewer.repositories.edges {
                self?.repositories = repositories as! [GetCurrentUserRepositoriesQuery.Data.Viewer.Repository.Edge]
                self?.tableView.reloadData()
            }
        }
    }
}

extension RepositoriesViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return repositories.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
}
