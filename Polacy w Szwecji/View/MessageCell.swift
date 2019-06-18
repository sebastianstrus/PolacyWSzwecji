//
//  MessageCell.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-17.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit
import AVFoundation

class MessageCell : UITableViewCell {
    
    /*var user : User? {
     didSet {
     
     }
     }*/
    
    //var user: User!
    
    var bubbleWidthConstraint: NSLayoutConstraint!
    var bubbleLeftConstraint: NSLayoutConstraint!
    var bubbleRightConstraint: NSLayoutConstraint!
    
    var playerLayer: AVPlayerLayer?
    var player: AVPlayer?
    var message: Message!

    var profileImage: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "profile0"))
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 16
        iv.clipsToBounds = true
        iv.isHidden = true
        return iv
    }()
    
    var bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.layer.borderWidth = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var textMessageLabel: UILabel = {
        let label = UILabel()
        label.text = "Message"
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    var dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "timestamp"
        label.font = UIFont.systemFont(ofSize: 10)
        return label
    }()
    
    var photoMessage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor(r: 250, g: 250, b: 250)
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 15
        iv.clipsToBounds = true
        iv.isHidden = true
        return iv
    }()
    
    let playButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "play_icon"), for: .normal)
        return button
    }()
    
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        indicator.isHidden = true
        indicator.style = .whiteLarge
        indicator.stopAnimating()
        return indicator
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImage)
        profileImage.setAnchor(top: nil,
                               leading: leadingAnchor,
                               bottom: bottomAnchor,
                               trailing: nil,
                               paddingTop: 0,
                               paddingLeft: 15,
                               paddingBottom: 12,
                               paddingRight: 0,
                               width: 32,
                               height: 32)
        
        addSubview(bubbleView)

        //top
        bubbleView.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        
        //left
        bubbleLeftConstraint = bubbleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 55)
        bubbleLeftConstraint.isActive = true
        
        //right
        bubbleRightConstraint = bubbleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8)
        //bubbleRightConstraint.isActive = true
        
        bubbleView.bottomAnchor.constraint(equalTo: profileImage.bottomAnchor).isActive = true
        
        //width
        bubbleWidthConstraint = bubbleView.widthAnchor.constraint(equalToConstant: 312)
        bubbleWidthConstraint.isActive = true
        
    
        
        bubbleView.addSubview(textMessageLabel)
        textMessageLabel.setAnchor(top: bubbleView.topAnchor,
                             leading: bubbleView.leadingAnchor,
                             bottom: nil,
                             trailing: bubbleView.trailingAnchor,
                             paddingTop: 8,
                             paddingLeft: 15,
                             paddingBottom: 0,
                             paddingRight: 15)
        
        bubbleView.addSubview(photoMessage)
        photoMessage.pinToEdges(view: bubbleView)
        
        bubbleView.addSubview(dateLabel)
        dateLabel.setAnchor(top: textMessageLabel.bottomAnchor,
                             leading: bubbleView.leadingAnchor,
                             bottom: bubbleView.bottomAnchor,
                             trailing: bubbleView.trailingAnchor,
                             paddingTop: 0,
                             paddingLeft: 8,
                             paddingBottom: 5,
                             paddingRight: 8,
                             width: 0,
                             height: 15)
        
        bubbleView.addSubview(playButton)
        playButton.setAnchor(top: bubbleView.topAnchor,
                                leading: nil,
                                bottom: nil,
                                trailing: bubbleView.trailingAnchor,
                                paddingTop: 5,
                                paddingLeft: 0,
                                paddingBottom: 0,
                                paddingRight: 5,
                                width: 37,
                                height: 37)
        
        bubbleView.addSubview(activityIndicator)
        activityIndicator.setAnchor(width: 50, height: 50)
        activityIndicator.centerXAnchor.constraint(equalTo: bubbleView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: bubbleView.centerYAnchor).isActive = true
        
        playButton.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        photoMessage.isHidden = true
        profileImage.isHidden = true
        textMessageLabel.isHidden = true
        
        if observation != nil {
            stopObservers()
        }
        playerLayer?.removeFromSuperlayer()
        player?.pause()
        playButton.isHidden = false
        
        activityIndicator.isHidden = true
        activityIndicator.stopAnimating()
    }
    
    func stopObservers() {
        player?.removeObserver(self, forKeyPath: "status")
        observation = nil
    }
    
    @objc func playTapped() {
        print("playTapped")
        handlePlay()
    }
    
    
    var observation: Any? = nil
    func handlePlay() {
        print("handlePlay")
        let videoUrl = message.videoUrl
        if videoUrl.isEmpty {
            return
        }
        if let url = URL(string: videoUrl) {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
            player = AVPlayer(url: url)
            playerLayer = AVPlayerLayer(player: player)
            playerLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
            playerLayer?.frame = photoMessage.frame
            observation = player?.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions.new, context: nil)
            bubbleView.layer.addSublayer(playerLayer!)
            player?.play()
            playButton.isHidden = true
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            let status: AVPlayer.Status = player!.status
            switch (status) {
            case .readyToPlay:
                activityIndicator.isHidden = true
                activityIndicator.stopAnimating()
                break
            case .failed, .unknown:
                break
            }
        }
    }
    
    //public functions
    func configureCell(uid: String, message: Message, circleImage: UIImage) {
        self.message = message
        let text = message.text
        if !text.isEmpty {
            print("Not empty")
            textMessageLabel.isHidden = false
            textMessageLabel.text = message.text
            
            let widthValue = text.estimateFrameForText(text).width + 40
            print("widthValue: \(widthValue)")
            
            if widthValue < 100 {
                bubbleWidthConstraint.constant = 100
            } else {
                bubbleWidthConstraint.constant = widthValue
            }
            dateLabel.textColor = UIColor.lightGray
        } else {
            print("Is empty")
            photoMessage.isHidden = false
            photoMessage.loadImage(message.imageUrl)
            bubbleView.layer.borderColor = UIColor.clear.cgColor
            bubbleWidthConstraint.constant = 250
            dateLabel.textColor = UIColor.white
        }
        
        if uid == message.from {
            bubbleView.backgroundColor = UIColor.groupTableViewBackground
            bubbleView.layer.borderColor = UIColor.clear.cgColor
            
            bubbleRightConstraint.constant = 8
            bubbleLeftConstraint.constant = UIScreen.main.bounds.width - bubbleWidthConstraint.constant - bubbleRightConstraint.constant
            
        } else {
            profileImage.isHidden = false
            bubbleView.backgroundColor = UIColor.white
            profileImage.image = circleImage
            bubbleView.layer.borderColor = UIColor.lightGray.cgColor
            
            bubbleLeftConstraint.constant = 55
            bubbleRightConstraint.constant = UIScreen.main.bounds.width - bubbleWidthConstraint.constant - bubbleLeftConstraint.constant
        }
        
        let date = Date(timeIntervalSince1970: message.date)
        let dateString = timeAgoSinceDate(date, currentDate: Date(), numericDates: true)
        dateLabel.text = dateString
    }
}

//global function
func timeAgoSinceDate(_ date:Date, currentDate:Date, numericDates:Bool) -> String {
    let calendar = Calendar.current
    let now = currentDate
    let earliest = (now as NSDate).earlierDate(date)
    let latest = (earliest == now) ? date : now
    let components:DateComponents = (calendar as NSCalendar).components([NSCalendar.Unit.minute , NSCalendar.Unit.hour , NSCalendar.Unit.day , NSCalendar.Unit.weekOfYear , NSCalendar.Unit.month , NSCalendar.Unit.year , NSCalendar.Unit.second], from: earliest, to: latest, options: NSCalendar.Options())
    
    if (components.year! >= 2) {
        return "\(components.year!) years ago"
    } else if (components.year! >= 1){
        if (numericDates){ return "1 year ago"
        } else { return "Last year" }
    } else if (components.month! >= 2) {
        return "\(components.month!) months ago"
    } else if (components.month! >= 1){
        if (numericDates){ return "1 month ago"
        } else { return "Last month" }
    } else if (components.weekOfYear! >= 2) {
        return "\(components.weekOfYear!) weeks ago"
    } else if (components.weekOfYear! >= 1){
        if (numericDates){ return "1 week ago"
        } else { return "Last week" }
    } else if (components.day! >= 2) {
        return "\(components.day!) days ago"
    } else if (components.day! >= 1){
        if (numericDates){ return "1 day ago"
        } else { return "Yesterday" }
    } else if (components.hour! >= 2) {
        return "\(components.hour!) hours ago"
    } else if (components.hour! >= 1){
        if (numericDates){ return "1 hour ago"
        } else { return "An hour ago" }
    } else if (components.minute! >= 2) {
        return "\(components.minute!) minutes ago"
    } else if (components.minute! >= 1){
        if (numericDates){ return "1 minute ago"
        } else { return "A minute ago" }
    } else if (components.second! >= 3) {
        return "\(components.second!) seconds ago"
    } else { return "Just now" }
}
