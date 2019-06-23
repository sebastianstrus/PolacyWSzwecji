//
//  AccountController.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-03.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class AccountController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var sideMenuDelegate:SideMenuDelegate?
    var accountView: AccountView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupView()
        setupTableView()
    }
    
    // MARK: - UITableViewDataSource methods
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 2
        case 2:
            return 1
        case 3:
            return 1
        default:
            return 1
        }
    }
    
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return indexPath.section == 0 ? 100 : 50
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //var cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell", for: indexPath)
        
        //cell.textLabel?.text = "Cell \(indexPath.section) : \(indexPath.row)"
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountTableViewCell", for: indexPath)
        
        print("indexPath.section: \(indexPath.section)")
        
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Sebastian Strus"
                return cell
            case 1:
                cell.textLabel?.text = "sebstian@gmail.com"
                return cell
            case 2:
                cell.textLabel?.text = "You can talk to me!"
                return cell
                
            default:
                return UITableViewCell()
            }
        case 1:
            switch indexPath.row {
            case 0:
                cell.textLabel?.text = "Privacy Policy"
                return cell
            case 1:
                cell.textLabel?.text = "Terms Of Service"
                return cell
            default:
                return cell
            }
        case 2:
            cell.textLabel?.text = "Log out"
            return cell
        case 3:
            cell.textLabel?.text = "Delete account"
            return cell
        default:
            return cell
        }
        
        
        //cell.textLabel?.text = "Cell \(indexPath.section) : \(indexPath.row)"
        
//        if indexPath.section == 2 {
//            if indexPath.row == 0 {
//                cell.textLabel?.text = "jeden"
//            } else {
//                cell.textLabel?.text = "dwa"
//            }
//        }
        
        
        //return cell
    }

    private func setupNavigationBar() {
        navigationItem.title = "Account"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.lightRed
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let menuBtn = UIBarButtonItem(image: UIImage(named: "menu_icon")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(requestToggleMenu))
        menuBtn.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = menuBtn
    }
    
    @objc private func requestToggleMenu() {
        sideMenuDelegate?.shouldToggleMenu()
    }

    func setupView() {
        accountView = AccountView()
        self.view.addSubview(accountView)
        
        accountView.pinToSafeEdges(view: view)
    }
    
    func setupTableView() {
        accountView.accountTV.delegate = self
        accountView.accountTV.dataSource = self
        accountView.accountTV.register(UITableViewCell.self, forCellReuseIdentifier: "AccountTableViewCell")
    }
    


}
