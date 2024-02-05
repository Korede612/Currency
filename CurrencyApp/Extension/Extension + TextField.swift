//
//  Extension + TextField.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 04/02/2024.
//

import UIKit

extension UITextField {
    func addLeftPadding(padding: CGFloat = 10) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: frame.size.height))
        
        leftView = paddingView
        leftViewMode = .always
    }
    
    func configureTextField(borderWidth: CGFloat = 1, borderColor: UIColor = .black, cornerRadius: CGFloat = 12) {
        self.borderWidth = borderWidth
        self.borderColor = borderColor.cgColor
        self.cornerRadius = cornerRadius
    }
    
    func configureTextFieldTextToNumber() {
        self.keyboardType = .numberPad
    }
}
