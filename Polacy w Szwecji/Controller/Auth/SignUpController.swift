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
import FirebaseStorage
import ProgressHUD

class SignUpController: BaseAuthViewController {
    
    fileprivate var signUpView: SignUpView!
    private var image: UIImage? = nil

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
        signUpView.signInAction = openSignIn
        signUpView.signUpAction = handleSignUp
    }
    
    private func handleCancel() {
        navigationController?.customPop()
    }
    
    private func handlePicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        self.present(picker, animated: true, completion: nil)
    }
    
    private func openSignIn() {
        self.view.endEditing(true)
        let signInController = SignInController()
        navigationController?.customPush(vc: signInController)
    }
    
    private func handleSignUp() {
        self.view.endEditing(true)
        validateTextFields()
        signUp(onSuccess: {
            print("SWITCH VIEW!!!")
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
        signUpView.handleKeyboardUp()
    }
    
    @objc fileprivate func keyboardWillHide(notification: NSNotification) {
        signUpView.handleKeyboardDown()
    }
    
    func validateTextFields() {
        guard let username = signUpView.nameTF.text, !username.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_USERNAME)
            return
        }
        guard let email = signUpView.emailTF.text, !email.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_EMAIL)
            return
        }
        guard let password = signUpView.passwordTF.text, !password.isEmpty else {
            ProgressHUD.showError(ERROR_EMPTY_PASSWORD)
            return
        }
    }

    
    func signUp(onSuccess: @escaping()-> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        ProgressHUD.show()
        Api.User.signUp(withUsername: signUpView.nameTF.text!,
                        email: signUpView.emailTF.text!,
                        password: signUpView.passwordTF.text!,
                        image: self.image,
                        onSuccess: {
                            ProgressHUD.dismiss()
                            onSuccess()
        }) { (errorMessage) in
            onError(errorMessage)
        }
    }
}

extension SignUpController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            image = selectedImage
            signUpView.setAwatar(image: selectedImage)
        }
        
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = originalImage
            signUpView.setAwatar(image: originalImage)
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
