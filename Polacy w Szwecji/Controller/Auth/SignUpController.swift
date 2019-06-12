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
        
        guard let imageSelected = self.image else {
            print("Image is nil")
            return
        }
        
        guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else {
            return
        }
        
        Auth.auth().createUser(withEmail: "test008@gmail.com", password: "123456") { (authDataResult, error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            if let authData = authDataResult {
                print(authData.user.email)
                var dict: Dictionary<String, Any> = [
                    "uid": authData.user.uid,
                    "email": authData.user.email,
                    "profileImageUrl": "",
                    "status": "Welcome to ”Polacy w Szwecji”"
                ]
                
                // TODO: move storage ref url somewhere to constatnts
                let storageRef = Storage.storage().reference(forURL: "gs://polacywszwecji-aee3f.appspot.com")
                let storageProfileRef = storageRef.child("profile").child(authData.user.uid)
                
                let metaData = StorageMetadata()
                metaData.contentType = "image/jpg"
                storageProfileRef.putData(imageData, metadata: metaData, completion: { (storageMetaData, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                        return
                    }
                    storageProfileRef.downloadURL(completion: { (url, error) in
                        if let metaImageUrl = url?.absoluteString {
                            dict["profileImageUrl"] = metaImageUrl
                            
                            Database.database().reference().child("users").child(authData.user.uid).updateChildValues(dict, withCompletionBlock: { (error, ref) in
                                if error == nil {
                                    print("Done")
                                }
                            })
                        }
                    })
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
