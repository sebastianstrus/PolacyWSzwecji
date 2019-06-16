//
//  UserCell.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-15.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//


import UIKit
//import SDWebImage

class UserCell : UITableViewCell {
    
    /*var user : User? {
        didSet {
     
        }
    }*/
    
    
    var userImageView : UIImageView = {
        let iv = UIImageView(image: UIImage(named: "info_icon"))
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.cornerRadius = 30
        iv.clipsToBounds = true
        return iv
    }()
    
    var usernameLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .left
        label.text = "My title"
        label.textColor = .black
        return label
    }()
    
    var statusLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.textAlignment = .left
        label.text = "Mozemy pogadac"
        label.textColor = UIColor.lightGray
        return label
    }()
    
    private let chatImageView : UIImageView = {
        let iv = UIImageView(image: UIImage(named: "msg_icon")?.withRenderingMode(.alwaysTemplate))
        iv.tintColor = UIColor.blueFB
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        addSubview(userImageView)
        userImageView.setAnchor(top: topAnchor,
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
                             leading: userImageView.trailingAnchor,
                             bottom: nil,
                             trailing: nil,
                             paddingTop: 25,
                             paddingLeft: 15,
                             paddingBottom: 0,
                             paddingRight: 0)
        
        
        addSubview(statusLabel)
        statusLabel.setAnchor(top: usernameLabel.bottomAnchor,
                              leading: userImageView.trailingAnchor,
                              bottom: nil,
                              trailing: nil,
                              paddingTop: 5,
                              paddingLeft: 15,
                              paddingBottom: 0,
                              paddingRight: 0)
        
        
        addSubview(chatImageView)
        chatImageView.setAnchor(top: nil,
                                leading: nil,
                                bottom: nil,
                                trailing: trailingAnchor,
                                paddingTop: 0,
                                paddingLeft: 9,
                                paddingBottom: 0,
                                paddingRight: 20,
                                width: 36,
                                height: 36)
        chatImageView.centerYAnchor.constraint(equalTo: userImageView.centerYAnchor).isActive = true

        
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    func loadData(_ user: User) {
        usernameLabel.text = user.username
        statusLabel.text = user.status
        userImageView.loadImage(user.profileImageUrl)
    }
    
}
