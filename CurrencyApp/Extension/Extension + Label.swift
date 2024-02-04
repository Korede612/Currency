//
//  Extension + Label.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 04/02/2024.
//

import UIKit

extension UILabel {
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init()
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.95
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
}
