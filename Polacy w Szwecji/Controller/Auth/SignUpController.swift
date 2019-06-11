//
//  SignUpController.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-09.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit
import AVKit

class SignUpController: BaseAuthViewController {
    
    fileprivate var signUpView: SignUpView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        handleKeyboard()
    }
    
    private func setupView() {
        signUpView = SignUpView()
        view.addSubview(signUpView)
        signUpView.pinToEdges(view: view)
        signUpView.cancelAction = handleCancel
        signUpView.signInAction = handleSignIn
        signUpView.signUpAction = handleSubmit
    }
    
    private func handleCancel() {
        navigationController?.customPop()
    }
    
    private func handleSignIn() {
        let signInController = SignInController()
        navigationController?.customPush(vc: signInController)
    }
    
    private func handleSubmit() {
        let containerController = ContainerController()
        let navController = UINavigationController(rootViewController: containerController)
        present(navController, animated: false)
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
        signUpView.handleKeyboardUp()
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        signUpView.handleKeyboardDown()
    }
    
}
