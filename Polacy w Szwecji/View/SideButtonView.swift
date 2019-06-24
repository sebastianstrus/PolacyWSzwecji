//
//  SideButtonView.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-05.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class SideButtonView: UIView {

    var imageName: String!
    var title: String?
    
    // MARK: - Initializers
    convenience init(imageName: String, title: String?) {
        self.init(frame: .zero)
        self.imageName = imageName
        self.title = title
        setupView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        addSubview(imageView)
        imageView.image = UIImage(named: imageName)!.withRenderingMode(UIImage.RenderingMode.alwaysTemplate)
        imageView.setAnchor(top: topAnchor,
                            leading: leadingAnchor,
                            bottom: nil,
                            trailing: trailingAnchor,
                            paddingTop: 0,
                            paddingLeft: 18,
                            paddingBottom: 0,
                            paddingRight: 18,
                            width: 0,
                            height: 44)
        
        addSubview(titleLabel)
        titleLabel.text = title
        titleLabel.setAnchor(top: nil,
                             leading: leadingAnchor,
                             bottom: bottomAnchor,
                             trailing: trailingAnchor,
                             paddingTop: 0,
                             paddingLeft: 0,
                             paddingBottom: 0,
                             paddingRight: 0,
                             width: 0,
                             height: 16)
    }
    
    
    private let imageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "menu_icon"))
        iv.tintColor = UIColor.sideMenuTint
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.sideMenuTint
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .center
        return label
    }()
    
    //public
    func setAvatar(photoUrl: URL) {
        imageView.loadImage(photoUrl.absoluteString)
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
    }
    
    func setImage(_ image: UIImage) {
        imageView.image = image
    }
}
