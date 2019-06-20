//
//  ChatView.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-16.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class ChatView: UIView {
    
    var bottomAnchorKeyboardHidden: NSLayoutConstraint!
    var bottomAnchorKeyboardShown: NSLayoutConstraint!
    

    
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
    var chatTableView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "aurora1"))
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    fileprivate var bottomContainer: UIView = {
        let view = UIView()
        return view
    }()
    
    
    // MARK: - private functions
    fileprivate func setup() {

        addSubview(bottomContainer)
        bottomContainer.setAnchor(top: nil,
                               leading: leadingAnchor,
                               bottom: safeBottomAnchor,
                               trailing: trailingAnchor,
                               paddingTop: 0,
                               paddingLeft: 0,
                               paddingBottom: 0,
                               paddingRight: 0,
                               width: 0,
                               height: 50)
        
        
        
        
       
        
        bottomContainer.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0).isActive = true
        bottomContainer.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0).isActive = true
        
        bottomContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        
        bottomAnchorKeyboardHidden = bottomContainer.bottomAnchor.constraint(equalTo: safeBottomAnchor, constant: 0)
        bottomAnchorKeyboardShown = bottomContainer.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -150)
        bottomAnchorKeyboardHidden.isActive = true
        
        
        
        addSubview(chatTableView)
        bottomContainer.setAnchor(top: topAnchor,
                                  leading: leadingAnchor,
                                  bottom: bottomContainer.topAnchor,
                                  trailing: trailingAnchor,
                                  paddingTop: 0,
                                  paddingLeft: 0,
                                  paddingBottom: 0,
                                  paddingRight: 0,
                                  width: 0,
                                  height: 50)
        
    }
    

    
    @objc fileprivate func handleNewCanvas() {
        newCanvasAction?()
    }
    
    @objc fileprivate func handleGallery() {
        galleryAction?()
    }
    
    
    func handleShowKeyboard() {
        bottomAnchorKeyboardHidden.isActive = false
        bottomAnchorKeyboardShown.isActive = true
    }
    
    func handleHideKeyboard() {
        bottomAnchorKeyboardShown.isActive = false
        bottomAnchorKeyboardHidden.isActive = true
    }
}
