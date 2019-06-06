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
}
