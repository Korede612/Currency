//
//  Extension + View.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 04/02/2024.
//

import UIKit

extension UIView {
    
    var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        } set {
            self.layer.borderWidth = newValue
        }
    }
    
    var borderColor: CGColor? {
        get {
            return self.layer.borderColor
        } set {
            self.layer.borderColor = newValue
        }
    }
    
    var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        } set {
            self.layer.cornerRadius = newValue
        }
    }
    
    func pin(to view: UIView, safeArea: Bool = false) {
        translatesAutoresizingMaskIntoConstraints = false
        if safeArea {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
                bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
                
            ])
        } else {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: view.topAnchor),
                leadingAnchor.constraint(equalTo: view.leadingAnchor),
                trailingAnchor.constraint(equalTo: view.trailingAnchor),
                bottomAnchor.constraint(equalTo: view.bottomAnchor)
                
            ])
        }
        
    }
    
    func pinConstraint(top: NSLayoutYAxisAnchor? = nil,
                          trailing: NSLayoutXAxisAnchor? = nil,
                          bottom: NSLayoutYAxisAnchor? = nil,
                          leading: NSLayoutXAxisAnchor? = nil,
                          paddingTop: CGFloat = 0,
                          paddingRight: CGFloat = 0,
                          paddingBottom: CGFloat = 0,
                          paddingLeft: CGFloat = 0
    ) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        
        if let trailing {
            trailingAnchor.constraint(equalTo: trailing, constant: -paddingRight).isActive = true
        }
        
        if let bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        
        if let leading {
            leadingAnchor.constraint(equalTo: leading, constant: paddingLeft).isActive = true
        }
    }
    
    func centerView(on view: UIView, axis: UIAxis, xOffset: CGFloat = 0, yOffset: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if axis == .horizontal {
            centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: xOffset).isActive = true
        }
        else if axis == .vertical {
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yOffset).isActive = true
        }
        else if axis == .both {
            centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: xOffset).isActive = true
            centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: yOffset).isActive = true
        }
    }
    
    func addSubview(_ views: [UIView]) {
        views.forEach { newView in
            addSubview(newView)
        }
    }
    
    func configureSizeConstraints(widthConstraint: NSLayoutDimension? = nil,
                                  widthMultiplier: CGFloat = 1,
                                  heightConstraint: NSLayoutDimension? = nil,
                                  heightMultiplier: CGFloat = 1) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let widthConstraint {
            widthAnchor.constraint(equalTo: widthConstraint, multiplier: widthMultiplier).isActive = true
        }
        if let heightConstraint {
            heightAnchor.constraint(equalTo: heightConstraint, multiplier: heightMultiplier).isActive = true
        }
    }
    
    func configureSize(width: CGFloat? = nil, height: CGFloat? = nil) {
        if let width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        
        if let height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
}
