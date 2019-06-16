//
//  ChatController.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-16.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class ChatController: UIViewController {

    
    var imagePartner: UIImage!
    var partnerUsername: String!
    
    // MARK: - All subviews
    var chatTableView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "aurora1"))
        iv.backgroundColor = .white
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    var bottomContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blueFB
        return view
    }()
    
    var avatarIV: UIImageView = {
        let iv = UIImageView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 18
        iv.clipsToBounds = true
        return iv
    }()
    
    var topLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    var mediaButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "attachment_icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.tintColor = UIColor.white
        return button
    }()
    
    var media2Button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "mic_icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.tintColor = UIColor.white
        return button
    }()
    
    var sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "send_icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.tintColor = UIColor.white
        return button
    }()
    
    var inputTV: UITextView = {
        let tv = UITextView()
        tv.layer.cornerRadius = 10
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupView()
    }
    

    // MARK: - Private methods
    func setupNavigationBar() {
        let containView = UIView(frame: CGRect(x: 0, y: 0, width: 36, height: 36))
        avatarIV.image = imagePartner
        containView.addSubview(avatarIV)
        
        let rightBarButton = UIBarButtonItem(customView: containView)
        navigationItem.rightBarButtonItem = rightBarButton
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
        
        let attributed = NSMutableAttributedString(string: partnerUsername + "\n", attributes: [.font : UIFont.systemFont(ofSize: 17), .foregroundColor: UIColor.white])
        attributed.append(NSAttributedString(string: "Active", attributes: [.font: UIFont.systemFont(ofSize: 13), .foregroundColor: UIColor.green]))
        topLabel.attributedText = attributed
        navigationItem.titleView = topLabel
        
    }
    
    func setupView() {
        view.addSubview(bottomContainer)
        bottomContainer.setAnchor(top: view.safeBottomAnchor,
                                  leading: view.leadingAnchor,
                                  bottom: view.bottomAnchor,
                                  trailing: view.trailingAnchor,
                                  paddingTop: -50,
                                  paddingLeft: 0,
                                  paddingBottom: 0,
                                  paddingRight: 0)
        
        bottomContainer.addSubview(mediaButton)
        mediaButton.setAnchor(top: bottomContainer.topAnchor,
                              leading: bottomContainer.leadingAnchor,
                              bottom: nil,
                              trailing: nil,
                              paddingTop: 5,
                              paddingLeft: 8,
                              paddingBottom: 0,
                              paddingRight: 0,
                              width: 32,
                              height: 32)
        
        bottomContainer.addSubview(media2Button)
        media2Button.setAnchor(top: bottomContainer.topAnchor,
                              leading: mediaButton.trailingAnchor,
                              bottom: nil,
                              trailing: nil,
                              paddingTop: 8,
                              paddingLeft: 8,
                              paddingBottom: 0,
                              paddingRight: 0,
                              width: 30,
                              height: 30)
        
        bottomContainer.addSubview(sendButton)
        sendButton.setAnchor(top: bottomContainer.topAnchor,
                              leading: nil,
                              bottom: nil,
                              trailing: bottomContainer.trailingAnchor,
                              paddingTop: 5,
                              paddingLeft: 5,
                              paddingBottom: 0,
                              paddingRight: 5,
                              width: 36,
                              height: 30)
        
        bottomContainer.addSubview(inputTV)
        inputTV.setAnchor(top: bottomContainer.topAnchor,
                               leading: bottomContainer.leadingAnchor,
                               bottom: nil,
                               trailing: sendButton.leadingAnchor,
                               paddingTop: 5,
                               paddingLeft: 88,
                               paddingBottom: 0,
                               paddingRight: 8,
                               width: 0,
                               height: 30)
        
        view.addSubview(chatTableView)
        chatTableView.setAnchor(top: view.topAnchor,
                                  leading: view.leadingAnchor,
                                  bottom: bottomContainer.topAnchor,
                                  trailing: view.trailingAnchor,
                                  paddingTop: 0,
                                  paddingLeft: 0,
                                  paddingBottom: 0,
                                  paddingRight: 0,
                                  width: 0,
                                  height: 50)
        
        
    }
    

}
