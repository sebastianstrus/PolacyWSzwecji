//
//  AccountImageCell.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-23.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class AccountImageCell: UITableViewCell {
    
    let profileIV: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "profile0"))
        iv.layer.cornerRadius = 40
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        backgroundColor = UIColor.groupTableViewBackground
        layer.borderColor = UIColor.groupTableViewBackground.cgColor
        layer.borderWidth = 2
        
        addSubview(profileIV)
        profileIV.setAnchor(width: 80,
                            height: 80)
        profileIV.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        profileIV.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    
}
