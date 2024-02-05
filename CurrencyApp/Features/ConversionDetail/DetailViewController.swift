//
//  DetailViewController.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 04/02/2024.
//

import UIKit

class DetailViewController: UIViewController {

    let dismissButton = UIButton(bgColor: .systemBackground, title: "Back")
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        view.addSubview(dismissButton)
        dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        dismissButton.pinConstraint(top: view.topAnchor,
                                    leading: view.leadingAnchor,
                                    paddingTop: 50,
                                    paddingLeft: 20)
        dismissButton.setTitleColor(.black, for: .normal)
    }
    
    @objc private func dismissButtonTapped(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    deinit {
        print("Detail VC is going to sleep")
    }
    
}
