//
//  ChatController.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-16.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class ChatController: UIViewController, UITextViewDelegate {

    
    var imagePartner: UIImage!
    var partnerUsername: String!
    var placeHolderLabel: UILabel!
    
    // MARK: - All subviews
    var chatTableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = UIColor.darkGray
        return tv
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
    
    var attachmentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "attachment_icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.tintColor = UIColor.white
        button.addTarget(self, action: #selector(attachmentPressed), for: .touchUpInside)
        return button
    }()
    
    var micButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "mic_icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.tintColor = UIColor.white
        button.addTarget(self, action: #selector(micPressed), for: .touchUpInside)
        return button
    }()
    
    @objc func attachmentPressed() {
        print("attachmentPressed")
    }
    
    @objc func micPressed() {
        print("micPressed")
    }
    
    var sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "send_icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.tintColor = UIColor.white
        return button
    }()
    
    var inputTV: UITextView = {
        let tv = UITextView()
        tv.layer.cornerRadius = 5
        
        
        
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationBar()
        setupView()
    }
    
    // MARK: - UITextViewDelegate methods
    func textViewDidChange(_ textView: UITextView) {
        let spacing = CharacterSet.whitespacesAndNewlines
        if !textView.text.trimmingCharacters(in: spacing).isEmpty {
            let text = textView.text.trimmingCharacters(in: spacing)
            sendButton.isEnabled = true
            sendButton.setTitleColor(.white, for: .normal)
            placeHolderLabel.isHidden = true
        } else {
            sendButton.isEnabled = false
            sendButton.setTitleColor(.lightGray, for: .normal)
            placeHolderLabel.isHidden = false
        }
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
        
        bottomContainer.addSubview(attachmentButton)
        attachmentButton.setAnchor(top: bottomContainer.topAnchor,
                              leading: bottomContainer.leadingAnchor,
                              bottom: nil,
                              trailing: nil,
                              paddingTop: 5,
                              paddingLeft: 8,
                              paddingBottom: 0,
                              paddingRight: 0,
                              width: 32,
                              height: 32)
        
        bottomContainer.addSubview(micButton)
        micButton.setAnchor(top: bottomContainer.topAnchor,
                              leading: attachmentButton.trailingAnchor,
                              bottom: nil,
                              trailing: nil,
                              paddingTop: 5,
                              paddingLeft: 8,
                              paddingBottom: 0,
                              paddingRight: 0,
                              width: 32,
                              height: 32)
        
        bottomContainer.addSubview(sendButton)
        sendButton.setAnchor(top: bottomContainer.topAnchor,
                              leading: nil,
                              bottom: nil,
                              trailing: bottomContainer.trailingAnchor,
                              paddingTop: 5,
                              paddingLeft: 0,
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
        chatTableView.setAnchor(top: view.safeTopAnchor,
                                  leading: view.leadingAnchor,
                                  bottom: bottomContainer.topAnchor,
                                  trailing: view.trailingAnchor,
                                  paddingTop: 0,
                                  paddingLeft: 0,
                                  paddingBottom: 0,
                                  paddingRight: 0)
        
        
        setupInputContainer()
        
    }
    
    
    func setupInputContainer() {
        
        // UITextView doesn't support placeholder so:
        view.layoutIfNeeded()
        view.setNeedsLayout()
        placeHolderLabel = UILabel()
        let placeholderX: CGFloat = inputTV.frame.size.width / 60
        let placeholderY: CGFloat = 0
        let placeholderWidth: CGFloat = inputTV.bounds.width - placeholderX
        let placeholderHeight: CGFloat = inputTV.bounds.height
        let placeholderFontSize: CGFloat = CGFloat(Device.SCREEN_WIDTH / 25)
        placeHolderLabel.frame = CGRect(x: placeholderX, y: placeholderY, width: placeholderWidth, height: placeholderHeight)
        placeHolderLabel.text = "Write a message"
        placeHolderLabel.font = UIFont(name: "HelveticaNeue", size: placeholderFontSize)
        placeHolderLabel.textColor = UIColor.lightGray
        placeHolderLabel.textAlignment = .left
        inputTV.addSubview(placeHolderLabel)
        inputTV.delegate = self
    }
    
    


    

}
