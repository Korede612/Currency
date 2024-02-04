//
//  EmptyStateView.swift
//  CurrencyApp
//
//  Created by Oko-osi Korede on 04/02/2024.
//

import UIKit

class EmptyStateView: UIView {

    let messageLabel = UILabel(textAlignment: .center, fontSize: 28)
    let imageView = UIImageView(image: UIImage(systemName: "trash"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init (message: String) {
        super.init(frame: .zero)
        messageLabel.text = message
        configure()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        configureMessageLabel()
        configureLogoView()
    }
    
    private func configure() {
        addSubview([messageLabel, imageView])
    }
    
    private func configureMessageLabel() {
        messageLabel.numberOfLines = 0
        messageLabel.textColor = .secondaryLabel
        
        messageLabel.pinConstraint(
            trailing: trailingAnchor, leading: leadingAnchor,
            paddingRight: 40, paddingLeft: 40)
        messageLabel.centerView(on: self, axis: .vertical, yOffset: -150)
    }
    
    private func configureLogoView() {
        imageView.configureSizeConstraints(widthConstraint: self.widthAnchor, 
                                           widthMultiplier: 0.5,
                                           heightConstraint: self.widthAnchor,
                                           heightMultiplier: 0.5)
        imageView.centerView(on: self, axis: .both)
        
    }
}
