//
//  UIViewController+Extension.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-11.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

extension UIViewController {

    // MARK: - Handle keyboard methods
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
