//
//  WelcomeController.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-01.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class WelcomeController: BaseAuthController {

    fileprivate var welcomeView: WelcomeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    private func setupView() {
        welcomeView = WelcomeView()
        view.addSubview(welcomeView)
        welcomeView.pinToEdges(view: view)
        welcomeView.fbAction = handleFB
        welcomeView.googleAction = handleGoogle
        welcomeView.creteAccountAction = handleCreateAccount
    }
    
    private func handleFB() {
        dismiss(animated: false)
    }
    
    private func handleGoogle() {
        dismiss(animated: true)
    }
    
    private func handleCreateAccount() {
        let signUpController = SignUpController()
        navigationController?.customPush(vc: signUpController)
    }
}

