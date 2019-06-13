//
//  SignInView.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-09.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class SignInView: UIView {

    var signInAction: (() -> Void)?
    var dismissAction: (() -> Void)?
    var forgotPasswordAction: (() -> Void)?
    
    private var yCenterAnchor: NSLayoutConstraint!
    private var yUpAnchor: NSLayoutConstraint!
    

    /*let signInLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign in"
        label.textColor = UIColor.black
        label.font = UIFont.init(name: "Didot-Bold", size: 28)
        label.textAlignment = .center
        return label
    }()*/
    
    let emailTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email address"
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.keyboardType = .emailAddress
        tf.textColor = UIColor.darkGray
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        return tf
    }()
    
    let passwordTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.autocorrectionType = .no
        tf.autocapitalizationType = .none
        tf.textColor = UIColor.darkGray
        tf.isSecureTextEntry = true
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        return tf
    }()
    
    let signInBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Sign in", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Device.IS_IPHONE ? 18 : 36)
        button.layer.cornerRadius = Device.IS_IPHONE ? 6 : 12
        button.clipsToBounds = true
        button.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        button.addTarget(self, action: #selector(handleSignIn), for: .touchUpInside)
        return button
    }()
    
    let signUpBtn: UIButton = {
        let button = UIButton()
        let attributedText = NSMutableAttributedString(string: "Don't have an account? ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: Device.IS_IPHONE ?  16 : 32), NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0.85)])
        let attributedSubText = NSMutableAttributedString(string: "Sign up", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: Device.IS_IPHONE ?  18 : 36), NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedText.append(attributedSubText)
        button.setAttributedTitle(attributedText, for: .normal)
        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        return button
    }()
    
    let forgotBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot password?", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Device.IS_IPHONE ? 18 : 36)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(handleForgotPassword), for: .touchUpInside)
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
        
        let containerView = UIView()
        addSubview(containerView)
        containerView.setAnchor(width: Device.IS_IPHONE ? 280 : 560,
                                height: Device.IS_IPHONE ? 184 : 368)
        containerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        yCenterAnchor = containerView.centerYAnchor.constraint(equalTo: centerYAnchor)
        yUpAnchor = containerView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100)
        yCenterAnchor.isActive = true
        
        containerView.addSubview(emailTF)
        emailTF.setAnchor(top: containerView.topAnchor,
                          leading: nil,
                          bottom: nil,
                          trailing: nil,
                          paddingTop: 0,
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

        containerView.addSubview(signInBtn)
        signInBtn.setAnchor(top: passwordTF.bottomAnchor,
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

        containerView.addSubview(signUpBtn)
        signUpBtn.setAnchor(top: signInBtn.bottomAnchor,
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
        
        addSubview(forgotBtn)
        forgotBtn.setAnchor(top: nil,
                            leading: leadingAnchor,
                            bottom: safeBottomAnchor,
                            trailing: trailingAnchor,
                            paddingTop: 0,
                            paddingLeft: 0,
                            paddingBottom: 30,
                            paddingRight: 0,
                            width: 0,
                            height: 40)
    }
    
    
    
    @objc func handleSignIn() {
        signInAction?()
    }
    
    @objc func handleSignUp() {
        dismissAction?()
    }
    
    @objc func handleForgotPassword() {
        forgotPasswordAction?()
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
}
