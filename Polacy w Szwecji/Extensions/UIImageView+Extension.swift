//
//  UIImageView+Extension.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-15.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit
import SDWebImage

extension UIImageView {
    func loadImage(_ urlString: String?, onSuccess: ((UIImage) -> Void)? = nil) {
        self.image = UIImage()
        guard let aUrlString = urlString else { return }
        guard let url = URL(string: aUrlString) else { return }
        
        self.sd_setImage(with: url) { (image, error, type, url) in
            if onSuccess != nil, error == nil {
                onSuccess!(image!)
            }
        }
    }
}

