//
//  MessageCell.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-17.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit
//import SDWebImage

class MessageCell : UITableViewCell {
    
    /*var user : User? {
     didSet {
     
     }
     }*/
    
    //var user: User!
    
    var bubbleWidthConstraint: NSLayoutConstraint!
    var bubbleLeftConstraint: NSLayoutConstraint!
    var bubbleRightConstraint: NSLayoutConstraint!
    
    

    
    var babbleView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.green
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        view.layer.borderWidth = 0.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    var profileImage: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "profile0"))
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 16
        iv.clipsToBounds = true
        iv.isHidden = true
        return iv
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
        return label
    }()
    
    var messageIV: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = UIColor.blueFB
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
    


    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        //yCenterAnchor = containerView.centerYAnchor.constraint(equalTo: centerYAnchor)
        //bubbleWidthConstraint = babbleView.widthAnchor.constraint(equalToConstant: 0)
        //bubbleLeftConstraint: NSLayoutConstraint!
        //bubbleRightConstraint: NSLayoutConstraint!
       
        
        addSubview(babbleView)

        //top
        babbleView.topAnchor.constraint(equalTo: topAnchor, constant: 12).isActive = true
        
        //left
        bubbleLeftConstraint = babbleView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 55)
        bubbleLeftConstraint.isActive = true
        
        //right
        bubbleRightConstraint = babbleView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 8)
        //bubbleRightConstraint.isActive = true
        
        babbleView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
        
        //width
        bubbleWidthConstraint = babbleView.widthAnchor.constraint(equalToConstant: 0)
        //bubbleWidthConstraint.isActive = true
        
        

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
        
        
        babbleView.addSubview(activityIndicator)
        activityIndicator.setAnchor(width: 50, height: 50)
        activityIndicator.centerXAnchor.constraint(equalTo: babbleView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: babbleView.centerYAnchor).isActive = true
        
        
        babbleView.addSubview(textMessageLabel)
        textMessageLabel.setAnchor(top: babbleView.topAnchor,
                             leading: babbleView.leadingAnchor,
                             bottom: nil,
                             trailing: babbleView.trailingAnchor,
                             paddingTop: 8,
                             paddingLeft: 15,
                             paddingBottom: 0,
                             paddingRight: 15)
        
        babbleView.addSubview(messageIV)
        messageIV.pinToEdges(view: babbleView)
        
        babbleView.addSubview(dateLabel)
        dateLabel.setAnchor(top: textMessageLabel.bottomAnchor,
                             leading: babbleView.leadingAnchor,
                             bottom: babbleView.bottomAnchor,
                             trailing: babbleView.trailingAnchor,
                             paddingTop: 0,
                             paddingLeft: 8,
                             paddingBottom: 5,
                             paddingRight: 8,
                             width: 0,
                             height: 15)
        
        babbleView.addSubview(playButton)
        playButton.setAnchor(top: babbleView.topAnchor,
                                leading: nil,
                                bottom: nil,
                                trailing: babbleView.trailingAnchor,
                                paddingTop: 5,
                                paddingLeft: 0,
                                paddingBottom: 0,
                                paddingRight: 5,
                                width: 37,
                                height: 37)
        

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        messageIV.isHidden = true
        profileImage.isHidden = true
        textMessageLabel.isHidden = true
    }
    
    //public functions
    func configureCell(uid: String, message: Message, circleImage: UIImage) {
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
            messageIV.isHidden = false
            messageIV.loadImage(message.imageUrl)
            babbleView.layer.borderColor = UIColor.clear.cgColor
            bubbleWidthConstraint.constant = 250
            dateLabel.textColor = UIColor.white
        }
        
        if uid == message.from {
            babbleView.backgroundColor = UIColor.groupTableViewBackground
            babbleView.layer.borderColor = UIColor.clear.cgColor
            
            bubbleRightConstraint.constant = 8
            bubbleLeftConstraint.constant = UIScreen.main.bounds.width - bubbleWidthConstraint.constant - bubbleRightConstraint.constant
            
        } else {
            profileImage.isHidden = false
            babbleView.backgroundColor = UIColor.white
            profileImage.image = circleImage
            babbleView.layer.borderColor = UIColor.lightGray.cgColor
            
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
