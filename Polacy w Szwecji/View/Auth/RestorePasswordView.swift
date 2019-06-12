//
//  RestorePasswordView.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-09.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class RestorePasswordView: UIView {

    private var yCenterAnchor: NSLayoutConstraint!
    private var yUpAnchor: NSLayoutConstraint!
    
    var cancelAction: (() -> Void)?
    var resetAction: (() -> Void)?
    
    let xButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = UIColor.white
        button.setImage(UIImage(named: "x_icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(handleCancel), for: .touchUpInside)
        return button
    }()
    
    let emailTF: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email address"
        tf.keyboardType = .emailAddress
        tf.textColor = UIColor.darkGray
        tf.borderStyle = UITextField.BorderStyle.roundedRect
        tf.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        return tf
    }()
    
    let resetBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Reset password", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Device.IS_IPHONE ? 18 : 36)
        button.layer.cornerRadius = Device.IS_IPHONE ? 6 : 12
        button.clipsToBounds = true
        button.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        button.addTarget(self, action: #selector(handleReset), for: .touchUpInside)
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
        
        let containerView = UIView()
        addSubview(containerView)
        containerView.setAnchor(width: Device.IS_IPHONE ? 260 : 520, height: Device.IS_IPHONE ? 88 : 176)
        containerView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        yCenterAnchor = containerView.centerYAnchor.constraint(equalTo: centerYAnchor)
        yUpAnchor = containerView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -100)
        yCenterAnchor.isActive = true
        
        containerView.addSubview(emailTF)
        emailTF.setAnchor(top: containerView.topAnchor, leading: nil, bottom: nil, trailing: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: Device.IS_IPHONE ?  260 : 520, height: Device.IS_IPHONE ? 40 : 80)
        emailTF.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        containerView.addSubview(resetBtn)
        resetBtn.setAnchor(top: emailTF.bottomAnchor, leading: nil, bottom: nil, trailing: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: Device.IS_IPHONE ?  260 : 520, height: Device.IS_IPHONE ? 40 : 80)
        resetBtn.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    @objc private func handleCancel() {
        cancelAction?()
    }
    
    @objc private func handleReset() {
        resetAction?()
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
