//
//  UIButton+Extension.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-11.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

extension UIButton {
    
    public convenience init(title: String, color: UIColor?, filled: Bool) {
        self.init()
        let attributedString = NSMutableAttributedString(attributedString: NSAttributedString(string: title, attributes: [NSAttributedString.Key.font: AppFonts.BTN_FONT!, .foregroundColor: UIColor.white]))
        self.setAttributedTitle(attributedString, for: .normal)
        self.layer.cornerRadius = Device.IS_IPHONE ? 30 : 60
        self.layer.borderWidth = 2
        self.layer.borderColor = color?.cgColor
        self.backgroundColor = filled ? color : .clear
        self.setAnchor(width: 0, height: Device.IS_IPHONE ? 60 : 120)
    }
    
}
