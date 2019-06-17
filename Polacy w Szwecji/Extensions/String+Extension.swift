//
//  String+Extension.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-18.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func estimateFrameForText(_ text: String) -> CGRect {
        let size = CGSize(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17)], context: nil)
        
    }
}
