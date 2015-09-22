//
//  SearchViewController.swift
//  GithubSearch
//
//  Created by Hiroki Nagasawa on 9/22/15.
//  Copyright © 2015 Hiroki Nagasawa. All rights reserved.
//

import UIKit

class SearchViewController: UITableViewController, ApplicationContextSettable {
    
    var appContext: ApplicationContext!
    
    lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.delegate = self
        controller.searchBar.delegate = self
        return controller
    }()
    
    var searchManager: SearchRepositoriesManager?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableHeaderView = searchController.searchBar
        tableView.registerNib(UINib(nibName: "RepositoryCell", bundle: nil), forCellReuseIdentifier: "RepositoryCell")
    }

    // MARK: Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchManager?.results.count ?? 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("RepositoryCell") as! RepositoryCell
        
        let repository = searchManager?.results[indexPath.row]
        cell.titleLabel?.text = repository?.fullName
        cell.detailLabel?.text = repository?.description
        
        return cell
    }
    
    // MARK: Table view delegate
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let repositoryViewController = storyboard?.instantiateViewControllerWithIdentifier("RepositoryViewController") as! RepositoryViewController
        repositoryViewController.appContext = appContext
        if let repository = searchManager?.results[indexPath.row] {
            repositoryViewController.repository = repository
        }
        self.navigationController?.pushViewController(repositoryViewController, animated: true)
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return RepositoryCell.heightForCell()
    }
    
    override func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        if let manager = searchManager where indexPath.row >= manager.results.count - 1 {
            manager.search(false) { [weak self] (error) in
                if let error = error {
                    print(error)
                } else {
                    self?.tableView.reloadData()
                }
            }
        }
    }
}

extension SearchViewController: UISearchControllerDelegate {
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        guard let searchManager = SearchRepositoriesManager(github: appContext.github, query: searchText) else { return }
        self.searchManager = searchManager
        searchManager.search(true) { [weak self] (error) in
            if let error = error {
                print(error)
            } else {
                self?.tableView.reloadData()
                self?.searchController.active = false
            }
        }
    }
}
