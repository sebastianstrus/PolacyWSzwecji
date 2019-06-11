//
//  ViewController.swift
//  SideMenuDemo2
//
//  Created by Sebastian Strus on 2019-06-02.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit


class ContainerController: UIViewController {

    final let kNumberButtons: CGFloat = 7
    final let kWidth: CGFloat = 80
    
    
    var menuShowing = false
    var sideMenuXAnchor: NSLayoutConstraint?
    
    var button0XAnchor: NSLayoutConstraint?
    var button1XAnchor: NSLayoutConstraint?
    var button2XAnchor: NSLayoutConstraint?
    var button3XAnchor: NSLayoutConstraint?
    var button4XAnchor: NSLayoutConstraint?
    var button5XAnchor: NSLayoutConstraint?
    var button6XAnchor: NSLayoutConstraint?
    var buttonViews: [SideButtonView]!
    
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
    
    lazy var sixthController: FirstController = {
        let viewController = FirstController()
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    lazy var seventhController: PDFViewController = {
        let pdfViewController = PDFViewController()
        self.addViewControllerAsChildViewController(childViewController: pdfViewController)
        return pdfViewController
    }()

    
    
    let buttonView0: SideButtonView = {
        let button = SideButtonView(imageName: "home_icon", title: "Home")//Forum
        return button
    }()
    
    let buttonView1: SideButtonView = {
        let button = SideButtonView(imageName: "work_icon", title: "Work")//Praca
        return button
    }()
    
    let buttonView2: SideButtonView = {
        let button = SideButtonView(imageName: "apartments_icon", title: "Flats")//Lokale
        return button
    }()
    
    let buttonView3: SideButtonView = {
        let button = SideButtonView(imageName: "alkohol_icon", title: "Shopping")//Zakupy
        return button
    }()
    
    let buttonView4: SideButtonView = {
        let button = SideButtonView(imageName: "chat_icon", title: "Chat") //Czat
        return button
    }()
    
    let buttonView5: SideButtonView = {
        let button = SideButtonView(imageName: "friends_icon", title: "Friends") //Znajomi
        return button
    }()
    
    let buttonView6: SideButtonView = {
        let button = SideButtonView(imageName: "info_icon", title: "Info") //Życie
        return button
    }()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //temp
        //let signUpController = RestorePasswordController()
        //present(signUpController, animated: true)
        
        // if not logged in
//        let welcomeController = WelcomeController()
//        present(welcomeController, animated: true)
        
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
    
    var waveContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var waveImageView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "wave_shape")?.withRenderingMode(.alwaysTemplate))
        iv.tintColor = UIColor.lightWhite
        iv.contentMode = UIView.ContentMode.scaleToFill
        return iv
    }()
    
    
    
    func setupNavBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.lightRed
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        let menuBtn = UIBarButtonItem(image: UIImage(named: "menu_icon")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(toggleMenu))
        menuBtn.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = menuBtn
        
        let joinBtn = UIBarButtonItem(title: "Join", style: .plain, target: self, action: #selector(handleJoin))
        joinBtn.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = joinBtn
    }
    
    func setupView() {
        
        buttonViews = [buttonView0, buttonView1, buttonView2, buttonView3, buttonView4, buttonView5, buttonView6]

        var anchors = [button0XAnchor, button1XAnchor, button2XAnchor, button3XAnchor, button4XAnchor, button5XAnchor, button6XAnchor]
        
        var i = 0
        buttonViews.forEach { (btnView) in
            btnView.tag = i
            i += 1
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            btnView.addGestureRecognizer(tap)
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
        
        var j = 0
        for button in buttonViews {
            containerSideMenu.addSubview(button)
            button.setAnchor(width: 50, height: 60)
            anchors[j] = buttonViews[j].centerXAnchor.constraint(equalTo: containerSideMenu.centerXAnchor)
            j += 1
        }

        buttonView0.transform = CGAffineTransform(rotationAngle: self.radians(10))
        buttonView1.transform = CGAffineTransform(rotationAngle: self.radians(15))
        buttonView2.transform = CGAffineTransform(rotationAngle: self.radians(17))
        buttonView3.transform = CGAffineTransform(rotationAngle: self.radians(19))
        buttonView4.transform = CGAffineTransform(rotationAngle: self.radians(17))
        buttonView5.transform = CGAffineTransform(rotationAngle: self.radians(15))
        buttonView6.transform = CGAffineTransform(rotationAngle: self.radians(10))
        
    }

    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        guard let getTag = sender.view?.tag else { return }
        updateView(tag: getTag)
        hideMenu()
    }
    
    override func viewDidLayoutSubviews() {
        let containerHeight = containerSideMenu.frame.height
        let heightByNumberItems = containerHeight/kNumberButtons
        var offset: CGFloat = 0.5
        for button in buttonViews {
            button.centerYAnchor.constraint(equalTo: containerSideMenu.topAnchor, constant: heightByNumberItems * offset).isActive = true
            offset += 1
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
        navigationController?.navigationBar.topItem?.title = buttonViews[tag].titleLabel.text
    }
    

    @objc func toggleMenu() {
        menuShowing ? hideMenu() : showMenu()
        menuShowing = !menuShowing
    }
    
    @objc func handleJoin() {
        let welcomeController = WelcomeController()
        let nav = UINavigationController(rootViewController: welcomeController)
        nav.isNavigationBarHidden = true
        present(nav, animated: true)
    }
    
    
    
    func showMenu() {
        containerSideMenu.isHidden = false
        UIView.animate(withDuration: 0.7) {
            self.sideMenuXAnchor?.isActive = false
            self.sideMenuXAnchor = self.waveContainerView.centerXAnchor.constraint(equalTo: self.view.leadingAnchor, constant: self.kWidth)
            self.sideMenuXAnchor?.isActive = true
            self.view.layoutIfNeeded()
        }
        UIView.animate(withDuration: 0.35, delay: 0.05, options: [], animations: {
            self.button0XAnchor?.isActive = false
            self.button0XAnchor = self.buttonView0.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: self.kWidth)
            self.button0XAnchor?.isActive = true
            self.buttonView0.transform = CGAffineTransform(rotationAngle: self.radians(0))
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 0.35, delay: 0.06, options: [], animations: {
            self.button1XAnchor?.isActive = false
            self.button1XAnchor = self.buttonView1.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: self.kWidth)
            self.button1XAnchor?.isActive = true
            self.buttonView1.transform = CGAffineTransform(rotationAngle: self.radians(0))
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 0.35, delay: 0.1, options: [], animations: {
            self.button2XAnchor?.isActive = false
            self.button2XAnchor = self.buttonView2.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: self.kWidth)
            self.button2XAnchor?.isActive = true
            self.buttonView2.transform = CGAffineTransform(rotationAngle: self.radians(0))
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 0.35, delay: 0.15, options: [], animations: {
            self.button3XAnchor?.isActive = false
            self.button3XAnchor = self.buttonView3.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: self.kWidth)
            self.button3XAnchor?.isActive = true
            self.buttonView3.transform = CGAffineTransform(rotationAngle: self.radians(0))
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 0.35, delay: 0.20, options: [], animations: {
            self.button4XAnchor?.isActive = false
            self.button4XAnchor = self.buttonView4.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: self.kWidth)
            self.button4XAnchor?.isActive = true
            self.buttonView4.transform = CGAffineTransform(rotationAngle: self.radians(0))
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 0.35, delay: 0.24, options: [], animations: {
            self.button5XAnchor?.isActive = false
            self.button5XAnchor = self.buttonView5.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: self.kWidth)
            self.button5XAnchor?.isActive = true
            self.buttonView5.transform = CGAffineTransform(rotationAngle: self.radians(0))
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 0.35, delay: 0.27, options: [], animations: {
            self.button6XAnchor?.isActive = false
            self.button6XAnchor = self.buttonView6.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: self.kWidth)
            self.button6XAnchor?.isActive = true
            self.buttonView6.transform = CGAffineTransform(rotationAngle: self.radians(0))
            self.view.layoutIfNeeded()
        })
    }
    
    func hideMenu() {
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
            self.button0XAnchor = self.buttonView0.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 0)
            self.button0XAnchor?.isActive = true
            self.buttonView0.transform = CGAffineTransform(rotationAngle: self.radians(10))
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 0.35, delay: 0.28, options: [], animations: {
            self.button1XAnchor?.isActive = false
            self.button1XAnchor = self.buttonView1.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 0)
            self.button1XAnchor?.isActive = true
            self.buttonView1.transform = CGAffineTransform(rotationAngle: self.radians(15))
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 0.35, delay: 0.25, options: [], animations: {
            self.button2XAnchor?.isActive = false
            self.button2XAnchor = self.buttonView2.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 0)
            self.button2XAnchor?.isActive = true
            self.buttonView2.transform = CGAffineTransform(rotationAngle: self.radians(17))
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 0.35, delay: 0.20, options: [], animations: {
            self.button3XAnchor?.isActive = false
            self.button3XAnchor = self.buttonView3.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 0)
            self.button3XAnchor?.isActive = true
            self.buttonView3.transform = CGAffineTransform(rotationAngle: self.radians(19))
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 0.35, delay: 0.16, options: [], animations: {
            self.button4XAnchor?.isActive = false
            self.button4XAnchor = self.buttonView4.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 0)
            self.button4XAnchor?.isActive = true
            self.buttonView4.transform = CGAffineTransform(rotationAngle: self.radians(17))
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 0.35, delay: 0.1, options: [], animations: {
            self.button5XAnchor?.isActive = false
            self.button5XAnchor = self.buttonView5.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 0)
            self.button5XAnchor?.isActive = true
            self.buttonView5.transform = CGAffineTransform(rotationAngle: self.radians(15))
            self.view.layoutIfNeeded()
        })
        UIView.animate(withDuration: 0.35, delay: 0.075, options: [], animations: {
            self.button6XAnchor?.isActive = false
            self.button6XAnchor = self.buttonView6.centerXAnchor.constraint(equalTo: self.containerSideMenu.centerXAnchor, constant: 0)
            self.button6XAnchor?.isActive = true
            self.buttonView6.transform = CGAffineTransform(rotationAngle: self.radians(10))
            self.view.layoutIfNeeded()
        })
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