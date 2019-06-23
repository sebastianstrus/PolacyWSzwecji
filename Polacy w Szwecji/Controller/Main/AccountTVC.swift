//
//  AccountController.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-03.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class AccountTVC: UITableViewController {

    var sideMenuDelegate:SideMenuDelegate?
    var user: User?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupTableView()
        observeData()
        
    }
    
    func observeData() {
        Api.User.getUserInfor(uid: Api.User.currentUserId) { (user) in
            self.user = user
            self.tableView.reloadData()
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 3
        case 2:
            return 2
        case 3:
            return 1
        case 4:
            return 1
        default:
            return 1
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 84 : 44
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("cellForRowAt")
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountImageTableViewCell", for: indexPath) as! AccountImageCell
            if let aUser = user {
                cell.profileIV.loadImage(aUser.profileImageUrl)
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTextFieldTableViewCell", for: indexPath) as! AccountTextFieldCell
            switch indexPath.row {
            case 0:
                if let aUser = user {
                    cell.textField.text = aUser.username
                }
            case 1:
                if let aUser = user {
                    cell.textField.text = aUser.email
                }
            case 2:
                if let aUser = user {
                    cell.textField.text = aUser.status
                }
            default:
                cell.textField.text = ""
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell", for: indexPath)
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Privacy policy"
                cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                return cell
            case 1:
                cell.textLabel?.text = "Terms of service"
                cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
                return cell
            default:
                return cell
            }
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell", for: indexPath)
            cell.textLabel?.text = "Log out"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = cell.tintColor
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell", for: indexPath)
            cell.textLabel?.text = "Remove account"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = UIColor.red
            return cell
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell", for: indexPath)
            cell.textLabel?.text = "Cell \(indexPath.section) : \(indexPath.row)"
            return cell
        }
        

        
    }

    private func setupNavigationBar() {
        navigationItem.title = "Account"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.lightRed
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let menuBtn = UIBarButtonItem(image: UIImage(named: "menu_icon")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(requestToggleMenu))
        menuBtn.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = menuBtn
        
        let saveBtn = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(handleSave))
        saveBtn.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = saveBtn
    }
    
    @objc private func handleSave() {
        print("handleSave")
    }
    
    @objc private func requestToggleMenu() {
        sideMenuDelegate?.shouldToggleMenu()
    }

    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AccountTableViewCell")
        tableView.register(AccountImageCell.self, forCellReuseIdentifier: "AccountImageTableViewCell")
        tableView.register(AccountTextFieldCell.self, forCellReuseIdentifier: "AccountTextFieldTableViewCell")
        
        //tableView.separatorColor = UIColor.clear
    }
    


}
