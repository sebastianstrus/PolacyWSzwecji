//
//  ViewController.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-01.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class WelcomeController: UIViewController {

    fileprivate var welcomeView: WelcomeView!
    
    let backgroundIV: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "sweden"))
        iv.contentMode = UIView.ContentMode.scaleAspectFill
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(backgroundIV)
        backgroundIV.pinToEdges(view: view)
        playVideo(title: "polish_flag")
        setupView()
    }
    
    private func setupView() {
        welcomeView = WelcomeView()
        view.addSubview(welcomeView)
        welcomeView.pinToEdges(view: view)
    }
}


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
