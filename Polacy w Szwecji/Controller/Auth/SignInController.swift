//
//  SignInController.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-09.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

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
        signInView.dismissAction = handleSignUp
        signInView.forgotPasswordAction = handleForgotPassword
    }
    
    private func handleSignIn() {
        print("signInToFB")
    }
    
    private  func handleSignUp() {
        print("handleSignUp")
        navigationController?.customPop()
    }
    
    private func handleForgotPassword() {
        let restorePasswordController = RestorePasswordController()
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

}
