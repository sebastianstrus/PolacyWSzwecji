//
//  ViewController.swift
//  SideMenuDemo2
//
//  Created by Sebastian Strus on 2019-06-02.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit


class ContainerController: UIViewController {

    final let kNumberButtons: Int = 7
    final let kWidth: CGFloat = 80
    
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
    
    lazy var firstController: FirstController = {
        let viewController = FirstController()
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    lazy var secondController: SecondController = {
        let viewController = SecondController()
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    lazy var thirdController: ThirdController = {
        let viewController = ThirdController()
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    lazy var fourthController: FirstController = {
        let viewController = FirstController()
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    lazy var fifthController: SecondController = {
        let viewController = SecondController()
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    lazy var sixthController: ThirdController = {
        let viewController = ThirdController()
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    lazy var seventhController: FirstController = {
        let viewController = FirstController()
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    
    let button0: SideButtonView = {
        let button = SideButtonView(imageName: "home_icon", title: "Forum")
        return button
    }()
    
    let button1: SideButtonView = {
        let button = SideButtonView(imageName: "work_icon", title: "Praca")
        return button
    }()
    
    let button2: SideButtonView = {
        let button = SideButtonView(imageName: "apartments_icon", title: "Lokale")
        return button
    }()
    
    let button3: SideButtonView = {
        let button = SideButtonView(imageName: "alkohol_icon", title: "Zakupy")
        return button
    }()
    
    let button4: SideButtonView = {
        let button = SideButtonView(imageName: "vademekum_icon", title: "Vademecum")
        return button
    }()
    
    let button5: SideButtonView = {
        let button = SideButtonView(imageName: "vademekum_icon", title: "Forum")
        return button
    }()
    
    let button6: SideButtonView = {
        let button = SideButtonView(imageName: "vademekum_icon", title: "Forum")
        return button
    }()
    
    
    @objc func buttonPressed(sender: UIButton) {
        updateView(tag: sender.tag)
        toggleMenu()
    }

    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        print("handleTap")
        guard let getTag = sender.view?.tag else { return }
        print("getTag: \(getTag)")
        updateView(tag: getTag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupView()
    }
    
    var containerSideMenu: UIView = {
        let view = UIView()
        view.isHidden = true
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
        
        let buttons = [button0, button1, button2, button3, button4, button5, button6]

        var anchors = [button0XAnchor, button1XAnchor, button2XAnchor, button3XAnchor, button4XAnchor, button5XAnchor, button6XAnchor]
        
        var i = 0
        for button in buttons {
            button.tag = i
            i += 1
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            button.addGestureRecognizer(tap)
        }
        
        
        updateView(tag: 0)
        
        // add static transparent container for side menu, initially hidden
        view.addSubview(containerSideMenu)
        containerSideMenu.topAnchor.constraint(equalTo: view.safeTopAnchor).isActive = true
        containerSideMenu.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        containerSideMenu.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -2*kWidth).isActive = true
        containerSideMenu.trailingAnchor.constraint(equalTo: view.leadingAnchor, constant: kWidth).isActive = true
        
        //add wave view shape
        containerSideMenu.addSubview(waveContainerView)
        waveContainerView.topAnchor.constraint(equalTo: containerSideMenu.topAnchor).isActive = true
        waveContainerView.bottomAnchor.constraint(equalTo: containerSideMenu.bottomAnchor).isActive = true
        waveContainerView.widthAnchor.constraint(equalToConstant: 2*kWidth).isActive = true
        sideMenuXAnchor = waveContainerView.centerXAnchor.constraint(equalTo: view.leadingAnchor, constant: -kWidth)
        sideMenuXAnchor?.isActive = true
        

        
        waveContainerView.addSubview(waveImageView)
        waveImageView.setAnchor(top: waveContainerView.topAnchor, leading: waveContainerView.leadingAnchor, bottom: waveContainerView.bottomAnchor, trailing: waveContainerView.trailingAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        
        for button in buttons {
            containerSideMenu.addSubview(button)
            button.setAnchor(width: 50, height: 60)
        }

        for i in 1...kNumberButtons {
            print("i: \(i)")
            anchors[i-1] = buttons[i-1].centerXAnchor.constraint(equalTo: containerSideMenu.centerXAnchor)
            print("activate \(i-1)")
            //anchors[i-1]?.isActive = true
        }


 
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
//        let welcomeController = WelcomeController()
//        present(welcomeController, animated: true)
        
        
        containerSideMenu.setNeedsLayout()
        containerSideMenu.layoutIfNeeded()
        
        let containerHeight = containerSideMenu.frame.height
        print("containerHeight: \(containerHeight)")
        let heightByNumberItems = containerHeight/8//kNumberButtons
        
        var offset: CGFloat = 0.5
        for button in buttons {
            button.centerYAnchor.constraint(equalTo: containerSideMenu.topAnchor, constant: heightByNumberItems * offset).isActive = true
            offset += 1
        }

        
//        let welcomeController = WelcomeController()
//        present(welcomeController, animated: true)
    }
    
//    override func viewWillLayoutSubviews() {
//        super.viewWillLayoutSubviews()
//
//        print("viewWillLayoutSubviews")
//        let containerHeight = containerSideMenu.frame.height
//        print("containerHeight: \(containerHeight)")
//        let heightBy5 = containerHeight/kNumberButtons
//
//        print("heightBy5: \(heightBy5)")
//
//        if (heightBy5 != 0.0) {
//            button0.centerYAnchor.constraint(equalTo: containerSideMenu.topAnchor, constant: heightBy5 * 0.5).isActive = true
//            button1.centerYAnchor.constraint(equalTo: containerSideMenu.topAnchor, constant: heightBy5 * 1.5).isActive = true
//            button2.centerYAnchor.constraint(equalTo: containerSideMenu.topAnchor, constant: heightBy5 * 2.5).isActive = true
//            button3.centerYAnchor.constraint(equalTo: containerSideMenu.topAnchor, constant: heightBy5 * 3.5).isActive = true
//            button4.centerYAnchor.constraint(equalTo: containerSideMenu.topAnchor, constant: heightBy5 * 4.5).isActive = true
//            button5.centerYAnchor.constraint(equalTo: containerSideMenu.topAnchor, constant: heightBy5 * 5.5).isActive = true
//            button6.centerYAnchor.constraint(equalTo: containerSideMenu.topAnchor, constant: heightBy5 * 6.5).isActive = true
//        }
//    }

    
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
            // hide menu
            UIView.animate(withDuration: 0.7, animations: {
                self.sideMenuXAnchor?.isActive = false
                self.sideMenuXAnchor = self.waveContainerView.centerXAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -self.kWidth)
                self.sideMenuXAnchor?.isActive = true
                self.view.layoutIfNeeded()
            }) { (_) in
                self.containerSideMenu.isHidden = true
                
            }
            
            UIView.animate(withDuration: 0.35, delay: 0.29, options: [], animations: {
                self.button0XAnchor?.isActive = false
                self.button0XAnchor = self.button0.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 0)
                self.button0XAnchor?.isActive = true
                self.button0.transform = CGAffineTransform(rotationAngle: self.radians(10))
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.35, delay: 0.28, options: [], animations: {
                self.button1XAnchor?.isActive = false
                self.button1XAnchor = self.button1.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 0)
                self.button1XAnchor?.isActive = true
                self.button1.transform = CGAffineTransform(rotationAngle: self.radians(15))
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.35, delay: 0.25, options: [], animations: {
                self.button2XAnchor?.isActive = false
                self.button2XAnchor = self.button2.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 0)
                self.button2XAnchor?.isActive = true
                self.button2.transform = CGAffineTransform(rotationAngle: self.radians(17))
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.35, delay: 0.20, options: [], animations: {
                self.button3XAnchor?.isActive = false
                self.button3XAnchor = self.button3.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 0)
                self.button3XAnchor?.isActive = true
                self.button3.transform = CGAffineTransform(rotationAngle: self.radians(19))
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.35, delay: 0.16, options: [], animations: {
                self.button4XAnchor?.isActive = false
                self.button4XAnchor = self.button4.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 0)
                self.button4XAnchor?.isActive = true
                self.button4.transform = CGAffineTransform(rotationAngle: self.radians(17))
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.35, delay: 0.1, options: [], animations: {
                self.button5XAnchor?.isActive = false
                self.button5XAnchor = self.button5.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 0)
                self.button5XAnchor?.isActive = true
                self.button5.transform = CGAffineTransform(rotationAngle: self.radians(15))
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.35, delay: 0.075, options: [], animations: {
                self.button6XAnchor?.isActive = false
                self.button6XAnchor = self.button6.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 0)
                self.button6XAnchor?.isActive = true
                self.button6.transform = CGAffineTransform(rotationAngle: self.radians(10))
                self.view.layoutIfNeeded()
            })
        } else {
            // show menu
            containerSideMenu.isHidden = false
            UIView.animate(withDuration: 0.7) {
                self.sideMenuXAnchor?.isActive = false
                self.sideMenuXAnchor = self.waveContainerView.centerXAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 80)
                self.sideMenuXAnchor?.isActive = true
                self.view.layoutIfNeeded()
            }
            UIView.animate(withDuration: 0.35, delay: 0.05, options: [], animations: {
                self.button0XAnchor?.isActive = false
                self.button0XAnchor = self.button0.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 80)
                self.button0XAnchor?.isActive = true
                self.button0.transform = CGAffineTransform(rotationAngle: self.radians(0))
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.35, delay: 0.06, options: [], animations: {
                self.button1XAnchor?.isActive = false
                self.button1XAnchor = self.button1.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 80)
                self.button1XAnchor?.isActive = true
                self.button1.transform = CGAffineTransform(rotationAngle: self.radians(0))
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.35, delay: 0.1, options: [], animations: {
                self.button2XAnchor?.isActive = false
                self.button2XAnchor = self.button2.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 80)
                self.button2XAnchor?.isActive = true
                self.button2.transform = CGAffineTransform(rotationAngle: self.radians(0))
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.35, delay: 0.15, options: [], animations: {
                self.button3XAnchor?.isActive = false
                self.button3XAnchor = self.button3.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 80)
                self.button3XAnchor?.isActive = true
                self.button3.transform = CGAffineTransform(rotationAngle: self.radians(0))
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.35, delay: 0.20, options: [], animations: {
                self.button4XAnchor?.isActive = false
                self.button4XAnchor = self.button4.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 80)
                self.button4XAnchor?.isActive = true
                self.button4.transform = CGAffineTransform(rotationAngle: self.radians(0))
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.35, delay: 0.24, options: [], animations: {
                self.button5XAnchor?.isActive = false
                self.button5XAnchor = self.button5.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 80)
                self.button5XAnchor?.isActive = true
                self.button5.transform = CGAffineTransform(rotationAngle: self.radians(0))
                self.view.layoutIfNeeded()
            })
            UIView.animate(withDuration: 0.35, delay: 0.27, options: [], animations: {
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
