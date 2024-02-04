//
//  Extension + Button.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 04/02/2024.
//

import UIKit

extension UIButton {
    func configureButtonStyle(title: String? = nil,
                              iconName: String
    ) {
        setTitle(title, for: .normal)
        setImage(UIImage(systemName: iconName), for: .normal)
        semanticContentAttribute = .forceRightToLeft
        titleLabel?.font = .systemFont(ofSize: 12, weight: .semibold)
        setTitleColor(.black, for: .normal)
        backgroundColor = .init(red: 234/255, green: 202/255, blue: 207/255, alpha: 1)
        tintColor = .systemGray
        cornerRadius = 10
    }
}
