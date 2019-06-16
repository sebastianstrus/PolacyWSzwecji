//
//  ChatView.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-16.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class ChatView: UIView {
    
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
                               bottom: bottomAnchor,
                               trailing: trailingAnchor,
                               paddingTop: 0,
                               paddingLeft: 0,
                               paddingBottom: 0,
                               paddingRight: 0,
                               width: 0,
                               height: 50)
        
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
}
