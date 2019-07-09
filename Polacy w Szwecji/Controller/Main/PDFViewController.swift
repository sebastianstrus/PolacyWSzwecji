//
//  PDFViewController.swift
//  Polacy w Szwecji
//
//  Created by Sebastian Strus on 2019-06-06.
//  Copyright © 2019 Sebastian Strus. All rights reserved.
//

import UIKit
import PDFKit

class PDFViewController: UIViewController {
    
    var pdfView = PDFView()
    var pdfURL: URL!
    
    var sideMenuDelegate:SideMenuDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        view = pdfView
        
        let path = Bundle.main.path(forResource: "vademecum2012", ofType: "pdf")!
        let pdfURL = URL(fileURLWithPath: path)
        let document = PDFDocument(url: pdfURL)
        pdfView.document = document
        //pdfView.displayMode = PDFDisplayMode.singlePageContinuous
        pdfView.maxScaleFactor = 3.0
        pdfView.autoScales = true
    }
    
    override func viewDidLayoutSubviews() {
        pdfView.frame = view.frame
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Info"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.lightRed
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        let logoutBtn = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        logoutBtn.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = logoutBtn
        
        let menuBtn = UIBarButtonItem(image: UIImage(named: "menu_icon")?.withRenderingMode(.alwaysTemplate), style: .plain, target: self, action: #selector(requestToggleMenu))
        menuBtn.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = menuBtn
    }
    
    // MARK: - Private methods
    @objc private func requestToggleMenu() {
        sideMenuDelegate?.shouldToggleMenu()
    }
    
    @objc private func handleLogout() {
        Api.User.logOut()
        
    }
}
