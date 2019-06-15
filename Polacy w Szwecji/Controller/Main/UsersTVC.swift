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

class UsersTVC: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate {
    
    var users: [User] = []
    var searchController: UISearchController = UISearchController(searchResultsController: nil)
    var sideMenuDelegate:SideMenuDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBarController()
        setupNavigationBar()
        observeUsers()
        setupTableView()
    }
    
    func setupSearchBarController() {
        let searchBar = searchController.searchBar
        searchBar.placeholder = "Search users..."
        searchBar.tintColor = UIColor.white
        searchBar.barTintColor = UIColor.white
        
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
    
    func setupNavigationBar() {
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

    func observeUsers() {
        Api.User.observeUsers { (user) in
            self.users.append(user)
            self.tableView.reloadData()
        }
    }
    
    func setupTableView(){
        tableView.register(UserCell.self, forCellReuseIdentifier: IDENTIFIER_CELL_USERS)
        
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }
    
     override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IDENTIFIER_CELL_USERS, for: indexPath) as! UserCell
        
        cell.loadData(users[indexPath.row])
        return cell
     }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
    
    @objc private func requestToggleMenu() {
        sideMenuDelegate?.shouldToggleMenu()
    }
}
