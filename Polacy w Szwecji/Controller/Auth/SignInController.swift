//
//  SignInController.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-09.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit
import ProgressHUD

class SignInController: BaseAuthViewController {


    fileprivate var signInView: SignInView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        handleKeyboard()
    }
    
    
    private func setupView() {
        signInView = SignInView()
        view.addSubview(signInView)
        signInView.pinToEdges(view: view)
        signInView.signInAction = handleSignIn
        signInView.dismissAction = cancelToSignUp
        signInView.forgotPasswordAction = handleForgotPassword
    }

    private func handleSignIn() {
        self.view.endEditing(true)
        validateTextFields()
        signIn(onSuccess: {
            print("SWITCH VIEW!!!")
        }) { (errorMessage) in
            ProgressHUD.showError(errorMessage)
        }
    }
    private  func cancelToSignUp() {
        print("handleSignUp")
        navigationController?.customPop()
    }
    
    private func handleForgotPassword() {
        let restorePasswordController = ResetPasswordController()
        navigationController?.customPush(vc: restorePasswordController)
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
        signInView.handleKeyboardUp()
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        signInView.handleKeyboardDown()
    }
    
    private func signIn(onSuccess: @escaping()-> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        ProgressHUD.show()
        Api.User.signIn(email: signInView.emailTF.text!,
                        password: signInView.passwordTF.text!,
                        onSuccess: {
                            ProgressHUD.dismiss()
                            onSuccess()
        }) { (errorMessage) in
            onError(errorMessage)
        }
    }
    
    func validateTextFields() {

        guard let email = signInView.emailTF.text, !email.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_EMAIL)
            return
        }
        guard let password = signInView.passwordTF.text, !password.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_PASSWORD)
            return
        }
    }

}
