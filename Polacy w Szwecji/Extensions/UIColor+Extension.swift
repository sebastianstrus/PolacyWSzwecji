//
//  UIColor+Extension.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-04.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

extension UIColor {
    
    public convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}
