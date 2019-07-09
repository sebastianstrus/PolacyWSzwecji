//
//  InboxTVC.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-14.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//


import UIKit



class InboxTVC: UITableViewController {
    

    var sideMenuDelegate:SideMenuDelegate?
    
    var inboxArray = [Inbox]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        setupTableView()
        observeInbox()
        
    }
    


 
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return inboxArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: IDENTIFIER_CELL_INBOX_USERS, for: indexPath) as! UserInboxCell
        let inbox = inboxArray[indexPath.row]
        cell.configureCell(uid: Api.User.currentUserId, inbox: inbox)
        return cell
    }
    

    
    // MARK: - UITableViewDelegate methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? UserInboxCell {
            let chatVC = ChatController()
            chatVC.imagePartner = cell.profileImageView.image
            chatVC.partnerUsername = cell.usernameLabel.text
            chatVC.partnerId = cell.user.uid
            navigationController?.pushViewController(chatVC, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }
    
    
    
    // MARK: - Private methods
    @objc private func requestToggleMenu() {
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
        Api.Inbox.lastMessages(uid: Api.User.currentUserId) { (inbox) in
            if !self.inboxArray.contains(where: {$0.user.uid == inbox.user.uid}) {
                self.inboxArray.append(inbox)
                self.sortedInbox()
            }
        }
    }
    

    func sortedInbox() {
        inboxArray = inboxArray.sorted(by: { $0.date > $1.date })
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    private func setupTableView(){
        tableView.tableFooterView = UIView()
        tableView.register(UserInboxCell.self, forCellReuseIdentifier: IDENTIFIER_CELL_INBOX_USERS)
        
    }
}
