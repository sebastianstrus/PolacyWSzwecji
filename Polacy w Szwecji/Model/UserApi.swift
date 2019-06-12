//
//  UserApi.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-12.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase
import ProgressHUD
//import FirebaseStorage

class UserApi {
    func signUp(withUsername username: String, email: String, password: String, image: UIImage?, onSuccess: @escaping()-> Void, onError: @escaping(_ errorMessage: String) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { (authDataResult, error) in
            if error != nil {
                ProgressHUD.showError(error!.localizedDescription)
                return
            }
            if let authData = authDataResult {
                let dict: Dictionary<String, Any> = [
                    UID: authData.user.uid,
                    EMAIL: authData.user.email!,
                    USERNAME: username,
                    PROFILE_IMAGE_URL: "",
                    STATUS: "Welcome to ”Polacy w Szwecji”"
                ]
                
                guard let imageSelected = image else {
                    ProgressHUD.showError(ERROR_EMPTY_PHOTO)
                    return
                }
                
                guard let imageData = imageSelected.jpegData(compressionQuality: 0.4) else {
                    return
                }
                
                // TODO: move storage ref url somewhere to constatnts
                let storageRef = Storage.storage().reference(forURL: "gs://polacywszwecji-aee3f.appspot.com")
                let storageProfileRef = storageRef.child("profile").child(authData.user.uid)
                
                let storageProfile = Ref().storageSpecificProfile(uid: authData.user.uid)
                
                let metaData = StorageMetadata()
                metaData.contentType = "image/jpg"
                
                StorageService.savePhoto(username: username,
                                         uid: authData.user.uid,
                                         data: imageData,
                                         metadata: metaData,
                                         storageProfileRef: storageProfileRef,
                                         dict: dict,
                                         onSuccess: {
                                            onSuccess()
                },
                                         onError: { (errorMessage) in
                                            onError(errorMessage)
                })
            }
        }
    }
}