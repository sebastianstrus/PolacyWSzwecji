//
//  SignUpView.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-09.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class SignUpView: UIView {
    
    var cancelAction: (() -> Void)?
    var pickerAction: (() -> Void)?
    var signUpAction: (() -> Void)?
    var signInAction: (() -> Void)?
    
    private var yCenterAnchor: NSLayoutConstraint!
    private var yUpAnchor: NSLayoutConstraint!
    
    let xButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.white
        button.setImage(UIImage(named: "x_icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    let awatarImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "profile_icon"))
        iv.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        iv.contentMode = .scaleAspectFill
        iv.alpha = 0.85
        iv.clipsToBounds = true
        iv.setAnchor(width: Device.IS_IPHONE ?  80 : 160, height: Device.IS_IPHONE ? 80 : 160)
        iv.layer.cornerRadius = Device.IS_IPHONE ? 40 : 80
        iv.backgroundColor = UIColor.white
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    let nameTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Full name"
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.textColor = UIColor.darkGray
        tf.setAnchor(width: 0, height: Device.IS_IPHONE ? 40 : 80)
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.backgroundColor = UIColor.white.withAlphaComponent(0.85)
        return tf
    }()
    
    let emailTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email address"
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.keyboardType = .emailAddress
        tf.textColor = UIColor.darkGray
        tf.setAnchor(width: 0, height: Device.IS_IPHONE ? 40 : 80)
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.backgroundColor = UIColor.white.withAlphaComponent(0.88)
        return tf
    }()
    
    let passwordTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.textColor = UIColor.darkGray
        tf.isSecureTextEntry = true
        tf.setAnchor(width: 0, height: Device.IS_IPHONE ? 40 : 80)
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.backgroundColor = UIColor.white.withAlphaComponent(0.85)
        return tf
    }()
    
    let signUpBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Sign up", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Device.IS_IPHONE ? 18 : 36)
        button.layer.cornerRadius = Device.IS_IPHONE ? 6 : 12
        button.clipsToBounds = true
        button.setAnchor(width: 0, height: Device.IS_IPHONE ? 40 : 80)
        button.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    let signInBtn: UIButton = {
        let button = UIButton()
        button.setAnchor(width: 0, height: Device.IS_IPHONE ? 40 : 80)
        let attributedText = NSMutableAttributedString(string: "Already have an account? ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: Device.IS_IPHONE ?  16 : 32), NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.85)])
        let attributedSubText = NSMutableAttributedString(string: "Sign in", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: Device.IS_IPHONE ?  18 : 36), NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedText.append(attributedSubText)
        button.setAttributedTitle(attributedText, for: .normal)
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private methods
    private func setup() {
        addSubview(xButton)
        xButton.setAnchor(top: safeTopAnchor,
                          leading: leadingAnchor,
                          bottom: nil,
                          trailing: nil,
                          paddingTop: 8,
                          paddingLeft: 8,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: Device.IS_IPHONE ? 40 : 80,
                          height: Device.IS_IPHONE ? 40 : 80)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(presentPicker))
        awatarImageView.addGestureRecognizer(tapGesture)
        
        let containerView = UIView()
        addSubview(containerView)
        containerView.setAnchor(width: Device.IS_IPHONE ? 280 : 560, height: Device.IS_IPHONE ? 320 : 640)
        containerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        yCenterAnchor = containerView.centerYAnchor.constraint(equalTo: centerYAnchor)
        yUpAnchor = containerView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100)
        yCenterAnchor.isActive = true
        
        containerView.addSubview(awatarImageView)
        awatarImageView.setAnchor(top: containerView.topAnchor,
                            leading: nil,
                            bottom: nil,
                            trailing: nil,
                            paddingTop: 0,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: Device.IS_IPHONE ?  80 : 160,
                            height: Device.IS_IPHONE ? 80 : 160)
        awatarImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        containerView.addSubview(nameTF)
        nameTF.setAnchor(top: awatarImageView.bottomAnchor,
                         leading: nil,
                         bottom: nil,
                         trailing: nil,
                         paddingTop: 10,
                         paddingLeft: 0,
                         paddingBottom: 0,
                         paddingRight: 0,
                         width: Device.IS_IPHONE ?  280 : 560,
                         height: Device.IS_IPHONE ? 40 : 80)
        nameTF.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        containerView.addSubview(emailTF)
        emailTF.setAnchor(top: nameTF.bottomAnchor,
                          leading: nil,
                          bottom: nil,
                          trailing: nil,
                          paddingTop: 8,
                          paddingLeft: 0,
                          paddingBottom: 0,
                          paddingRight: 0,
                          width: Device.IS_IPHONE ?  280 : 560,
                          height: Device.IS_IPHONE ? 40 : 80)
        emailTF.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        containerView.addSubview(passwordTF)
        passwordTF.setAnchor(top: emailTF.bottomAnchor,
                             leading: nil,
                             bottom: nil,
                             trailing: nil,
                             paddingTop: 8,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: Device.IS_IPHONE ?  280 : 560,
                             height: Device.IS_IPHONE ? 40 : 80)
        passwordTF.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        containerView.addSubview(signUpBtn)
        signUpBtn.setAnchor(top: passwordTF.bottomAnchor,
                            leading: nil,
                            bottom: nil,
                            trailing: nil,
                            paddingTop: 8,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: Device.IS_IPHONE ?  280 : 560,
                            height: Device.IS_IPHONE ? 40 : 80)
        signUpBtn.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true

        containerView.addSubview(signInBtn)
        signInBtn.setAnchor(top: signUpBtn.bottomAnchor,
                            leading: nil,
                            bottom: nil,
                            trailing: nil,
                            paddingTop: 8,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: Device.IS_IPHONE ?  280 : 560,
                            height: Device.IS_IPHONE ? 40 : 80)
        signInBtn.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    @objc private func presentPicker() {
        pickerAction?()
    }
    
    @objc private func handleCancel() {
        cancelAction?()
    }
    
    @objc private func handleSignIn() {
        signInAction?()
    }
    
    @objc private func handleSignUp() {
        signUpAction?()
    }
    

    
    //public
    func handleKeyboardUp() {
        self.yCenterAnchor.isActive = false
        self.yUpAnchor.isActive = true
        UIView.animate(withDuration: 0.4) {
            self.layoutIfNeeded()
        }
    }
    
    func handleKeyboardDown() {
        self.yUpAnchor.isActive = false
        self.yCenterAnchor.isActive = true
        UIView.animate(withDuration: 0.4) {
            self.layoutIfNeeded()
        }
    }
    
    func setAwatar(image: UIImage) {
        awatarImageView.image = image
    }
}
