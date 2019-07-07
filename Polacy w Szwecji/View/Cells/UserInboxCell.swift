//
//  UserInboxCell.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-19.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//


import UIKit
//import SDWebImage

class UserInboxCell : UITableViewCell {
    
    /*var user : User? {
     didSet {
     
     }
     }*/
    
    var user: User!
    
    var profileImageView : UIImageView = {
        let iv = UIImageView(image: UIImage(named: "info_icon"))
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 30
        iv.clipsToBounds = true
        return iv
    }()
    
    var usernameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        label.text = "My title"
        return label
    }()
    
    var latestMessageLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .left
        label.text = "Mozemy pogadac"
        label.textColor = UIColor.lightGray
        return label
    }()
    
    var dateLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .right
        label.text = "Mozemy pogadac"
        label.textColor = UIColor.lightGray
        return label
    }()
    

    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        profileImageView.setAnchor(top: topAnchor,
                                   leading: leadingAnchor,
                                   bottom: nil,
                                   trailing: nil,
                                   paddingTop: 20,
                                   paddingLeft: 20,
                                   paddingBottom: 0,
                                   paddingRight: 0,
                                   width: 60,
                                   height: 60)
        
        addSubview(usernameLabel)
        usernameLabel.setAnchor(top: topAnchor,
                                leading: profileImageView.trailingAnchor,
                                bottom: nil,
                                trailing: nil,
                                paddingTop: 25,
                                paddingLeft: 15,
                                paddingBottom: 0,
                                paddingRight: 0)
        
        
        addSubview(latestMessageLabel)
        latestMessageLabel.setAnchor(top: usernameLabel.bottomAnchor,
                              leading: profileImageView.trailingAnchor,
                              bottom: nil,
                              trailing: nil,
                              paddingTop: 5,
                              paddingLeft: 15,
                              paddingBottom: 0,
                              paddingRight: 0)
        
        
        addSubview(dateLabel)
        dateLabel.setAnchor(top: nil,
                                leading: nil,
                                bottom: nil,
                                trailing: trailingAnchor,
                                paddingTop: 0,
                                paddingLeft: 0,
                                paddingBottom: 0,
                                paddingRight: 20)
        dateLabel.centerYAnchor.constraint(equalTo: usernameLabel.centerYAnchor).isActive = true
        
        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    

    
    // public
    func configureCell(uid: String, inbox: Inbox) {
        user = inbox.user
        profileImageView.loadImage(inbox.user.profileImageUrl)
        usernameLabel.text = inbox.user.username
        
        let date = Date(timeIntervalSince1970: inbox.date)
        let dateString = timeAgoSinceDate(date, currentDate: Date(), numericDates: true)
        dateLabel.text = dateString
        
        latestMessageLabel.text = inbox.text.isEmpty ? "[MEDIA]" : inbox.text

    }
    
}
