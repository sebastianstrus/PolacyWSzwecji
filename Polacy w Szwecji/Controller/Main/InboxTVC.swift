//
//  InboxTVC.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-14.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//


import UIKit



class InboxTVC: UITableViewController/*, UISearchControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating*/ {
    

    var sideMenuDelegate:SideMenuDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setupSearchBarController()
        setupNavigationBar()
        observeInbox()
        setupTableView()
    }
    
    // MARK: - UISearchResultsUpdating methods
//    func updateSearchResults(for searchController: UISearchController) {
//        if  searchController.searchBar.text == nil || searchController.searchBar.text!.isEmpty {
//            view.endEditing(true)
//        } else {
//            let textLowercased = searchController.searchBar.text!.lowercased()
//            filterContent(for: textLowercased)
//        }
//        tableView.reloadData()
//    }
    

    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IDENTIFIER_CELL_INBOX_USERS, for: indexPath) as! UserInboxCell
        return cell
    }
    

    
    // MARK: - UITableViewDelegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: - Private methods
    @objc private func requestToggleMenu() {
        print("requestToggleMenu")
        sideMenuDelegate?.shouldToggleMenu()
    }
    

    private func setupNavigationBar() {
        navigationItem.title = "Inbox"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.lightRed
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let menuBtn = UIBarButtonItem(image: UIImage(named: "menu_icon")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(requestToggleMenu))
        menuBtn.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = menuBtn
    }

    
    
    private func observeInbox() {
        Api.Inbox.lastMessages(uid: Api.User.currentUserId)
    }
    
    private func setupTableView(){
        tableView.tableFooterView = UIView()
        tableView.register(UserInboxCell.self, forCellReuseIdentifier: IDENTIFIER_CELL_INBOX_USERS)
        
    }
}
