//
//  Extension + StackView.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 05/02/2024.
//

import UIKit

extension UIStackView {
    func addArrangedSubview(_ views: [UIView]) {
        views.forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview(view)
        }
    }
    
    convenience init(distribution: UIStackView.Distribution,
                            spacing: CGFloat,
                            axis: NSLayoutConstraint.Axis) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        self.distribution = distribution
        self.spacing = spacing
        self.axis = axis
    }
}
