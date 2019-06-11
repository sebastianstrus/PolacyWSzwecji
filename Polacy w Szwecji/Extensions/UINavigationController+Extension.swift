//
//  UINavigationController+Extension.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-11.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

public extension UINavigationController {
    

    func customPop() {
        addTransition(transitionType: .fade, duration: 0.3)
        popViewController(animated: false)
    }
    
    func customPopToRoot() {
        addTransition(transitionType: .fade, duration: 0.3)
        popToRootViewController(animated: false)
    }

    func customPush(vc: UIViewController) {
        addTransition(transitionType: .fade, duration: 0.3)
        pushViewController(vc, animated: false)
    }
    
    private func addTransition(transitionType type: CATransitionType, duration: CFTimeInterval) {
        let transition = CATransition()
        transition.duration = duration
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        transition.type = type
        self.view.layer.add(transition, forKey: nil)
    }
    
}
