//
//  Extension + Button.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 04/02/2024.
//

import UIKit

extension UIButton {
    func configureConversionButtonStyle(title: String? = nil,
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
    
    convenience init(bgColor: UIColor, title: String = "") {
        self.init(frame: .zero)
        self.backgroundColor = bgColor
         self.setTitle(title, for: .normal)
        configureGeneralButton()
    }
    
    func configureGeneralButton() {
        self.cornerRadius           = 10
        titleLabel?.textColor       = .white
        titleLabel?.font            = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints   = false
    }
}
