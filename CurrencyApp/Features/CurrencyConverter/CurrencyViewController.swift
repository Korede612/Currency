//
//  ViewController.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 04/02/2024.
//

import UIKit

class CurrencyViewController: UIViewController {

    let conversionView = CurrencyView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        
        view.addSubview(conversionView)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        conversionView.pin(to: view)
    }

}

