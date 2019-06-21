//
//  ResetPasswordController.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-09.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit
import ProgressHUD

class ResetPasswordController: BaseAuthController {


    private var yCenterAnchor: NSLayoutConstraint!
    private var yUpAnchor: NSLayoutConstraint!
    
    fileprivate var resetPasswordView: ResetPasswordView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        handleKeyboard()
    }
    

    
    private func setupView() {
        resetPasswordView = ResetPasswordView()
        view.addSubview(resetPasswordView)
        resetPasswordView.pinToEdges(view: view)
        resetPasswordView.cancelAction = handleCancel
        resetPasswordView.resetAction = handleResetPasword
    }
    
    func handleCancel() {
        navigationController?.customPopToRoot()
    }
    func handleResetPasword() {
        self.view.endEditing(true)
        guard let email = resetPasswordView.emailTF.text, email != "" else {
            ProgressHUD.showError(ERROR_EMPTY_EMAIL_RESET)
            return
        }
        Api.User.resetPassword(email: email,
                               onSuccess: {
                                ProgressHUD.showSuccess(SUCCESS_EMAIL_RESET)
                                self.navigationController?.customPop()
        }) { (errorMessage) in
            ProgressHUD.showError(errorMessage)
        }
    }
    
    // MARK: - Private functions
    private func handleKeyboard() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc fileprivate func keyboardWillShow(_ notification: Notification) {
        resetPasswordView.handleKeyboardUp()
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        resetPasswordView.handleKeyboardDown()
    }

}
