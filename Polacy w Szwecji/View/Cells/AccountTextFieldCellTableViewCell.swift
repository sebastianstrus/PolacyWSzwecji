//
//  AccountTextFieldCellTableViewCell.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-23.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//


import UIKit

class AccountTextFieldCell: UITableViewCell {
    
    let textField: UITextField = {
        let tf = UITextField()
        tf.textColor = UIColor.darkGray
        return tf
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(textField)
        textField.setAnchor(top: topAnchor,
                            leading: leadingAnchor,
                            bottom: bottomAnchor,
                            trailing: trailingAnchor,
                            paddingTop: 0,
                            paddingLeft: 20,
                            paddingBottom: 0,
                            paddingRight: 20)
    }
    
    
}
