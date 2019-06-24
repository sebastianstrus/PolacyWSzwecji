//
//  AccountController.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-03.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit
import ProgressHUD

protocol ProfileImageDelegate {
    func updateImage(image: UIImage)
}

class AccountTVC: UITableViewController, OpenPickerDelegate, UITextFieldDelegate {
    
    var profileImageDelegate:ProfileImageDelegate!
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        switch textField.tag {
        case TAG_USERNAME_TF:
            if let text = textField.text as NSString? {
                let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
                user?.username = txtAfterUpdate
            }
        case TAG_EMAIL_TF:
            if let text = textField.text as NSString? {
                let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
                user?.email = txtAfterUpdate
            }
        case TAG_STATUS_TF:
            if let text = textField.text as NSString? {
                let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
                user?.status = txtAfterUpdate
            }
        default:
            print("Unexpected case. Incorrect tag.")
        }
        return true
    }
    
    // MARK: - OpenPickerDelegate methods
    func openPicker() {
        view.endEditing(true)
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    var sideMenuDelegate:SideMenuDelegate?
    var user: User?
    private var image: UIImage? = nil {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        handleKeyboard()
        //hideKeyboardWhenTappedAround()
        setupNavigationBar()
        setupTableView()
        observeData()
    }
    
    func observeData() {
        Api.User.getUserInforSingleEvent(uid: Api.User.currentUserId) { (user) in
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
            let cell = tableView.dequeueReusableCell(withIdentifier: IDENTIFIER_CELL_ACCOUNT_IMAGE, for: indexPath) as! AccountImageCell
            cell.openPickerDelegate = self
            if let aUser = user {
                if let aImage = self.image {
                    cell.profileIV.image = aImage
                } else {
                    cell.profileIV.loadImage(aUser.profileImageUrl)
                }
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: IDENTIFIER_CELL_ACCOUNT_TF, for: indexPath) as! AccountTextFieldCell
            //cell.selectionStyle = .none
            cell.textField.delegate = self
            switch indexPath.row {
            case 0:
                if let aUser = user {
                    cell.textField.tag = TAG_USERNAME_TF
                    cell.textField.text = aUser.username
                }
            case 1:
                if let aUser = user {
                    cell.textField.tag = TAG_EMAIL_TF
                    cell.textField.text = aUser.email
                }
            case 2:
                if let aUser = user {
                    cell.textField.tag = TAG_STATUS_TF
                    cell.textField.text = aUser.status
                }
            default:
                cell.textField.text = ""
            }
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: IDENTIFIER_CELL_ACCOUNT_DEFAULT, for: indexPath)
            cell.selectionStyle = .none
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
            let cell = tableView.dequeueReusableCell(withIdentifier: IDENTIFIER_CELL_ACCOUNT_DEFAULT, for: indexPath)
            cell.selectionStyle = .none
            cell.textLabel?.text = "Log out"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = cell.tintColor
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: IDENTIFIER_CELL_ACCOUNT_DEFAULT, for: indexPath)
            cell.selectionStyle = .none
            cell.textLabel?.text = "Remove account"
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.textColor = UIColor.red
            return cell
            
        default:
            print("Default cell")
            return UITableViewCell()
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
        ProgressHUD.show("Loading...")
        var dict = Dictionary<String, Any>()
        if let username = user?.username, !username.isEmpty {
            dict["username"] = username
        }
        if let email = user?.email, !email.isEmpty {
            dict["email"] = email
        }
        if let status = user?.status, !status.isEmpty {
            dict["status"] = status
        }
        print("saveUserProfile")
        Api.User.saveUserProfile(dict: dict,
                                 onSuccess: {
                                    print("onSuccess, show HUD")
                                    if let img = self.image {
                                        StorageService.safePhotoProfile(image: img,
                                                                        uid: Api.User.currentUserId,
                                                                        onSuccess: {
                                                                            self.profileImageDelegate?.updateImage(image: self.image!)
                                                                            ProgressHUD.showSuccess()
                                        }) { (errorMessage) in
                                            ProgressHUD.showError(errorMessage)
                                        }
                                    } else {
                                        self.profileImageDelegate?.updateImage(image: self.image!)
                                        ProgressHUD.showSuccess()
                                    }
        },
                                 onError: { (errorMessage) in
                                    ProgressHUD.showError(errorMessage)
        })
    }
    
    @objc private func requestToggleMenu() {
        sideMenuDelegate?.shouldToggleMenu()
    }

    func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: IDENTIFIER_CELL_ACCOUNT_DEFAULT)
        tableView.register(AccountImageCell.self, forCellReuseIdentifier: "AccountImageTableViewCell")
        tableView.register(AccountTextFieldCell.self, forCellReuseIdentifier: IDENTIFIER_CELL_ACCOUNT_TF)
        //tableView.allowsSelection = false
    }
}


extension AccountTVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = selectedImage
        }
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = originalImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 2:
            switch indexPath.row {
            case 0:
                print("PP")
            case 1:
                print("T&C")
            default:
                print("Remove account?")
            }
        case 3:
            Api.User.logOut()
        case 4:
            removeAccountPressed()
        default:
            print("No action required")
        }
    }
    
    func removeAccountPressed() {
        let alert = UIAlertController(title: "Remove account ”Polacy w Szwecji”", message: "Are you sure you want to remove your account? All your data will be lost permanently.", preferredStyle: .actionSheet)
        let removeAccountAction = UIAlertAction(title: "Remove permanently", style: .destructive) { (_) in
            print("Remove account")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(removeAccountAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    
    
    func handleKeyboard() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    override func dismissKeyboard() {
        view.endEditing(true)
    }
}
