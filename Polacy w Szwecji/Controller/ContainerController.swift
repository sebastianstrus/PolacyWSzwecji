//
//  ViewController.swift
//  SideMenuDemo2
//
//  Created by Sebastian Strus on 2019-06-02.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit

class ContainerController: UIViewController {

    var menuView: MenuView!
    
    var menuShowing = false
    var sideMenuXAnchor: NSLayoutConstraint?
    
    var button0XAnchor: NSLayoutConstraint?
    var button1XAnchor: NSLayoutConstraint?
    var button2XAnchor: NSLayoutConstraint?
    var button3XAnchor: NSLayoutConstraint?
    var button4XAnchor: NSLayoutConstraint?
    var button5XAnchor: NSLayoutConstraint?
    var button6XAnchor: NSLayoutConstraint?
    

    
    var canSetButtons = false
    
    lazy var firstController: FirstController = {
        let viewController = FirstController()
        viewController.view.backgroundColor = UIColor.darkGray
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    lazy var secondController: SecondController = {
        let viewController = SecondController()
        viewController.view.backgroundColor = UIColor.gray
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    lazy var thirdController: ThirdController = {
        let viewController = ThirdController()
        viewController.view.backgroundColor = UIColor.lightGray
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    lazy var fourthController: FirstController = {
        let viewController = FirstController()
        viewController.view.backgroundColor = UIColor.orange
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    lazy var fifthController: SecondController = {
        let viewController = SecondController()
        viewController.view.backgroundColor = UIColor.purple
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    lazy var sixthController: ThirdController = {
        let viewController = ThirdController()
        viewController.view.backgroundColor = UIColor.blue
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    lazy var seventhController: FirstController = {
        let viewController = FirstController()
        viewController.view.backgroundColor = UIColor.green
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    
    let button0: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.borderWidth = 2
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 34)
        button.layer.borderColor = UIColor.red.cgColor
        button.setTitle("1", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        button.tag = 0
        return button
    }()
    let button1: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.borderWidth = 2
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 34)
        button.layer.borderColor = UIColor.red.cgColor
        button.setTitle("2", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        button.tag = 1
        return button
    }()
    let button2: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.borderWidth = 2
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 34)
        button.layer.borderColor = UIColor.red.cgColor
        button.setTitle("3", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        button.tag = 2
        return button
    }()
    let button3: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.borderWidth = 2
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 34)
        button.layer.borderColor = UIColor.red.cgColor
        button.setTitle("4", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        button.tag = 3
        return button
    }()
    let button4: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.borderWidth = 2
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 34)
        button.layer.borderColor = UIColor.red.cgColor
        button.setTitle("5", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        button.tag = 4
        return button
    }()
    let button5: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.borderWidth = 2
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 34)
        button.layer.borderColor = UIColor.red.cgColor
        button.setTitle("6", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        button.tag = 5
        return button
    }()
    let button6: UIButton = {
        let button = UIButton(type: .custom)
        button.layer.borderWidth = 2
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 34)
        button.layer.borderColor = UIColor.red.cgColor
        button.setTitle("7", for: .normal)
        button.setTitleColor(UIColor.red, for: .normal)
        button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        button.tag = 6
        return button
    }()
    
    
    @objc func buttonPressed(sender: UIButton) {
        updateView(tag: sender.tag)
        toggleMenu()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupView()
    }
    
    var containerSideMenu: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.clipsToBounds = true
        return view
    }()
    
    lazy var waveContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var waveImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "wave_shape")?.withRenderingMode(.alwaysTemplate))
        iv.tintColor = UIColor.white
        iv.contentMode = UIView.ContentMode.scaleToFill
        return iv
    }()
    
    
    
    func setupNavBar() {
        //navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor(r: 235, g: 40, b: 40)
        let menuBtn = UIBarButtonItem(image: UIImage(named: "menu_icon")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(toggleMenu))
        menuBtn.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = menuBtn
    }
    
    func setupView() {
        updateView(tag: 0)
        // add static container for side menu, initially hidden
        view.addSubview(containerSideMenu)
        containerSideMenu.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        containerSideMenu.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerSideMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -160).isActive = true
        containerSideMenu.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: 80).isActive = true
        
        
        //add wave view shape
        containerSideMenu.addSubview(waveContainerView)
        waveContainerView.topAnchor.constraint(equalTo: containerSideMenu.topAnchor).isActive = true
        waveContainerView.bottomAnchor.constraint(equalTo: containerSideMenu.bottomAnchor).isActive = true
        waveContainerView.widthAnchor.constraint(equalToConstant: 160).isActive = true
        sideMenuXAnchor = waveContainerView.centerXAnchor.constraint(equalTo: view.leadingAnchor, constant: -80)
        sideMenuXAnchor?.isActive = true
        

        
        waveContainerView.addSubview(waveImageView)
        waveImageView.setAnchor(top: waveContainerView.topAnchor, leading: waveContainerView.leadingAnchor, bottom: waveContainerView.bottomAnchor, trailing: waveContainerView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        
        
        
        containerSideMenu.addSubview(button0)
        containerSideMenu.addSubview(button1)
        containerSideMenu.addSubview(button2)
        containerSideMenu.addSubview(button3)
        containerSideMenu.addSubview(button4)
        containerSideMenu.addSubview(button5)
        containerSideMenu.addSubview(button6)
        
        button0.setAnchor(width: 50, height: 60)
        button1.setAnchor(width: 50, height: 60)
        button2.setAnchor(width: 50, height: 60)
        button3.setAnchor(width: 50, height: 60)
        button4.setAnchor(width: 50, height: 60)
        button5.setAnchor(width: 50, height: 60)
        button6.setAnchor(width: 50, height: 60)
        
        button0XAnchor = button0.centerXAnchor.constraint(equalTo: containerSideMenu.centerXAnchor)
        button1XAnchor = button1.centerXAnchor.constraint(equalTo: containerSideMenu.centerXAnchor)
        button2XAnchor = button2.centerXAnchor.constraint(equalTo: containerSideMenu.centerXAnchor)
        button3XAnchor = button3.centerXAnchor.constraint(equalTo: containerSideMenu.centerXAnchor)
        button4XAnchor = button4.centerXAnchor.constraint(equalTo: containerSideMenu.centerXAnchor)
        button5XAnchor = button5.centerXAnchor.constraint(equalTo: containerSideMenu.centerXAnchor)
        button6XAnchor = button6.centerXAnchor.constraint(equalTo: containerSideMenu.centerXAnchor)
        
        button0XAnchor?.isActive = true
        button1XAnchor?.isActive = true
        button2XAnchor?.isActive = true
        button3XAnchor?.isActive = true
        button4XAnchor?.isActive = true
        button5XAnchor?.isActive = true
        button6XAnchor?.isActive = true
        
        
        
        
        button0.transform = CGAffineTransform(rotationAngle: self.radians(10))
        button1.transform = CGAffineTransform(rotationAngle: self.radians(15))
        button2.transform = CGAffineTransform(rotationAngle: self.radians(17))
        button3.transform = CGAffineTransform(rotationAngle: self.radians(19))
        button4.transform = CGAffineTransform(rotationAngle: self.radians(17))
        button5.transform = CGAffineTransform(rotationAngle: self.radians(15))
        button6.transform = CGAffineTransform(rotationAngle: self.radians(10))
        
        

        // if not logged in:
        let welcomeController = WelcomeController()
        present(welcomeController, animated: true)
        
        
        
    }
    
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("viewWillLayoutSubviews")
        let containerHeight = containerSideMenu.frame.height
        print("containerHeight: \(containerHeight)")
        
        let heightBy5 = containerHeight/7
        print("heightBy5: \(heightBy5)")
        
        
        if (heightBy5 != 0.0) {
            button0.centerYAnchor.constraint(equalTo: containerSideMenu.topAnchor, constant: heightBy5 * 0.5).isActive = true
            button1.centerYAnchor.constraint(equalTo: containerSideMenu.topAnchor, constant: heightBy5 * 1.5).isActive = true
            button2.centerYAnchor.constraint(equalTo: containerSideMenu.topAnchor, constant: heightBy5 * 2.5).isActive = true
            button3.centerYAnchor.constraint(equalTo: containerSideMenu.topAnchor, constant: heightBy5 * 3.5).isActive = true
            button4.centerYAnchor.constraint(equalTo: containerSideMenu.topAnchor, constant: heightBy5 * 4.5).isActive = true
            button5.centerYAnchor.constraint(equalTo: containerSideMenu.topAnchor, constant: heightBy5 * 5.5).isActive = true
            button6.centerYAnchor.constraint(equalTo: containerSideMenu.topAnchor, constant: heightBy5 * 6.5).isActive = true
        }
        
        
        
    }
    
    
    
    func updateView(tag: Int) {
        firstController.view.isHidden = !(tag == 0)
        secondController.view.isHidden = !(tag == 1)
        thirdController.view.isHidden = !(tag == 2)
        fourthController.view.isHidden = !(tag == 3)
        fifthController.view.isHidden = !(tag == 4)
        sixthController.view.isHidden = !(tag == 5)
        seventhController.view.isHidden = !(tag == 6)
    }
    
    
    

    @objc func toggleMenu() {
        if menuShowing {
            UIView.animate(withDuration: 0.7) {
                self.sideMenuXAnchor?.isActive = false
                self.sideMenuXAnchor = self.waveContainerView.centerXAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -80)
                self.sideMenuXAnchor?.isActive = true
                self.view.layoutIfNeeded()
            }
            
            UIView.animate(withDuration: 0.35, delay: 0.285, options: [], animations: {
                self.button0XAnchor?.isActive = false
                self.button0XAnchor = self.button0.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 0)
                self.button0XAnchor?.isActive = true
                self.button0.transform = CGAffineTransform(rotationAngle: self.radians(10))
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.35, delay: 0.27, options: [], animations: {
                self.button1XAnchor?.isActive = false
                self.button1XAnchor = self.button1.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 0)
                self.button1XAnchor?.isActive = true
                self.button1.transform = CGAffineTransform(rotationAngle: self.radians(15))
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.35, delay: 0.23, options: [], animations: {
                self.button2XAnchor?.isActive = false
                self.button2XAnchor = self.button2.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 0)
                self.button2XAnchor?.isActive = true
                self.button2.transform = CGAffineTransform(rotationAngle: self.radians(17))
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.35, delay: 0.18, options: [], animations: {
                self.button3XAnchor?.isActive = false
                self.button3XAnchor = self.button3.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 0)
                self.button3XAnchor?.isActive = true
                self.button3.transform = CGAffineTransform(rotationAngle: self.radians(19))
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.35, delay: 0.13, options: [], animations: {
                self.button4XAnchor?.isActive = false
                self.button4XAnchor = self.button4.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 0)
                self.button4XAnchor?.isActive = true
                self.button4.transform = CGAffineTransform(rotationAngle: self.radians(17))
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.35, delay: 0.08, options: [], animations: {
                self.button5XAnchor?.isActive = false
                self.button5XAnchor = self.button5.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 0)
                self.button5XAnchor?.isActive = true
                self.button5.transform = CGAffineTransform(rotationAngle: self.radians(15))
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.35, delay: 0.065, options: [], animations: {
                self.button6XAnchor?.isActive = false
                self.button6XAnchor = self.button6.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 0)
                self.button6XAnchor?.isActive = true
                self.button6.transform = CGAffineTransform(rotationAngle: self.radians(10))
                self.view.layoutIfNeeded()
            })
            

            
            
        } else {
            UIView.animate(withDuration: 0.7) {
                self.sideMenuXAnchor?.isActive = false
                self.sideMenuXAnchor = self.waveContainerView.centerXAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 80)
                self.sideMenuXAnchor?.isActive = true
                self.view.layoutIfNeeded()
            }
            
            
            UIView.animate(withDuration: 0.35, delay: 0.08, options: [], animations: {
                self.button0XAnchor?.isActive = false
                self.button0XAnchor = self.button0.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 80)
                self.button0XAnchor?.isActive = true
                self.button0.transform = CGAffineTransform(rotationAngle: self.radians(0))
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.35, delay: 0.1, options: [], animations: {
                self.button1XAnchor?.isActive = false
                self.button1XAnchor = self.button1.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 80)
                self.button1XAnchor?.isActive = true
                self.button1.transform = CGAffineTransform(rotationAngle: self.radians(0))
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.35, delay: 0.16, options: [], animations: {
                self.button2XAnchor?.isActive = false
                self.button2XAnchor = self.button2.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 80)
                self.button2XAnchor?.isActive = true
                self.button2.transform = CGAffineTransform(rotationAngle: self.radians(0))
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.35, delay: 0.20, options: [], animations: {
                self.button3XAnchor?.isActive = false
                self.button3XAnchor = self.button3.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 80)
                self.button3XAnchor?.isActive = true
                self.button3.transform = CGAffineTransform(rotationAngle: self.radians(0))
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.35, delay: 0.25, options: [], animations: {
                self.button4XAnchor?.isActive = false
                self.button4XAnchor = self.button4.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 80)
                self.button4XAnchor?.isActive = true
                self.button4.transform = CGAffineTransform(rotationAngle: self.radians(0))
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.35, delay: 0.27, options: [], animations: {
                self.button5XAnchor?.isActive = false
                self.button5XAnchor = self.button5.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 80)
                self.button5XAnchor?.isActive = true
                self.button5.transform = CGAffineTransform(rotationAngle: self.radians(0))
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.35, delay: 0.3, options: [], animations: {
                self.button6XAnchor?.isActive = false
                self.button6XAnchor = self.button6.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 80)
                self.button6XAnchor?.isActive = true
                self.button6.transform = CGAffineTransform(rotationAngle: self.radians(0))
                self.view.layoutIfNeeded()
            })
        }
        menuShowing = !menuShowing
    }
    
    
    
    private func addViewControllerAsChildViewController(childViewController: UIViewController) {
        addChild(childViewController)
        view.addSubview(childViewController.view)
        childViewController.view.frame = view.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController.didMove(toParent: self)
    }
    
    func radians(_ degrees: Double) -> CGFloat {
        return CGFloat(degrees * .pi / 180)
    }
}
