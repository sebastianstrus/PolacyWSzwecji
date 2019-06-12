//
//  RestorePasswordController.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-09.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class RestorePasswordController: BaseAuthViewController {


    private var yCenterAnchor: NSLayoutConstraint!
    private var yUpAnchor: NSLayoutConstraint!
    
    fileprivate var restorePasswordView: RestorePasswordView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        handleKeyboard()
    }
    

    
    private func setupView() {
        restorePasswordView = RestorePasswordView()
        view.addSubview(restorePasswordView)
        restorePasswordView.pinToEdges(view: view)
        restorePasswordView.cancelAction = handleCancel
    }
    
    func handleCancel() {
        navigationController?.customPopToRoot()
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
        restorePasswordView.handleKeyboardUp()
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        restorePasswordView.handleKeyboardDown()
    }

}
