//
//  ChatController.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-16.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit
import MobileCoreServices
import AVFoundation

class ChatController: UIViewController, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource {
    
    fileprivate var sideMenuDelegate:SideMenuDelegate?
    
    var bottomAnchorKeyboardHidden: NSLayoutConstraint!
    var bottomAnchorKeyboardShown: NSLayoutConstraint!
    
    var imagePartner: UIImage!
    var partnerUsername: String!
    var partnerId: String!
    var placeHolderLabel: UILabel!
    var picker = UIImagePickerController()
    var messages = [Message]()
    
    // MARK: - All subviews
    var chatTableView: UITableView = {
        let tv = UITableView()
        tv.tableFooterView = UIView()
        return tv
    }()
    
    var bottomContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightRed
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
        //button.addTarget(self, action: #selector(attachmentPressed), for: .touchUpInside)
        return button
    }()
    
    var micButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "mic_icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.tintColor = UIColor.white
        //button.addTarget(self, action: #selector(micPressed), for: .touchUpInside)
        return button
    }()
    
    var sendButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "send_icon")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.imageView?.tintColor = UIColor.white
        button.addTarget(self, action: #selector(sendPressed), for: .touchUpInside)
        return button
    }()
    
    var inputTV: UITextView = {
        let tv = UITextView()
        tv.layer.cornerRadius = 5
        return tv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPicker()
        setupNavigationBar()
        setupView()
        observeMessages()
        setupChatTableView()
        handleKeyboard()
    }
    
    func observeMessages() {
        Api.Message.retriveMessage(from: Api.User.currentUserId, to: partnerId) { (message) in
            print(message.uid)
            self.messages.append(message)
            self.sortMessages()
        }
        Api.Message.retriveMessage(from: partnerId, to: Api.User.currentUserId) { (message) in
            print(message.uid)
            self.messages.append(message)
            self.sortMessages()
        }
    }
    
    func sortMessages() {
        messages = messages.sorted(by: { $0.date < $1.date })
        DispatchQueue.main.async {
            self.chatTableView.reloadData()
        }
    }
    
    func setupPicker() {
        picker.delegate = self
    }
    
    func setupChatTableView() {
        chatTableView.separatorStyle = .none
        chatTableView.delegate = self
        chatTableView.dataSource = self
        chatTableView.register(MessageCell.self, forCellReuseIdentifier: IDENTIFIER_CELL_MESSAGES)
    }
    
    // MARK: - UITableViewDataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = chatTableView.dequeueReusableCell(withIdentifier: IDENTIFIER_CELL_MESSAGES) as! MessageCell
        cell.playButton.isHidden = messages[indexPath.row].videoUrl == ""
        cell.configureCell(uid: Api.User.currentUserId, message: messages[indexPath.row], circleImage: imagePartner)
        return cell
    }
    
    // MARK: - UITableViewDelegate methods
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height: CGFloat = 0
        let message = messages[indexPath.row]
        let text = message.text
        if !text.isEmpty {
            height = text.estimateFrameForText(text).height + 60
        }
        let heightMessage = message.height
        let widthMessage = message.width
        if heightMessage != 0, widthMessage != 0 {
            height = CGFloat(heightMessage / widthMessage * 250)
        }
        return height
    }
    
    // MARK: - UIImagePickerControllerDelegate methods
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let videoUrl = info[UIImagePickerController.InfoKey.mediaURL] as? URL {
            print("TEST555")
            print(videoUrl)
            handleVideoSelectedForUrl(videoUrl)
        } else {
            handleImageSelectedForInfo(info)
        }
    }
    
    func handleVideoSelectedForUrl(_ url: URL) {
        // save video data
        print("TEST777")
        print(url)
        //  fileURI = fileURI.indexOf('file://')==0?fileURI:'file://'+fileURI;
        let videoName = NSUUID().uuidString
        StorageService.saveVideoMessage(url: url,
                                        id: videoName,
                                        onSuccess: { (anyValue) in
                                            if let dict = anyValue as? [String: Any] {
                                                print("TEST777")
                                                print(dict)
                                                self.sendToFirebase(dict: dict)
                                            }
        }) { (errorMessage) in
            
        }
        self.picker.dismiss(animated: true, completion: nil)
    }
    
    func handleImageSelectedForInfo(_ info: [UIImagePickerController.InfoKey: Any]) {
        var selectedImageFromPicker: UIImage?
        if let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImageFromPicker = selectedImage
        }
        
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        // save photo data
        let imageName = NSUUID().uuidString
        StorageService.savePhotoMessage(image: selectedImageFromPicker,
                                        id: imageName,
                                        onSuccess: { (anyValue) in
            if let dict = anyValue as? [String: Any] {
                self.sendToFirebase(dict: dict)
            }
        }) { (errorMessage) in
            print("Save photo error: \(errorMessage)")
        }
        self.picker.dismiss(animated: true, completion: nil)
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
        view.backgroundColor = UIColor.lightRed
        
        // workaround for iOS 13, TODO: move to buttons,
        attachmentButton.addTarget(self, action: #selector(attachmentPressed), for: .touchUpInside)
        micButton.addTarget(self, action: #selector(micPressed), for: .touchUpInside)
        
        view.addSubview(bottomContainer)
        bottomContainer.translatesAutoresizingMaskIntoConstraints = false
        bottomContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        bottomContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        bottomContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true

        bottomAnchorKeyboardHidden = bottomContainer.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: 0)
        bottomAnchorKeyboardHidden.isActive = true
        
        bottomContainer.addSubview(attachmentButton)
        attachmentButton.setAnchor(top: bottomContainer.topAnchor,
                              leading: bottomContainer.leadingAnchor,
                              bottom: nil,
                              trailing: nil,
                              paddingTop: 8,
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
                              paddingTop: 8,
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
                              height: 36)
        
        bottomContainer.addSubview(inputTV)
        inputTV.setAnchor(top: bottomContainer.topAnchor,
                               leading: bottomContainer.leadingAnchor,
                               bottom: nil,
                               trailing: sendButton.leadingAnchor,
                               paddingTop: 8,
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
    
    @objc func attachmentPressed() {
        let alert = UIAlertController(title: "Polacy w Szwecji", message: "Select source", preferredStyle: .actionSheet)
        let libraryAction = UIAlertAction(title: "Open library", style: .default) { (_) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
                self.picker.sourceType = .photoLibrary
                self.picker.mediaTypes = [String(kUTTypeImage), String(kUTTypeMovie)]
                self.present(self.picker, animated: true, completion: nil)
            } else {
                print("Library unavailable")
            }
        }
        let cameraAction = UIAlertAction(title: "Take a picture", style: .default) { (_) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                self.picker.sourceType = .camera
                self.present(self.picker, animated: true, completion: nil)
            } else {
                print("Camera unavailable")
            }
        }
        let videoCameraAction = UIAlertAction(title: "Take a video", style: .default) { (_) in
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
                self.picker.sourceType = .camera
                self.picker.mediaTypes = [String(kUTTypeMovie)]
                self.picker.videoExportPreset = AVAssetExportPresetPassthrough
                self.picker.videoMaximumDuration = 30
                self.present(self.picker, animated: true, completion: nil)
            } else {
                print("Camera unavailable")
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(libraryAction)
        alert.addAction(cameraAction)
        alert.addAction(cancelAction)
        alert.addAction(videoCameraAction)
        
        present(alert, animated: true)
    }
    
    @objc func micPressed() {
        print("micPressed")
    }
    
    @objc func sendPressed() {
        inputTV.endEditing(true)
        if let text = inputTV.text, text != "" {
            inputTV.text = ""
            self.textViewDidChange(inputTV)
            sendToFirebase(dict: ["text": text as Any])
        }
    }

    func sendToFirebase(dict: Dictionary<String, Any>) {
        let date: Double = Date().timeIntervalSince1970
        var value = dict
        value["from"] = Api.User.currentUserId
        value["to"] = partnerId
        value["date"] = date
        value["read"] = true
        
        Api.Message.sendMessage(from: Api.User.currentUserId,
                                to: partnerId,
                                value: value)
    }
    
    // MARK: - Handling keyboard methods
    func handleKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            bottomAnchorKeyboardShown = bottomContainer.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -keyboardSize.height)
            self.bottomAnchorKeyboardHidden.isActive = false
            self.bottomAnchorKeyboardShown.isActive = true
            self.view.layoutIfNeeded()
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if let aBottomAnchorKeyboardShown = bottomAnchorKeyboardShown {
            aBottomAnchorKeyboardShown.isActive = false
            bottomAnchorKeyboardHidden.isActive = true
            view.layoutIfNeeded()
        }
    }
}
