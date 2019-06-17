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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
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
    
    
    private func setupNavBar() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = UIColor.lightRed

        let logoutBtn = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        logoutBtn.tintColor = UIColor.white
        navigationItem.rightBarButtonItem = logoutBtn
    }
    
    @objc private func handleLogout() {
        print("handleLogout")
        
        Api.User.logOut()
        
    }
}
