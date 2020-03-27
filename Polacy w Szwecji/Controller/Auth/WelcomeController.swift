//
//  WelcomeController.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-01.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import ProgressHUD
import Firebase

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
        print("handleFB")
        let fbLoginManager = LoginManager()
        fbLoginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            if let error = error {
                ProgressHUD.showError(error.localizedDescription)
                return
            }
            
            guard let accessToken = AccessToken.current else {
                //TODO: investigate why AccessToken.current == nil
                ProgressHUD.showError("Failed to get token")
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            Auth.auth().signIn(with: credential) { (result, error) in
                if let error = error {
                    ProgressHUD.showError(error.localizedDescription)
                    return
                }
                
                
                if let authData = result {
                    print(authData)
                    print(authData.user.email)
                    let dict: Dictionary<String, Any> = [
                        UID: authData.user.uid,
                        EMAIL: authData.user.email!,
                        USERNAME: authData.user.displayName,
                        PROFILE_IMAGE_URL: authData.user.photoURL?.absoluteString,
                        STATUS: "Welcome to ”Poles in Sweden”"
                    ]
                    Ref().databaseSpecificUser(uid: authData.user.uid).updateChildValues(dict, withCompletionBlock: { (error, ref) in
                        if error == nil {
                            // TODO: set the user is online
                            (UIApplication.shared.delegate as! AppDelegate).configureInitialVC()
                        } else {
                            ProgressHUD.showError(error!.localizedDescription)
                        }
                    })
                    
                }
            }
             
            
        }
    }
    
    private func handleGoogle() {
        dismiss(animated: true)
    }
    
    private func handleCreateAccount() {
        let signUpController = SignUpController()
        navigationController?.customPush(vc: signUpController)
    }
}

