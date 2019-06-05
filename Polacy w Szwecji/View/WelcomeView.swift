//
//  WelcomeView.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-01.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class WelcomeView: UIView {
    
    var cancelAction: (() -> Void)?
    var submitAction: (() -> Void)?
    
    var yCenterAnchor: NSLayoutConstraint!
    var yUpAnchor: NSLayoutConstraint!
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public actions
    var loginAction: (() -> Void)?
    var signUpAction: (() -> Void)?
    
    // MARK: - All subviews
    let backgroundIV: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "sweden"))
        return iv
    }()
    
    let topContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    let bottomContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    let firstLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: "POLACY", attributes: [NSAttributedString.Key.font: AppFonts.TITLE_FONT!, .foregroundColor: UIColor.white]))
        label.attributedText = attributedString
        label.textAlignment = NSTextAlignment.center
        label.shadowColor = .black
        label.shadowOffset = CGSize(width: 2.0, height: 2.0)
        return label
    }()
    
    let secondLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: "W SZWECJI", attributes: [NSAttributedString.Key.font: AppFonts.TITLE_FONT!, .foregroundColor: UIColor.white]))
        label.attributedText = attributedString
        label.textAlignment = NSTextAlignment.center
        label.shadowColor = .black
        label.shadowOffset = CGSize(width: 2.0, height: 2.0)
        return label
    }()
    
    let loginButton: UIButton = {
        let button = UIButton()
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: "Logowanie", attributes: [NSAttributedString.Key.font: AppFonts.BTN_FONT!, .foregroundColor: UIColor.red]))
        button.setAttributedTitle(attributedString, for: .normal)
        button.layer.cornerRadius = Device.IS_IPHONE ? 18 : 36
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.red.cgColor
        button.backgroundColor = .white
        button.setAnchor(width: 0, height: Device.IS_IPHONE ? 36 : 72)
        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        return button
    }()
    
    let signupButton: UIButton = {
        let button = UIButton()
        
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: "Rejestracja", attributes: [NSAttributedString.Key.font: AppFonts.BTN_FONT!, .foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedString, for: .normal)
        button.layer.cornerRadius = Device.IS_IPHONE ? 18 : 36
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = .red
        button.setAnchor(width: 0, height: Device.IS_IPHONE ? 36 : 72)
        button.addTarget(self, action: #selector(handleSignup), for: .touchUpInside)
        return button
    }()
    
    func setup() {
        addSubview(topContainer)

        // create container for topImageView
        topContainer.translatesAutoresizingMaskIntoConstraints = false
        topContainer.topAnchor.constraint(equalTo: topAnchor).isActive = true
        //        topImageContainerView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        //        topImageContainerView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topContainer.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true//better than leftAn
        topContainer.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true// better than rightAn
        topContainer.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        
    
        
        addSubview(bottomContainer)
        bottomContainer.setAnchor(top: topContainer.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        let titlesStackView = createStackView(views: [firstLabel, secondLabel])
        topContainer.addSubview(titlesStackView)
        titlesStackView.setAnchor(width: frame.width,
                                  height: Device.IS_IPHONE ? 160 : 320)
        titlesStackView.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor).isActive = true
        titlesStackView.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor).isActive = true
        
        let buttonsStackView = createStackView(views: [loginButton, signupButton])
        bottomContainer.addSubview(buttonsStackView)
        buttonsStackView.setAnchor(width: Device.IS_IPHONE ?  150 : 300,
                                   height: Device.IS_IPHONE ?  82 : 164)
        buttonsStackView.centerXAnchor.constraint(equalTo: bottomContainer.centerXAnchor).isActive = true
        buttonsStackView.centerYAnchor.constraint(equalTo: bottomContainer.centerYAnchor).isActive = true
    }
    
    @objc func handleLogin() {
        print("login")
    }
    
    @objc func handleSignup() {
        print("register")
        submitAction?()
    }
}
