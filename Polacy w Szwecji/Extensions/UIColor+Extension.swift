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
    
    class var lightRed: UIColor { return UIColor.blueFB}//{ return UIColor(r: 245, g: 30, b: 30)}
    class var lightWhite: UIColor { return UIColor(r: 240, g: 240, b: 240)}
    class var sideMenuTint: UIColor { return UIColor.white } //.white
    class var blueFB: UIColor { return UIColor(r: 72, g: 98, b: 168)} //or (66,103,178), (59, 89, 152)
    class var redGoogle: UIColor { return UIColor(r: 220, g: 90, b: 64)}
    class var sideMenuBackground: UIColor { return UIColor.blueFB}
    

}
