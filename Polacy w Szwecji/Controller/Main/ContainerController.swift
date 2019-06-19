//
//  ContainerController.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-02.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit


class ContainerController: UIViewController, SideMenuDelegate {

    func shouldToggleMenu() {
        toggleMenu()
    }
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
    
    lazy var accountController: UINavigationController = {
        let viewController = AccountController()
        viewController.sideMenuDelegate = self
        let navController = UINavigationController(rootViewController: viewController)
        self.addViewControllerAsChildViewController(childViewController: navController)
        return navController
    }()
    
    lazy var usersController: UINavigationController = {
        let viewController = UsersTVC()
        viewController.sideMenuDelegate = self
        let navController = UINavigationController(rootViewController: viewController)
        self.addViewControllerAsChildViewController(childViewController: navController)
        return navController
    }()
    
    
    lazy var inboxController: UINavigationController = {
        let viewController = InboxTVC()
        viewController.sideMenuDelegate = self
        let navController = UINavigationController(rootViewController: viewController)
        self.addViewControllerAsChildViewController(childViewController: navController)
        return navController
    }()
    
    lazy var workController: UINavigationController = {
        let viewController = WorkController()
        viewController.sideMenuDelegate = self
        let navController = UINavigationController(rootViewController: viewController)
        self.addViewControllerAsChildViewController(childViewController: navController)
        return navController
    }()
    
    lazy var flatsController: UINavigationController = {
        let viewController = FlatsController()
        viewController.sideMenuDelegate = self
        let navController = UINavigationController(rootViewController: viewController)
        self.addViewControllerAsChildViewController(childViewController: navController)
        return navController
    }()
    
    lazy var shoppingController: UINavigationController = {
        let viewController = ShoppingController()
        viewController.sideMenuDelegate = self
        let navController = UINavigationController(rootViewController: viewController)
        self.addViewControllerAsChildViewController(childViewController: navController)
        return navController
    }()
    
    lazy var infoController: UINavigationController = {
        let pdfViewController = PDFViewController()
        pdfViewController.sideMenuDelegate = self
        let navController = UINavigationController(rootViewController: pdfViewController)
        self.addViewControllerAsChildViewController(childViewController: navController)
        return navController
    }()

    
    let buttonView0: SideButtonView = {
        let button = SideButtonView(imageName: "account_icon", title: "Account")//Forum
        return button
    }()
    
    let buttonView1: SideButtonView = {
        let button = SideButtonView(imageName: "users_icon", title: "Users")//Praca
        return button
    }()
    
    let buttonView2: SideButtonView = {
        let button = SideButtonView(imageName: "chat_icon", title: "Inbox")//Lokale
        return button
    }()
    
    let buttonView3: SideButtonView = {
        let button = SideButtonView(imageName: "work_icon", title: "Work")//Zakupy
        return button
    }()
    
    let buttonView4: SideButtonView = {
        let button = SideButtonView(imageName: "flats_icon", title: "Flats") //Czat
        return button
    }()
    
    let buttonView5: SideButtonView = {
        let button = SideButtonView(imageName: "shopping_icon", title: "Shopping") //Znajomi
        return button
    }()
    
    let buttonView6: SideButtonView = {
        let button = SideButtonView(imageName: "info_icon", title: "Info") //Życie
        return button
    }()
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupView()
    }
    
    var blockerCoverView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.isHidden = true
        return view
    }()
    
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
        iv.tintColor = UIColor.sideMenuBackground
        iv.contentMode = UIView.ContentMode.scaleToFill
        return iv
    }()
    
    
    
    private func setupNavBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.lightRed
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        let menuBtn = UIBarButtonItem(image: UIImage(named: "menu_icon")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(toggleMenu))
        menuBtn.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = menuBtn
        
        let logoutBtn = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        logoutBtn.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = logoutBtn
    }
    
    private func setupView() {
        
        buttonViews = [buttonView0, buttonView1, buttonView2, buttonView3, buttonView4, buttonView5, buttonView6]


        // set initial view
        updateView(tag: 2)
        
        
        view.addSubview(blockerCoverView)
        blockerCoverView.setAnchor(top: view.safeTopAnchor, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, paddingTop: 44, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        //TODO: check nav bar height (if 44) on other devices
        // add static transparent container for side menu, initially hidden
        view.addSubview(containerSideMenu)
        containerSideMenu.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 44).isActive = true
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
        waveImageView.setAnchor(top: waveContainerView.topAnchor,
                                leading: waveContainerView.leadingAnchor,
                                bottom: waveContainerView.bottomAnchor,
                                trailing: waveContainerView.trailingAnchor,
                                paddingTop: 0,
                                paddingLeft: 0,
                                paddingBottom: 0,
                                paddingRight: 0)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideMenu))
        blockerCoverView.addGestureRecognizer(tap)

        var i = 0
        buttonViews.forEach { (btnView) in
            btnView.tag = i
            i += 1
            let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            btnView.addGestureRecognizer(tap)
            containerSideMenu.addSubview(btnView)
            btnView.setAnchor(width: 50, height: 60)
        }
        
        buttonView0.transform = CGAffineTransform(rotationAngle: self.radians(10))
        buttonView1.transform = CGAffineTransform(rotationAngle: self.radians(15))
        buttonView2.transform = CGAffineTransform(rotationAngle: self.radians(17))
        buttonView3.transform = CGAffineTransform(rotationAngle: self.radians(19))
        buttonView4.transform = CGAffineTransform(rotationAngle: self.radians(17))
        buttonView5.transform = CGAffineTransform(rotationAngle: self.radians(15))
        buttonView6.transform = CGAffineTransform(rotationAngle: self.radians(10))
        
    }

    @objc private func handleTap(_ sender: UITapGestureRecognizer) {
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
    
    private func updateView(tag: Int) {
        accountController.view.isHidden = !(tag == 0)
        usersController.view.isHidden = !(tag == 1)
        inboxController.view.isHidden = !(tag == 2)
        workController.view.isHidden = !(tag == 3)
        flatsController.view.isHidden = !(tag == 4)
        shoppingController.view.isHidden = !(tag == 5)
        infoController.view.isHidden = !(tag == 6)
        navigationController?.navigationBar.topItem?.title = buttonViews[tag].titleLabel.text
    }
    

    @objc private func toggleMenu() {
        menuShowing ? hideMenu() : showMenu()
    }
    
    @objc private func handleLogout() {
        print("handleLogout")
        
        Api.User.logOut()
        
    }
    
    
    
    private func showMenu() {
        blockerCoverView.isHidden = false
        containerSideMenu.isHidden = false
        menuShowing = true
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
    
    @objc private func hideMenu() {
        UIView.animate(withDuration: 0.7, animations: {
            self.sideMenuXAnchor?.isActive = false
            self.sideMenuXAnchor = self.waveContainerView.centerXAnchor.constraint(equalTo: self.view.leadingAnchor, constant: -self.kWidth)
            self.sideMenuXAnchor?.isActive = true
            self.view.layoutIfNeeded()
        }) { (_) in
            self.containerSideMenu.isHidden = true
            self.menuShowing = false
            self.blockerCoverView.isHidden = true
            
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
    
    private func radians(_ degrees: Double) -> CGFloat {
        return CGFloat(degrees * .pi / 180)
    }
}
