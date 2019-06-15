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
        
        
        //setupTheNavigationBar()
        
        observeUsers()
    
        
        setupTableView()
    }
    
    func setupSearchBarController() {

        
        let searchBar = searchController.searchBar
        searchBar.placeholder = "Search users..."
        searchBar.tintColor = UIColor.white
        searchBar.barTintColor = UIColor.white
        
        
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            //textfield.textColor = UIColor.mainBlue
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
        //navigationController?.navigationBar.isHidden = false
        navigationItem.title = "People"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.lightRed
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    
        let menuBtn = UIBarButtonItem(image: UIImage(named: "menu_icon")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(requestToggleMenu))
        menuBtn.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = menuBtn
        
        
    }
    
    @objc func handleLogout() {
        print("handleLogout")
        
        Api.User.logOut()
        
        
        //        let welcomeController = WelcomeController()
        //        let nav = UINavigationController(rootViewController: welcomeController)
        //        nav.isNavigationBarHidden = true
        //        present(nav, animated: true)
    }
    func setupNavBar() {
//        navigationController?.navigationBar.isTranslucent = false
//        navigationController?.navigationBar.barTintColor = UIColor.lightRed
//        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
//
//        let menuBtn = UIBarButtonItem(image: UIImage(named: "menu_icon")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(toggleMenu))
//        menuBtn.tintColor = UIColor.white
//        navigationItem.leftBarButtonItem = menuBtn
//
//        let logoutBtn = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
//        logoutBtn.tintColor = UIColor.white
//        navigationItem.rightBarButtonItem = logoutBtn
    }
    
    
    
    fileprivate func setupTheNavigationBar() {
        
        navigationController?.isNavigationBarHidden = true
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        definesPresentationContext = true
        let searchBar = searchController.searchBar
        searchBar.tintColor = UIColor.white
        searchBar.barTintColor = UIColor.white
        if let textfield = searchBar.value(forKey: "searchField") as? UITextField {
            //textfield.textColor = UIColor.mainBlue
            if let backgroundview = textfield.subviews.first {
                backgroundview.backgroundColor = UIColor.white
                backgroundview.layer.cornerRadius = 10;
                backgroundview.clipsToBounds = true;
            }
        }
        
        if let navigationbar = self.navigationController?.navigationBar {
            navigationbar.barTintColor = UIColor.blueFB
        }
        navigationItem.searchController = searchController
        
        navigationItem.searchController?.searchBar.delegate = self
        
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationItem.title = "Trips"
        
        //setupButton()
        
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
//        cell.titleLabel.text = "Sebastian Strus"
//        cell.statusLabel.text = "We can talk"
//        cell.userImageView.image = UIImage(named: "profile0")
     
        // Configure the cell...
     
        return cell
     }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
    
    @objc private func requestToggleMenu() {
        sideMenuDelegate?.shouldToggleMenu()
    }

//    func setupNavBar() {
//        navigationController?.navigationBar.isTranslucent = false
//        navigationController?.navigationBar.barTintColor = UIColor.lightRed
//        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
//        let menuBtn = UIBarButtonItem(image: UIImage(named: "menu_icon")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(toggleMenu))
//        menuBtn.tintColor = UIColor.white
//        navigationItem.leftBarButtonItem = menuBtn
//    }
//    @objc func toggleMenu() {
//        parent.menuShowing ? parent.hideMenu() : parent.showMenu()
//        parent.menuShowing = !parentmenuShowing
//    }
  
    
}
