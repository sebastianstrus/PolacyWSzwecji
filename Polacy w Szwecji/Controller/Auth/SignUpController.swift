//
//  SignUpController.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-09.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

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
        signUpView.pickerAction = handlePicker
        signUpView.signInAction = handleSignIn
        signUpView.signUpAction = handleSubmit
    }
    
    private func handleCancel() {
        navigationController?.customPop()
    }
    
    private func handlePicker() {
        print("handlePicker")
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    private func handleSignIn() {
        let signInController = SignInController()
        navigationController?.customPush(vc: signInController)
    }
    
    private func handleSubmit() {
        Auth.auth().createUser(withEmail: "test3@gmail.com", password: "123456") { (authDataResult, error) in
            if error != nil {
                print(error?.localizedDescription)
                return
            }
            if let authData = authDataResult {
                print(authData.user.email)
                let dict: Dictionary<String, Any> = [
                    "uid": authData.user.uid,
                    "email": authData.user.email,
                    "profileImageUrl": "",
                    "status": "Welcome to ”Polacy w Szwecji”"
                ]
                
                Database.database().reference().child("users").child(authData.user.uid).updateChildValues(dict, withCompletionBlock: {
                    (error, ref) in
                    if error == nil {
                        print("Done")
                    }
                })
            }
            
        }
        
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


extension SignUpController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            signUpView.setAwatar(image: selectedImage)
        }
        
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            signUpView.setAwatar(image: originalImage)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
}
