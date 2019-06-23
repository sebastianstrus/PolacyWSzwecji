//
//  AccountView.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-23.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//


import UIKit

class AccountView: UIView {
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public actions
    var newCanvasAction: (() -> Void)?
    var galleryAction: (() -> Void)?
    
    // MARK: - All subviews
    let profileIV: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "profile0"))
        iv.contentMode = .scaleAspectFill
        iv.backgroundColor = UIColor.lightGray
        iv.layer.cornerRadius = 40
        iv.clipsToBounds = true
        return iv
    }()
    
    let accountTV: UITableView = {
        let tv = UITableView(frame: .zero, style: .grouped)
        return tv
    }()
    
    // MARK: - private functions
    fileprivate func setup() {
        backgroundColor = UIColor.groupTableViewBackground
        
        addSubview(profileIV)
        profileIV.setAnchor(top: safeTopAnchor,
                            leading: nil,
                            bottom: nil,
                            trailing: nil,
                            paddingTop: 30,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0,
                            width: 80,
                            height: 80)
        profileIV.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        
        addSubview(accountTV)
        accountTV.setAnchor(top: profileIV.bottomAnchor,
                            leading: leadingAnchor,
                            bottom: bottomAnchor,
                            trailing: trailingAnchor,
                            paddingTop: 10,
                            paddingLeft: 0,
                            paddingBottom: 0,
                            paddingRight: 0)
        
    }
    
    
    
    @objc fileprivate func handleNewCanvas() {
        newCanvasAction?()
    }
    
    @objc fileprivate func handleGallery() {
        galleryAction?()
    }
    
    
    func handleShowKeyboard() {

    }
    
    func handleHideKeyboard() {

    }
}
