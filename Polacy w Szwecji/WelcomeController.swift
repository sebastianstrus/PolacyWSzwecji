//
//  ViewController.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-01.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController {

    let topContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let bottomContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    
    
    
    
    
    
    let loginButton: UIButton = {
        let button = UIButton()
        
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: "Logowanie", attributes: [NSAttributedString.Key.font: AppFonts.BTN_FONT!, .foregroundColor: UIColor.red]))
        button.setAttributedTitle(attributedString, for: .normal)
        button.layer.cornerRadius = Device.IS_IPHONE ? 30 : 60
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.red.cgColor
        button.backgroundColor = .white
        button.setAnchor(width: 0, height: Device.IS_IPHONE ? 60 : 120)
        
        button.addTarget(self, action: #selector(handleGoToLogin), for: .touchUpInside)
        return button
    }()
    
    
    
    let signupButton: UIButton = {
        let button = UIButton()
        
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: "Rejestracja", attributes: [NSAttributedString.Key.font: AppFonts.BTN_FONT!, .foregroundColor: UIColor.white]))
        button.setAttributedTitle(attributedString, for: .normal)
        button.layer.cornerRadius = Device.IS_IPHONE ? 30 : 60
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.backgroundColor = .red
        button.setAnchor(width: 0, height: Device.IS_IPHONE ? 60 : 120)
        
        button.addTarget(self, action: #selector(handleGoToSignup), for: .touchUpInside)
        return button
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
    
    

    
    
    
    
    
    @objc func handleGoToLogin() {
        print("login")
    }
    
    @objc func handleGoToSignup() {
        print("register")
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        playVideo(title: "polish_flag")
        
        view.addSubview(topContainer)
        topContainer.setAnchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: CGFloat(Device.SCREEN_HEIGHT / 2))
        
        view.addSubview(bottomContainer)
        bottomContainer.setAnchor(top: topContainer.bottomAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        
        
        let titlesStackView = view.createStackView(views: [firstLabel, secondLabel])
        topContainer.addSubview(titlesStackView)
        titlesStackView.setAnchor(width: view.frame.width,
                                  height: Device.IS_IPHONE ? 160 : 320)
        titlesStackView.centerXAnchor.constraint(equalTo: topContainer.centerXAnchor).isActive = true
        titlesStackView.centerYAnchor.constraint(equalTo: topContainer.centerYAnchor).isActive = true
        
        
        let buttonsStackView = view.createStackView(views: [loginButton, signupButton])
        bottomContainer.addSubview(buttonsStackView)
        buttonsStackView.setAnchor(width: view.frame.width * 2 / 3,
                                  height: Device.IS_IPHONE ? 130 : 260)
        buttonsStackView.centerXAnchor.constraint(equalTo: bottomContainer.centerXAnchor).isActive = true
        buttonsStackView.centerYAnchor.constraint(equalTo: bottomContainer.centerYAnchor).isActive = true
        
    }


}


extension UIButton {
    
    
    public convenience init(title: String, color: UIColor?, filled: Bool) {
        self.init()
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: AppFonts.BTN_FONT!, .foregroundColor: UIColor.white]))
        self.setAttributedTitle(attributedString, for: .normal)
        self.layer.cornerRadius = Device.IS_IPHONE ? 30 : 60
        self.layer.borderWidth = 2
        self.layer.borderColor = color?.cgColor
        self.backgroundColor = filled ? color : .clear
        self.setAnchor(width: 0, height: Device.IS_IPHONE ? 60 : 120)
    }
    
}
