//
//  WelcomeView.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-01.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class WelcomeView: UIView {
    
    var fbAction: (() -> Void)?
    var googleAction: (() -> Void)?
    var creteAccountAction: (() -> Void)?
    
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
    
    let titleLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: "POLACY\nW SZWECJI", attributes: [NSAttributedString.Key.font: AppFonts.TITLE_FONT!, .foregroundColor: UIColor.white]))
        label.attributedText = attributedString
        label.numberOfLines = 0
        label.textAlignment = NSTextAlignment.center
        label.shadowColor = .black
        let shadowOffset = Device.IS_IPHONE ? 1.5 : 3.0
        label.shadowOffset = CGSize(width: shadowOffset, height: shadowOffset)
        return label
    }()
    

    let fbBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Sign in with Facebook", for: .normal)
        button.setImage(UIImage(named: "icon-facebook"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.white
        button.imageEdgeInsets = UIEdgeInsets(top: 8, left: -10, bottom: 8, right: 0)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Device.IS_IPHONE ? 18 : 36)
        button.layer.cornerRadius = Device.IS_IPHONE ? 6 : 12
        button.clipsToBounds = true
        button.backgroundColor = UIColor.blueFB
        button.setAnchor(width: 0, height: Device.IS_IPHONE ? 40 : 80)
        button.addTarget(self, action: #selector(handleFB), for: .touchUpInside)
        return button
    }()
    
    let googleBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Sign in with Google", for: .normal)
        button.setImage(UIImage(named: "icon-google"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = UIColor.white
        button.imageEdgeInsets = UIEdgeInsets(top: 8, left: -30, bottom: 8, right: 0)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Device.IS_IPHONE ? 18 : 36)
        button.layer.cornerRadius = Device.IS_IPHONE ? 6 : 12
        button.clipsToBounds = true
        button.backgroundColor = UIColor.redGoogle//.red
        button.setAnchor(width: 0, height: Device.IS_IPHONE ? 40 : 80)
        button.addTarget(self, action: #selector(handleGoogle), for: .touchUpInside)
        return button
    }()
    
    let orLabel: UILabel = {
        let label = UILabel()
        label.text = "Or"
        label.font = UIFont.boldSystemFont(ofSize: Device.IS_IPHONE ?  16 : 32)
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.setAnchor(width: 0, height: Device.IS_IPHONE ? 40 : 100)
        return label
    }()
    
    let createAccountBtn: UIButton = {
        let button = UIButton()
        button.setTitle("Create a new account", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Device.IS_IPHONE ? 18 : 36)
        button.layer.cornerRadius = Device.IS_IPHONE ? 6 : 12
        button.clipsToBounds = true
        button.backgroundColor = UIColor.black

        button.setAnchor(width: 0, height: Device.IS_IPHONE ? 40 : 80)
        button.addTarget(self, action: #selector(handleCreateAccount), for: .touchUpInside)
        return button
    }()
    
    let termsLabel: UILabel = {
        let label = UILabel()
        let attributedTermsText = NSMutableAttributedString(string: "By clicking ”Create a new account” you agree to our ", attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: Device.IS_IPHONE ?  14 : 28), NSAttributedString.Key.foregroundColor: UIColor.white])
        let attributedTermsSubText = NSMutableAttributedString(string: "Termf of Service.", attributes: [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: Device.IS_IPHONE ?  14 : 28), NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedTermsText.append(attributedTermsSubText)
        label.attributedText = attributedTermsText
        label.numberOfLines = 0
        label.setAnchor(width: 0, height: Device.IS_IPHONE ? 40 : 80)
        return label
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
        
        addSubview(titleLabel)
        
        titleLabel.setAnchor(width: frame.width,
                                  height: Device.IS_IPHONE ? 160 : 320)
        
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: topAnchor, constant: CGFloat(Device.SCREEN_HEIGHT / 4)).isActive = true
        
        //addSubviews([fbBtn, googleBtn, orLabel, createAccountBtn, termsLabel])

        
        let buttonsStackView = createStackView(views: [fbBtn, googleBtn, orLabel, createAccountBtn, termsLabel])
        addSubview(buttonsStackView)
        buttonsStackView.setAnchor(width: Device.IS_IPHONE ?  260 : 520,
                                   height: Device.IS_IPHONE ?  232 : 464)
        buttonsStackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        buttonsStackView.topAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    @objc func handleFB() {
        fbAction?()
    }
    
    @objc func handleGoogle() {
        googleAction?()
    }
    
    @objc func handleCreateAccount() {
        creteAccountAction?()
    }

}
