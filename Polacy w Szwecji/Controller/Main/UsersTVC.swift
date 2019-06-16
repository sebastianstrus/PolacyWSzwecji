//
//  UsersTVC.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-14.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

protocol SideMenuDelegate {
    func shouldToggleMenu()
}

class UsersTVC: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    
    var users: [User] = []
    var searchController: UISearchController = UISearchController(searchResultsController: nil)
    var searchResults: [User] = []
    var sideMenuDelegate:SideMenuDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBarController()
        setupNavigationBar()
        observeUsers()
        setupTableView()
    }
    
    // MARK: - UISearchResultsUpdating methods
    func updateSearchResults(for searchController: UISearchController) {
        if  searchController.searchBar.text == nil || searchController.searchBar.text!.isEmpty {
            view.endEditing(true)
        } else {
            let textLowercased = searchController.searchBar.text!.lowercased()
            filterContent(for: textLowercased)
        }
        tableView.reloadData()
    }
    
    func filterContent(for searchText: String) {
        searchResults = self.users.filter {
            return $0.username.lowercased().range(of: searchText) != nil
        }
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (searchController.isActive ? searchResults : users).count
        
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IDENTIFIER_CELL_USERS, for: indexPath) as! UserCell
        cell.loadData((searchController.isActive ? searchResults : users)[indexPath.row])
        return cell
     }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
    
    // MARK: - UITableViewDelegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? UserCell {
            let chatVC = ChatController()
            chatVC.imagePartner = cell.userImageView.image
            chatVC.partnerUsername = cell.usernameLabel.text
            navigationController?.pushViewController(chatVC, animated: true)
        }
    }
    
    // MARK: - Private methods
    @objc private func requestToggleMenu() {
        sideMenuDelegate?.shouldToggleMenu()
    }
    
    private func setupSearchBarController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        //searchController.dimsBackgroundDuringPresentation = false
        let searchBar = searchController.searchBar
        searchBar.placeholder = "Search users..."
        searchBar.tintColor = UIColor.white
        searchBar.barTintColor = UIColor.white
        definesPresentationContext = true// allows to present correct even cearched users
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            if let backgroundview = textfield.subviews.first {
                backgroundview.backgroundColor = UIColor.white
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "People"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.lightRed
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let menuBtn = UIBarButtonItem(image: UIImage(named: "menu_icon")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(requestToggleMenu))
        menuBtn.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = menuBtn
    }
    
    @objc private func handleLogout() {
        Api.User.logOut()
    }
    
    private func observeUsers() {
        Api.User.observeUsers { (user) in
            self.users.append(user)
            self.tableView.reloadData()
        }
    }
    
    private func setupTableView(){
        tableView.register(UserCell.self, forCellReuseIdentifier: IDENTIFIER_CELL_USERS)
        
    }
}
