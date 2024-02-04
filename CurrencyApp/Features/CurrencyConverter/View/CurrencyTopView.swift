//
//  CurrencyTopView.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 04/02/2024.
//

import UIKit

class CurrencyTopView: UIView {
    
    let contentView = UIView()
    let buttonViews = ConversionDetailView()
    let textFields = ConversionDetailView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(contentView)
        contentView.addSubview([buttonViews, textFields])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.pinConstraint(trailing: trailingAnchor, bottom: bottomAnchor, leading: leadingAnchor)
        contentView.configureSizeConstraints(heightConstraint: heightAnchor,
                                              heightMultiplier: 0.75)
        textFields.pinConstraint(trailing: contentView.trailingAnchor,
                                    bottom: contentView.bottomAnchor,
                                    leading: contentView.leadingAnchor)
        textFields.configureSize(height: 52)
        buttonViews.pinConstraint(trailing: contentView.trailingAnchor,
                                     bottom: textFields.topAnchor,
                                     leading: contentView.leadingAnchor,
                                     paddingBottom: -10
        )
        buttonViews.configureSize(height: 52)
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
